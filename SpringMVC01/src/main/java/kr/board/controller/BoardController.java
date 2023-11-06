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

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {
	
	@Autowired
	private BoardMapper boardMapper;
	
	// boardList.do
	@RequestMapping("/boardList.do")
	public String boardList(Model model) {
		
		List<Board> list = boardMapper.getLists();
		
		model.addAttribute("list", list);
		return "boardList"; // /WEB-INF/views/boardList.jsp --> forward
	}
	@GetMapping("/boardForm.do")
	public String boardForm() {
		return "boardForm";		//	/WEB-INF/views/boardForm.jsp --> forward
	}
	
	@PostMapping("/boardInsert.do")
	public String boardInsert(Board vo) { // title, content, writer --> 파라미터 수집
		boardMapper.boardInsert(vo);
		return "redirect:/boardList.do";
	}
	
	@GetMapping("/boardContent.do")
	public String boardContent(@RequestParam("idx") int idx, Model model) { // ?idx=6
		Board vo = boardMapper.boardContent(idx);
		model.addAttribute("vo", vo);
		return "boardContent";	//	/WEB-INF/views/boardContent.jsp --> forward
	}
	
	@GetMapping("/boardDelete.do/{idx}")
	public String boardDelete(@PathVariable("idx") int idx) {	//	?idx=6
		boardMapper.boardDelete(idx);
 		return "redirect:/boardList.do";
	}
	
	@GetMapping("/boardUpdateForm.do/{idx}")
	public String boardUpdateForm(@PathVariable("idx") int idx, Model model) {
		Board vo = boardMapper.boardContent(idx);
		model.addAttribute("vo", vo);
		return "boardUpdate"; // boardUpdate.jsp
	}
	
	@PostMapping("/boardUpdate.do")
	public String boardUpdate(Board vo) {
		boardMapper.boardUpdate(vo); // 수정
		return "redirect:/boardList.do";
	}
	
}
