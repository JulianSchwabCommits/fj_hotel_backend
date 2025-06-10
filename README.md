# fj_hotel_backend

Great! Since you already have **signup** and **signin** endpoints, here’s a list of **useful RESTful API endpoints** to cover the rest of your booking system:


###  **Login**

#### 1. **Login**

* **GET** `/auth/login`
* **Query Params**: `email`, `password`
* **Description**: login

---

### 📅 **Signup**

#### 1. **Signup**

* **GET** `/auth/signup`
* **Query Params**: `firstname`, `lastname`, `email`, `password`, `adress`,`phonenumber`, `birthdate`
* **Description**:signup 

---
### 📅 **Availability & Booking**

#### 1. **Check Available Rooms**

* **GET** `/rooms/available`
* **Query Params**: `checkin_date`, `checkout_date`, `capacity?`, `category?`, `room_type?`
* **Description**: Returns a list of rooms not already booked during the specified date range.

---

### 🏨 **Room Management**

#### 2. **List All Rooms**

* **GET** `/rooms`
* **Description**: Returns all rooms with their details and images.

#### 3. **Get Room Details**

* **GET** `/rooms/:id`
* **Description**: Returns detailed info (capacity, category, price, image) for a room.

---

### 💳 **Payments**

#### 4. **Add Payment Method**

* **POST** `/payments`
* **Body**: `user_id`, `cardholder_name`, `card_number`, `expiry_month`, `expiry_year`, `cvv`, `billing_address`
* **Description**: Adds a new payment method.

---

### 🛒 **Order/Booking**

#### 5. **Create Booking**

* **POST** `/orders`
* **Body**: `user_id`, `room_id`, `checkin_date`, `checkout_date`, `payment_method`, `payment_id`, `guests` (list of user IDs)
* **Description**: Books a room and assigns guests.

#### 6. **List User Orders**

* **GET** `/users/:id/orders`
* **Description**: Returns all bookings made by a user.

#### 7. **Get Order Details**

* **GET** `/orders/:id`
* **Description**: Returns full booking info, guests, payment info.

#### 8. **Cancel Order**

* **PATCH** `/orders/:id/cancel`
* **Description**: Updates the order status to `cancelled`.

---

### 👥 **Guest Management**

#### 9. **Add Guest to Order**

* **POST** `/orders/:id/guests`
* **Body**: `user_id`
* **Description**: Adds a guest to an existing order.

#### 10. **Remove Guest from Order**

* **DELETE** `/orders/:id/guests/:user_id`
* **Description**: Removes a guest from the order.




### ⚙️ Other Suggestions

* **Authentication Middleware** to protect `/orders`, `/payments`, etc.
* **Room Filtering** on `/rooms/available` (by price range, type, etc.)
* **Rate Limiting** on signup/signin.
* **Hash Passwords** before storage (looks like you’re doing that already 👍).

