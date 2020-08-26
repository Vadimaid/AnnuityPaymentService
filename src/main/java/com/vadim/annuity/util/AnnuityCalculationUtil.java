package com.vadim.annuity.util;

public class AnnuityCalculationUtil {

    public static Double calculateAnnuityPayments(Double creditAmount, Double interestRate, Integer paymentPeriod){
        Double interestAmountInMonthLessThanOne = (interestRate * 0.01) / 12;
        Double temporaryPow = Math.pow((1.0 + interestAmountInMonthLessThanOne), paymentPeriod);
        Double annuityCoefficient = (interestAmountInMonthLessThanOne * temporaryPow) / (temporaryPow - 1.0);
        return Math.round((annuityCoefficient * creditAmount) * 100.0) / 100.0;
    }
}
