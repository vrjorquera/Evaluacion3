<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="webApp.Usuario" %>

<!DOCTYPE html>
<html>
<head>
    <title>Eva3 - My Construcción</title>
</head>

<body>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Usuario validUser = new Usuario("admin", "admi123");

    if (username != null && password != null && username.equals(validUser.getUsername()) && password.equals(validUser.getPassword())) {
        
        response.sendRedirect("bienvenido.jsp?username=" + username);
    } else {
       
%>
    <p>Error - Usuario o contraseña no validos.</p>
<%
    }
%>

</body>

</html>

