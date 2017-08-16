package com.dream.dblog.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 */
public class DataFormat {

    public static String getNowDate(){
        Date date = new Date();
        String model="yyyy-MM-dd  HH:mm:ss";  //指定格式化的模板
        SimpleDateFormat dateFormat2=new SimpleDateFormat(model);
        return dateFormat2.format(date);
    }

}
