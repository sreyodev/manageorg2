<%@page session="true"%>
<%
if(session.getAttribute("user") == null){
	response.sendRedirect("login.jsp");
	return;
} else {	
%>
<%@include file="assets/includes/start.jsp"%>
<!-- Page Content Starts here -->




<h1>PAYMENTS</h1>




<!-- Page Content Ends here -->
<jsp:include page="assets/includes/footer.jsp"></jsp:include>
<script>
<!-- Custom Page Scripts Starts here -->

<!-- Custom Page Scripts Ends here -->
</script>
<jsp:include page="assets/includes/end.jsp"></jsp:include>

<%
}	
%>