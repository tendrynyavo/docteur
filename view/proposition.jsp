<%@page isErrorPage="true" %>
<%@page import="model.client.Client" %>
<%

    String error = (exception == null) ? "" : exception.getMessage();
    Client[] clients = (Client[]) new Client().findAll(null);

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
    <div class="mx-auto w-50 row shadow-sm rounded my-5">
        <div class="col">
            <form action="/dentiste/detail-proposition.jsp" method="post" class="p-5">
                <div class="mb-3">
                    <label class="my-2">Client</label>
                    <select name="client" class="form-select">
                        <% for (Client client : clients) { %>
                        <option value="<%=client.getId() %>"><%=client.getNom() %></option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="my-2">Client</label>
                    <select name="option" class="form-select">
                        <option value="B">Beaute</option>
                        <option value="S">Sante</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="my-2">Budget</label>
                    <input type="text" name="budget" class="form-control">
                </div>
                <input type="submit" value="Proposer" class="btn btn-outline-success">
                <h3 class="text-danger"><%=error %></h3>
            </form>
        </div>
    </div>
</body>
</html>