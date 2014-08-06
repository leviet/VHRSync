package com.myapp.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.myapp.presentation.IBatchDetailService;
import com.myapp.service.BatchDetailServiceImpl;

/**
 * Servlet implementation class BatchDetail
 */
public class BatchDetail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BatchDetail() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acction = request.getParameter("action");
		response.setContentType( "text/html" );
		response.setCharacterEncoding( "UTF-8" );
		if("viewDetail".equalsIgnoreCase(acction)){
			String strBatchId = request.getParameter("BatchId");
			try{
				Long batchId = Long.parseLong(strBatchId);
				IBatchDetailService jsonService = new BatchDetailServiceImpl();
				response.getWriter().print(jsonService.getBatchDetail(strBatchId));
			}catch(Exception e){
				response.sendRedirect("Dashboard.html");
			}
		}else{
			response.sendRedirect("Dashboard.html");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
