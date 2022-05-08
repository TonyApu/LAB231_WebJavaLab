/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.util;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author TamNXL
 */
public class DateHelper implements Serializable {
    
    public long getDaysBetween(String begin, String end) throws ParseException {
        DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-mm-dd");
        
        Date date1;
        Date date2;
        long daysBetween;
        
        date1 = simpleDateFormat.parse(begin);
        date2 = simpleDateFormat.parse(end);
        long secondBetween = date2.getTime() - date1.getTime();
        daysBetween = secondBetween / (24 * 60 * 60 * 1000);
        return daysBetween;
    }
}
