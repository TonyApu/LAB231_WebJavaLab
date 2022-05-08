/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.userInfor;

import java.io.Serializable;

/**
 *
 * @author TamNXL
 */
public class UserInforDTO implements Serializable {
    private String username;
    private String password;
    private String name;
    private String phone;
    private String email;
    private int roleId;

    public UserInforDTO() {
    }

    public UserInforDTO(String username, String password, String name, String phone, String email, int roleId) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.phone = phone;
        this.email = email;
        this.roleId = roleId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
}
