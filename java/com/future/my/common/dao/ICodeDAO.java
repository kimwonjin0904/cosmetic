package com.future.my.common.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.future.my.common.vo.CodeVO;

@Mapper
public interface ICodeDAO {
	
	public ArrayList<CodeVO> getCodeList(String commParent);
}
