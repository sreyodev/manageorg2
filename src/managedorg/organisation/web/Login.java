package managedorg.organisation.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet implementation class login
 */

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
		HttpServletResponse response) throws ServletException, IOException {

		// get request parameters for userID and password
		String user = request.getParameter("username");
		String pwd = request.getParameter("password");
		
		int userId = new Utility().isValidUser(user, pwd);
		
		if(userId != 0) {
			try {
				JSONArray userData 		= new managedorg.admin.web.Utility().convertRsToJson(new Utility().getUserData(userId)); 
				JSONObject jsonObj 		= new JSONObject(userData.get(0).toString());
				HttpSession session 	= request.getSession();
				session.setAttribute("user", user);
				session.setAttribute("userData", jsonObj);
				
				JSONArray urlAccessIdData 		= new managedorg.admin.web.Utility().convertRsToJson(new Utility().getUrlData(jsonObj.getInt("roleId")));

				JSONArray urlListData 	= new managedorg.admin.web.Utility().convertRsToJson(new Utility().fetchAllRoutes());
				session.setAttribute("urlList", urlListData);

				JSONArray urlAccessList = new JSONArray();
				for(int aList = 0; aList < urlAccessIdData.length(); aList++) {
					JSONObject aListObject 	= urlAccessIdData.getJSONObject(aList);
					for(int index = 0; index < urlListData.length(); index++) {
			            JSONObject jsonObject 	= urlListData.getJSONObject(index);
			            if(jsonObject.getInt("id") == aListObject.getInt("routeId")) {
			            	urlAccessList.put(jsonObject);
			            	break;
			            } 
			        }
				}
				session.setAttribute("urlAccessList", urlAccessList);
				response.sendRedirect("index.jsp");
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}else{
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/login.jsp");
			PrintWriter out= response.getWriter();
			out.println("<font color=red>Either user name or password is wrong.</font>");
			rd.include(request, response);
		}
		
		 
		
	}

}