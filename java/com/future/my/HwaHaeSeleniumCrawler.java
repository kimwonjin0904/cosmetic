package com.future.my;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class HwaHaeSeleniumCrawler {

    public List<String> getCosmeticRanking() {
        List<String> rankingList = new ArrayList<>();

        System.setProperty("webdriver.chrome.driver", "C:\\chromedriver.exe");

        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless");
        options.addArguments("--no-sandbox");
        options.addArguments("--disable-dev-shm-usage");

        WebDriver driver = new ChromeDriver(options);

        try {
            driver.get("https://www.hwahae.co.kr/");
            Thread.sleep(3000); // 페이지 로딩 대기

            // ✅ 원하는 랭킹 데이터 크롤링 (overflow-auto px-20)
            List<WebElement> elements = driver.findElements(By.cssSelector(".overflow-auto.px-20"));

            for (WebElement element : elements) {
                rankingList.add(element.getText());
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit();
        }

        return rankingList;
    }
}
