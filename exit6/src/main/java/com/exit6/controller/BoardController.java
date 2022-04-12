package com.exit6.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.exit6.service.CalendarService;
import com.exit6.vo.CalendarVo;

@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	private CalendarService calendarService;
	
	// 메인 화면
	@RequestMapping(value = "")
	public String home() throws Exception {
		logger.info("/board/home");
		return "home";
	}
	
	// 계산기
	@RequestMapping(value = "/board/calculator")
	public String calculator() throws Exception {
		logger.info("/board/calculator");
		return "/board/calculator";
	}
	
	// 캘린더 메인화면 
	@RequestMapping(value = "/board/calendar")
	public String calendar(Model model) {
		logger.info("/board/calendar");
		return "/board/calendar";
	}
	
	// test화면
	@RequestMapping(value = "/htm13/test")
	public String test(Model model) {
		logger.info("/htm13/test");
		return "/htm13/test";
	}
	
	// 캘린더 모달
	@RequestMapping("/board/modalCalendar")
	public @ResponseBody ResponseEntity<CalendarVo> modalCalendar(@RequestParam("calDay") int calDay) {
		logger.info("/board/modalCalendar");
		CalendarVo calendarList = calendarService.getCalendarByDay(calDay);
		return new ResponseEntity<CalendarVo>(calendarList, HttpStatus.OK);
	}
}




