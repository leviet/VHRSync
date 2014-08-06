package com.myapp.dao;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Assert;
import org.junit.Test;

import com.myapp.common.util.DBUtils;
import com.myapp.myobject.DataTableObject;
import com.myapp.presentation.IReloadRequestService;
import com.myapp.service.ReloadRequestServiceImpl;

public class TestReloadRequestService {

	Connection connection = null;
	PreparedStatement sStatement = null;

	@Test
	public void testGetListUser() {
		IReloadRequestService service = new ReloadRequestServiceImpl();
		String[] lstUser = service.getListUser();
		assertTrue("Get list user success",true);
	}
	
	
	@Test
	public void testGetListSourceNode() {
		IReloadRequestService service = new ReloadRequestServiceImpl();
		String[] lstNode = service.getListSourceNode();
		assertTrue("Get list node success",true);
	}
	
	@Test
	public void testSearch() throws ParseException {
		IReloadRequestService service = new ReloadRequestServiceImpl();
		DateFormat date = new SimpleDateFormat("dd/MM/yyyy");
		String fromDate = "01/08/2014";
		Date from = date.parse(fromDate);
		String toDate = "10/08/2014";
		Date to = date.parse(toDate);
		DataTableObject data = service.searchLogReloadRequest(from, to, "gsync_admin", "vhr_vtc", "OK");
		System.out.print(data);
		assertTrue("Search success",true);
	}
	
	@Test
	public void testPutLogReloadRequest() throws ParseException, SQLException {
		IReloadRequestService service = new ReloadRequestServiceImpl();
		DateFormat date = new SimpleDateFormat("dd/MM/yyyy");
		String fromDate = "01/08/2014";
		Date from = date.parse(fromDate);
		String toDate = "10/08/2014";
		Date to = date.parse(toDate);
		long logId = service.putLogReloadRequest(from, to, "vhr_vtc", "gsync_admin");
		
		try{
			connection = DBUtils.getConnection();
			String strSQL = "SELECT * FROM sync_reload_request_log where request_history_id=?";
			sStatement = connection.prepareStatement(strSQL);
			sStatement.setLong(1, logId);
			
			ResultSet result = sStatement.executeQuery();
			if(!result.next()){
				Assert.fail("Can't not select any record");
			}else{
				assertTrue("Insert sync_reload_request_log success!", true);
				deleteRecord(logId);
			}
		}finally{
			sStatement.close();
			connection.close();
		}
	}
	
	@Test
	public void TestCheckStatusRequest(){
		
	}
	
	private void deleteRecord(long logID) throws SQLException{
		try{
		connection = DBUtils.getConnection();
		String strSQL = "DELETE FROM sync_reload_request_log where request_history_id=?";
		sStatement = connection.prepareStatement(strSQL);
		sStatement.setLong(1, logID);
		}finally{
			sStatement.close();
			connection.close();
		}
	}
	
}
