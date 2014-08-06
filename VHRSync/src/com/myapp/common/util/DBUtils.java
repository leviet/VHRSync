/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.myapp.common.util;

import com.myapp.BO.DbInfo;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import java.util.ResourceBundle;
import oracle.jdbc.pool.OracleConnectionCacheManager;
import oracle.jdbc.pool.OracleDataSource;

/**
 *
 * @author kdvt_tuannv22
 */
public class DBUtils {

    private final static String CACHE_NAME = "BCCS_IM";
    private static OracleDataSource ods = null;

    static {
        System.out.println("Khởi tạo OracleDataSource");
        try {
            DbInfo info = ResourceBundleUtils.getDbInfoEncrypt("connectUrl");
            ResourceBundle rb = ResourceBundle.getBundle("config");

            String poolSize = rb.getString("poolSize");
            String url = info.getConnStr();
            String userName = info.getUserName();
            String FpassWord = info.getPassWord();

            ods = new OracleDataSource();
            ods.setURL(url);
            ods.setUser(userName);
            ods.setPassword(FpassWord);
            // caching parms
            ods.setConnectionCachingEnabled(true);
            ods.setConnectionCacheName(CACHE_NAME);
            Properties cacheProps = new Properties();

            cacheProps.setProperty("MinLimit", "1");
            cacheProps.setProperty("MaxLimit", poolSize);
            cacheProps.setProperty("InitialLimit", "1");
            cacheProps.setProperty("ConnectionWaitTimeout", poolSize);
            cacheProps.setProperty("ValidateConnection", "true");

            ods.setConnectionCacheProperties(cacheProps);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * private constructor for static class
     */
    private DBUtils() {
    }

    public static Connection getConnection() throws SQLException {
        return getConnection("BSSC");
    }

    public static Connection getConnection(String connectName)
            throws SQLException {
        System.out.println("Khởi tạo kết nối: " + connectName);
        if (ods == null) {
            throw new SQLException("OracleDataSource null.");
        }
        return ods.getConnection();
    }

    public static void closePooledConnections() throws SQLException {
        if (ods != null) {
            ods.close();
        }
    }

    public static void listCacheInfos() throws SQLException {
        OracleConnectionCacheManager occm =
                OracleConnectionCacheManager.getConnectionCacheManagerInstance();
        System.out.println(occm.getNumberOfAvailableConnections(CACHE_NAME)
                + " Số connection hiện có trong bộ đệm " + CACHE_NAME);
        System.out.println(occm.getNumberOfActiveConnections(CACHE_NAME)
                + " connections đang active");
    }
}
