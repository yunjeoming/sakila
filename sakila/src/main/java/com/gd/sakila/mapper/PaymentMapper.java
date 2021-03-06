package com.gd.sakila.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gd.sakila.vo.Payment;

@Mapper
public interface PaymentMapper {
	Double selectPaymentByCustomer(int customerId);
	List<Map<String, Object>> selectSalesListByCategory();
	List<Map<String, Object>> selectBestSellerList();
	List<Map<String, Object>> selectSalesListByStore();
	List<Map<String, Object>> selectPaymentInfoList(Map<String, Object> map);
	Double selectAmountFromRentalDate(int rentalId);
	List<Integer> selectYear();
	List<Map<String, Object>> selectSalesListByPeriod(Integer storeId, int year);
	int insertPayment(Payment payment);
	int updateAmount(Map<String, Object> map);
}
