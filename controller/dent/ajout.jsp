<%@page import="model.dent.Dent" %>
<%@page errorPage="../../dent.jsp" %>
<%

    new Dent().ajouterMutliple(request.getParameter("client"), request.getParameter("dent"), request.getParameter("note"), null);
    response.sendRedirect("/dentiste/dent.jsp");

%>