package com.neusoft.controller;

import com.neusoft.bean.Manager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class BaseController {
    @Autowired
    HttpSession session;
    @Autowired
    HttpServletResponse request;

    public Manager getLoginManager()
    {
        Manager manger=(Manager)session.getAttribute(Manager.CURRENT_MANAGER);
        return manger;
    }
}
