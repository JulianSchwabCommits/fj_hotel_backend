package com.example.fj_hotel.dto;

import com.example.fj_hotel.entity.Order;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderResponse {
    private Integer orderId;
    private Integer userId;
    private Integer roomId;
    private String roomName;
    private LocalDateTime checkinDate;
    private LocalDateTime checkoutDate;
    private Order.PaymentMethod paymentMethod;
    private Order.Status status;
    private LocalDateTime createdAt;
    private String message;
    private boolean success;
    
    public static OrderResponse fromOrder(Order order) {
        return OrderResponse.builder()
            .orderId(order.getOrderId())
            .userId(order.getUserId())
            .roomId(order.getRoomId())
            .roomName(order.getRoom() != null ? order.getRoom().getRoomName() : null)
            .checkinDate(order.getCheckinDate())
            .checkoutDate(order.getCheckoutDate())
            .paymentMethod(order.getPaymentMethod())
            .status(order.getStatus())
            .createdAt(order.getCreatedAt())
            .success(true)
            .build();
    }
    
    public static OrderResponse error(String message) {
        return OrderResponse.builder()
            .success(false)
            .message(message)
            .build();
    }
}
