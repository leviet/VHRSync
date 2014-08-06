package com.myapp.presentation;

import java.util.Date;

import com.myapp.myobject.DataTableObject;
/*
 * @author VietLv2
 */
public interface ISumaryChartService {
	/*
	 * @description get du lieu hien thi len bieu do
	 * @param long durationTime: khoang thoi gian lay du lieu
	 * int column so co du lieu hien thi
	 * @return DataTableObject
	 */
	public DataTableObject getSumaryChart(Date fromDate, Date toDate, int column);
}
