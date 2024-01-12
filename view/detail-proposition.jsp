<%@page import="model.proposition.Proposition"%>
<%@page import="model.traitement.Traitement"%>
<%

    Proposition proposition = new Proposition().proposer(request.getParameter("client"), request.getParameter("budget"), request.getParameter("option"));

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <title>Document</title>
</head>
<body>
    <div class="d-flex justify-content-center mt-5">
        <img src="/dentiste/assets/img/alternattoothchart3.jpg" width="500" alt="">
    </div>
    <div class="mx-auto w-50 col p-4">
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
                <% for (Traitement traitement : proposition.getTraitements()) { %>
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
        <h3>Montant Total : <%=proposition.getMontantTotal() %> Ariary</h3>
    </div>
</body>
</html>