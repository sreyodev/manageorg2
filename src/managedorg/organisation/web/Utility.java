package managedorg.organisation.web;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

				return rs;
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public ResultSet getUrlData(int roleId) {
		Database db			= new Database();
		Connection conn		= db.getConnection();
		
		if(conn != null) {
			try {
				Statement stmt		= conn.createStatement();
				ResultSet rs		= stmt.executeQuery("select routeId from tbl_role_routes where roleId='"+roleId+"' and isActive='YES'");

				return rs;
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public ResultSet fetchOrgDetails(String identifier)	{
		ResultSet rs = null;
		Connection con		= new managedorg.admin.web.Database().getConnection();
		String sql = "SELECT * from tbl_organisations WHERE identifier = ? AND isActive = 'YES'";
		PreparedStatement ps;
		try {
			ps = con.prepareStatement(sql);
			ps.setString(1, identifier.trim());
			rs = ps.executeQuery();		
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}
	
	public ResultSet fetchOrgTheme(int orgId)	{
		ResultSet rs = null;
		Connection con		= new managedorg.admin.web.Database().getConnection();
		String sql = "SELECT variable,value from tbl_themes WHERE orgId = ? AND isActive = 'YES'";
		PreparedStatement ps;
		try {
			ps = con.prepareStatement(sql);
			ps.setInt(1, orgId);
			rs = ps.executeQuery();		
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}
	
	public ResultSet fetchAllRoutes()	{
		ResultSet rs = null;
		Connection con		= new managedorg.admin.web.Database().getConnection();
		String sql = "SELECT `id`, `displayName`, `description`, `functionName`, `logo`, `type`, `parentId` FROM `tbl_routes` WHERE isActive = 'YES'";
		PreparedStatement ps;
		try {
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();		
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}
	
}
