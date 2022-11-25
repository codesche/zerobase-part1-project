
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DataBase.DBConnection" %>
<%@ page import="DataBase.WifiInfo" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="DataBase.WifiDto" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>

<%
    Connection conn = DBConnection.getConnection();

    final String CREATE_History = "CREATE TABLE IF NOT EXISTS History"
            + "("
            + " ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,"
            + " Y좌표 DOUBLE NOT NULL,"
            + " X좌표 DOUBLE NOT NULL,"
            + " 조회날짜 varchar(45) NOT NULL"
            + ")";

    final String SqlCreate = "CREATE TABLE IF NOT EXISTS WiFi"
            + "("
            + " 관리번호 varchar(45) NOT NULL,"
            + " 자치구 varchar(45) NOT NULL,"
            + " 와이파이명 varchar(45) NOT NULL,"
            + " 도로명주소 varchar(45) NOT NULL,"
            + " 상세주소 varchar(45),"
            + " 설치위치 varchar(45),"
            + " 설치유형 varchar(45) NOT NULL,"
            + " 설치기관 varchar(45) NOT NULL,"
            + " 서비스구분 varchar(45) NOT NULL,"
            + " 망종류 varchar(45) NOT NULL,"
            + " 설치년도 varchar(45) NOT NULL,"
            + " 실내외구분 varchar(45) NOT NULL,"
            + " wifi접속환경 varchar(45),"
            + " Y좌표 DOUBLE NOT NULL,"
            + " X좌표 DOUBLE NOT NULL,"
            + " 작업일자 varchar(45) NOT NULL"
            + ")";

    final String SqlInsert = "INSERT into WiFi VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    final String SqlDrop = "Drop Table IF EXISTS WiFi";

    ArrayList<WifiDto> wifi = null;
    WifiInfo wifiInfo = new WifiInfo();
    PreparedStatement ps;
    Statement sm;

    try {
        sm = conn.createStatement();
        sm.execute(SqlDrop);

        sm = conn.createStatement();
        sm.execute(CREATE_History);

        sm = conn.createStatement();
        sm.execute(SqlCreate);

        ps = conn.prepareStatement(SqlInsert);

        wifi = wifiInfo.getWifiInfo();

        for (int i = 0; i < wifi.size(); i++) {
            ps.setString(1, (wifi.get(i).getX_SWIFI_MGR_NO()));
            ps.setString(2, (wifi.get(i).getX_SWIFI_WRDOFC()));
            ps.setString(3, (wifi.get(i).getX_SWIFI_MAIN_NM()));
            ps.setString(4, (wifi.get(i).getX_SWIFI_ADRES1()));
            ps.setString(5, (wifi.get(i).getX_SWIFI_ADRES2()));
            ps.setString(6, (wifi.get(i).getX_SWIFI_INSTL_FLOOR()));
            ps.setString(7, (wifi.get(i).getX_SWIFI_INSTL_TY()));
            ps.setString(8, (wifi.get(i).getX_SWIFI_INSTL_MBY()));
            ps.setString(9, (wifi.get(i).getX_SWIFI_SVC_SE()));
            ps.setString(10, (wifi.get(i).getX_SWIFI_CMCWR()));
            ps.setString(11, (wifi.get(i).getX_SWIFI_CNSTC_YEAR()));
            ps.setString(12, (wifi.get(i).getX_SWIFI_INOUT_DOOR()));
            ps.setString(13, (wifi.get(i).getX_SWIFI_REMARS3()));
            ps.setDouble(14, wifi.get(i).getLAT());
            ps.setDouble(15, wifi.get(i).getLNT());
            ps.setString(16, (wifi.get(i).getWORK_DTTM()));

            ps.execute();

            System.out.println(i + "번째 처리중...");
        }
        sm.close();
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("연결해제");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>

<html>
<head>
    <title>Data Working</title>
</head>
<body>
    <H3 align="center"><%=wifi.size()%>개의 WiFi정보를 정상적으로 저장하였습니다.</H3>
    <H3 align="center"><a href="index.jsp">홈으로 가기</a></H3>
</body>
</html>
