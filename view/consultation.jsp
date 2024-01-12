<%@page import="model.client.Client" %>
<%

    Client[] clients = (Client[]) new Client().findAll(null);

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <title>Consultation</title>
</head>
<body>
    <div class="mx-auto w-50 mt-5 shadow-sm p-5 rounded">
        <h2>Consultation</h2>
        <form action="/dentiste/controller/consultation/consulter.jsp" method="post">
            <div class="mb-3">
                <label class="my-2">Client</label>
                <select name="client" class="form-select">
                    <% for (Client client : clients) { %>
                    <option value="<%=client.getId() %>"><%=client.getNom() %></option>
                    <% } %>
                </select>
            </div>
            <div class="mb-3">
                <label class="my-2">Date</label>
                <input type="date" name="date" class="form-control">
            </div>
            <input type="submit" value="Consulter" class="btn btn-outline-success">
        </form>
    </div>
</body>
</html>