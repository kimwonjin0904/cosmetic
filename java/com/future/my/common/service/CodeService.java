package com.future.my.common.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.common.dao.ICodeDAO;
import com.future.my.common.vo.CodeVO;

@Service
public class CodeService {

		@Autowired
		ICodeDAO dao;
		
		public ArrayList<CodeVO> getCodeList(String commParent){
			return dao.getCodeList(commParent);
		}
}
