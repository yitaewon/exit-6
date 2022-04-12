package com.exit6.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.exit6.controller.BoardController;
import com.exit6.vo.CalendarVo;

@Repository
public class CalendarDaoImpl implements CalendarDao {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private SqlSession sql;
	
	private static String namespace = "boardMapper";
	
	@Override
	public int insertCalendar(CalendarVo calendarVo) {
		return sql.insert(namespace + ".insertCalendar", calendarVo);
	}

	@Override
	public int deleteCalendarByNo(int calNo) {
		return sql.delete(namespace + ".deleteCalendarByNo", calNo);
	}

	@Override
	public CalendarVo getCalendarByDay(int calDay) {
		return sql.selectOne(namespace + ".getCalendarByDay", calDay);
	}

	@Override
	public List<CalendarVo> getAllCalendars() {
		return sql.selectList(namespace + ".getAllCalendars");
	}
}
