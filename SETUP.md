# FJ Hotel Backend Setup Guide

This guide will walk you through setting up the FJ Hotel booking system backend, including database configuration and Spring Boot application setup.

## � Quick Start Summary

1. **First:** Execute `setup_mysql.sh` to set up the database
2. **Then:** Install Java and Maven 
3. **Finally:** Build and run the Spring Boot application

## �📋 Prerequisites

Before starting, ensure you have the following installed:

- **Java 21** or higher
- **Maven 3.6+** (or use the included Maven wrapper)
- **Docker** (for database setup)
- **Git** (for version control)

## 🗄️ Step 1: Database Setup

### Execute setup_mysql.sh Script

**IMPORTANT:** You must run the database setup script first before installing Spring Boot.

1. **Navigate to the Database directory:**
   ```bash

   ```

2. **Make the setup script executable and run it:**
   ```bash
   chmod +x Database/setup_mysql.sh
   Database/setup_mysql.sh
   ```

This script will automatically:
- Create a MySQL Docker container named `mysql`
- Set up the `fj_hotel` database
- Create all required tables (users, rooms, orders)
- Insert default sample data

**Note:** If the script fails, use the manual setup commands in the troubleshooting section below.

### Database Connection Details

After setup, your database will be accessible with:
- **Host**: localhost
- **Port**: 3307 (mapped from Docker container's 3306)
- **Database**: fj_hotel
- **Username**: fjhotel
- **Password**: 1234

### Verify Database Setup

Test the database connection:
```bash
docker exec -it mysql mysql -u fjhotel -p1234 fj_hotel
```

## 🚀 Step 2: Install and Setup Spring Boot

**Prerequisites:** Complete Step 1 (Database Setup) first before proceeding.

### Install Required Software

Before setting up Spring Boot, you need to install Java and Maven:

#### On Ubuntu/Debian:
```bash
# Install Java 21
sudo apt update
sudo apt install openjdk-21-jdk

# Install Maven
sudo apt install maven

# Verify installations
java -version
mvn -version
```


### Project Dependencies

The project includes these key Spring Boot starters:
- `spring-boot-starter-web` - For REST API endpoints
- `spring-boot-starter-data-jpa` - For database operations
- `spring-boot-starter-security` - For authentication and authorization
- `spring-boot-starter-validation` - For input validation
- `mysql-connector-j` - MySQL database driver
- `lombok` - For reducing boilerplate code

### Setup Spring Boot Application

**Important:** Make sure you've completed Step 1 (Database Setup) and the database is running before proceeding.

1. **Clean and compile the project:**
   ```bash
   mvn clean compile
   ```

2. **Run tests (optional):**
   ```bash
   mvn test
   ```

3. **Package the application:**
   ```bash
   mvn clean package
   ```



### Run the Application

#### Method 1: Using Maven
```bash

```



### Verify Application Startup

Once the application starts successfully, you should see:
```
Started FjHotelApplication in X.XXX seconds (JVM running for X.XXX)
```

The application will be available at: **http://localhost:8080**

## 🧪 Step 3: Testing the Setup

### Test Database Connection

1. **Check application logs** for successful database connection
2. **Verify tables exist** in your MySQL database
3. **Test API endpoints** (see [`ENDPOINTS.md`](ENDPOINTS.md) for available endpoints)

### Basic API Tests

You can test the basic endpoints:

```bash
# Health check (if available)
curl http://localhost:8080/actuator/health

# Test rooms endpoint
curl http://localhost:8080/api/rooms

# Test authentication endpoints
curl -X POST http://localhost:8080/api/auth/signup \
  -H "Content-Type: application/json" \
  -d '{"username":"test","email":"test@example.com","password":"password"}'
```

## 🛠️ Development Workflow

### Using VS Code

1. **Open the project in VS Code**
2. **Install recommended extensions:**
   - Extension Pack for Java
   - Spring Boot Extension Pack
   - MySQL (for database management)

3. **Use VS Code tasks for common operations:**
   - `Spring Boot: Run` - Start the application
   - `Maven: Clean Compile` - Clean and compile

### Hot Reload

The project includes Spring Boot DevTools for hot reload during development. Any changes to your Java files will automatically restart the application.

## 🔧 Troubleshooting

### Most Common Issue: Database Connection Failed

If you see `Communications link failure` or `Connection refused` errors, the database isn't running. Follow these steps:

1. **Start the MySQL database first:**
   ```bash
   cd Database/
   
   # Remove any existing container
   docker stop mysql && docker rm mysql
   
   # Create new container with correct settings
   docker run -d --name mysql \
     -e MYSQL_ROOT_PASSWORD=1234 \
     -e MYSQL_DATABASE=fj_hotel \
     -e MYSQL_USER=fjhotel \
     -e MYSQL_PASSWORD=1234 \
     -p 3307:3306 \
     mysql:8.0
   
   # Wait for MySQL to start (about 15-20 seconds)
   sleep 15
   
   # Import database schema and data
   docker exec -i mysql mysql -u root -p1234 fj_hotel < setup_fj_hotel.sql
   
   # Verify setup
   docker exec mysql mysql -u root -p1234 fj_hotel -e "SHOW TABLES;"
   ```

2. **Then start the Spring Boot application:**
   ```bash
   cd ..
   mvn spring-boot:run
   ```

### Other Common Issues

1. **Port 8080 already in use:**
   ```bash
   # Find and kill the process using port 8080
   lsof -ti:8080 | xargs kill -9
   ```

2. **Check if database is running:**
   ```bash
   # Check Docker containers
   docker ps
   
   # Test database connection
   docker exec mysql mysql -u root -p1234 -e "SELECT 1;"
   ```

3. **Java version mismatch:**
   ```bash
   # Check Java version
   java -version
   # Should show version 21.x.x
   ```

4. **Maven not found:**
   ```bash
   # Use Maven wrapper instead
   ./mvnw spring-boot:run
   ```

5. **Docker not running:**
   ```bash
   # Start Docker service (Linux)
   sudo systemctl start docker
   
   # Check Docker status
   docker --version
   ```

### Logs

Check application logs for detailed error information:
- Application logs appear in the console when running
- For packaged applications, logs are in `logs/` directory

## 🏁 Next Steps

Once setup is complete:

1. **Explore the API endpoints** - See [`ENDPOINTS.md`](ENDPOINTS.md)
2. **Review the codebase** - Understand the project structure
3. **Test the frontend** - Use the HTML test files in `test-html/`
4. **Start developing** - Add new features or modify existing ones

## 📚 Additional Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Spring Data JPA Reference](https://spring.io/projects/spring-data-jpa)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Maven Getting Started Guide](https://maven.apache.org/guides/getting-started/)

---

🎉 **Congratulations!** Your FJ Hotel backend is now ready for development!