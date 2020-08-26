package com.vadim.annuity.util;

import org.junit.Test;

import static org.junit.Assert.*;

public class AnnuityCalculationUtilTest {

    @Test
    public void calculateAnnuityPayments() {
        Double expectedResult = 94.36;
        Double notExpectedResult = 80.55;
        Double methodResult = AnnuityCalculationUtil.calculateAnnuityPayments(2000.0, 48.0, 48);
        Double methodResultForNotExpected = AnnuityCalculationUtil.calculateAnnuityPayments(5000.0, 15.0, 15);
        assertEquals(expectedResult, methodResult);
        assertNotEquals(notExpectedResult, methodResultForNotExpected);
    }
}