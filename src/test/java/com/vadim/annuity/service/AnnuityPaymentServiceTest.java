package com.vadim.annuity.service;

import com.vadim.annuity.util.AnnuityCalculationUtil;
import org.junit.Test;
import org.mockito.Mockito;
import org.mockito.internal.matchers.Any;

import static org.junit.Assert.*;
import static org.mockito.ArgumentMatchers.anyDouble;
import static org.mockito.ArgumentMatchers.anyInt;

public class AnnuityPaymentServiceTest {

    private Double getResultFromUtil(){
        return AnnuityCalculationUtil.calculateAnnuityPayments(Double.valueOf(2000), 48.0, 48);
    }

    @Test
    public void getMonthlyPayment() {
        AnnuityPaymentService annuityPaymentService = Mockito.mock(AnnuityPaymentService.class);
        Double temporaryResult = getResultFromUtil();
        Mockito.when(annuityPaymentService.getMonthlyPayment(2000, 48.0, 48)).thenReturn(temporaryResult);

        Double expectedResult = 94.36;
        Double methodResult = annuityPaymentService.getMonthlyPayment(2000, 48.0, 48);
        assertEquals(expectedResult, methodResult);
    }
}