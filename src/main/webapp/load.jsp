
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DataBase.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>

<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="location.js"></script>
    <title>와이파이 정보 구하기</title>
</head>

<body>

<h1>와이파이 정보 구하기</h1>
<div>
    <ul class="nav justify-content-start bg-light float-left">
        <a class="nav-link" href="index.jsp">Home</a> |
        <a class="nav-link" href="history.jsp">History</a> |
        <a class="nav-link" href="load-wifi.jsp">Wi-Fi information</a>
    </ul>
</div>
<br/>

<%
    int cnt = 0;
    final String SqlInsertHistory = "INSERT INTO History(Y좌표, X좌표, 조회날짜) VALUES(?, ?, ?)";

    Connection conn = DBConnection.getConnection();
    Double lat = Double.parseDouble(request.getParameter("lat"));
    Double lnt = Double.parseDouble(request.getParameter("lnt"));

    PreparedStatement ps = conn.prepareStatement(SqlInsertHistory);
    ps.setDouble(1, lat);
    ps.setDouble(2, lnt);
    ps.setString(3, new Date().toString());
    ps.execute();

    String calcDist = "SELECT *, \n" +
            "       (6371 * acos(cos(radians(" + lnt + ")) " +
            " * cos(radians(X좌표)) " +
            " * cos(radians(Y좌표) - radians("+ lat +")) +sin(radians("+ lnt +"))" +
            " * sin(radians(X좌표)))) \n" +
            "           AS dist\n" +
            "FROM WiFi ORDER BY dist";

    ps = conn.prepareStatement(calcDist);
    ResultSet rs = ps.executeQuery();

%>
    <form method="get" action="/load.jsp">
        <p> LAT : <input type="text" id="location_lat" name="lat"/>
            LNT : <input type="text" id="location_lnt" name="lnt"/>
            <input type="button", value="내 위치 가져오기" onclick="on()"/>
            <input type="submit", value="근처 Wi-Fi 정보 보기" onclick="noValueError()"/>
    </form>

<table class="table table-bordered">
        <tr>
            <th scope="col">거리</th>
            <th scope="col">관리번호</th>
            <th scope="col">자치구</th>
            <th scope="col">와이파이명</th>
            <th scope="col">도로명주소</th>
            <th scope="col">상세주소</th>
            <th scope="col">설치위치</th>
            <th scope="col">설치기관</th>
            <th scope="col">서비스구분</th>
            <th scope="col">망종류</th>
            <th scope="col">설치년도</th>
            <th scope="col">실내외구분</th>
            <th scope="col">wifi접속환경</th>
            <th scope="col">Y좌표</th>
            <th scope="col">X좌표</th>
            <th scope="col">작업일자</th>
            <%
            while (rs.next() && cnt < 20){
                cnt++;
            %>
                <tr>
                    <td><%= rs.getString("dist").substring(0, 5)%></td>
                    <td><%= rs.getString("관리번호") %></td>
                    <td><%= rs.getString("자치구") %></td>
                    <td><%= rs.getString("와이파이명") %></td>
                    <td><%= rs.getString("도로명주소") %></td>
                    <td><%= rs.getString("상세주소") %></td>
                    <td><%= rs.getString("설치위치") %></td>
                    <td><%= rs.getString("설치기관") %></td>
                    <td><%= rs.getString("서비스구분") %></td>
                    <td><%= rs.getString("망종류") %></td>
                    <td><%= rs.getString("설치년도") %></td>
                    <td><%= rs.getString("실내외구분") %></td>
                    <td><%= rs.getString("Wifi접속환경") %></td>
                    <td><%= rs.getString("Y좌표") %></td>
                    <td><%= rs.getString("X좌표") %></td>
                    <td><%= rs.getString("작업일자") %></td>
                </tr>
        <%}%>
        <%
            conn.close();
            rs.close();
            ps.close();
        %>
    </tr>
</table>
</body>
</html>
