package com.vadim.annuity.controller;


import com.vadim.annuity.dto.AnnuityPaymentDTO;
import com.vadim.annuity.service.AnnuityPaymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/annuity")
public class ApiAnnuityPaymentController {

    private final AnnuityPaymentService annuityPaymentService;

    @Autowired
    public ApiAnnuityPaymentController(AnnuityPaymentService annuityPaymentService) {
        this.annuityPaymentService = annuityPaymentService;
    }

    @GetMapping("/calculate")
    public AnnuityPaymentDTO getCalculatedResult(
            @RequestParam(name = "creditAmount") Integer creditAmount,
            @RequestParam(name = "interestRate") Double interestRate,
            @RequestParam(name = "paymentPeriod") Integer paymentPeriod
    ){
        if (interestRate <= 0.0)
            return new AnnuityPaymentDTO()
                    .setStatus(HttpStatus.BAD_REQUEST)
                    .setError("Процентная ставка не может быть ниже или равна 0");
        if (creditAmount <= 0.0)
            return new AnnuityPaymentDTO()
                    .setStatus(HttpStatus.BAD_REQUEST)
                    .setError("Сумма кредита не может быть ниже или равна 0");
        if (paymentPeriod <= 0.0)
            return new AnnuityPaymentDTO()
                    .setStatus(HttpStatus.BAD_REQUEST)
                    .setError("Расчетный период не может быть ниже или равен 0");

        return new AnnuityPaymentDTO()
                .setStatus(HttpStatus.OK)
                .setError("")
                .setPaymentPeriod(paymentPeriod)
                .setPaymentPerMonth(annuityPaymentService.getMonthlyPayment(creditAmount, interestRate, paymentPeriod));
    }
}
