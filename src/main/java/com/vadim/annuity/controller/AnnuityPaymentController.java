package com.vadim.annuity.controller;

import com.vadim.annuity.util.RedirectUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/")
public class AnnuityPaymentController {

    @GetMapping()
    public ModelAndView index(){
        return RedirectUtil.redirect("/annuity/main");
    }

    @GetMapping("/annuity/main")
    public ModelAndView getMainPage(){
        return new ModelAndView("index");
    }
}
