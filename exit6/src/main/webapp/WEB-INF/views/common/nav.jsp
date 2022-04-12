<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<ul class="nav nav-tabs">
	<li role="presentation" class="home"><a href="home">Home</a></li>
	<li role="presentation" class="board">
	<a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false"> 게시판<span class="caret"></span></a>
		<ul class="dropdown-menu" role="menu">
			<li><a href="/board/boardList">게시판 목록</a></li>
			<li><a href="/board/boardhome">게시판 목록 2</a></li>
		</ul>
	</li>
	<li role="presentation" class="calculator"><a href="/board/calculator">계산기</a></li>
	<li role="presentation" class="calendar"><a href="/board/calendar">캘린더</a></li>
	<li role="presentation" class="test"><a href="/htm13/test">테스트</a></li>
</ul>
<script>
$(document).ready(function() {
	console.log("[네비게이션바] 적용 jsp");
	var loc = location.pathname.split("/")[2];
	console.log("location.pathname => "+location.pathname);
	console.log("loc => "+loc);
	// 해당 페이지에 맞는 네비게이션바 강조 옵션 적용
	if(loc.indexOf("board") > -1){
		$(".board").addClass("active");
	}else if(loc.indexOf("home") > -1){
		$(".home").addClass("active");
	}else if(loc.indexOf("calculator") > -1){
		$(".calculator").addClass("active");
	}else if(loc.indexOf("calendar") > -1){
		$(".calendar").addClass("active");
	}else if(loc.indexOf("test") > -1){
		$(".test").addClass("active");
});
</script>
