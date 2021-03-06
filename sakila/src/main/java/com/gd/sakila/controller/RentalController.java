package com.gd.sakila.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gd.sakila.service.RentalService;
import com.gd.sakila.vo.Rental;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class RentalController {
	@Autowired RentalService rentalService;
	
	@GetMapping("/getRentalList")
	public String getRentalList(Model model, @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
											@RequestParam(value = "rowPerPage", defaultValue = "10") int rowPerPage,
											@RequestParam(value = "searchWord", required = false) String searchWord,
											@RequestParam(value = "storeId", required = false) Integer storeId) {
		log.debug("▶@▶@▶@▶currentPage-> "+currentPage);
		log.debug("▶@▶@▶@▶rowPerPage-> "+rowPerPage);
		log.debug("▶@▶@▶@▶searchWord-> "+searchWord);	
		log.debug("▶@▶@▶@▶storeId-> "+storeId);	
		
		//String 넘어오는 값 전처리
		if(searchWord != null && searchWord.equals("")) {
			searchWord = null;
		}
		
		Map<String, Object> map = rentalService.getRentalList(currentPage, rowPerPage, searchWord, storeId);
		model.addAttribute("rentalList", map.get("rentalList"));
		model.addAttribute("lastPage", map.get("lastPage"));
		model.addAttribute("totalRow", map.get("totalRow"));
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("storeId", storeId);
		
		return "getRentalList";
	}
	
	@GetMapping("/addRental")
	public String addRental() {
		return "addRental";
	}
	
	@PostMapping("/addRental")
	public String addRental(String[] customerId, String[] inventoryId, String[] staffId) {
		for(int i=0; i<customerId.length; i++) {
			log.debug("▶@▶@▶@▶대여 customerId->["+customerId[i]+"], inventoryId->["+inventoryId[i]+"], staffId->["+staffId[i]+"]");
		}
		int totalCnt = rentalService.addRental(customerId, inventoryId, staffId);
		log.debug("▶@▶@▶@▶대여 등록 횟수-> "+totalCnt);
		//렌탈 id 추가 후 paymentId 추가하도록 한다. -> rentalService에서 한번에 처리한다.
		
		return "redirect:/admin/getRentalList";
	}
}
