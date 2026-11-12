package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.util.Map;

@RestController
public class HelloController {

    @Value("${APP_VERSION:local}")
    private String version;

    @GetMapping("/")
    public Map<String, String> hello() throws Exception {
        return Map.of(
                "message", "hello gitops v2",
                "version", version,
                "host", InetAddress.getLocalHost().getHostName()
        );
    }
}