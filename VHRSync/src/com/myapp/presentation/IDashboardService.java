package com.myapp.presentation;

import java.util.ArrayList;
import java.util.Date;

import com.myapp.myobject.BatchDetail;
import com.myapp.myobject.DataTableObject;

public interface IDashboardService {
	/*
	 * @author VietLV2
	 * @description load all record compare with search param
	 * @param Date fromDate, Date toDate, String tableSearch, String status
	 * @return DataTable Object
	 */
	public DataTableObject searchBatchRecord(Date fromDate, Date toDate, String tableSearch, String status);
	/*
	 * @param BatchID
	 * @return a object BatchDetail
	 */
	public BatchDetail getBatchDetail(String batchId);
	/*
	 * @description Get list option table form map table
	 */
	public ArrayList<String> getListOptionTable();
	
	public ArrayList<String> getTables(String view);
}
