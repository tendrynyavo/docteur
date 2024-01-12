<%@page import="model.dent.Dent" %>
<%@page import="model.prestation.Prestation" %>
<%@page import="model.consultation.Consultation" %>
<%@page import="model.traitement.Traitement" %>
<%@page import="connection.BddObject" %>
<%@page isErrorPage="true" %>
<%

    String id = (request.getParameter("id") == null) ? "CONS023" : request.getParameter("id");
    String error = (exception == null) ? "" : exception.getMessage();

    Prestation[] prestations = (Prestation[]) new Prestation().findAll("id_prestation");
    Consultation consultation = new Consultation().detail(id);
    Dent[] dents = (Dent[]) ((BddObject) new Dent().setClient(consultation.getClient()).setTable("etat_dentaire")).findAll("numero");

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/dentiste/assets/bootstrap/css/bootstrap.min.css">
    <title>Traitement</title>
</head>
<body>
    <div class="d-flex justify-content-center mt-5">
        <img src="/dentiste/assets/img/alternattoothchart3.jpg" width="500" alt="">
    </div>
    <div class="row my-5">
        <div class="col">
            <form action="/dentiste/controller/traitement/traiter.jsp" method="post" class="p-5">
                <div class="mb-3">
                    <label class="my-2">Dent</label>
                    <select name="dent" class="form-select">
                        <% for (Dent dent : dents) { %>
                        <option value="<%=dent.getNumero() %>"><%=dent.getNumero() %> : <%=dent.getEtat() %></option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="my-2">Prestation</label>
                    <select name="prestation" class="form-select">
                        <% for (Prestation prestation : prestations) { %>
                        <option value="<%=prestation.getId() %>"><%=prestation.getNom() %></option>
                        <% } %>
                    </select>
                </div>
                <input type="hidden" name="consultation" value="<%=id %>">
                <input type="submit" value="Traiter" class="btn btn-outline-success">
                <h3 class="text-danger"><%=error %></h3>
            </form>
        </div>
        <div class="col p-4">
            <table class="table my-4">
                <thead>
                    <tr>
                        <th>N° Dent</th>
                        <th>Prestation</th>
                        <th>Prix</th>
                        <th>Etat</th>
                        <th>Point</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Traitement traitement : consultation.getTraitement()) { %>
                    <tr>
                        <td><%=traitement.getDent().getNumero() %></td>
                        <td><%=traitement.getPrestation().getNom() %></td>
                        <td><%=traitement.getPrix() %></td>
                        <td><%=traitement.getEtat() %></td>
                        <td><%=traitement.getPrestation().getPoint() %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <h3>Montant Total : <%=consultation.getMontantTotal() %> Ariary</h3>
        </div>
    </div>
</body>
</html>