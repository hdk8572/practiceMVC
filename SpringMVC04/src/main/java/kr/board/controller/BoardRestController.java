package kr.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@RequestMapping("/board")
@RestController	// Ajax 통신할 떄 사용하는 코드 @ResponseBody를 생략 할 수 있다.
public class BoardRestController {

	@Autowired
	private BoardMapper BoardMapper;
	
	@GetMapping("/all")
	public List<Board> boardList() {
		List<Board> list = BoardMapper.getLists();
		return list; //  JSON 데이터 형식으로 변환(API)해서 리턴하겠다.
	}
	
	// @PostMapping("/boardInsert.do")
	@PostMapping("/new")
	public void boardInsert(Board vo) {
		BoardMapper.boardInsert(vo); // 등록성공
	}
	
	@DeleteMapping("/{idx}")
	public void boardDelete(@RequestParam("idx") int idx) {
		BoardMapper.boardDelete(idx);
	}
	
	@PutMapping("/update")
	public void boardUpdate(@RequestBody Board vo) {
		BoardMapper.boardUpdate(vo);
	}
	
	@GetMapping("/{idx}")
	public Board boardContent(@PathVariable("idx") int idx) {
		Board vo = BoardMapper.boardContent(idx);
		return vo;
	}
	
	@PutMapping("/count/{idx}")
	public Board boardCount(@PathVariable("idx") int idx) {
		BoardMapper.boardCount(idx);
		Board vo = BoardMapper.boardContent(idx);
		return vo;
	}
	
}
