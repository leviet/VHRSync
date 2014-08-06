/*
 * ResourceBundleUtils.java
 *
 * Created on September 18, 2007, 11:01 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package com.myapp.common.util;

import com.myapp.BO.DbInfo;
import com.viettel.common.util.EncryptDecryptUtils;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ResourceBundle;

/**
 *
 * @author DatTV
 */
public class ResourceBundleUtils {

    static private ResourceBundle rb = null;

    /** Creates a new instance of ResourceBundleUtils */
    public ResourceBundleUtils() {
    }

    public static DbInfo getDbInfoEncrypt(String key) {
        rb = ResourceBundle.getBundle("config");
        String resKey = rb.getString(key);
        return decryptDBConfig(resKey);
    }

    private static DbInfo decryptDBConfig(String encryptFilePath) {
        try {
            URL file = Thread.currentThread().getContextClassLoader().getResource(encryptFilePath);
            String decryptString = EncryptDecryptUtils.decryptFile(URLDecoder.decode(file.getPath(),"UTF-8"));
            String[] appProperties = decryptString.split("\r\n");
            DbInfo dbInfo = new DbInfo();

            //2012_10_11: AnhDK: Thay doi cach giai ma de ap dung cho DB RAC
            int splitPoint = appProperties[0].indexOf("=");
            String dbConnStr = appProperties[0].substring(splitPoint + 1);
            splitPoint = appProperties[1].indexOf("=");
            String dbUser = appProperties[1].substring(splitPoint + 1);
            splitPoint = appProperties[2].indexOf("=");
            String dbPass = appProperties[2].substring(splitPoint + 1);
            /*
            String dbConnStr = appProperties[0].split("=")[1].trim();
            String dbUser = appProperties[1].split("=")[1].trim();
            String dbPass = appProperties[2].split("=")[1].trim();
            */

            dbInfo.setConnStr(dbConnStr);
            dbInfo.setUserName(dbUser);
            dbInfo.setPassWord(dbPass);
            return dbInfo;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
