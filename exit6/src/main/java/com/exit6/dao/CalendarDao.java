package com.exit6.dao;

import java.util.List;

import com.exit6.vo.CalendarVo;

public interface CalendarDao {

	int insertCalendar(CalendarVo calendarVo);
//	int updateCalendar(CalendarVo calendarVo);
//	int mergeCalendar(CalendarVo calendarVo);
	int deleteCalendarByNo(int calNo);
	CalendarVo getCalendarByDay(int calDay);
	List<CalendarVo> getAllCalendars();
}
