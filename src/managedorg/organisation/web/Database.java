package managedorg.organisation.web;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class Database {
	public Database() {
		loadDriver(dbDriver);
	}
		
	private static String dbUrl = "";
	private static String dbUname = "";
	private static String dbPassword = "";
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


	public void setDbUrl(String dbUrl) {
		Database.dbUrl = "jdbc:mysql://localhost:3306/"+dbUrl+"?serverTimezone=UTC";;
	}

	public void setDbUname(String dbUname) {
		Database.dbUname = dbUname;
	}

	public void setDbPassword(String dbPassword) {
		Database.dbPassword = dbPassword;
	}
	
	

}