package com.myapp.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import com.myapp.BO.GsyncTableReloadRequest;
import com.myapp.BO.GsyncTableReloadRequestPK;
import com.myapp.BO.SyncReloadRequestLog;
import com.myapp.common.util.DataProvider;

public class ReloadRequestDAO {
	private static final String ROUTER_ID = "vhr_vtc_2_vhr_td_vhrdata";
	private static final String TRIGRER_ID = "vhr_td_emp_timekeeping";
	private static final String SOURCE_NODE_ID = "vhr_vtc";
	private static final String TARGET_NODE_ID = "vhr_td";
	private static final String USER_UPDATE = "gsync_admin";
	private String SELECT_EMPLOYEE_IN_MONTH;

	public List<SyncReloadRequestLog> search(Date fromDate, Date toDate,
			String userRequest, String sourceNode, String status) {
		Session sesion = DataProvider.getSessionFactory().openSession();
		
		Query query = sesion.getNamedQuery("SyncReloadRequestLog.findByCustom");
		query.setParameter("fromDate", fromDate);
		query.setParameter("toDate", toDate);
		query.setParameter("sourceNodeId", ("null".equals(sourceNode)) ? null : sourceNode);
		query.setParameter("userName", ("null".equals(userRequest)) ? null : userRequest);
		List<SyncReloadRequestLog> lstResult = query.list();
//		List<SyncReloadRequestLog> lstTmp = new LinkedList<>();
//		for (SyncReloadRequestLog item : lstResult) {
//			if (status
//					.equalsIgnoreCase(checkStatus(item.getRequestHistoryId()))) {
//				item.setStatus(checkStatus(item.getRequestHistoryId()));
//				lstTmp.add(item);
//			}
//		}
//		return lstTmp;
		return lstResult;
	}

	public String checkStatus(Long requestId) {
		Session sesion = DataProvider.getSessionFactory().openSession();
		Query query = sesion
				.getNamedQuery("SyncReloadRequestLog.findByRequestHistoryId");
		query.setParameter("requestHistoryId", requestId);
		List<SyncReloadRequestLog> requests = query.list();
		if (requests.isEmpty()) {
			return "NULL";
		}
		SyncReloadRequestLog request = requests.get(0);
		query = sesion.getNamedQuery("GsyncTableReloadRequest.findById");
		query.setParameter("targetNodeId", request.getTargetNodeId());
		query.setParameter("sourceNodeId", request.getSourceNodeId());
		query.setParameter("triggerId", request.getTriggerId());
		query.setParameter("routerId", request.getRouterId());
		List<GsyncTableReloadRequest> lstResult = query.list();
		if (lstResult.isEmpty()) {
			return "OK";
		}
		return "ER";
	}

	public String[] getListUser() {

		Session sesion = DataProvider.getSessionFactory().openSession();
		Query query = sesion
				.getNamedQuery("SyncReloadRequestLog.findAllUserName");
		List<String> lstResult = query.list();
		String[] result = new String[lstResult.size()];
		int i = 0;
		for (String item : lstResult) {
			result[i] = item;
			i++;
		}
		return result;
	}

	public String[] getSourceNodeId() {
		Session sesion = DataProvider.getSessionFactory().openSession();
		Query query = sesion
				.getNamedQuery("SyncReloadRequestLog.findAllSourceNodeId");
		List<String> lstResult = query.list();
		String[] result = new String[lstResult.size()];
		int i = 0;
		for (String item : lstResult) {
			result[i] = item;
			i++;
		}
		return result;
	}

	public String putReloadRequest(Date fromDate, Date toDate,
			String sourceNode, String userRequest) {
		try {
			GsyncTableReloadRequestPK reloadId = new GsyncTableReloadRequestPK();
			reloadId.setRouterId(ROUTER_ID);
			reloadId.setSourceNodeId(SOURCE_NODE_ID);
			reloadId.setTargetNodeId(TARGET_NODE_ID);
			reloadId.setTriggerId(TRIGRER_ID);
			DateFormat date = new SimpleDateFormat("dd/MM/yyyy");

			GsyncTableReloadRequest requestReload = new GsyncTableReloadRequest();
			requestReload.setId(reloadId);
			requestReload.setLastUpdateBy(USER_UPDATE);
			SELECT_EMPLOYEE_IN_MONTH = "EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE EMPLOYEE_CODE NOT LIKE 'VTC%')"
					+ " AND DATE_TIMEKEEPING BETWEEN  TO_DATE( '%FROM_DATE%' ,'DD/MM/YYYY') AND TO_DATE( '%TO_DATE%' ,'DD/MM/YYYY') ";
			SELECT_EMPLOYEE_IN_MONTH = SELECT_EMPLOYEE_IN_MONTH.replace(
					"%FROM_DATE%", date.format(fromDate));
			SELECT_EMPLOYEE_IN_MONTH = SELECT_EMPLOYEE_IN_MONTH.replace(
					"%TO_DATE%", date.format(toDate));
			requestReload.setReloadSelect(SELECT_EMPLOYEE_IN_MONTH);
			requestReload.setReloadEnabled(BigDecimal.valueOf(1L));
			requestReload.setCreateTime(new Timestamp(new Date().getTime()));
			requestReload
					.setLastUpdateTime(new Timestamp(new Date().getTime()));

			DataProvider dataProvider = new DataProvider();
			long id = putLogReloadRequest(fromDate, toDate, sourceNode, userRequest);
			if(dataProvider.insert(requestReload)){
				System.out.print("ReloadRequestDAO.class: RowId of record is: "+requestReload.getRowId());
				return "OK";
				}
			return "ER";
		} catch (Exception e) {
			e.printStackTrace();
			return "ER";
		}

	}
	
	public long putLogReloadRequest(Date fromDate, Date toDate, String sourceNode, String userRequest){
		try {
			SyncReloadRequestLog reloadId = new SyncReloadRequestLog();
			reloadId.setRouterId(ROUTER_ID);
			reloadId.setSourceNodeId(sourceNode);
			reloadId.setTargetNodeId(TARGET_NODE_ID);
			reloadId.setTriggerId(TRIGRER_ID);
			DateFormat date = new SimpleDateFormat("dd/MM/yyyy");

			reloadId.setLastUpdateBy(userRequest);
			SELECT_EMPLOYEE_IN_MONTH = "EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEE WHERE EMPLOYEE_CODE NOT LIKE 'VTC%')"
					+ " AND DATE_TIMEKEEPING BETWEEN  TO_DATE( '%FROM_DATE%' ,'DD/MM/YYYY') AND TO_DATE( '%TO_DATE%' ,'DD/MM/YYYY') ";
			SELECT_EMPLOYEE_IN_MONTH = SELECT_EMPLOYEE_IN_MONTH.replace(
					"%FROM_DATE%", date.format(fromDate));
			SELECT_EMPLOYEE_IN_MONTH = SELECT_EMPLOYEE_IN_MONTH.replace(
					"%TO_DATE%", date.format(toDate));
			reloadId.setReloadSelect(SELECT_EMPLOYEE_IN_MONTH);
			reloadId.setReloadEnabled(BigDecimal.valueOf(1L));
			reloadId.setCreateTime(new Timestamp(new Date().getTime()));
			reloadId
					.setLastUpdateTime(new Timestamp(new Date().getTime()));
			reloadId.setUserName(USER_UPDATE);
			reloadId.setFromDate(fromDate);
			reloadId.setToDate(toDate);
			reloadId.setStatus("LD");
			reloadId.setRequestCreateTime(new Timestamp(new Date().getTime()));
			DataProvider dataProvider = new DataProvider();
			if(dataProvider.insert(reloadId))
				return reloadId.getRequestHistoryId();
			return -1L;
		} catch (Exception e) {
			e.printStackTrace();
			return -1L;
		}
	}
}
