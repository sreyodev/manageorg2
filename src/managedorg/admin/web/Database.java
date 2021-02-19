package managedorg.admin.web;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Database {
	public Database() {
		loadDriver(dbDriver);
	}
	
	private String dbUrl = "jdbc:mysql://localhost:3306/db_managedorg_admin?serverTimezone=UTC";
	private String dbUname = "root";
	private String dbPassword = "";
	private String dbDriver = "com.mysql.cj.jdbc.Driver";
	
	public void loadDriver(String dbDriver)	{
		try {
			Class.forName(dbDriver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	public Connection getConnection()	{
		Connection con = null;
		try {
			con = DriverManager.getConnection(dbUrl, dbUname, dbPassword);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return con;
	}
	
	public ResultSet fetchOrgDetails(String identifier)	{
		ResultSet rs = null;
		Connection con = getConnection();
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
		Connection con = getConnection();
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
}
