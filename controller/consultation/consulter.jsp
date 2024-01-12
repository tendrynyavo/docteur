<%@page import="model.consultation.Consultation" %>
<%@page errorPage="../../consultation.jsp" %>
<%

    new Consultation().consulter(request.getParameter("client"), request.getParameter("date"));
    response.sendRedirect("/dentiste/traitement.jsp");

%>