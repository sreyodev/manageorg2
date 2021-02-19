package managedorg.organisation.web;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Utility {
	public Utility() {}
	public int isValidUser(String user, String pwd) {
		Database db			= new Database();
		Connection conn		= db.getConnection();
		int id = 0;
		
		if(conn != null) {
			try {
				Statement stmt		= conn.createStatement();
				ResultSet rs		= stmt.executeQuery("select id from tbl_users where username='"+user+"' and password='"+pwd+"' and isActive='YES' and isBlocked='NO'");
				if(rs.next()) {
					id = rs.getInt("id");
					conn.close();
					return id;
					
				}
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			finally {
				try {
					conn.close();
				}
				catch(Exception ex) {}
			}
		}
		return id;
	}
	
	public ResultSet getUserData(int userId) {
		Database db			= new Database();
		Connection conn		= db.getConnection();
		
		if(conn != null) {
			try {
				Statement stmt		= conn.createStatement();
				ResultSet rs		= stmt.executeQuery("select * from tbl_users where id='"+userId+"' and isActive='YES' and isBlocked='NO'");
				//conn.close();
				
				/*if(rs.next()) {
					System.out.println(rs.getString("name"));
				}*/
				
				return rs;
			}
			catch(Exception e) {
				e.printStackTrace();
			}
			/*finally {
				try {
					conn.close();
				}
				catch(Exception ex) {}
			}*/
		}
		return null;
	}
	
}
