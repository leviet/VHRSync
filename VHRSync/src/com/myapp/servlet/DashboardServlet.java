package com.myapp.servlet;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.myapp.common.util.DataProvider;
import com.myapp.myobject.DataTableObject;
import com.myapp.presentation.IDashboardService;
import com.myapp.service.DashboardServiceImpl;
import com.myapp.service.ReloadRequestServiceImpl;

/**
 * Servlet implementation class DashboardServlet
 */
public class DashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String ACTION_INIT_LOAD = "initLoad";
	private static final String ACTION_GET_OPTION = "getOption";
	private static final String ACTION_SEARCH = "search";
	private IDashboardService service = new DashboardServiceImpl();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acction = request.getParameter("action");
		response.setContentType("application/json; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		if(ACTION_INIT_LOAD.equalsIgnoreCase(acction)){
			initLoad(response);
		}else if(ACTION_SEARCH.equalsIgnoreCase(acction)){
			search(request,response);
		}else if(ACTION_GET_OPTION.equalsIgnoreCase(acction)){
			genOption(response);
		}
		else{
			
		}
	}

	private void genOption(HttpServletResponse response) throws IOException {
		ArrayList<String> options = service.getListOptionTable(); 
		Gson gson = new Gson();
		response.getWriter().print(gson.toJson(options));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	private void initLoad(HttpServletResponse response) throws IOException{
		DataTableObject data = service.searchBatchRecord(null, null, "Tất cả", null);
		Gson gson = new Gson();
		response.getWriter().print(gson.toJson(data));
	}
	private void search(HttpServletRequest request, HttpServletResponse response) throws IOException{
		try{
			String strFromDate = request.getParameter("fromDate");
			String strToDate = request.getParameter("toDate");
			String tableSearch = request.getParameter("tableSearch");
			byte[] bytes = tableSearch.getBytes(StandardCharsets.ISO_8859_1);
			tableSearch = new String(bytes, StandardCharsets.UTF_8);
			String status = request.getParameter("status");
			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");

			Date fromDate = ("".equals(strFromDate)) ? null : dateFormat.parse(strFromDate);
			Date toDate = ("".equals(strToDate)) ? null : dateFormat.parse(strToDate);
			
			DataTableObject data = service.searchBatchRecord(fromDate, toDate, tableSearch, status);
			
			Gson gson = new Gson();
			response.getWriter().print(gson.toJson(data));
			
		}catch(Exception e){
			e.toString();
			response.getWriter().print("Có lỗi xảy ra!");
		}
	}

}
