package kr.board.mapper;

import java.util.List;

import kr.board.entity.Board;

// @Mapper - mybatis API
public interface BoardMapper {
	
	public List<Board> getLists();
}
