<%@page import="org.json.JSONObject" session="true"%>
<%
	//allow access only if session exists
	if(session.getAttribute("user") != null && !session.getAttribute("user").toString().equals("")){
		//Get URL string here and check with session identifier.
		String currentIdentifier = "sreyo";
		JSONObject orgData	 = (JSONObject)session.getAttribute("ORG_DATA");
		if(!orgData.getString("identifier").equalsIgnoreCase(currentIdentifier)){
	    	if(session != null){
	    		session.invalidate();
	    	}
		}
	} 
	response.sendRedirect("index.jsp");
	
%>