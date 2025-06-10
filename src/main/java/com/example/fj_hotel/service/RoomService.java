package com.example.fj_hotel.service;

import com.example.fj_hotel.dto.AvailableRoomDto;
import com.example.fj_hotel.entity.Room;
import com.example.fj_hotel.repository.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class RoomService {
    
    private static final Logger logger = LoggerFactory.getLogger(RoomService.class);
    
    @Autowired
    private RoomRepository roomRepository;
    
    public List<AvailableRoomDto> getAvailableRooms(LocalDateTime checkinDate, 
                                                   LocalDateTime checkoutDate,
                                                   Integer capacity,
                                                   Room.Category category,
                                                   Room.RoomType roomType) {
        
        logger.info("Searching for available rooms from {} to {} with capacity: {}, category: {}, roomType: {}", 
                   checkinDate, checkoutDate, capacity, category, roomType);
        
        List<Room> availableRooms;
        
        // Use the most specific query based on provided parameters
        if (capacity != null || category != null || roomType != null) {
            availableRooms = roomRepository.findAvailableRoomsWithFilters(
                checkinDate, checkoutDate, capacity, category, roomType);
        } else {
            availableRooms = roomRepository.findAvailableRooms(checkinDate, checkoutDate);
        }
        
        logger.info("Found {} available rooms", availableRooms.size());
        
        return availableRooms.stream()
                .map(AvailableRoomDto::fromRoom)
                .collect(Collectors.toList());
    }
    
    public List<AvailableRoomDto> getAllRooms() {
        logger.info("Fetching all rooms");
        
        List<Room> allRooms = roomRepository.findAll();
        logger.info("Found {} total rooms", allRooms.size());
        
        return allRooms.stream()
                .map(AvailableRoomDto::fromRoom)
                .collect(Collectors.toList());
    }
    
    public AvailableRoomDto getRoomById(Integer roomId) {
        logger.info("Fetching room with ID: {}", roomId);
        
        return roomRepository.findById(roomId)
                .map(AvailableRoomDto::fromRoom)
                .orElse(null);
    }
}
