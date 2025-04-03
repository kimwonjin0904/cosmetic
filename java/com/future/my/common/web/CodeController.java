package com.future.my.common.web;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.future.my.common.service.CodeService;
import com.future.my.common.vo.CodeVO;

@RestController
@RequestMapping("/api")
public class CodeController {

		@Autowired
		private CodeService codeService;
		
		@GetMapping("/getSubCodes")
		public ArrayList<CodeVO> getSubCodes (String commParent){
			ArrayList<CodeVO> codeList = codeService.getCodeList(commParent);
			return codeList;
		}
}
