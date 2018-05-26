package com.example.demo;

import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WelcomeController {

	// inject via application.properties
	@Value("${message.title:test}")
	private String message = "Test test";

	@RequestMapping("/")
	public String welcome(Map<String, Object> model) {
		model.put("title", this.message);
		return "welcome";
	}

}