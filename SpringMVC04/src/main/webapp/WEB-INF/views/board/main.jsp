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
  
  	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	$(document).ready(function() {
		loadList();
	});
	function loadList() {
		// 서버와 통신 : 게시판 리스트 가져오기
		$.ajax({
			url: "board/all",
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
			listHtml+="<td id='t"+obj.idx+"'><a href='javascript:goContent("+obj.idx+")'>"+obj.title+"</td>";
			listHtml+="<td>"+obj.writer+"</td>";
			listHtml+="<td>"+obj.indate.split(' ')[0]+"</td>";
			listHtml+="<td id='cnt"+obj.idx+"'>"+obj.count+"</td>";
			listHtml+="</tr>";
			
			listHtml+="<tr id='c"+obj.idx+"' style='display:none'>";
			listHtml+="<td>내용</td>";
			listHtml+="<td colspan='4'>";
			listHtml+="<textarea id='ta"+obj.idx+"' readonly rows='7' class='form-control'></textarea>";
			
			if("${mvo.memID}"==obj.memID) {
			listHtml+="</br>";
			listHtml+="<span id='ub"+obj.idx+"'><button class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp;";
			listHtml+="<button class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>";
			} else {
				listHtml+="</br>";
				listHtml+="<span id='ub"+obj.idx+"'><button disabled class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp;";
				listHtml+="<button disabled class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>";
			}
			
			listHtml+="</td>";
			listHtml+="</tr>";
		});
		// 로그인을 해야 보이는 부분
		if(${!empty mvo}) {
			listHtml+="<tr>"
			listHtml+="<td colspan='5'>"
			listHtml+="<button class='btn btn-primary btn-sm' onclick='goForm()'>글쓰기</button>"
			listHtml+="</td>"
			listHtml+="</tr>"
		}
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
			url:"board/new",
			type:"post",
			data: fData,
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
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
	function goContent(idx) {
		if($("#c"+idx).css("display")=="none") {
			$.ajax({
				url: "board/"+idx,
				type: "get",
				data: {"idx": idx},
				dataType: "json",
				success: function(data) {
					$("#ta"+idx).val(data.content);
				},
				error: function() {
					alert("goContent error");
				}
			});
			$("#c"+idx).css("display", "table-row"); // 보이게
			$("#ta"+idx).attr("readonly", true);
		} else {
			$("#c"+idx).css("display", "none"); // 안보이게
			
			$.ajax({
				url: "board/count/"+idx,
				type: "put",
				data: {"idx": idx},
				dataType: "json",
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
				},
				success: function(data) {
					$("#cnt"+idx).text(data.count);
				},
				error: function() {
					alert("goContent error");
				}
			});
		}
	}
	function goDelete(idx) {
		$.ajax({
			url: "board/"+idx,
			type: "delete",
			data: {"idx": idx},
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			success: function() {
				loadList();
			},
			error: function() {
				alert("error");
			}
		});
	}
	function goUpdateForm(idx) {
		$("#ta"+idx).attr("readonly", false);
		var title = $("#t"+idx).text();
		var newInput = "<input type='text' id='nt"+idx+"' class='form-control' value='"+title+"'/>";
		$("#t"+idx).html(newInput);
		
		var newButton ="<button class='btn btn-primary btn-sm' onclick='goUpdate("+idx+")'>수정</button>";
		$("#ub"+idx).html(newButton);
	}
	function goUpdate(idx) {
		var title = $("#nt"+idx).val();
		var content = $("#ta"+idx).val();
		$.ajax({
			url: "board/update",
			type: "put",
			contentType: 'application/json;charset=utf-8',
			data: JSON.stringify({"idx":idx, "title":title, "content":content}),
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
			},
			success: function() {
				console.log("asd");
				loadList();
			},
			error: function() {
				alert("goUpdate error");
			}
		});	
	}
	
  </script>
</head>
<body>



<div class="container">
  <jsp:include page="../common/header.jsp"/>
  <h2>회원 게시판</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD</div>
    <div class="panel-body" id="view">Panel Content</div>
    <div class="panel-body" id="wform" style="display: none;">
    	<form id="frm">
    		<input type="hidden" id="memID" name="memID" value="${mvo.memID}">
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
		   			<td><input type="text" id="writer" name="writer" class="form-control" value="${mvo.memName}" readonly></td>
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
