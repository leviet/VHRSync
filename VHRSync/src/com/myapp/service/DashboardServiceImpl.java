package com.myapp.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.myapp.dao.DashboardDAO;
import com.myapp.myobject.BatchDetail;
import com.myapp.myobject.DataTableObject;
import com.myapp.presentation.IDashboardService;

public class DashboardServiceImpl implements IDashboardService {
	DashboardDAO dashboard = new DashboardDAO();

	@Override
	public DataTableObject searchBatchRecord(Date fromDate, Date toDate,
			String tableSearch, String status) {
		String[] columns = { "STT", "Node", "Bảng đồng bộ", "Sự kiện",
				"Số bản ghi", "Thời gian bắt đầu", "Thời gian kết thúc",
				"Trạng thái", "Chi tiết"};
		ArrayList<Object[]> tables = dashboard.search(fromDate, toDate, tableSearch, status);
		DataTableObject obj = new DataTableObject();
		obj.setColumns(columns);
		obj.setTableData(tables);
		return obj;
	}

	@Override
	public BatchDetail getBatchDetail(String batchId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<String> getListOptionTable() {
		// TODO Auto-generated method stub
		return dashboard.getListOptionTable();
	}

	@Override
	public ArrayList<String> getTables(String view) {
		// TODO Auto-generated method stub
		return dashboard.getTables(view);
	}

}
