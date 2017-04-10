<%@page import="com.interativaconsultoria.dao.Jdbc"%>
<%@page import="com.interativaconsultoria.dao.Propriedade"%>

<%
   //System.out.print("url:" + request.getServletPath());
    
    if (session.getAttribute("nome") != null) {
        
        session.setMaxInactiveInterval(1000);
        
        if (request.getServletPath().equals("/index.jsp")) {
            response.sendRedirect("home.jsp");
            return;
        }

    } else {
        if (request.getServletPath().equals("/index.jsp")) {

        } else {
            response.sendRedirect("index.jsp?err");
            return;
        }

    }

%>

