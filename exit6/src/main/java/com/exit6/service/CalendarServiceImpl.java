package com.exit6.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.exit6.controller.BoardController;
import com.exit6.dao.CalendarDao;
import com.exit6.vo.CalendarVo;


@Service
public class CalendarServiceImpl implements CalendarService{
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Resource
	private CalendarDao calendarDao;

	@Override
	public void insertCalendar(CalendarVo calendarVo) {
		calendarDao.insertCalendar(calendarVo);
	}

	@Override
	public void deleteCalendarByNo(int calNo) {
		calendarDao.deleteCalendarByNo(calNo);
	}

	@Override
	public CalendarVo getCalendarByDay(int calDay) {
		return calendarDao.getCalendarByDay(calDay);
	}

	@Override
	public List<CalendarVo> getAllCalendars() {
		return calendarDao.getAllCalendars();
	}
}
