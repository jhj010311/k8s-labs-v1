package com.example.hellospringwithdocker;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class HelloController {

    private final HelloRepository repository;

    @GetMapping
    public String hello() {
        return "Hello World<br>Spring Boot and Docker here";
    }

    @ResponseBody
    @GetMapping("/greeting")
    public String greeting(@RequestParam String lang) {
        Greeting greeting = repository.getByLangCode(lang);

        return greeting.getMessage();
    }
}
