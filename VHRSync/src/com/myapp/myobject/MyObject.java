package com.myapp.myobject;

import java.lang.reflect.Field;


public class MyObject {
	public <T> Object[] toArray() {

	    final Field[] fields = MyObject.class.getDeclaredFields(); // includes private fields

	    final Object[] values = new Object[fields.length];

	    for (int i = 0; i < fields.length; i++) {
	        if (!fields[i].isAccessible()) {
	            fields[i].setAccessible(true); // enables private field accessing.
	        }
	        try {
	            values[i] = fields[i].get(this);
	        } catch (IllegalAccessException iae) {
	            // @@?
	        }
	    }

	    return values;
	}
}
