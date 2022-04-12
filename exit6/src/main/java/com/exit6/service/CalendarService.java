package com.exit6.service;

import java.util.List;

import com.exit6.vo.CalendarVo;


public interface CalendarService {

	void insertCalendar(CalendarVo calendarVo);
//	void updateCalendar(CalendarVo calendarVo);
//	void mergeCalendar(CalendarVo calendarVo);
	void deleteCalendarByNo(int calNo);
	CalendarVo getCalendarByDay(int calDay);
	List<CalendarVo> getAllCalendars();	
}
