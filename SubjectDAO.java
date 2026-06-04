package com.sohel.smartattendencesystem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SubjectDAO {
    private int subjectId;
    private String subjectName;

    // Constructor
    public SubjectDAO(int subjectId, String subjectName) {
        this.subjectId = subjectId;
        this.subjectName = subjectName;
    }

    // Default constructor
    public SubjectDAO() {}

    // Getters and Setters
    public int getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    // Function to retrieve all subjects
    public static List<SubjectDAO> getSubjects() {
        List<SubjectDAO> subjects = new ArrayList<>();
        String sql = "SELECT subject_id, subject_name FROM tbl_subjects";

        try (Connection conn = DataAccess.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                subjects.add(new SubjectDAO(rs.getInt("subject_id"), rs.getString("subject_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subjects;
    }

    // Function to retrieve subjects with pagination
    public static List<SubjectDAO> getSubjects(int start, int recordsPerPage) {
        List<SubjectDAO> subjects = new ArrayList<>();
        String sql = "SELECT subject_id, subject_name FROM tbl_subjects LIMIT ?, ?";

        try (Connection conn = DataAccess.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, start);
            stmt.setInt(2, recordsPerPage);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                subjects.add(new SubjectDAO(rs.getInt("subject_id"), rs.getString("subject_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subjects;
    }

    // Function to get total count of subjects
    public static int getTotalSubjects() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM tbl_subjects";

        try (Connection conn = DataAccess.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // Function to add a new subject
    public static boolean addSubject(String subjectName) {
        String sql = "INSERT INTO tbl_subjects (subject_name) VALUES (?)";

        try (Connection conn = DataAccess.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, subjectName);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Function to update an existing subject
    public static boolean updateSubject(int subjectId, String subjectName) {
        String sql = "UPDATE tbl_subjects SET subject_name = ? WHERE subject_id = ?";

        try (Connection conn = DataAccess.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, subjectName);
            stmt.setInt(2, subjectId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Function to delete a subject by ID
    public static boolean deleteSubject(int subjectId) {
        String sql = "DELETE FROM tbl_subjects WHERE subject_id = ?";

        try (Connection conn = DataAccess.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, subjectId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
     

    // Function to retrieve a subject by ID for editing
    public static SubjectDAO getSubjectById(int subjectId) {
        String sql = "SELECT subject_id, subject_name FROM tbl_subjects WHERE subject_id = ?";
        SubjectDAO subject = null;

        try (Connection conn = DataAccess.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, subjectId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                subject = new SubjectDAO(rs.getInt("subject_id"), rs.getString("subject_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subject;
    }
}
