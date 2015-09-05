<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" 
	import="univr.is.tmc.entity.*"
	import="java.util.*" 
	import="java.sql.*" %>
<%
	String user = "";
    char userMode = 'U';
    char minMode = 'A';
    if(session.getAttribute("currUserEmail") == null)
        response.sendRedirect("login.jsp");
    else {
        user = session.getAttribute("currUserEmail").toString();
        userMode = session.getAttribute("currUserMode").toString().charAt(0);

		if (minMode == 'A'){
			if(userMode != 'A')
				response.sendRedirect("accessoNegato.jsp");
		}else
        if (minMode == 'U'){
            if(userMode != 'A' && userMode != 'U')
				response.sendRedirect("accessoNegato.jsp");
		}
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Gestione utenti</title>
</head>
<body>
	<h1>GESTIONE VEICOLI</h1>
	<%=user%>
	<hr/>
	<h3>Veicoli presenti nel DataBase:</h3>
	<form action="VeicoliUtenteServlet" method="POST" name="formFiltro">
		<table order="1" cellpadding="1" cellspacing="5">
			<thead>
				<tr>
					<th></th>
					<th>Nome</th>
					<th>Cognome</th>
					<th>Email</th>
					<th>Targa</th>
					<th>Marca</th>
					<th>Modello</th>
				</tr>
			</thead>
			<tbody>

				<% List<VeicoloUtente> listaVeicoliUtente = VeicoloUtente.getVeicoliUtenti(); %>
				<% for (VeicoloUtente vu : listaVeicoliUtente) { %>

				<tr>
					<td><input type="radio" name="veicoloUtenteSel" 
						value="<%=vu.getVeicolo().getTarga()+","+vu.getUtente().getEmail()%>">
					</td>
					<td><%=vu.getUtente().getNome()%></td>
					<td><%=vu.getUtente().getCognome()%></td>
					<td><%=vu.getUtente().getEmail()%></td>
					<td><%=vu.getVeicolo().getTarga()%></td>
					<td><%=vu.getVeicolo().getMarca()%></td>
					<td><%=vu.getVeicolo().getModello()%></td>
				</tr>
				
				<% } %>
			</tbody>
		</table>
		<hr>
		<input type="submit" name="azione" value="Inserisci"> 
		<input type="submit" name="azione" value="Modifica">
		<input type="submit" name="azione" value="Elimina" 
				onclick="return confirm('Sei sicuro di voler eliminare il veicolo selezionato?')">
	</form>
	<br/>
	<form action="LogoutServlet" method="POST">
		<input type="submit" name="Logout" value="Logout">
	</form>
	<br/>
	<a href="welcomeUser.jsp">Home</a>
	
</body>
</html>
