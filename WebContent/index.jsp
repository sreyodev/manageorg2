
<%@page import="managedorg.admin.web.Database"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="managedorg.admin.web.Utility"%>
<%@page session="true" %>

<%
    //String identifier = "vishwagokulam";
	String identifier = "sreyo";
	int orgId;
	try {
		JSONArray jsonArray = new Utility().convertRsToJson(new Database().fetchOrgDetails(identifier));
		if(jsonArray.length() == 1) {
	JSONObject jsonObj = new JSONObject(jsonArray.get(0).toString());
	orgId = jsonObj.getInt("id");
	session.setAttribute("ORG_DATA", jsonObj);
	
	//out.println("X = "+jsonObj);
	
	managedorg.organisation.web.Database dbParamToSet		= new managedorg.organisation.web.Database();
	dbParamToSet.setDbUrl(jsonObj.getString("dbName"));
	dbParamToSet.setDbUname(jsonObj.getString("dbUsername"));
	dbParamToSet.setDbPassword(jsonObj.has("dbPassword")?jsonObj.getString("dbPassword"):"");
	
	JSONArray jsonArray2 = new Utility().convertRsToJson(new Database().fetchOrgTheme(orgId));
	JSONObject jsonObj2 = new JSONObject(jsonArray2.get(1).toString());
	session.setAttribute("ORG_THEME_DATA", jsonObj2);

	String userName = null;
	
	//allow access only if session exists
	if(session.getAttribute("user") == null){
		response.sendRedirect("login.jsp");
	}else { 
		userName = (String) session.getAttribute("user");
		response.sendRedirect("dashboard.jsp");
	}	
		}
		else {
	response.getWriter().write("<html><body><b>No Data Found.</b></body></html>");
		}
	}
	catch(Exception e) {
		
	}
%>

