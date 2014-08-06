package com.myapp.common.util;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.SQLException;

import junit.framework.Assert;

import org.junit.Test;

public class DBUtilsTest {

	@Test
	public void testCreateConnection() throws SQLException {
		Connection con = DBUtils.getConnection();
		assertTrue("Create connection success", true);
	}

}
