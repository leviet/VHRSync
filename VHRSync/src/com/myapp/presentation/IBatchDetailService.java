package com.myapp.presentation;

/*
 * @author VietLV2
 * @createDate 31/07/2014
 */

public interface IBatchDetailService {
	//get out going batch
	public String getOutgoingBatch(String batchId);
	//get incoming error
	public String getIncomingError(String batchId);
	//get data from batchID
	public String getDataFromBatch(String batchId);
	//get BatchDetail
	public String getBatchDetail(String batchId);
}
