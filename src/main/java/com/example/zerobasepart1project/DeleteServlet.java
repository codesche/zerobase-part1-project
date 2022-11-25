package com.example.zerobasepart1project;


import DataBase.DBConnection;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;


@WebServlet("/delete.jsp")
public class DeleteServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int value = Integer.parseInt(request.getParameter("idx"));
        Connection conn = DBConnection.getConnection();

        String delete = "Delete from History where ID = " + value;

        try {
            PreparedStatement ps = conn.prepareStatement(delete);
            ps.execute();

            response.sendRedirect("history.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                    System.out.println("delete Connection Closed");
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

    }

    public void destroy() {
    }
}