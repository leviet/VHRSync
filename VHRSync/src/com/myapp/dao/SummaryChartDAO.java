package com.myapp.dao;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.hibernate.Query;
import org.hibernate.Session;

import com.myapp.common.util.DataProvider;
import com.myapp.myobject.DataTableObject;
import com.myapp.presentation.IDashboardService;
import com.myapp.service.DashboardServiceImpl;

public class SummaryChartDAO {
	
	public DataTableObject getSummayChart(Date fromDate, Date toDate, int col){
		long timeDuration = toDate.getTime() - fromDate.getTime();
		ArrayList<Object[]> lst = new ArrayList<>();
//		lst.add(new Object[] {"Thời gian","Nhân viên","Danh mục","Đơn vị"});
		long time = fromDate.getTime();
		long[] arrayTime = new long[col];
		long timeLeft = (timeDuration/col);
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
		for(int i=0;i<col;i++){
			arrayTime[i] = time - timeLeft*i;
			String label = dateFormat.format(new Date(arrayTime[i]));
			if(i!=0){
				long employee = getCountChanel("Thông tin chung nhân viên", new Timestamp(arrayTime[i-1]), new Timestamp(arrayTime[i]));
				long sys_cat = getCountChanel("Danh mục dùng chung", new Timestamp(arrayTime[i-1]), new Timestamp(arrayTime[i]));
				long organization = getCountChanel("Đơn vị", new Timestamp(arrayTime[i-1]), new Timestamp(arrayTime[i]));
				lst.add(new Object[] {label, employee, sys_cat, organization});
			}else{
				long employee = getCountChanel("Thông tin chung nhân viên", new Timestamp(time), new Timestamp(arrayTime[i]));
				long sys_cat = getCountChanel("Danh mục dùng chung", new Timestamp(time), new Timestamp(arrayTime[i]));
				long organization = getCountChanel("Đơn vị", new Timestamp(time), new Timestamp(arrayTime[i]));
				lst.add(new Object[] {label, employee, sys_cat, organization});
			}
			
		}
		DataTableObject obj = new DataTableObject();
		obj.setTableData(lst);
		return obj;
	}
	
	private long getCountChanel(String tableName, Timestamp fromTime, Timestamp toTime){
		IDashboardService dashboard = new DashboardServiceImpl();
		Session sesion = DataProvider.getSessionFactory().openSession();
		
		Query query = sesion.getNamedQuery("GsyncData.countChanelByTime");
		query.setParameterList("tableName", dashboard.getTables(tableName));
		query.setParameter("fromTime", fromTime);
		query.setParameter("toTime", toTime);
		
		Object obj = query.uniqueResult();
		return (Long) obj;
	}
}
