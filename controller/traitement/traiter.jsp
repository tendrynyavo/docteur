<%@page import="model.traitement.Traitement" %>
<%@page errorPage="../../traitement.jsp" %>
<%

    new Traitement().traiter(request.getParameter("consultation"), request.getParameter("dent"), request.getParameter("prestation"));
    response.sendRedirect("/dentiste/traitement.jsp");

%>