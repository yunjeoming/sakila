package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.BoardMapper;
import com.gd.sakila.vo.Board;
import com.gd.sakila.vo.Page;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service	//BoardService의 객체를 생성
@Transactional
public class BoardService {
	@Autowired	//BoardMapper의 객체를 생성
	private BoardMapper boardMapper;
	
	//수정
	public int modifyBoard(Board board) {
		log.debug("▷▶▷▶▷modifyBoard-> "+board.toString());
		return boardMapper.updateBoard(board);
	}
	
	//삭제
	public int removeBoard(Board board) {
		log.debug("▷▶▷▶▷removeBoard-> "+board.toString());
		return boardMapper.deleteBoard(board);
	}
	
	//추가
	public int addBoard(Board board) {
		log.debug("▷▶▷▶▷addBoard-> "+board.toString());
		return boardMapper.insertBoard(board);
	}
	
	//하나보기
	public Map<String, Object> getBoardOne(int boardId){
		log.debug("▷▶▷▶▷getBoardOne.boardId-> "+boardId);
		Map<String, Object> boardOne = boardMapper.selectBoardOne(boardId);
		return boardOne;
	}
	
	//리스트 출력
	public Map<String, Object>	getBoardList(int currentPage, int rowPerPage, String searchWord){
		//매개변수 값 가공&처리
		//전체 list 수(boardTotal), 마지막 페이지(lastPage) 구하기
		int boardTotal = boardMapper.selectBoardTotal(searchWord);
		int lastPage = boardTotal/rowPerPage;
		if(boardTotal%rowPerPage != 0) {
			lastPage += 1;
		}
		//int lastPage = (int)(Math.ceil((double)boardTotal/rowPerPage));
		int beginRow = (currentPage-1)*rowPerPage;
		
		//전처리
		Page page = new Page();
		page.setBeginRow(beginRow);
		page.setRowPerPage(rowPerPage);
		page.setSearchWord(searchWord);
		//System.out.println("Page-> "+page.toString());
		log.debug("▷▶▷▶▷getBoardList.page-> "+page.toString());
		
		//쿼리 호출
		List<Board> boardList = boardMapper.selectBoardList(page);	//Page
		
		Map<String, Object> map = new HashMap<>();
		map.put("boardList", boardList);
		map.put("lastPage", lastPage);
		
		return map;
	}
}