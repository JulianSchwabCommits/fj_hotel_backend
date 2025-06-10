# 🧪 Hotel API Test Suite

Interactive HTML test pages for the FJ Hotel Backend API endpoints.

## 📁 Files

- **`index.html`** - Main test suite dashboard with links to all tests
- **`all-rooms-test.html`** - Test `/rooms` endpoint (list all rooms)
- **`room-details-test.html`** - Test `/rooms/:id` endpoint (get specific room)
- **`available-rooms-test.html`** - Test `/rooms/available` endpoint (search availability)

## 🚀 How to Use

1. **Start your Spring Boot application:**
   ```bash
   ./mvnw spring-boot:run
   ```

2. **Open any test page in your browser:**
   ```bash
   # Open main dashboard
   open test-html/index.html
   
   # Or open specific tests
   open test-html/all-rooms-test.html
   open test-html/room-details-test.html
   open test-html/available-rooms-test.html
   ```

3. **Test the endpoints interactively:**
   - Click buttons to make API calls
   - View formatted JSON responses
   - See the actual URLs being called
   - Test error scenarios (like 404 errors)

## 🎯 Features

### All Rooms Test (`all-rooms-test.html`)
- ✅ Load all rooms from `/rooms`
- ✅ Test specific room by ID from `/rooms/:id`
- ✅ Beautiful grid layout of room cards
- ✅ Links to other test pages

### Room Details Test (`room-details-test.html`)
- ✅ Get room details by ID
- ✅ Quick test buttons for different room types
- ✅ 404 error testing
- ✅ Detailed room information display

### Available Rooms Test (`available-rooms-test.html`)
- ✅ Date picker for check-in/check-out
- ✅ Optional filters (capacity, category, room type)
- ✅ Quick test with preset dates
- ✅ Shows actual API URL being called
- ✅ Comprehensive filtering options

### Main Dashboard (`index.html`)
- ✅ Overview of all implemented endpoints
- ✅ Links to individual test pages
- ✅ API documentation summary
- ✅ Implementation status

## 🔧 Technical Details

- **No external dependencies** - Pure HTML, CSS, JavaScript
- **CORS enabled** - API configured to accept cross-origin requests
- **Real-time testing** - Direct API calls to `localhost:8080`
- **Error handling** - Displays HTTP errors and validation messages
- **Responsive design** - Works on desktop and mobile

## 📊 API Endpoints Tested

| Endpoint | Method | Description | Status |
|----------|--------|-------------|--------|
| `/rooms` | GET | List all rooms | ✅ Working |
| `/rooms/:id` | GET | Get room details | ✅ Working |
| `/rooms/available` | GET | Search available rooms | ✅ Working |

## 🎨 Visual Features

- **Color-coded room types:** Blue for rooms, Purple for meeting rooms
- **Category badges:** Orange for Standard, Green for Deluxe, Pink for Suite
- **Interactive cards:** Hover effects and click animations
- **Loading states:** Visual feedback during API calls
- **Error displays:** Clear error messages with styling

## 💡 Tips

1. **Make sure your backend is running** on `http://localhost:8080`
2. **Check browser console** for detailed error messages
3. **Use Quick Test buttons** for immediate testing
4. **Try different date ranges** to see availability changes
5. **Test with invalid room IDs** to see 404 handling

Perfect for development, testing, and demonstrating the API functionality! 🎉
