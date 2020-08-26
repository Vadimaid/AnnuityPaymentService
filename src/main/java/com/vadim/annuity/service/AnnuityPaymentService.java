package com.vadim.annuity.service;

import com.vadim.annuity.util.AnnuityCalculationUtil;
import org.springframework.stereotype.Service;

import javax.validation.constraints.NotNull;

@Service
public class AnnuityPaymentService {

    @NotNull
    public Double getMonthlyPayment(Integer creditAmount, Double interestRate, Integer paymentPeriod){
        return AnnuityCalculationUtil.calculateAnnuityPayments(Double.valueOf(creditAmount), interestRate, paymentPeriod);
    }
}
