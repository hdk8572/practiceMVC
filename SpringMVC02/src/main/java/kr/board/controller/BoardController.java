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
	private BoardMapper boardMapper;
	
	// boardList.do
	@RequestMapping("/")
	public String main() {
		return "main";
	}

	@RequestMapping("/boardList.do")
	@ResponseBody // -> jackson-databind(객체를 -> Json 데이터 포멧으로 변환)
	public List<Board> boardList() {
		List<Board> list = boardMapper.getLists();
		return list;	// JSON 데이터 형식으로 변환해서 리턴하겠다.
	}
	
	@PostMapping("/boardInsert.do")
	@ResponseBody
	public void boardInsert(Board vo) {
		boardMapper.boardInsert(vo);
	}
	
}
