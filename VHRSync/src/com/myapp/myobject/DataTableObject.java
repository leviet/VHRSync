package com.myapp.myobject;

import java.util.ArrayList;

public class DataTableObject {
	private String[] columns;
	private ArrayList<Object[]> tableData;
	public String[] getColumns() {
		return columns;
	}
	public void setColumns(String[] columns) {
		this.columns = columns;
	}
	public ArrayList<Object[]> getTableData() {
		return tableData;
	}
	public void setTableData(ArrayList<Object[]> tableData) {
		this.tableData = tableData;
	}
}
