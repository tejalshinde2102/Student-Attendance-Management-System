package com.sohel.smartattendencesystem;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class StaffDAO {
    
    public static boolean updateStaffProfile(int staffId, String fullName, String phone, int subjectId, String designation) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean isUpdated = false;
        
        try {
            conn = DataAccess.getConnection();
            String updateSQL = "UPDATE tbl_staff SET full_name=?, phone=?, subject=?, designation=? WHERE staff_id=?";
            
            stmt = conn.prepareStatement(updateSQL);
            stmt.setString(1, fullName);
            stmt.setString(2, phone);
            stmt.setInt(3, subjectId);
            stmt.setString(4, designation);
            stmt.setInt(5, staffId);

            int updated = stmt.executeUpdate();
            if (updated > 0) {
                isUpdated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return isUpdated;
    }
}
