<%@page import="org.json.JSONObject"%>
<%
		
	//allow access only if session exists
	if(session.getAttribute("user") != null && !session.getAttribute("user").toString().equals("")){
		//Get URL string here and check with session identifier.
		String currentIdentifier = "vishwagokulam";
		JSONObject orgData	 = (JSONObject)session.getAttribute("ORG_DATA");
		if(!orgData.getString("identifier").equalsIgnoreCase(currentIdentifier)){
			response.sendRedirect("logout.jsp");
		}
	} else {
		response.sendRedirect("login.jsp");
	}
%>