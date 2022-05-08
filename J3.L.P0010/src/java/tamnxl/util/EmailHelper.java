/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.util;

import java.io.Serializable;
import java.util.Properties;
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
    
    private final String userEmail;

    public EmailHelper(String userEmail) {
        this.userEmail = userEmail;
    }
    
     public void sendMail() throws MessagingException {
        // Enter the email address and password for the account from which verification link will be send
        String email = "nguyenxuanlinhtam0205@gmail.com";
        String password = "0982423454";

        Properties theProperties = new Properties();

        theProperties.put("mail.smtp.auth", "true");
        theProperties.put("mail.smtp.starttls.enable", "true");
        theProperties.put("mail.smtp.host", "smtp.gmail.com");
        theProperties.put("mail.smtp.port", "587");

        Session session = Session.getDefaultInstance(theProperties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, password);
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(email));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
        message.setSubject("Email Verification Link");
        message.setText("Click this link to confirm your email address and complete setup for your account."
                + "\n\nVerification Link: " + "http://localhost:8084/J3.L.P0010/ActiveAccountServlet?txtEmail=" + userEmail);

        Transport.send(message);

        System.out.println("Successfully sent Verification Link");

    }
}
