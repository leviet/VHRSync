package com.myapp.myobject;

import static org.junit.Assert.*;

import org.junit.Test;

import com.myapp.BO.GsyncOutgoingBatch;

public class TestMyJsonObject {

	@Test
	public void test() {
		MyJsonObject obj = new MyJsonObject(GsyncOutgoingBatch.class);
		obj.setTable(null);
		assertEquals("Class GsyncOutgoingBatch have 35 columns", 35, obj.getColumn().length);
		assertEquals("Class GsyncOutgoingBatch have columns 0 is serialVersionUID", "serialVersionUID", obj.getColumn()[0]);
		assertTrue(true);
	}

}
