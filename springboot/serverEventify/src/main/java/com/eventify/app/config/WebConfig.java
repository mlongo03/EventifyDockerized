package com.eventify.app.config;

import java.util.Arrays;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.web.filter.CorsFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.beans.factory.annotation.Value;

@Configuration
@EnableWebMvc
public class WebConfig {

	@Value("${client.prot}")
	private String clientProtocol;

	@Value("${client.ip}")
	private String clientIp;

	@Value("${client.port}")
	private int clientPort;

	@Bean
	public FilterRegistrationBean<CorsFilter> corsFilter() {
		UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
		CorsConfiguration config = new CorsConfiguration();
		config.setAllowCredentials(true);
		config.addAllowedOrigin(clientProtocol + "://" + clientIp + ":" + clientPort);
		config.addAllowedOrigin(clientProtocol + "://" + clientIp);
		config.setAllowedHeaders(Arrays.asList(
			HttpHeaders.AUTHORIZATION,
			HttpHeaders.CONTENT_TYPE,
			HttpHeaders.ACCEPT));
		config.setAllowedMethods(Arrays.asList(
			HttpMethod.GET.name(),
			HttpMethod.POST.name(),
			HttpMethod.PUT.name(),
			HttpMethod.DELETE.name()
		));
		config.setMaxAge(3600L);
		source.registerCorsConfiguration("/**", config);
		FilterRegistrationBean<CorsFilter> bean = new FilterRegistrationBean<CorsFilter>(new CorsFilter(source));
		bean.setOrder(-102);
		return bean;
	}

}
