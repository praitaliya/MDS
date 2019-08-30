package com.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;
import java.util.Date;

/**
 * class for various util checks
 * @author Prashant Italiya
 *
 */
public class Utils {
	public static int checkPageAccess(String role, String uid) { // check if user have access to request and page access
		int response = 0;
		if (!role.equalsIgnoreCase("admin")) {
			response = 0;
		} else {
			response = 1;
		}
		return response;
	}
	
	public static int getAge(String date) throws ParseException {
		Date d = new SimpleDateFormat("yyyy-mm-dd").parse(date);
		LocalDate dob = convertToLocalDateViaInstant(d);
		LocalDate now = LocalDate.now();
		int age = Period.between(dob, now).getYears();
		return age;
	}
	
	public static LocalDate convertToLocalDateViaInstant(Date dateToConvert) {
	    return dateToConvert.toInstant()
	      .atZone(ZoneId.systemDefault())
	      .toLocalDate();
	}
}
