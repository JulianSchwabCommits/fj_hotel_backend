package com.example.fj_hotel.repository;

import com.example.fj_hotel.entity.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface RoomRepository extends JpaRepository<Room, Integer> {
    
    @Query("SELECT r FROM Room r WHERE r.roomId NOT IN " +
           "(SELECT o.roomId FROM Order o WHERE " +
           "((o.checkinDate <= :checkoutDate AND o.checkoutDate > :checkinDate) OR " +
           "(o.checkinDate < :checkoutDate AND o.checkoutDate >= :checkoutDate) OR " +
           "(o.checkinDate >= :checkinDate AND o.checkoutDate <= :checkoutDate)) " +
           "AND o.status IN ('pending', 'confirmed'))")
    List<Room> findAvailableRooms(@Param("checkinDate") LocalDateTime checkinDate, 
                                 @Param("checkoutDate") LocalDateTime checkoutDate);
    
    @Query("SELECT r FROM Room r WHERE r.roomId NOT IN " +
           "(SELECT o.roomId FROM Order o WHERE " +
           "((o.checkinDate <= :checkoutDate AND o.checkoutDate > :checkinDate) OR " +
           "(o.checkinDate < :checkoutDate AND o.checkoutDate >= :checkoutDate) OR " +
           "(o.checkinDate >= :checkinDate AND o.checkoutDate <= :checkoutDate)) " +
           "AND o.status IN ('pending', 'confirmed')) " +
           "AND (:capacity IS NULL OR r.capacity >= :capacity)")
    List<Room> findAvailableRoomsWithCapacity(@Param("checkinDate") LocalDateTime checkinDate, 
                                             @Param("checkoutDate") LocalDateTime checkoutDate,
                                             @Param("capacity") Integer capacity);
    
    @Query("SELECT r FROM Room r WHERE r.roomId NOT IN " +
           "(SELECT o.roomId FROM Order o WHERE " +
           "((o.checkinDate <= :checkoutDate AND o.checkoutDate > :checkinDate) OR " +
           "(o.checkinDate < :checkoutDate AND o.checkoutDate >= :checkoutDate) OR " +
           "(o.checkinDate >= :checkinDate AND o.checkoutDate <= :checkoutDate)) " +
           "AND o.status IN ('pending', 'confirmed')) " +
           "AND (:capacity IS NULL OR r.capacity >= :capacity) " +
           "AND (:category IS NULL OR r.category = :category) " +
           "AND (:roomType IS NULL OR r.roomType = :roomType)")
    List<Room> findAvailableRoomsWithFilters(@Param("checkinDate") LocalDateTime checkinDate, 
                                            @Param("checkoutDate") LocalDateTime checkoutDate,
                                            @Param("capacity") Integer capacity,
                                            @Param("category") Room.Category category,
                                            @Param("roomType") Room.RoomType roomType);
}
