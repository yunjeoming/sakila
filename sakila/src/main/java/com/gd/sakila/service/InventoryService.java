package com.gd.sakila.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gd.sakila.mapper.FilmMapper;
import com.gd.sakila.mapper.InventoryMapper;
import com.gd.sakila.vo.Film;
import com.gd.sakila.vo.Inventory;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class InventoryService {
	@Autowired InventoryMapper inventoryMapper;
	@Autowired FilmMapper filmMapper;
	
	public Map<String, Object> getInventoryList(int currentPage, int rowPerPage, String searchWord, Integer storeId, Integer notInStock){
		log.debug("▶@▶@▶@▶currentPage-> "+currentPage);
		log.debug("▶@▶@▶@▶rowPerPage-> "+rowPerPage);
		log.debug("▶@▶@▶@▶searchWord-> "+searchWord);
		log.debug("▶@▶@▶@▶storeId-> "+storeId);
		log.debug("▶@▶@▶@▶notInStock-> "+notInStock);
		
		//메소드 실행시 매개변수로 넣어줄 setMap
		Map<String, Object> setMap = new HashMap<>();
		setMap.put("searchWord", searchWord);
		setMap.put("storeId", storeId);
		setMap.put("notInStock", notInStock);
		
		//페이징
		int beginRow = (currentPage-1)*rowPerPage;
		int totalRow = inventoryMapper.selectInventoryTotal(setMap);
		log.debug("▶@▶@▶@▶totalRow-> "+totalRow);
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		
		//setMap에 나머지 값들 넣어준다.
		setMap.put("beginRow", beginRow);
		setMap.put("rowPerPage", rowPerPage);
		log.debug("▶@▶@▶@▶setMap-> "+setMap);
		
		//리스트 출력 메소드
		List<Map<String, Object>> inventoryList = inventoryMapper.selectInventoryList(setMap);
		log.debug("▶@▶@▶@▶inventoryList-> "+inventoryList);
		
		//컨트롤러에게 전달해줄 map
		Map<String, Object> map = new HashMap<>();
		map.put("inventoryList", inventoryList);
		map.put("lastPage", lastPage);
		map.put("totalRow", totalRow);
		
		return map;
	}
	
	public int addInventory(Inventory inventory, int ea) {
		log.debug("▶@▶@▶@▶inventory-> "+inventory);
		log.debug("▶@▶@▶@▶추가 갯수-> "+ea);
		
		int addCnt = 0;		//추가 횟수
		int totalCnt = 0;	//수량만큼 추가했는지?
		
		for(int i=0; i<ea; i++) {
			addCnt = inventoryMapper.insertInventory(inventory);
			log.debug("▶@▶@▶@▶inventory 등록 완료1, 실패0-> "+addCnt);
			if(addCnt == 1) {
				totalCnt += 1;
			}
		}
		return totalCnt;
	}
	
	public int removeInventory(Inventory inventory, int ea) {
		log.debug("▶@▶@▶@▶inventory-> "+inventory);
		log.debug("▶@▶@▶@▶삭제 갯수-> "+ea);
		
		int removeCnt = 0;	//추가 횟수
		int totalCnt = 0;	//확인용
		int inventoryId = 0;
		//delete에서 selectKey가 안 먹혀서 쿼리를 2개로 나눴음.
		//inventoryId 구하는 select쿼리 실행 후 -> delete 실행
		
		for(int i=0; i<ea; i++) {
			inventoryId = inventoryMapper.selectLastInventoryId(inventory);	//inventoryId 얻기 <- 제일 늦게 등록한 inventoryId를 가져온다.
			removeCnt = inventoryMapper.deleteInventory(inventoryId);		//위에서 얻은 id로 삭제 실행
			log.debug("▶@▶@▶@▶inventory 삭제 완료1, 실패0-> "+removeCnt);
			if(removeCnt == 1) {
				totalCnt += 1;
			}
		}
		return totalCnt;
	}
	
	public List<Film> addInventoryByFilmTitleList(String keyWord) {
		return filmMapper.selectFilmTitleList(keyWord);
	}
	
	public List<Map<String, Object>> removeInventoryByFilmTitleList(int storeId, String keyWord){
		log.debug("▶@▶@▶@▶storeId-> "+storeId);
		log.debug("▶@▶@▶@▶keyWord-> "+keyWord);
		//selectFilmTitleListByStoreId의 매개타입 Map
		Map<String, Object> setMap = new HashMap<>();
		setMap.put("storeId", storeId);
		setMap.put("keyWord", keyWord);
		return filmMapper.selectFilmTitleListByStoreId(setMap);
	}
}
