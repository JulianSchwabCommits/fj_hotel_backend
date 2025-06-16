-- FJ Hotel Database Setup Script
-- This script creates all tables and inserts default data

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS order_guests;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS pictures;
DROP TABLE IF EXISTS users;

-- Picture table (to store BLOBs)
CREATE TABLE pictures (
    picture_id INT AUTO_INCREMENT PRIMARY KEY,
    image_data LONGBLOB NULL,
    file_name VARCHAR(255),
    mime_type VARCHAR(50)
);

-- Rooms and Meeting Rooms table
CREATE TABLE rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_name VARCHAR(100) NOT NULL,
    capacity INT NOT NULL,
    room_type ENUM('room', 'meeting_room') NOT NULL,
    category ENUM('standard', 'deluxe', 'suite') NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    picture_id INT,
    FOREIGN KEY (picture_id) REFERENCES pictures(picture_id) ON DELETE SET NULL
);

-- Users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    birthdate DATE,
    address VARCHAR(255)
);

-- Payment table (linked to users)
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    cardholder_name VARCHAR(100) NOT NULL,
    card_number CHAR(16) NOT NULL,
    expiry_month CHAR(2) NOT NULL,
    expiry_year CHAR(4) NOT NULL,
    cvv CHAR(4) NOT NULL,
    billing_address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Orders table (order history)
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,  -- This is the person who made the booking
    room_id INT NOT NULL,
    checkin_date TIMESTAMP NOT NULL,
    checkout_date TIMESTAMP NOT NULL,
    payment_method ENUM('credit_card', 'cash', 'other') NOT NULL,
    payment_id INT,
    status ENUM('pending', 'confirmed', 'cancelled', 'completed') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id) ON DELETE CASCADE,
    FOREIGN KEY (payment_id) REFERENCES payments(payment_id) ON DELETE SET NULL
);

-- Order Guests (many-to-many: orders <-> users)
CREATE TABLE order_guests (
    order_id INT NOT NULL,
    user_id INT NOT NULL,
    PRIMARY KEY (order_id, user_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Insert default data

-- Insert pictures (without actual image data for Docker setup)
INSERT INTO pictures (image_data, file_name, mime_type) VALUES
(NULL, 'Standard-Room-1.jpg', 'image/jpeg'),
(NULL, 'Suite-Room-2.jpg', 'image/jpeg'),
(NULL, 'Deluxe-Room-2.webp', 'image/webp'),
(NULL, 'Standard-Room-2.jpg', 'image/jpeg'),
(NULL, 'Suite-Room-1.jpg', 'image/jpeg'),
(NULL, 'Deluxe-Room-1.webp', 'image/webp'),
(NULL, 'Standard-Meetingroom-1.jpg', 'image/jpeg'),
(NULL, 'Standard-Meetingroom-2.jpg', 'image/jpeg'),
(NULL, 'Deluxe-Meetingroom-1.jpg', 'image/jpeg'),
(NULL, 'Deluxe-Meetingroom-2.jpg', 'image/jpeg'),
(NULL, 'Suite-Meetingroom-1.webp', 'image/webp'),
(NULL, 'Suite-Meetingroom-2.webp', 'image/webp');

-- Insert rooms
INSERT INTO rooms (room_name, capacity, room_type, category, price, picture_id) VALUES
('Standard Room 1', 2, 'room', 'standard', 100.00, 1),
('Standard Room 2', 2, 'room', 'standard', 100.00, 4),
('Deluxe Room 1', 3, 'room', 'deluxe', 180.00, 6),
('Deluxe Room 2', 3, 'room', 'deluxe', 180.00, 3),
('Suite Room 1', 4, 'room', 'suite', 300.00, 5),
('Suite Room 2', 4, 'room', 'suite', 300.00, 2),
('Standard Meeting Room 1', 10, 'meeting_room', 'standard', 150.00, 7),
('Standard Meeting Room 2', 12, 'meeting_room', 'standard', 160.00, 8),
('Deluxe Meeting Room 1', 20, 'meeting_room', 'deluxe', 250.00, 9),
('Deluxe Meeting Room 2', 22, 'meeting_room', 'deluxe', 260.00, 10),
('Suite Meeting Room 1', 30, 'meeting_room', 'suite', 400.00, 11),
('Suite Meeting Room 2', 35, 'meeting_room', 'suite', 420.00, 12);

-- Insert users
INSERT INTO users (first_name, last_name, email, password, phone_number, birthdate, address) VALUES
('Fabian', 'Spiri', 'fababum@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '+41 79 570 46 59', '2000-01-01', 'Some Street 2, Bern'),
('Julian', 'Schwab', 'jla.schwab@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '+41 77 460 46 59', '2000-01-01', 'Some Street 1, Zürich'),
('Luc', 'Stützenegger', 'luc.stuzenegger@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '+41 76 500 00 00', '1998-12-15', 'Another Street 3, Basel');

-- Insert payment (for Julian and Luc)
INSERT INTO payments (user_id, cardholder_name, card_number, expiry_month, expiry_year, cvv, billing_address) VALUES
(2, 'Julian Schwab', '4111111111111111', '12', '2027', '123', 'Some Street 1, Zürich'),
(3, 'Luc Stützenegger', '4000123412341234', '11', '2026', '456', 'Another Street 3, Basel');

-- Insert orders: Julian books Suite Room 1 (id=5) for himself and Fabian, Luc books Deluxe Meeting Room 1 (id=9)
INSERT INTO orders (user_id, room_id, checkin_date, checkout_date, payment_method, payment_id, status) VALUES
(2, 5, '2025-05-27 14:00:00', '2025-06-15 12:00:00', 'credit_card', 1, 'confirmed'),
(3, 9, '2025-06-20 08:00:00', '2025-06-20 18:00:00', 'credit_card', 2, 'confirmed');

-- Insert order guests
INSERT INTO order_guests (order_id, user_id) VALUES 
(1, 2), 
(1, 1), 
(2, 3);
