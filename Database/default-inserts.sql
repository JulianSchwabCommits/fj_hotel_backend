-- Insert pictures
INSERT INTO pictures (image_data, file_name, mime_type) VALUES
(LOAD_FILE('/var/lib/mysql-files/Images/Standard-Room-1.jpg'), 'Standard-Room-1.jpg', 'image/jpeg'),
(LOAD_FILE('/var/lib/mysql-files/Images/Suite-Room-2.jpg'), 'Suite-Room-2.jpg', 'image/jpeg'),
(LOAD_FILE('/var/lib/mysql-files/Images/Deluxe-Room-2.webp'), 'Deluxe-Room-2.webp', 'image/webp'),
(LOAD_FILE('/var/lib/mysql-files/Images/Standard-Room-2.jpg'), 'Standard-Room-2.jpg', 'image/jpeg'),
(LOAD_FILE('/var/lib/mysql-files/Images/Suite-Room-1.jpg'), 'Suite-Room-1.jpg', 'image/jpeg'),
(LOAD_FILE('/var/lib/mysql-files/Images/Deluxe-Room-1.webp'), 'Deluxe-Room-1.webp', 'image/webp'),
(LOAD_FILE('/var/lib/mysql-files/Images/Standard-Meetingroom-1.jpg'), 'Standard-Meetingroom-1.jpg', 'image/jpeg'),
(LOAD_FILE('/var/lib/mysql-files/Images/Standard-Meetingroom-2.jpg'), 'Standard-Meetingroom-2.jpg', 'image/jpeg'),
(LOAD_FILE('/var/lib/mysql-files/Images/Deluxe-Meetingroom-1.jpg'), 'Deluxe-Meetingroom-1.jpg', 'image/jpeg'),
(LOAD_FILE('/var/lib/mysql-files/Images/Deluxe-Meetingroom-2.jpg'), 'Deluxe-Meetingroom-2.jpg', 'image/jpeg'),
(LOAD_FILE('/var/lib/mysql-files/Images/Suite-Meetingroom-1.webp'), 'Suite-Meetingroom-1.webp', 'image/webp'),
(LOAD_FILE('/var/lib/mysql-files/Images/Suite-Meetingroom-2.webp'), 'Suite-Meetingroom-2.webp', 'image/webp');

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
INSERT INTO order_guests (order_id, user_id) VALUES (1, 2);
INSERT INTO order_guests (order_id, user_id) VALUES (1, 1);
INSERT INTO order_guests (order_id, user_id) VALUES (2, 3);
