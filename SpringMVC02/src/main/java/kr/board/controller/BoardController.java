package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {
	
	@Autowired
	private BoardMapper BoardMapper;
	
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
	@RequestMapping("/boardList.do")
	@ResponseBody
	public List<Board> boardList() {
		List<Board> list = BoardMapper.getLists();
		return list; //  JSON 데이터 형식으로 변환(API)해서 리턴하겠다.
	}
	
	@PostMapping("/boardInsert.do")
	@ResponseBody
	public void boardInsert(Board vo) {
		BoardMapper.boardInsert(vo); // 등록성공
	}
	
	@GetMapping("/boardDelete.do")
	@ResponseBody
	public void boardDelete(@RequestParam("idx") int idx) {
		BoardMapper.boardDelete(idx);
	}
	
	@PostMapping("/boardUpdate.do")
	@ResponseBody
	public void boardUpdate(Board vo) {
		BoardMapper.boardUpdate(vo);
	}
	
	@GetMapping("/boardContent.do")
	@ResponseBody
	public Board boardContent(@RequestParam("idx") int idx) {
		Board vo = BoardMapper.boardContent(idx);
		return vo;
	}
	
	@GetMapping("/boardCount.do")
	@ResponseBody
	public Board boardCount(@RequestParam("idx") int idx) {
		BoardMapper.boardCount(idx);
		Board vo = BoardMapper.boardContent(idx);
		return vo;
	}
	
}
 
