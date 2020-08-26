package com.vadim.annuity.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.annotation.PostConstruct;
import java.util.Collections;

@Configuration
public class ApplicationConfiguration {

    private final FreeMarkerConfigurer freeMarkerConfigurer;

    @Autowired
    public ApplicationConfiguration(FreeMarkerConfigurer freeMarkerConfigurer) {
        this.freeMarkerConfigurer = freeMarkerConfigurer;
    }

    @PostConstruct
    public void loadClassPathTlds() {
        freeMarkerConfigurer
                .getTaglibFactory()
                .setClasspathTlds(Collections.singletonList("/META-INF/security.tld"));
    }
}
