<%@page import="model.client.Client" %>
<%@page isErrorPage="true" %>
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
    <title>Consultation</title>
</head>
<body>
    <div class="mx-auto w-50 mt-5 shadow-sm p-5 rounded">
        <h2>Ajout de dent</h2>
        <form action="/dentiste/controller/dent/ajout.jsp" method="post">
            <div class="mb-3">
                <label class="my-2">Client</label>
                <select name="client" class="form-select">
                    <% for (Client client : clients) { %>
                    <option value="<%=client.getId() %>"><%=client.getNom() %></option>
                    <% } %>
                </select>
            </div>
            <div class="mb-3">
                <label class="my-2">Dent</label>
                <input type="text" name="dent" class="form-control">
            </div>
            <div class="mb-3">
                <label class="my-2">Note</label>
                <input type="text" name="note" class="form-control">
            </div>
            <h2 class="text-danger"><%=error %></h2>
            <input type="submit" value="Consulter" class="btn btn-outline-success">
        </form>
    </div>
</body>
</html>