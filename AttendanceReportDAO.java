package com.sohel.smartattendencesystem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AttendanceReportDAO {

    //REPORT ATTENDECE BY SUBJECT AND DATE
    public static ResultSet getAttendanceReport(String date, int subjectId) {
        ResultSet rs = null;
        String sql = "SELECT a.attendance_id, a.student_name, a.roll_no, s.subject_name, a.attendance_date "
                + "FROM tbl_attendance a "
                + "JOIN tbl_subjects s ON a.subject_id = s.subject_id "
                + "WHERE DATE(a.attendance_date) = ? AND a.subject_id = ?";

        try {
            Connection conn = DataAccess.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, date);
            stmt.setInt(2, subjectId);
            rs = stmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rs;
    }
    
    //REPORT ATTENDANCE BY STUDENT
    public static ResultSet getAttendanceReportByStudent(String studentName, int subjectId, String startDate, String endDate) {
    ResultSet rs = null;
    try {
        Connection conn = DataAccess.getConnection();
        String query = "SELECT a.attendance_id, a.student_name, a.roll_no, s.subject_name, a.attendance_date " +
                       "FROM tbl_attendance a " +
                       "JOIN tbl_subjects s ON a.subject_id = s.subject_id " +
                       "WHERE a.student_name = ? AND a.subject_id = ? " +
                       "AND DATE(a.attendance_date) BETWEEN ? AND ? " +
                       "ORDER BY a.attendance_date ASC";

        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, studentName);
        stmt.setInt(2, subjectId);
        stmt.setString(3, startDate);
        stmt.setString(4, endDate);

        rs = stmt.executeQuery();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return rs;
}

    //Deleting the perticular student Attendance
     public static boolean deleteAttendance(int attendanceId) {
        boolean isDeleted = false;
        Connection con = null;
        PreparedStatement pstmt = null;
        
        try {
            con = DataAccess.getConnection();
            String query = "DELETE FROM tbl_attendance WHERE attendance_id = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, attendanceId);
            
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                isDeleted = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        return isDeleted;
    }
}
