package managedorg.organisation.web;

import java.io.IOException;
import java.io.PrintWriter;
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
		System.out.println("userId = " + userId);
		if(userId != 0) {
			try {
				JSONArray userData = new managedorg.admin.web.Utility().convertRsToJson(new Utility().getUserData(userId));
				JSONObject jsonObj = new JSONObject(userData.get(0).toString());
				
				//System.out.println("XX = "+jsonObj);
				
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				session.setAttribute("userData", jsonObj);
				
				System.out.println("XY = "+session.getAttribute("userData"));

				response.sendRedirect("dashboard.jsp");
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