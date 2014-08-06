package com.myapp.myobject;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

/*
 * @author VietLV2
 * @description Convert object hibernate to object data table
 * @createDate 31/07/2014
 */
public class MyJsonObject<T> {
	public String[] column;
	public ArrayList<Object[]> table;

	public MyJsonObject(Class<T> obj) {
		this.column = getColumns(obj);
	}

	public String[] getColumn() {
		return column;
	}

	public void setColumn(String[] column) {
		this.column = column;
	}

	public ArrayList<Object[]> getTable() {
		return table;
	}

	public <T> void setTable(List<?> lst) {
		if (lst == null)
			this.table = null;
		else {
			ArrayList<Object[]> objs = new ArrayList<>();
			for (Object item : lst) {
				objs.add(toArray((Class<T>) item.getClass(), (T) item));
			}
			this.table = objs;
		}
	}

	private <T> Object[] toArray(final Class<T> type, final T instance) {

		final Field[] fields = type.getDeclaredFields(); // includes private
															// fields

		final Object[] values = new Object[fields.length];

		for (int i = 0; i < fields.length; i++) {
			if (!fields[i].isAccessible()) {
				fields[i].setAccessible(true); // enables private field
												// accessing.
			}
			try {
				values[i] = fields[i].get(instance);
			} catch (IllegalAccessException iae) {
				// @@?
			}
		}

		return values;
	}

	private <T> String[] getColumns(Class<T> obj) {
		Field[] lstColum = obj.getDeclaredFields();
		String[] columns = new String[lstColum.length];
		for (int i = 0; i < lstColum.length; i++) {
			columns[i] = lstColum[i].getName();
		}
		return columns;
	}
}
