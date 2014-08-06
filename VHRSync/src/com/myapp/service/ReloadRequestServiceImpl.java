package com.myapp.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.myapp.BO.SyncReloadRequestLog;
import com.myapp.dao.ReloadRequestDAO;
import com.myapp.myobject.DataTableObject;
import com.myapp.myobject.MyJsonObject;
import com.myapp.presentation.IReloadRequestService;

public class ReloadRequestServiceImpl implements IReloadRequestService {
	private ReloadRequestDAO reloadDao = new ReloadRequestDAO();

	@Override
	public String[] getListUser() {
		return reloadDao.getListUser();
	}

	@Override
	public String[] getListSourceNode() {
		return reloadDao.getSourceNodeId();
	}

	@Override
	public DataTableObject searchLogReloadRequest(Date fromDate, Date toDate,
			String userRequest, String sourceNode, String status) {
		// TODO Auto-generated method stub
		List<SyncReloadRequestLog> lstResult = reloadDao.search(fromDate,
				toDate, userRequest, sourceNode, status);
		String[] columns = { "STT", "Từ", "Đến", "Thời gian yêu cầu",
				"Từ ngày", "Đến ngày", "Người yêu cầu", "Thời gian bắt đầu",
				"Thời gian kết thúc"};
		ArrayList<Object[]> table = new ArrayList<Object[]>();
		for (SyncReloadRequestLog item : lstResult) {
			table.add(new Object[] { item.getRequestHistoryId(),
					item.getSourceNodeId(), "vhr_td", item.getCreateTime(),
					item.getFromDate(), item.getToDate(), item.getUserName(),
					item.getRequestCreateTime(), item.getLastUpdateTime()});
		}
		DataTableObject myTable = new DataTableObject();
		myTable.setColumns(columns);
		myTable.setTableData(table);
		return myTable;
	}

	@Override
	public String putReloadRequest(Date fromDate, Date toDate,
			String sourceNode, String userRequest) {
		// TODO Auto-generated method stub
		return reloadDao.putReloadRequest(fromDate, toDate, sourceNode, userRequest);
	}

	@Override
	public long putLogReloadRequest(Date fromDate, Date toDate,
			String sourceNode, String userRequest) {
		// TODO Auto-generated method stub
		return reloadDao.putLogReloadRequest(fromDate, toDate, sourceNode, userRequest);
	}

	@Override
	public String checkStatusReloadRequest(String requestId) {
		// TODO Auto-generated method stub
		return reloadDao.checkStatus(Long.parseLong(requestId));
	}

}
