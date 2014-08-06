package com.myapp.presentation;

import java.util.Date;

import com.myapp.myobject.DataTableObject;
/*
 * @author VietLV2
 */
public interface IReloadRequestService {
	/*
	 * @return List user has permission user function request sync data employee time keeping
	 */
	public String[] getListUser();
	/*
	 * @return List source node join in sync network
	 */
	public String[] getListSourceNode();
	/*
	 * @description load all record compare with search param
	 * @param Date fromDate, String toDate: thoi gian dong bo
	 * String status: Trang thai request
	 * String userRequest: Nguoi yeu cau dong bo
	 * String sourceNode: Nguon du lieu
	 * @return DataTable Object
	 */
	public DataTableObject searchLogReloadRequest(Date fromDate, Date toDate, String userRequest, String sourceNode, String status);
	/*
	 * @description ghi nhan yeu cau dong bo du lieu cham cong
	 * @param String userRequest: nguoi yeu cau
	 * @param Date fromDate: Dong bo du lieu tu ngay
	 * @param Date toDate: Dong bo du lieu den ngay
	 * @param String sourceNode: Du lieu dong bo lay tu
	 * @return String messageRes: Result message
	 */
	public String putReloadRequest(Date fromDate, Date toDate, String sourceNode, String userRequest);
	/*
	 * @description Ghi nhan log yeu cau dong bo
	 * @param String userRequest: nguoi yeu cau
	 * @param Date fromDate: Dong bo du lieu tu ngay
	 * @param Date toDate: Dong bo du lieu den ngay
	 * @param String sourceNode: Du lieu dong bo lay tu
	 */
	public long putLogReloadRequest(Date fromDate, Date toDate, String sourceNode, String userRequest);
	/*
	 * @description check status of request
	 * @param String requestId
	 * @return String status <p>'OK': Thanh cong, 'LD': Dang cho thu hien, 'ER': Loi</p>
	 */
	public String checkStatusReloadRequest(String requestId);
}
