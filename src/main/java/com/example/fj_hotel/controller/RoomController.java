package com.example.fj_hotel.controller;

import com.example.fj_hotel.dto.AvailableRoomDto;
import com.example.fj_hotel.entity.Room;
import com.example.fj_hotel.service.RoomService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/rooms")
@CrossOrigin(origins = "*")
public class RoomController {
    
    @Autowired
    private RoomService roomService;
    
    @GetMapping("/available")
    public ResponseEntity<?> getAvailableRooms(
            @RequestParam("checkin_date") 
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) 
            LocalDateTime checkinDate,
            
            @RequestParam("checkout_date") 
            @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) 
            LocalDateTime checkoutDate,
            
            @RequestParam(value = "capacity", required = false) 
            Integer capacity,
            
            @RequestParam(value = "category", required = false) 
            Room.Category category,
            
            @RequestParam(value = "room_type", required = false) 
            Room.RoomType roomType) {
        
        try {
            // Validate that checkout is after checkin
            if (checkoutDate.isBefore(checkinDate) || checkoutDate.isEqual(checkinDate)) {
                return ResponseEntity.badRequest()
                    .body("Checkout date must be after checkin date");
            }
            
            // Validate that checkin date is not in the past
            if (checkinDate.isBefore(LocalDateTime.now())) {
                return ResponseEntity.badRequest()
                    .body("Checkin date cannot be in the past");
            }
            
            List<AvailableRoomDto> availableRooms = roomService.getAvailableRooms(
                checkinDate, checkoutDate, capacity, category, roomType);
            
            return ResponseEntity.ok(availableRooms);
        } catch (Exception e) {
            return ResponseEntity.status(500)
                .body("Error retrieving available rooms: " + e.getMessage());
        }
    }
    
    @GetMapping
    public ResponseEntity<List<AvailableRoomDto>> getAllRooms() {
        try {
            List<AvailableRoomDto> rooms = roomService.getAllRooms();
            return ResponseEntity.ok(rooms);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<?> getRoomById(@PathVariable Integer id) {
        try {
            AvailableRoomDto room = roomService.getRoomById(id);
            if (room != null) {
                return ResponseEntity.ok(room);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(500)
                .body("Error retrieving room: " + e.getMessage());
        }
    }
}
