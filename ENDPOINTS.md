# API Endpoints Documentation

## 🏨 **Room Management**

### 1. **List All Rooms**

**Endpoint:** `GET /rooms`

**Description:** Returns all rooms with their details including capacity, category, price, and image information.

**Parameters:** None

---

### 2. **Get Room Details**

**Endpoint:** `GET /rooms/:id`

**Description:** Returns detailed information for a specific room by ID.

**Parameters:**
- `id` (Path Parameter): Room ID (Integer)

---

## 📅 **Availability & Booking**

### 3. **Check Available Rooms**

**Endpoint:** `GET /rooms/available`

**Description:** Returns a list of rooms not already booked during the specified date range.

**Required Parameters:**
- `checkin_date` (ISO DateTime): Check-in date and time
- `checkout_date` (ISO DateTime): Check-out date and time

**Optional Parameters:**
- `capacity` (Integer): Minimum room capacity
- `category` (String): Room category - `standard`, `deluxe`, `suite`
- `room_type` (String): Room type - `room`, `meeting_room`

---

## 🔧 **cURL Examples**

### Room Management

#### Get All Rooms
```bash
curl -X GET "http://localhost:8080/rooms"
```

#### Get Specific Room Details
```bash
# Get room with ID 1
curl -X GET "http://localhost:8080/rooms/1"

# Get room with ID 5 (Suite Room)
curl -X GET "http://localhost:8080/rooms/5"

# Get room with ID 31 (Meeting Room)
curl -X GET "http://localhost:8080/rooms/31"

# Test non-existent room (will return 404)
curl -X GET "http://localhost:8080/rooms/999"
```

### Availability Search

#### Basic Availability Check
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00"
```

#### Filter by Room Type (Only Regular Rooms)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&room_type=room"
```

#### Filter by Room Type (Only Meeting Rooms)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&room_type=meeting_room"
```

#### Filter by Category (Standard Rooms)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&category=standard"
```

#### Filter by Category (Deluxe Rooms)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&category=deluxe"
```

#### Filter by Category (Suite Rooms)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&category=suite"
```

#### Filter by Minimum Capacity (4+ people)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&capacity=4"
```

#### Filter by Minimum Capacity (10+ people)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&capacity=10"
```

#### Multiple Filters (Standard Regular Rooms)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&room_type=room&category=standard"
```

#### Multiple Filters (Deluxe Meeting Rooms)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&room_type=meeting_room&category=deluxe"
```

#### Multiple Filters (Suite Rooms with 4+ Capacity)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&category=suite&capacity=4"
```

#### Complex Filter (Standard Meeting Rooms with 15+ Capacity)
```bash
curl -X GET "http://localhost:8080/rooms/available?checkin_date=2025-06-15T15:00:00&checkout_date=2025-06-16T11:00:00&room_type=meeting_room&category=standard&capacity=15"
```

---

## 📝 **Response Format**

**Success Response (200 OK):**
```json
[
  {
    "roomId": 1,
    "roomName": "Standard Room 1",
    "capacity": 2,
    "roomType": "room",
    "category": "standard",
    "price": 100.00,
    "pictureId": 1
  },
  {
    "roomId": 2,
    "roomName": "Standard Room 2",
    "capacity": 2,
    "roomType": "room",
    "category": "standard",
    "price": 100.00,
    "pictureId": 4
  }
]
```

**Error Responses:**
- `400 Bad Request`: Invalid date parameters or checkout before checkin
- `500 Internal Server Error`: Database or server error

---

## 🗓️ **Date Format Examples**

All dates must be in ISO 8601 format with time:

- `2025-06-15T15:00:00` (3 PM on June 15, 2025)
- `2025-06-16T11:00:00` (11 AM on June 16, 2025)
- `2025-12-25T14:30:00` (2:30 PM on December 25, 2025)

---

## 🏨 **Available Room Categories**

- **standard**: Basic rooms and meeting rooms
- **deluxe**: Premium rooms and meeting rooms
- **suite**: Luxury rooms and meeting rooms

## 🏠 **Available Room Types**

- **room**: Regular hotel rooms for accommodation
- **meeting_room**: Conference and meeting spaces

---

## 📊 **Sample Data Overview**

**Regular Rooms (room_type=room):**
- Standard Room 1 & 2: 2 people, $100
- Deluxe Room 1 & 2: 3 people, $180
- Suite Room 1 & 2: 4 people, $300

**Meeting Rooms (room_type=meeting_room):**
- Standard Meeting Room 1 & 2: 10-12 people, $150-160
- Deluxe Meeting Room 1 & 2: 20-22 people, $250-260
- Suite Meeting Room 1 & 2: 30-35 people, $400-420
