package com.myapp.service;

import java.util.ArrayList;
import java.util.Date;

import com.myapp.dao.SummaryChartDAO;
import com.myapp.myobject.DataTableObject;
import com.myapp.presentation.ISumaryChartService;

public class SummaryChartServiceImpl implements ISumaryChartService {
	SummaryChartDAO summary = new SummaryChartDAO();

	@Override
	public DataTableObject getSumaryChart(Date fromDate,Date toDate, int column) {
		// TODO Auto-generated method stub
		DataTableObject obj = summary.getSummayChart(fromDate, toDate, column);
		ArrayList<Object[]> tables = obj.getTableData();
		tables.add(obj.getColumns());
		DataTableObject returnObj = new DataTableObject();
		String[] columns = { "Thời gian", "Nhân viên", "Danh mục", "Đơn vị" };
		returnObj.setColumns(columns);
		returnObj.setTableData(tables);

		return returnObj;
	}

}
