-- Picture table (to store BLOBs)
CREATE TABLE pictures (
    picture_id INT AUTO_INCREMENT PRIMARY KEY,
    image_data LONGBLOB NOT NULL,
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
    phone_number VARCHAR(20)
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
    checkin_date DATE NOT NULL,
    checkout_date DATE NOT NULL,
    payment_method ENUM('credit_card', 'paypal', 'other') NOT NULL,
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
