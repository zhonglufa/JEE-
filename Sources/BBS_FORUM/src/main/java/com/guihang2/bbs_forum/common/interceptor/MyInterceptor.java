package com.guihang2.bbs_forum.common.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Author: zhonglufa
 * @CreateTime: 2025-05-16
 * @Description:
 * @Version: 2.0
 */


public class MyInterceptor implements HandlerInterceptor {
    //实现拦截器三种方法
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Object obj = request.getSession().getAttribute("user");
        if ( obj == null) {
            //未登录
            request.setAttribute("msg","请登录之后在访问");
            //从静态地址转发登录页面，不会被拦截，因为之拦截controlle
            request.getRequestDispatcher("/login.jsp").forward(request,response);
            return false;
        }
        return true;
    }


    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
        System.out.println("postHandle********");
    }


    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        System.out.println("afterCompletion********");
    }
}
