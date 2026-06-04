package com.sohel.smartattendencesystem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactUs {

    private String name;
    private String email;
    private String message;
    private int id;
    private Timestamp createdAt;

    public int getId() {
        return id;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    // Default Constructor
    public ContactUs() {
    }

    // Getter & Setter Methods
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    // Constructor with ID and Created At
    public ContactUs(int id, String name, String email, String message, Timestamp createdAt) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.message = message;
        this.createdAt = createdAt;
    }

    // Constructor
    public ContactUs(String name, String email, String message) {
        this.name = name;
        this.email = email;
        this.message = message;
    }

    // Method to insert contact message into database
    public boolean saveMessage() {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DataAccess.getConnection();
            if (con != null) {
                String sql = "INSERT INTO tbl_contact_messages (name, email, message) VALUES (?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, this.name);
                ps.setString(2, this.email);
                ps.setString(3, this.message);
                int rowsAffected = ps.executeUpdate();
                return rowsAffected > 0; // Return true if insert was successful
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    // Function to fetch messages with pagination
    public static List<ContactUs> getMessages(int start, int recordsPerPage) {
        List<ContactUs> messages = new ArrayList<>();
        String sql = "SELECT id, name, email, message, created_at FROM tbl_contact_messages ORDER BY id DESC LIMIT ?, ?";

        try (Connection conn = DataAccess.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, start);
            stmt.setInt(2, recordsPerPage);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                messages.add(new ContactUs(
                        rs.getInt("id"), // Now fetching ID
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("message"),
                        rs.getTimestamp("created_at") // Fetching created_at
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return messages;
    }

    // Function to get total number of messages
    public static int getTotalMessages() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM tbl_contact_messages";

        try (Connection conn = DataAccess.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
}
