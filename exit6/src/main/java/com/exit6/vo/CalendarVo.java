package com.exit6.vo;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;


@Data
public class CalendarVo {

	private int calNo;
	private int calYear;
	private int calMonth;
	private int calDay;
	private int calTime;
	private String contents;
	private String calReq;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date calDate;
}
