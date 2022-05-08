/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.orderDetail;

import java.io.Serializable;

/**
 *
 * @author TamNXL
 */
public class OrderDetailDTO implements Serializable {
    private String orderId;
    private int cakeId;
    private int price;
    private int quantity;

    public OrderDetailDTO(String orderId, int cakeId, int price, int quantity) {
        this.orderId = orderId;
        this.cakeId = cakeId;
        this.price = price;
        this.quantity = quantity;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public int getCakeId() {
        return cakeId;
    }

    public void setCakeId(int cakeId) {
        this.cakeId = cakeId;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
}
