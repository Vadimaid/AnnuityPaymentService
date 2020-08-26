<#import "/spring.ftl" as spring/>
<#import "layout/main.ftl" as main/>

<#assign arr = {"#" : 'annuity.main'} />

<@main.render "annuity.main" arr >
    <div class="row">
        <div class="col-md-4">
            <label class="form-control" style="text-align: center"><@spring.message "annuity.credit.amount" /></label>
        </div>
        <div class="col-md-8">
            <input id="creditAmount" type="number" class="form-control">
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label class="form-control" style="text-align: center"><@spring.message "annuity.interest-rate" /></label>
        </div>
        <div class="col-md-8">
            <input id="interestRate" type="number" class="form-control">
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <label class="form-control" style="text-align: center"><@spring.message "annuity.payment.period" /></label>
        </div>
        <div class="col-md-8">
            <input id="paymentPeriod" type="number" class="form-control">
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 form-actions text-right">
            <input id="submitButton" type="button" class="btn btn-success" value="<@spring.message "action.accept"/>">
            <input id="cancelButton" type="button" class="btn btn-danger" value="<@spring.message "action.cancel"/>">
        </div>
    </div>
    <hr>
    <div id="calculationResult">
    </div>


    <script type="application/javascript">
        var creditAmount = $("#creditAmount");
        var interestRate = $("#interestRate");
        var paymentPeriod = $("#paymentPeriod");

        $("#cancelButton").bind('click', function(){
            creditAmount.val("");
            interestRate.val("");
            paymentPeriod.val("");
        });

        $("#submitButton").bind('click', function(){
            var creditAmountValue = creditAmount.val();
            var interestRateValue = interestRate.val();
            var paymentPeriodValue = paymentPeriod.val();
            if (!Number.isInteger(creditAmountValue * 1)){
                swal({
                    title: "<@spring.message "error.title"/>",
                    text: "<@spring.message "error.credit-amount.integer" />",
                    type: "error"
                });
                creditAmount.val("");
                return;
            }
            if (!Number.isInteger(paymentPeriodValue * 1)){
                swal({
                    title: "<@spring.message "error.title"/>",
                    text: "<@spring.message "error.payment-period.integer" />",
                    type: "error"
                });
                paymentPeriod.val("");
                return;
            }
            $.ajax({
                url: "/api/annuity/calculate?creditAmount=" + creditAmountValue + "&interestRate=" + interestRateValue + "&paymentPeriod=" + paymentPeriodValue,
                type: 'GET',
                contentType: "application/json",
                success: function(data, textStatus, xhr){
                    $("#calculationResult").empty();
                    console.log(data.status);
                    console.log(xhr.status);
                    console.log(textStatus);
                    if (data.status === "OK"){
                        $("#calculationResult").append("" +
                            "<table class=\"table table-bordered\">\n" +
                            "            <thead>\n" +
                            "                <tr>\n" +
                            "                    <th>" + "<@spring.message "payment.month-number" />" + "</th>\n" +
                            "                    <th>" + "<@spring.message "payment.paymentAmount" />" + "</th>\n" +
                            "                </tr>\n" +
                            "            </thead>\n" +
                            "            <tbody id=changeableRows>\n" +
                            "            </tbody>\n" +
                            "        </table>");
                        for (i = 0; i < data["paymentPeriod"]; i++){
                            $("#changeableRows").append("" +
                                "<tr><td>" + (i + 1) + "</td>" +
                                "<td>" + data["paymentPerMonth"] + "</td></tr>"
                            );
                        }
                    }else{
                        swal({
                            title: "<@spring.message "error.title"/>",
                            text: data.error,
                            type: "error"
                        });
                    }
                }
            });
        });
    </script>
</@main.render>