# FJ Hotel Database

This directory contains the database setup and configuration for the FJ Hotel booking system.

## 🚀 Quick Setup

Run the automated setup script to create the MySQL Docker container and initialize the database:

```bash
cd Database/
chmod +x Database/setup_mysql.sh
Database/setup_mysql.sh
```

This script will:
- Create a MySQL Docker container named `mysql`
- Set up the `fj_hotel` database
- Create all required tables
- Insert default sample data

## 📋 Connection Details

- **Host**: localhost
- **Port**: 3306
- **Database**: fj_hotel
- **Root Username**: root
- **Root Password**: root
- **App Username**: hotel_user
- **App Password**: hotel_password

## 🔗 Connection Strings

**JDBC URL for Spring Boot:**
```
jdbc:mysql://localhost:3306/fj_hotel
```

**Manual Connection:**
```bash
docker exec -it mysql mysql -u root -proot fj_hotel
```

## 📁 Files

- `setup_mysql.sh` - Automated setup script
- `setup_fj_hotel.sql` - Combined schema and data script
- `schema.sql` - Original schema definition
- `default-inserts.sql` - Original data inserts

## 🧪 Testing the Database

After running the setup script, you can test the database with these commands:

### 1. Check if container is running
```bash
docker ps | grep mysql
```

### 2. Connect to database
```bash
docker exec -it mysql mysql -u root -proot fj_hotel
```

### 3. Test queries inside MySQL shell
```sql
-- Show all tables
SHOW TABLES;

-- Check room data
SELECT room_name, category, price FROM rooms LIMIT 5;

-- Check user data
SELECT first_name, last_name, email FROM users;

-- Check bookings
SELECT u.first_name, u.last_name, r.room_name, o.checkin_date, o.checkout_date 
FROM orders o 
JOIN users u ON o.user_id = u.user_id 
JOIN rooms r ON o.room_id = r.room_id;

-- Count records in each table
SELECT 'Rooms' as Entity, COUNT(*) as Count FROM rooms
UNION ALL SELECT 'Users', COUNT(*) FROM users
UNION ALL SELECT 'Orders', COUNT(*) FROM orders
UNION ALL SELECT 'Pictures', COUNT(*) FROM pictures;
```

### 4. Test from command line (one-liner)
```bash
docker exec mysql mysql -u root -proot fj_hotel -e "SELECT COUNT(*) as total_rooms FROM rooms; SELECT COUNT(*) as total_users FROM users;"
```

Expected output:
```
total_rooms
12
total_users
3
```

## 🛠️ Container Management

```bash
# Stop the container
docker stop mysql

# Start the container
docker start mysql

# Remove the container (will delete all data)
docker stop mysql && docker rm mysql

# Recreate everything (run setup script again)
./setup_mysql.sh
```
