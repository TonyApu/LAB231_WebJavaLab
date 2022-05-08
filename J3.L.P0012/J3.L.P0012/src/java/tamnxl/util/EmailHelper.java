/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.util;

import java.io.Serializable;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author TamNXL
 */
public class EmailHelper implements Serializable {
    
    private String userEmail;

    public EmailHelper(String userEmail) {
        this.userEmail = userEmail;
    }

    public void sendConfirmBookingMail(String bookID) throws MessagingException {
        String email = "nguyenxuanlinhtam0205@gmail.com";
        String password = "0982423454";

        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getDefaultInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, password);
            }
        });
        
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(email));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
        message.setSubject("Email Verification Link");
        message.setText("Click this link to confirm your Booking."
                + "\n\nVerification Link: " + "http://localhost:8084/J3.L.P0012/confirmBooking?key1=" + bookID);

        Transport.send(message);
    }
    
    public void sendConfirmResetPasswordMail(String username, String newPassword) throws MessagingException {
        String email = "nguyenxuanlinhtam0205@gmail.com";
        String password = "0982423454";
        
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getDefaultInstance(properties, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, password);
            }

        });
        
        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(email));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
        message.setSubject("Email Verification Link");
        message.setText("Click this link to confirm your new password."
                + "\n\nVerification Link: " + "http://localhost:8084/J3.L.P0012/confirmResetPassword?key1=" + username + "&key2=" + newPassword);

        Transport.send(message);
    }
}
