package com.future.my.service;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class HwahaeCrawlerService {
    public List<String> getHwahaeProducts() {
        List<String> productList = new ArrayList<>();

        WebDriverManager.chromedriver().setup();
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless"); // GUI 없이 실행
        options.addArguments("--disable-gpu");
        options.addArguments("--no-sandbox");

        WebDriver driver = new ChromeDriver(options);

        try {
            driver.get("https://www.hwahae.co.kr/rankings?english_name=skin&theme_id=174");
            Thread.sleep(3000);

            List<WebElement> products = driver.findElements(By.cssSelector(".product-info .name"));

            if (products.isEmpty()) {
                System.out.println("🚨 제품 정보를 찾을 수 없습니다.");
            } else {
                for (WebElement product : products) {
                    String productName = product.getText();
                    System.out.println("✅ 제품: " + productName);
                    productList.add(productName);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit();
        }

        return productList;
    }
}
