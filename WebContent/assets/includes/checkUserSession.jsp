<%@page import="org.json.JSONArray"%>
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
		
		String currentPageName = request.getRequestURI().toString();
		JSONArray urlAccessList = (JSONArray)session.getAttribute("urlAccessList");
		int i=0;
		for(; i<urlAccessList.length(); i++){
			JSONObject jsonObj = new JSONObject(urlAccessList.get(i).toString());
            if(currentPageName.toLowerCase().endsWith((jsonObj.getString("functionName")+".jsp").toLowerCase())){
            	break;
            }
		}
		
		if(i == urlAccessList.length()){
			response.sendRedirect("404.jsp"); // NO PAGE ACCESS
			return;
		}
	} 
	else{
		response.sendRedirect("index.jsp"); // NO SESSION
		return;
	}
	
%>