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
import com.myapp.presentation.ISumaryChartService;
import com.myapp.service.SummaryChartServiceImpl;

public class TestSumaryChartService {

	@Test
	public void testConvertColumnSearchBatchRecord() throws ParseException {
		ISumaryChartService chartService = new SummaryChartServiceImpl();
		DateFormat date = new SimpleDateFormat("dd/MM/yyyy");
		String fromDate = "24/07/2014";
		Date from = date.parse(fromDate);
		String toDate = "26/0/2014";
		Date to = date.parse(toDate);
		DataTableObject objReturn = chartService.getSumaryChart(from, to, 10);
		String[] columns = objReturn.getColumns();
		assertEquals("Chart summary have 11 row data", 11, objReturn.getTableData().size());
		String label0 = objReturn.getTableData().get(0)[0].toString();
		String label1 = objReturn.getTableData().get(1)[0].toString();
		
		DateFormat dateTime = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		
		Date time0 = dateTime.parse(label0);
		Date time1 = dateTime.parse(label1);

		assertEquals("Distance of 2 column in durationtime/column", 6*60*1000, time0.getTime() - time1.getTime(),1000);
	}
	

}
