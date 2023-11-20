<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script>
	$(document).ready(function() {
		loadList();
	});
	function loadList() {
		// 서버와 통신 : 게시판 리스트 가져오기
		$.ajax({
			url: "boardList.do",
			type: "get",
			dataType: "json",
			success: makeView,
			error: function() {
				alert("error3");
			}
		});
	}																			
	function makeView(data) { // data=[{ },{ },{ },,,]
		var listHtml="<table class='table table-bordered'>";
		listHtml+="<tr>";
		listHtml+="<td>번호</td>";
		listHtml+="<td>제목</td>";
		listHtml+="<td>작성자</td>";
		listHtml+="<td>작성일</td>";
		listHtml+="<td>조회수</td>";
		listHtml+="</tr>";
		$.each(data, function(index, obj) {
			listHtml+="<tr>";
			listHtml+="<td>"+obj.idx+"</td>";
			listHtml+="<td><a href=#>"+obj.title+"</td>";
			listHtml+="<td>"+obj.writer+"</td>";
			listHtml+="<td>"+obj.indate+"</td>";
			listHtml+="<td>"+obj.count+"</td>";
			listHtml+="</tr>";	
		});
		listHtml+="<tr>"
		listHtml+="<td colspan='5'>"
		listHtml+="<button class='btn btn-primary btn-sm' onclick='goForm()'>글쓰기</button>"
		listHtml+="</td>"
		listHtml+="</tr>"
		listHtml+="</table>"
		$("#view").html(listHtml);
		
		$("#view").css("display", "block");
		$("#wform").css("display", "none");
	}
	function goForm() {
		$("#view").css("display", "none");
		$("#wform").css("display", "block");
	}
	function goList() {
		$("#view").css("display", "block");
		$("#wform").css("display", "none");
	}
	function goInsert() {
		// var title = $("#title").val();
		// var content = $("#content").val();
		// var writer = $("#writer").val();
		
		var fData = $("#frm").serialize();
		
		$.ajax({
			url:"boardInsert.do",
			type:"post",
			data: fData,
			success: function() {
				loadList();
			},
			error: function() {
				alert(error)
			}
		});
/*		$("#title").val("");
		$("#content").val("");
		$("#writer").val(""); */
		$("#fclear").trigger("click"); // id="fclear"을 찾아가서 강제로 클릭 해준다
	}
	
  </script>
</head>
<body>
 
<div class="container">
  <h2>Spring MVC02</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD</div>
    <div class="panel-body" id="view">Panel Content</div>
    <div class="panel-body" id="wform" style="display: none;">
    	<form id="frm">
		   	<table class="table">
		   		<tr>
	  				<td>제목</td>
	  				<td><input type="text" id="title" name="title" class="form-control"></td>
		   		</tr>
		   		<tr>
		   			<td>내용</td>
		   			<td><textarea rows="7" id="content" name="content" class="form-control"></textarea></td>
		   		</tr>
		   		<tr>
		   			<td>작성자</td>
		   			<td><input type="text" id="writer" name="writer" class="form-control"></td>
		   		</tr>
		   		<tr>
		   			<td colspan="2" align="center">
		   				<button type="submit" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
		   				<button type="reset" class="btn btn-warning btn-sm" id="fclear">취소</button>
		   				<button type="button" class="btn btn-info btn-sm" onclick="goList()">리스트</button>
		   			</td>
		   		</tr>
		   	</table>
    	</form>
    </div>
    <div class="panel-footer">인프런_스프1탄_황대경</div>
  </div>
</div>

</body>
</html>
