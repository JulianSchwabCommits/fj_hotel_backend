package com.example.fj_hotel.dto;

import com.example.fj_hotel.entity.Room;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AvailableRoomDto {
    private Integer roomId;
    private String roomName;
    private Integer capacity;
    private Room.RoomType roomType;
    private Room.Category category;
    private BigDecimal price;
    private Integer pictureId;
    
    public static AvailableRoomDto fromRoom(Room room) {
        return new AvailableRoomDto(
            room.getRoomId(),
            room.getRoomName(),
            room.getCapacity(),
            room.getRoomType(),
            room.getCategory(),
            room.getPrice(),
            room.getPictureId()
        );
    }
}
