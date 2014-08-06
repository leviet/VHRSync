package com.myapp.service;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * @author BinhTD
 * @date: 18-Jan-2010
 * @purpose:
 *
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SqlCommon {

    public static void closeStatement(PreparedStatement statement) {
        try {
            if (statement != null) {
                statement.close();
            }
        } catch (Exception e) {
        }
    }

    public static void closeResultSet(ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (Exception e) {
        }

    }

    public static boolean commitOrRollback(Connection conn) {
        if (conn == null) {
            return false;
        }
        try {
            conn.commit();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            try {
                conn.rollback();
            } catch (SQLException ex1) {
                ex1.printStackTrace();
                return false;
            }
            return false;
        }
    }

    public static boolean commitOnly(Connection conn) {
        if (conn == null) {
            return false;
        }
        try {
            conn.commit();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static boolean rollback(Connection conn) {
        if (conn == null) {
            return false;
        }
        try {
            conn.rollback();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static void closeConnection(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public static boolean commit(Connection conn) {
        if (conn == null) {
            return false;
        }
        try {
            conn.commit();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public static Long getSequence(Connection cnn, String sequenceName) throws Exception {
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String queryString = "select " + sequenceName + ".NextVal as sequence FROM Dual";

            stm = cnn.prepareStatement(queryString);
            rs = stm.executeQuery();

            Long result = null;
            if (rs.next()) {
                result = rs.getLong("sequence");
            }
            return result;

        } catch (Exception re) {
            re.printStackTrace();
            throw re;

        } finally {
            SqlCommon.closeResultSet(rs);
            SqlCommon.closeStatement(stm);
        }


    }
}
