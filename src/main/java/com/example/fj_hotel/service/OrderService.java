package com.example.fj_hotel.service;

import com.example.fj_hotel.dto.OrderRequest;
import com.example.fj_hotel.dto.OrderResponse;
import com.example.fj_hotel.entity.Order;
import com.example.fj_hotel.entity.Room;
import com.example.fj_hotel.entity.User;
import com.example.fj_hotel.repository.OrderRepository;
import com.example.fj_hotel.repository.RoomRepository;
import com.example.fj_hotel.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderService {

    private static final Logger logger = LoggerFactory.getLogger(OrderService.class);
    
    private final OrderRepository orderRepository;
    private final RoomRepository roomRepository;
    private final UserRepository userRepository;
    
    public OrderResponse createOrder(OrderRequest orderRequest) {
        try {
            logger.info("Creating new order for user ID: {} and room ID: {}", 
                       orderRequest.getUserId(), orderRequest.getRoomId());
                       
            // Validate user exists
            Optional<User> userOpt = userRepository.findById(orderRequest.getUserId());
            if (userOpt.isEmpty()) {
                logger.error("User not found with ID: {}", orderRequest.getUserId());
                return OrderResponse.error("User not found");
            }
            
            // Validate room exists
            Optional<Room> roomOpt = roomRepository.findById(orderRequest.getRoomId());
            if (roomOpt.isEmpty()) {
                logger.error("Room not found with ID: {}", orderRequest.getRoomId());
                return OrderResponse.error("Room not found");
            }
            
            Room room = roomOpt.get();
            
            // Validate dates
            if (orderRequest.getCheckinDate().isAfter(orderRequest.getCheckoutDate())) {
                logger.error("Check-in date cannot be after check-out date");
                return OrderResponse.error("Check-in date cannot be after check-out date");
            }
            
            if (orderRequest.getCheckinDate().isBefore(LocalDateTime.now())) {
                logger.error("Check-in date cannot be in the past");
                return OrderResponse.error("Check-in date cannot be in the past");
            }
            
            // Check if room is available for the selected dates
            List<Room> availableRooms = roomRepository.findAvailableRooms(
                orderRequest.getCheckinDate(), 
                orderRequest.getCheckoutDate()
            );
            
            boolean isRoomAvailable = availableRooms.stream()
                .anyMatch(r -> r.getRoomId().equals(orderRequest.getRoomId()));
                
            if (!isRoomAvailable) {
                logger.error("Room is not available for the selected dates");
                return OrderResponse.error("Room is not available for the selected dates");
            }
            
            // Create order
            Order order = new Order();
            order.setUserId(orderRequest.getUserId());
            order.setRoomId(orderRequest.getRoomId());
            order.setCheckinDate(orderRequest.getCheckinDate());
            order.setCheckoutDate(orderRequest.getCheckoutDate());
            order.setPaymentMethod(orderRequest.getPaymentMethod());
            order.setPaymentId(orderRequest.getPaymentId());
            order.setStatus(Order.Status.pending);
            
            // Save order
            Order savedOrder = orderRepository.save(order);
            logger.info("Order created successfully with ID: {}", savedOrder.getOrderId());
            
            OrderResponse response = OrderResponse.fromOrder(savedOrder);
            response.setRoomName(room.getRoomName());
            response.setMessage("Order created successfully");
            return response;
            
        } catch (Exception e) {
            logger.error("Error creating order: {}", e.getMessage(), e);
            return OrderResponse.error("Error creating order: " + e.getMessage());
        }
    }
    
    public List<OrderResponse> getOrdersByUserId(Integer userId) {
        logger.info("Fetching orders for user ID: {}", userId);
        
        // Check if user exists
        if (!userRepository.existsById(userId)) {
            logger.error("User not found with ID: {}", userId);
            return List.of(OrderResponse.error("User not found"));
        }
        
        List<Order> orders = orderRepository.findByUserId(userId);
        logger.info("Found {} orders for user ID: {}", orders.size(), userId);
        
        return orders.stream()
            .map(OrderResponse::fromOrder)
            .collect(Collectors.toList());
    }
    
    public OrderResponse getOrderById(Integer orderId) {
        logger.info("Fetching order with ID: {}", orderId);
        
        return orderRepository.findById(orderId)
            .map(order -> {
                OrderResponse response = OrderResponse.fromOrder(order);
                response.setMessage("Order found");
                return response;
            })
            .orElseGet(() -> {
                logger.error("Order not found with ID: {}", orderId);
                return OrderResponse.error("Order not found");
            });
    }
    
    public OrderResponse updateOrderStatus(Integer orderId, Order.Status newStatus) {
        logger.info("Updating order ID: {} to status: {}", orderId, newStatus);
        
        return orderRepository.findById(orderId)
            .map(order -> {
                order.setStatus(newStatus);
                Order updatedOrder = orderRepository.save(order);
                logger.info("Order status updated successfully");
                
                OrderResponse response = OrderResponse.fromOrder(updatedOrder);
                response.setMessage("Order status updated successfully");
                return response;
            })
            .orElseGet(() -> {
                logger.error("Order not found with ID: {}", orderId);
                return OrderResponse.error("Order not found");
            });
    }
    
    public OrderResponse cancelOrder(Integer orderId) {
        logger.info("Cancelling order with ID: {}", orderId);
        
        return updateOrderStatus(orderId, Order.Status.cancelled);
    }
}
