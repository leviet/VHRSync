package com.myapp.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import oracle.sql.TIMESTAMP;

import org.hibernate.Query;
import org.hibernate.Session;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import com.google.gson.stream.JsonReader;
import com.myapp.common.util.DataProvider;

public class DashboardDAO {
	public static final String FILE_MAP_TABLE = "../../../resource/mapTable.json";
	private static final String SELECT_DATA_SQL = "select o.batch_id, o.node_id, d.table_name, decode(d.event_type,'I','Thêm mới', 'U', 'Cập nhật', 'D', 'Xóa', 'R', 'Tải lại', ''),"
			+ " o.data_event_count, to_char(d.create_time,'dd/MM/yyyy HH24:mm:ss'),"
			+ " to_char(o.last_update_time,'dd/MM/yyyy HH24:mm:ss'),"
			+ " decode(o.status,'OK','<span class=''label label-success''>'|| o.status || '</span>'"
			+ " ,'ER', '<span class=''label label-important''>'|| o.status || '</span>'"
			+ " ,'<span class=''label label-warning''>'|| o.status || '</span>')"
			+ " from (select * from gsync_data 	where table_name not like 'gsync%'"
			+ " AND (create_time >= :fromDate OR :fromDate IS NULL)"
			+ " AND (table_name IN (:table_name))) d"
			+ " inner join gsync_data_event v"
			+ " on d.data_id = v.data_id"
			+ " inner join (select * from gsync_outgoing_batch where (status = :status OR :status IS NULL)"
			+ "  AND (last_update_time <= :toDate OR :toDate IS NULL)) o"
			+ " on v.batch_id=o.batch_id"
			+ " where (ROWNUM <= :rowCount OR :rowCount IS NULL)";

	public ArrayList<Object[]> search(Date fromDate, Date toDate,
			String tableSearch, String status) {
		Session sesion = DataProvider.getSessionFactory().openSession();
		Query query = sesion.createSQLQuery(SELECT_DATA_SQL);
		query.setParameter("rowCount", 200);
		query.setParameter("fromDate", (fromDate == null) ? new Timestamp(0)
				: new Timestamp(fromDate.getTime()));
		query.setParameter("toDate", (toDate == null) ? new Timestamp(
				9999999999999L) : new Timestamp(toDate.getTime()));
		if(getTables(tableSearch).isEmpty()){
			query.setParameter("table_name", "-1");
		}else{
			query.setParameterList("table_name", getTables(tableSearch));
		}
		
		query.setParameter(
				"status",
				("null".equals(status) || status == null || "".equals(status)) ? null
						: status);
		ArrayList<Object[]> lst = (ArrayList<Object[]>) query.list();
		return lst;
	}

	public ArrayList<String> getTables(String view) {
		ArrayList<String> tables = new ArrayList<>();
		JSONArray data = getDataFromFile();
		Iterator i = data.iterator();
		// take each value from the json array separately
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			if (innerObj.get("title").toString().equalsIgnoreCase(view)) {
				// loop array
				JSONArray msg = (JSONArray) innerObj.get("table");
				Iterator<String> iterator = msg.iterator();
				while (iterator.hasNext()) {
					tables.add(iterator.next());
				}
			}
		}

		return tables;
	}

	public ArrayList<String> getListOptionTable() {
		ArrayList<String> tables = new ArrayList<>();
		JSONArray data = getDataFromFile();
		Iterator i = data.iterator();
		// take each value from the json array separately
		while (i.hasNext()) {
			JSONObject innerObj = (JSONObject) i.next();
			tables.add(innerObj.get("title").toString());
		}
		return tables;
	}

	private JSONArray getDataFromFile() {
		try {
			URL filePath = DashboardDAO.class.getResource(FILE_MAP_TABLE);
			FileReader reader = new FileReader(filePath.getFile());
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(reader);
			JSONArray data = (JSONArray) jsonObject.get("data");
			return data;
		} catch (IOException | ParseException e) {
			e.printStackTrace();
			return null;
		}

	}

}
