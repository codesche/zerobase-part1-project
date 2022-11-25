package DataBase;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection(){
        Connection conn = null;
        try {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:F:\\dev\\zerobase-part1-project\\wifi_info.sqlite");
            System.out.println("DBConnection Success");

        }catch (Exception e){
            e.printStackTrace();
        }

        return conn;
    }

    public static void main(String[] args) {
        getConnection();
    }
}
