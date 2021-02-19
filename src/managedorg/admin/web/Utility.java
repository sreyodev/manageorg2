package managedorg.admin.web;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import org.json.JSONArray;
import org.json.JSONObject;

public class Utility {
	public Utility() {
		
	}
	
	public JSONArray convertRsToJson(ResultSet rs) {
		JSONArray json = new JSONArray();
		try {
			if(rs != null) {
				ResultSetMetaData rsmd = rs.getMetaData();
				while(rs.next()) {
					int numColumns = rsmd.getColumnCount();
					JSONObject obj = new JSONObject();
					for (int i=1; i<=numColumns; i++) {
						String column_name = rsmd.getColumnName(i);
						obj.put(column_name, rs.getObject(column_name));
					}
					json.put(obj);
				}
			}
		}
		catch(Exception e) {}
		return json;
	}
	

}
