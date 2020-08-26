package com.vadim.annuity.controller;

import com.vadim.annuity.dto.AnnuityPaymentDTO;
import com.vadim.annuity.service.AnnuityPaymentService;
import com.vadim.annuity.util.AnnuityCalculationUtil;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.CoreMatchers.is;
import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc
public class ApiAnnuityPaymentControllerTest {

    @Autowired
    private MockMvc mvc;

    @Autowired
    private ApiAnnuityPaymentController apiAnnuityPaymentController;

    @Autowired
    private AnnuityPaymentService annuityPaymentService;

    @Before
    public void setUp(){
        apiAnnuityPaymentController = Mockito.mock(ApiAnnuityPaymentController.class);
        annuityPaymentService = Mockito.mock(AnnuityPaymentService.class);
    }

    private Double getResultFromUtil(){
        return AnnuityCalculationUtil.calculateAnnuityPayments(Double.valueOf(2000), 48.0, 48);
    }

    @Test
    public void getCalculatedResult() {
        Double temporaryResult = getResultFromUtil();
        Mockito.when(annuityPaymentService.getMonthlyPayment(2000, 48.0, 48)).thenReturn(temporaryResult);
        Double resultFromService = annuityPaymentService.getMonthlyPayment(2000, 48.0, 48);
        AnnuityPaymentDTO resultDTO = new AnnuityPaymentDTO()
                .setStatus(HttpStatus.OK)
                .setError("")
                .setPaymentPeriod(48)
                .setPaymentPerMonth(resultFromService);
        Mockito.when(apiAnnuityPaymentController.getCalculatedResult(2000, 48.0, 48)).thenReturn(resultDTO);

        assertThat(94.36, is(apiAnnuityPaymentController.getCalculatedResult(2000, 48.0, 48).getPaymentPerMonth()));
    }

    @Test
    public void getCalculatedResultUrlTest() throws Exception{
        mvc.perform(get("/api/annuity/calculate")
                .contentType(MediaType.APPLICATION_JSON)
                .param("creditAmount", "2000")
                .param("interestRate", "48")
                .param("paymentPeriod", "48"))
                .andExpect(status().isOk())
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                .andExpect(content().json("{'paymentPerMonth':94.36}"));
    }
}