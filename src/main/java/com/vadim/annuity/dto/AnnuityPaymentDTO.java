package com.vadim.annuity.dto;

import org.springframework.http.HttpStatus;

public class AnnuityPaymentDTO {

    private HttpStatus status;

    private String error;

    private Integer paymentPeriod;

    private Double paymentPerMonth;

    public AnnuityPaymentDTO(){}

    public HttpStatus getStatus() {
        return status;
    }

    public AnnuityPaymentDTO setStatus(HttpStatus status) {
        this.status = status;
        return this;
    }

    public String getError() {
        return error;
    }

    public AnnuityPaymentDTO setError(String error) {
        this.error = error;
        return this;
    }

    public Integer getPaymentPeriod() {
        return paymentPeriod;
    }

    public AnnuityPaymentDTO setPaymentPeriod(Integer paymentPeriod) {
        this.paymentPeriod = paymentPeriod;
        return this;
    }

    public Double getPaymentPerMonth() {
        return paymentPerMonth;
    }

    public AnnuityPaymentDTO setPaymentPerMonth(Double paymentPerMonth) {
        this.paymentPerMonth = paymentPerMonth;
        return this;
    }
}
