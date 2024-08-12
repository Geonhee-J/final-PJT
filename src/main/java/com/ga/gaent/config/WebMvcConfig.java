package com.ga.gaent.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import com.ga.gaent.util.LoginInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        
        /* 업로드 파일 불러오기, 배포 후 */
        /*
         * registry.addResourceHandler("/upload/**") .addResourceLocations("file:/home/ubuntu/upload/");
         */

        /* 업로드 파일 불러오기, 배포 전 */
        registry.addResourceHandler("/upload/**")
        .addResourceLocations("classpath:/static/upload/");
        
        /* "/assets/**"로 호출하는 자원은 "/static/assets/"폴더 아래에서 찾는다. */
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("classpath:/static/assets/")
                .setCachePeriod(60 * 60 * 24 * 365);
        
        /* "/js/**"로 호출하는 자원은 "/static/js/"폴더 아래에서 찾는다. */
        registry.addResourceHandler("/js/**")
                .addResourceLocations("classpath:/static/js/")
                .setCachePeriod(60 * 60 * 24 * 365);
        
        /* "/libs/**"로 호출하는 자원은 "/static/libs/"폴더 아래에서 찾는다. */
        registry.addResourceHandler("/libs/**")
                .addResourceLocations("classpath:/static/libs/")
                .setCachePeriod(60 * 60 * 24 * 365);
        
        /* "/scss/**"로 호출하는 자원은 "/static/scss/"폴더 아래에서 찾는다. */
        registry.addResourceHandler("/scss/**")
                .addResourceLocations("classpath:/static/scss/")
                .setCachePeriod(60 * 60 * 24 * 365);
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 19.
     * Description : 로그인 인증 분기 인터셉터
     */
    @Autowired LoginInterceptor loginInterceptor;
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loginInterceptor)
        .addPathPatterns("/**")
        .excludePathPatterns("/login","/notLogin","/findId","/findPw","/resetPw", "/static/**", "/assets/**", "/fonts/**", "/js/**", "/libs/**", "/scss/**" , "/upload/**");
        WebMvcConfigurer.super.addInterceptors(registry);
    }
}
