package com.myapp.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.myapp.BO.GsyncTableReloadRequest;
import com.myapp.BO.GsyncTableReloadRequestPK;
import com.myapp.common.util.DataProvider;
import com.myapp.myobject.DataTableObject;
import com.myapp.presentation.IReloadRequestService;
import com.myapp.service.ReloadRequestServiceImpl;

/**
 * Servlet implementation class ReloadEmployeeTimeKeeping
 */
public class ReloadEmployeeTimeKeeping extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String SELECT_EMPLOYEE_IN_MONTH;
	private static final String ROUTER_ID = "vhr_vtc_2_vhr_td_vhrdata";
	private static final String TRIGRER_ID = "vhr_td_emp_timekeeping";
	private static final String SOURCE_NODE_ID = "vhr_vtc";
	private static final String TARGET_NODE_ID = "vhr_td";
	private static final String USER_UPDATE = "gsync_admin";
	IReloadRequestService service = null;
	private static final String ACTION_ADD_RELOAD_REQUEST = "syncTimeKeeping";
	private static final String ACTION_INIT_LOAD = "initLoad";
	private static final String ACTION_SEARCH_REQUEST = "search";
	private static final String ACTION_GET_LIST_USER="getListUser";
	private static final String ACTION_GET_LIST_SOURCE="getListSource";
	private static final String ACTION_SEARCH="search";
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReloadEmployeeTimeKeeping() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String acction = request.getParameter("action");
		response.setContentType("application/json; charset=UTF-8");
		if(ACTION_INIT_LOAD.equalsIgnoreCase(acction)){
			initLoad(response);
		}else if(ACTION_GET_LIST_USER.equalsIgnoreCase(acction)){
			getListUser(response);
		}else if(ACTION_GET_LIST_SOURCE.equalsIgnoreCase(acction)){
			getListSource(response);
		}else if(ACTION_SEARCH.equalsIgnoreCase(acction)){
			search(request, response);
		} else {
			response.getWriter().print("Hello world!");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String acction = request.getParameter("action");
		response.setContentType("text/html");
		response.setCharacterEncoding("UTF-8");
		if (ACTION_ADD_RELOAD_REQUEST.equalsIgnoreCase(acction)) {
			addReloadRequest(request, response);
		}else {
			response.getWriter().print("Hello world!");
		}

	}
	

	public void addReloadRequest(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		try {
			String strFromDate = request.getParameter("fromDate");
			String strToDate = request.getParameter("toDate");
			if (strFromDate != null && !"".equals(strFromDate)
					&& !"null".equals(strFromDate)) {
				if (strToDate != null && !"".equals(strToDate)
						&& !"null".equals(strToDate)) {

					DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

					Date fromDate = dateFormat.parse(strFromDate);
					Date toDate = dateFormat.parse(strToDate);

					if (fromDate.getTime() > toDate.getTime()) {
						response.getWriter()
								.print("Ngày bắt đầu không được lớn hơn ngày kết thúc!");
						return;
					}

					Calendar cal = Calendar.getInstance();
					cal.setTime(toDate);
					cal.add(Calendar.MONTH, -1);

					toDate = cal.getTime();

					// Chỉ cho phép quét trong tối đa 30 ngày
					if (fromDate.getTime() < toDate.getTime()) {
						response.getWriter()
								.print("Chỉ cho phép đồng bộ dữ liệu trong tối đa 1 tháng!");
						return;
					}
					service = new ReloadRequestServiceImpl();
					String rerult = service.putReloadRequest(fromDate, toDate,
							SOURCE_NODE_ID, USER_UPDATE);
					response.setStatus(200);
					response.getWriter()
							.print("Yêu cầu đồng bộ đã được ghi nhận, đợi trong ít phút để hoàn thành quá trình đồng bộ!");
				} else {
					response.getWriter().print(
							"Ngày kết thúc không được bỏ trống!");
				}
			} else {
				response.getWriter().print("Ngày bắt đầu không được bỏ trống!");
			}
		} catch (Exception e) {
			e.toString();
			response.getWriter().print("Có lỗi xảy ra!");
		}
	}
	
	public void getListUser(HttpServletResponse response) throws IOException{
		service = new ReloadRequestServiceImpl();
		String[] lstUser = service.getListUser();
		Gson gson = new Gson();
		response.getWriter().print(gson.toJson(lstUser));
	}
	
	public void getListSource(HttpServletResponse response) throws IOException{
		service = new ReloadRequestServiceImpl();
		String[] lstSource = service.getListSourceNode();
		Gson gson = new Gson();
		response.getWriter().print(gson.toJson(lstSource));
	}
	
	public void initLoad(HttpServletResponse response) throws IOException{
		service = new ReloadRequestServiceImpl();
		DataTableObject data = service.searchLogReloadRequest(null, null, null, null, "OK");
		Gson gson = new Gson();
		response.getWriter().print(gson.toJson(data));
	}
	
	public void search(HttpServletRequest request,
			HttpServletResponse response) throws IOException{
		try{
			String strFromDate = request.getParameter("fromDate");
			String strToDate = request.getParameter("toDate");
			String userRequest = request.getParameter("userRequest");
			String sourceNode = request.getParameter("sourceNode");
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

			Date fromDate = ("".equals(strFromDate)) ? null : dateFormat.parse(strFromDate);
			Date toDate = ("".equals(strToDate)) ? null : dateFormat.parse(strToDate);
			service = new ReloadRequestServiceImpl();
			
			DataTableObject data = service.searchLogReloadRequest(fromDate, toDate, userRequest, sourceNode, "OK");
			
			Gson gson = new Gson();
			response.getWriter().print(gson.toJson(data));
			
		}catch(Exception e){
			e.toString();
			response.getWriter().print("Có lỗi xảy ra!");
		}
	}
}
