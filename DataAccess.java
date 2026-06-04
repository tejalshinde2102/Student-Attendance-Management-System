/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sohel.smartattendencesystem;
import com.mysql.jdbc.Driver;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DataAccess {
    public static final String URL = "jdbc:mysql://localhost:3306/dbsmartattendence";

    public static final String USER = "root";

    public static final String PASS = "root";
    
    
    public static Connection getConnection() throws SQLException

    {

      try {

          DriverManager.registerDriver(new Driver());

          return DriverManager.getConnection(URL, USER, PASS);

      }
      catch (Exception ex)
      {
          System.out.println(ex);
        //  throw new RuntimeException("Error connecting to the database", ex);

      }
            return null;
    
    }
}
