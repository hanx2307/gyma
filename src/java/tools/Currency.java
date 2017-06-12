/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tools;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.util.Locale;

/**
 *
 * @author Jack
 */
public class Currency {
    public static String formatCurrency(Long money){
        Locale locale =  new Locale("vi", "VN");
        NumberFormat format = NumberFormat.getCurrencyInstance(locale);
        DecimalFormat format2 = (DecimalFormat) DecimalFormat.getCurrencyInstance(locale);
        DecimalFormatSymbols formatSymbols = new DecimalFormatSymbols();
        formatSymbols.setCurrencySymbol("VNĐ");
        format2.setDecimalFormatSymbols(formatSymbols);
        return format2.format(money);
    }
}
