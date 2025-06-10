package com.example.fj_hotel.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "orders")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Order {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Integer orderId;
    
    @Column(name = "user_id", nullable = false)
    private Integer userId;
    
    @Column(name = "room_id", nullable = false)
    private Integer roomId;
    
    @Column(name = "checkin_date", nullable = false)
    private LocalDateTime checkinDate;
    
    @Column(name = "checkout_date", nullable = false)
    private LocalDateTime checkoutDate;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "payment_method", nullable = false)
    private PaymentMethod paymentMethod;
    
    @Column(name = "payment_id")
    private Integer paymentId;
    
    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private Status status = Status.pending;
    
    @Column(name = "created_at")
    private LocalDateTime createdAt;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", insertable = false, updatable = false)
    private User user;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "room_id", insertable = false, updatable = false)
    private Room room;
    
    public enum PaymentMethod {
        credit_card, cash, other
    }
    
    public enum Status {
        pending, confirmed, cancelled, completed
    }
    
    @PrePersist
    public void prePersist() {
        this.createdAt = LocalDateTime.now();
    }
}
