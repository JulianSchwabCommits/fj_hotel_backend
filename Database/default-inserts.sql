-- Insert pictures
INSERT INTO pictures (image_data, file_name, mime_type) VALUES
(LOAD_FILE('\\\\wsl.localhost\\Ubuntu\\home\\julian\\coding\\fj_hotel_backend\\Images\\Standard-Room-1.jpg'), 'Standard-Room-1.jpg', 'image/jpeg'),
(LOAD_FILE('\\\\wsl.localhost\\Ubuntu\\home\\julian\\coding\\fj_hotel_backend\\Images\\Suite-Room-2.jpg'), 'Suite-Room-2.jpg', 'image/jpeg'),
(LOAD_FILE('\\\\wsl.localhost\\Ubuntu\\home\\julian\\coding\\fj_hotel_backend\\Images\\Deluxe-Room-2.webp'), 'Deluxe-Room-2.webp', 'image/webp'),
(LOAD_FILE('\\\\wsl.localhost\\Ubuntu\\home\\julian\\coding\\fj_hotel_backend\\Images\\Standard-Room-2.jpg'), 'Standard-Room-2.jpg', 'image/jpeg'),
(LOAD_FILE('\\\\wsl.localhost\\Ubuntu\\home\\julian\\coding\\fj_hotel_backend\\Images\\Suite-Room-1.jpg'), 'Suite-Room-1.jpg', 'image/jpeg'),
(LOAD_FILE('\\\\wsl.localhost\\Ubuntu\\home\\julian\\coding\\fj_hotel_backend\\Images\\Deluxe-Room-1.webp'), 'Deluxe-Room-1.webp', 'image/webp');

-- Insert rooms
INSERT INTO rooms (room_name, capacity, room_type, category, price, picture_id) VALUES
('Standard Room 1', 2, 'room', 'standard', 100.00, 1),
('Standard Room 2', 2, 'room', 'standard', 100.00, 4),
('Deluxe Room 1', 3, 'room', 'deluxe', 180.00, 6),
('Deluxe Room 2', 3, 'room', 'deluxe', 180.00, 3),
('Suite Room 1', 4, 'room', 'suite', 300.00, 5),
('Suite Room 2', 4, 'room', 'suite', 300.00, 2);

-- Insert users
INSERT INTO users (first_name, last_name, email, password, phone_number) VALUES
('Fabian', 'Spiri', 'fababum@gmail.com', '76bfb30e51b77a2da8ec902cff0fe997b4a9e9a5afddccef511c669155386c47', '+41 79 570 46 59'),
('Julian', 'Schwab', 'jla.schwab@gmail.com', 'bb299f20f2858d8936659521f8b1d0d27cddb31e6c45ae2efdbbe2580e0a7bc2', '+41 77 460 46 59');

-- Insert payment (for Julian)
INSERT INTO payments (user_id, cardholder_name, card_number, expiry_month, expiry_year, cvv, billing_address) VALUES
(2, 'Julian Schwab', '4111111111111111', '12', '2027', '123', 'Some Street 1, Zürich');

-- Insert order: Julian books Suite Room 1 (id=5) for himself and Fabian
INSERT INTO orders (user_id, room_id, checkin_date, checkout_date, payment_method, payment_id, status) VALUES
(2, 5, '2025-05-27', '2025-06-15', 'credit_card', 1, 'confirmed');

-- Julian's order id is 1 (auto_incremented). Add Julian and Fabian as guests.
-- Replace `1` with the actual `order_id` if different in your DB.

-- Link Julian (user_id=2) as guest
INSERT INTO order_guests (order_id, user_id) VALUES (1, 2);

-- Link Fabian (user_id=1) as guest
INSERT INTO order_guests (order_id, user_id) VALUES (1, 1);
