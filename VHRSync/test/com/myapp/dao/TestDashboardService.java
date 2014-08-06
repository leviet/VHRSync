package com.myapp.dao;

import static org.junit.Assert.*;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import org.junit.Assert;
import org.junit.Test;

import com.myapp.myobject.DataTableObject;
import com.myapp.presentation.IDashboardService;
import com.myapp.service.DashboardServiceImpl;

public class TestDashboardService {

	@Test
	public void testConvertColumnSearchBatchRecord() throws ParseException {
		IDashboardService dashboardService = new DashboardServiceImpl();
		DateFormat date = new SimpleDateFormat("dd/MM/yyyy");
		String fromDate = "01/08/2014";
		Date from = date.parse(fromDate);
		String toDate = "10/08/2014";
		Date to = date.parse(toDate);
		DataTableObject objReturn = dashboardService.searchBatchRecord(from, to, "ORGANIZATION", "OK");
		String[] columns = objReturn.getColumns();
		assertEquals("Dashboard table have 9 columns", 9, columns.length);
		assertEquals("Dashboard table have column 0 is STT", "STT", columns[0]);
		assertEquals("Dashboard table have last column is Trạng thái", "Trạng thái", columns[columns.length-2]);
		assertEquals("Dashboard table have column 1 is Node", "Node", columns[1]);
	}
	
	@Test
	public void testDatatableSearchBatchRecord() throws ParseException {
		IDashboardService dashboardService = new DashboardServiceImpl();
		DateFormat date = new SimpleDateFormat("dd/MM/yyyy");
		String fromDate = "01/08/2014";
		Date from = date.parse(fromDate);
		String toDate = "10/08/2014";
		Date to = date.parse(toDate);
		DataTableObject objReturn = dashboardService.searchBatchRecord(from, to, "ORGANIZATION", "OK");
		ArrayList<Object[]> lstObj = objReturn.getTableData();
		if(lstObj.size()>0){
			Object[] rowData = getRandomObjectFormList(lstObj);
			assertEquals("Row data of Dashboard table have 8 columns", 8, rowData.length);
			rowData = getRandomObjectFormList(lstObj);
			assertEquals("All row return had staus is OK", "<span class='label label-success'>OK</span>", rowData[rowData.length-1].toString());
		}
	}
	
	@Test
	public void testDatatSearchBatchRecord() throws ParseException {
		IDashboardService dashboardService = new DashboardServiceImpl();
		DateFormat date = new SimpleDateFormat("dd/MM/yyyy");
		String fromDate = "01/08/2014";
		Date from = date.parse(fromDate);
		String toDate = "10/08/2014";
		Date to = date.parse(toDate);
		DataTableObject objReturn = dashboardService.searchBatchRecord(from, to, "ORGANIZATION", "OK");
		ArrayList<Object[]> lstObj = objReturn.getTableData();
		if(lstObj.size()>0){
			Object[] rowData = getRandomObjectFormList(lstObj);
			assertEquals("Row data of Dashboard table have 8 columns", 8, rowData.length);
			rowData = getRandomObjectFormList(lstObj);
			assertEquals("All row return had status is OK", "<span class='label label-success'>OK</span>", rowData[rowData.length-1].toString());
			rowData = getRandomObjectFormList(lstObj);
			assertEquals("All row return had table_name is ORGANIZATION", "ORGANIZATION", rowData[2].toString());
		}
	}
	
	@Test
	public void testDataTimeSearchBatchRecord() throws ParseException {
		IDashboardService dashboardService = new DashboardServiceImpl();
		DateFormat date = new SimpleDateFormat("dd/MM/yyyy");
		String fromDate = "01/08/2014";
		Date from = date.parse(fromDate);
		String toDate = "10/08/2014";
		Date to = date.parse(toDate);
		DateFormat dateTime = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		DataTableObject objReturn = dashboardService.searchBatchRecord(from, to, "ORGANIZATION,WORK_PROCESS", "OK");
		ArrayList<Object[]> lstObj = objReturn.getTableData();
		if(lstObj.size()>0){
			Object[] rowData = getRandomObjectFormList(lstObj);
			try{
			String createTime = rowData[5].toString();
			Date time = dateTime.parse(createTime);
			assertTrue("Create timme allway >= from date", time.getTime()>=from.getTime());
			assertTrue("Create timme allway <= to date", time.getTime()<=to.getTime());
			createTime = rowData[6].toString();
			time = dateTime.parse(createTime);
			assertTrue("Update timme allway >= from date", time.getTime()>=from.getTime());
			assertTrue("Update timme allway <= to date", time.getTime()<=to.getTime());
			}catch(Exception e){
				Assert.fail();
			}
		}
	}
	
	@Test
	public void TestSearchWithNonRecordReturn() throws ParseException{
		IDashboardService dashboardService = new DashboardServiceImpl();
		DateFormat date = new SimpleDateFormat("dd/MM/yyyy");
		String fromDate = "01/08/2014";
		Date from = date.parse(fromDate);
		String toDate = "10/08/2014";
		Date to = date.parse(toDate);
		DataTableObject objReturn = dashboardService.searchBatchRecord(from, to, "", "OK");
		assertEquals("Haven't any record return", 0, objReturn.getTableData().size());
	}
	
	@Test
	public void TestSearchNullParam() throws ParseException{
		IDashboardService dashboardService = new DashboardServiceImpl();
		DataTableObject objReturn = dashboardService.searchBatchRecord(null, null, null, null);
		assertEquals("Haven't any record return", 0, objReturn.getTableData().size());
	}
	
	private Object[] getRandomObjectFormList(ArrayList<Object[]> lstObj){
		return lstObj.get(new Random().nextInt(lstObj.size()));
	}

}
