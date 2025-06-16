#!/bin/bash

# FJ Hotel MySQL Docker Setup Script
# Creates MySQL container and sets up the hotel database with schema and data

set -e

# Configuration
CONTAINER_NAME="mysql"
MYSQL_ROOT_PASSWORD="root"
MYSQL_DATABASE="fj_hotel"
MYSQL_USER="hotel_user"
MYSQL_PASSWORD="hotel_password"
MYSQL_PORT="3306"

echo "🏨 Setting up FJ Hotel MySQL Database..."

# Remove existing container if it exists
if docker ps -a --format 'table {{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "🗑️  Removing existing container: ${CONTAINER_NAME}"
    docker stop ${CONTAINER_NAME} 2>/dev/null || true
    docker rm ${CONTAINER_NAME} 2>/dev/null || true
fi

# Create and start MySQL container
echo "🐳 Creating MySQL container: ${CONTAINER_NAME}"
docker run -d \
    --name ${CONTAINER_NAME} \
    -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
    -e MYSQL_DATABASE=${MYSQL_DATABASE} \
    -e MYSQL_USER=${MYSQL_USER} \
    -e MYSQL_PASSWORD=${MYSQL_PASSWORD} \
    -p ${MYSQL_PORT}:3306 \
    mysql:8.0

# Wait for MySQL to be ready
echo "⏳ Waiting for MySQL to be ready..."
max_attempts=30
attempt=1
while [ $attempt -le $max_attempts ]; do
    if docker exec ${CONTAINER_NAME} mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SELECT 1" >/dev/null 2>&1; then
        echo "✅ MySQL is ready!"
        break
    fi
    echo "   Attempt $attempt/$max_attempts: waiting 5 seconds..."
    sleep 5
    attempt=$((attempt + 1))
done

if [ $attempt -gt $max_attempts ]; then
    echo "❌ Error: MySQL failed to start within the expected time"
    exit 1
fi

# Setup database with schema and data
echo "📊 Setting up database schema and inserting data..."
docker exec -i ${CONTAINER_NAME} mysql -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} < Database/setup_fj_hotel.sql

# Verify setup
echo "🔍 Verifying database setup..."
echo ""
echo "Tables created:"
docker exec ${CONTAINER_NAME} mysql -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} -e "SHOW TABLES;" 2>/dev/null

echo ""
echo "Data summary:"
docker exec ${CONTAINER_NAME} mysql -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE} -e "
SELECT 'Rooms' as Entity, COUNT(*) as Count FROM rooms
UNION ALL SELECT 'Users', COUNT(*) FROM users
UNION ALL SELECT 'Orders', COUNT(*) FROM orders
UNION ALL SELECT 'Pictures', COUNT(*) FROM pictures;" 2>/dev/null

echo ""
echo "✅ FJ Hotel Database Setup Complete!"
echo ""
echo "📋 Container Details:"
echo "   Name: ${CONTAINER_NAME}"
echo "   Port: ${MYSQL_PORT}"
echo "   Database: ${MYSQL_DATABASE}"
echo "   Root Password: ${MYSQL_ROOT_PASSWORD}"
echo "   User: ${MYSQL_USER}"
echo "   User Password: ${MYSQL_PASSWORD}"
echo ""
echo "🔗 Connection Information:"
echo "   JDBC URL: jdbc:mysql://localhost:${MYSQL_PORT}/${MYSQL_DATABASE}"
echo "   Manual Access: docker exec -it ${CONTAINER_NAME} mysql -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DATABASE}"
echo ""
echo "🛠️  Container Management:"
echo "   Stop:  docker stop ${CONTAINER_NAME}"
echo "   Start: docker start ${CONTAINER_NAME}"
echo "   Remove: docker stop ${CONTAINER_NAME} && docker rm ${CONTAINER_NAME}"
echo ""
