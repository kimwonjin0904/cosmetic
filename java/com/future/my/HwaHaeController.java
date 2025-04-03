package com.future.my;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;

@Controller
@RequestMapping("/hwaHae")
public class HwaHaeController {

    private final HwaHaeSeleniumCrawler crawler;

    public HwaHaeController(HwaHaeSeleniumCrawler crawler) {
        this.crawler = crawler;
    }

    @GetMapping("/home")
    public String getHomePage(Model model) {
        List<String> rankings = crawler.getCosmeticRanking(); // 크롤링한 데이터 가져오기
        model.addAttribute("rankings", rankings); // JSP에 데이터 전달
        return "home"; // home.jsp로 이동
    }
}
