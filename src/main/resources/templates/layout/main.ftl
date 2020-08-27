<#import "/spring.ftl" as spring/>

<#macro head title>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>
    Annuity payment
    <#list title as k,v>
        | <@spring.message v/>
    </#list>
</title>

<!-- Global stylesheets -->
<link href="https://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700,900" type="text/css">
<link href="/assets/css/icons/icomoon/styles.css" rel="stylesheet" type="text/css">
<link href="/assets/css/icons/fontawesome/styles.min.css" rel="stylesheet" type="text/css">
<link href="/assets/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="/assets/css/core.css" rel="stylesheet" type="text/css">
<link href="/assets/css/components.css" rel="stylesheet" type="text/css">
<link href="/assets/css/colors.css" rel="stylesheet" type="text/css">
<link href="/assets/css/app.css" rel="stylesheet" type="text/css">
<link href="/assets/css/style.css" rel="stylesheet" type="text/css">
<!-- /global stylesheets -->

<!-- Core JS files -->
<script type="text/javascript" src="/assets/js/core/libraries/jquery.min.js"></script>
<script type="text/javascript" src="/assets/js/core/libraries/bootstrap.min.js"></script>
<script type="text/javascript" src="/assets/js/plugins/loaders/blockui.min.js"></script>
<script type="text/javascript" src="/assets/js/plugins/loaders/pace.min.js"></script>
<script type="text/javascript" src="/assets/js/plugins/ui/nicescroll.min.js"></script>
<script type="text/javascript" src="/assets/js/plugins/ui/drilldown.js"></script>
<!-- /core JS files -->

<!-- /core JS files -->
<script type="text/javascript" src="/assets/js/core/libraries/jquery_ui/core.min.js"></script>
<script type="text/javascript" src="/assets/js/core/libraries/jquery_ui/effects.min.js"></script>
<script type="text/javascript" src="/assets/js/core/libraries/jquery_ui/interactions.min.js"></script>
<script type="text/javascript" src="/assets/js/plugins/trees/fancytree_all.min.js"></script>
<script type="text/javascript" src="/assets/js/plugins/trees/fancytree_childcounter.js"></script>
<script type="text/javascript" src="/assets/js/plugins/notifications/sweet_alert.min.js"></script>
<!-- /core JS files -->

<#--Forms-->
<script type="text/javascript" src="/assets/js/plugins/forms/selects/select2.min.js"></script>
<script type="text/javascript" src="/assets/js/plugins/forms/styling/uniform.min.js"></script>
<script type="text/javascript" src="/assets/js/plugins/forms/styling/switch.min.js"></script>
<script type="text/javascript" src="/assets/js/plugins/forms/validation/validate.min.js"></script>
<script type="text/javascript" src="/assets/js/plugins/notifications/pnotify.min.js"></script>
<#--Forms-->

<script type="text/javascript" src="/assets/js/core/app.js"></script>

<#--Form validate override-->
<script>
    (function ($) {
        jQuery.extend(jQuery.validator.messages, {
            required: "<@spring.message 'validation.form.required-field' />",
            remote: "Please fix this field.",
            email: "Please enter a valid email address.",
            url: "Please enter a valid URL.",
            date: "Please enter a valid date.",
            dateISO: "Please enter a valid date (ISO).",
            number: "Please enter a valid number.",
            digits: "Please enter only digits.",
            creditcard: "Please enter a valid credit card number.",
            equalTo: "Please enter the same value again.",
            accept: "Please enter a value with a valid extension.",
            maxlength: jQuery.validator.format("Please enter no more than {0} characters."),
            minlength: jQuery.validator.format("Please enter at least {0} characters."),
            rangelength: jQuery.validator.format("Please enter a value between {0} and {1} characters long."),
            range: jQuery.validator.format("Please enter a value between {0} and {1}."),
            max: jQuery.validator.format("Please enter a value less than or equal to {0}."),
            min: jQuery.validator.format("Please enter a value greater than or equal to {0}.")
        });
        $.fn.lasronValidate = function () {
            var rules = {};
            var messages = {};

            $(this).find("input").each(function () {
                rules[$(this).attr("name")] = {
                    required: $(this).prop('required'),
                    email: (String($(this).attr("type")).indexOf('email') > -1)
                };
                messages[$(this).attr("name")] = (($(this).prop('required'))
                        ? "<@spring.message 'validation.form.required-field' />"
                        : "")
                        + ((String($(this).attr("name")).indexOf('email') === -1)
                                ? ""
                                : " <@spring.message 'validation.form.input-valid-email' />")
                        + ((String($(this).attr("name")).indexOf('applicantInn') === -1)
                                ? ""
                                : " <@spring.message 'validation.form.required-field-pin' />")
            });

            $(this).find("textarea").each(function () {
                rules[$(this).attr("name")] = {
                    required: $(this).prop('required'),
                    minlength: 2,
                    maxlength: 60000
                };
                messages[$(this).attr("name")] = (($(this).prop('required'))
                        ? "<@spring.message 'validation.form.required-field' />"
                        : "");
            });

            $(this).find("select").each(function () {
                rules[$(this).attr("name")] = {
                    required: $(this).prop('required')
                };
                messages[$(this).attr("name")] = (($(this).prop('required'))
                        ? "<@spring.message 'validation.form.select' />"
                        : "");
            });

            $(this).find("file").each(function () {
                rules[$(this).attr("name")] = {
                    required: $(this).prop('required')
                };
                messages[$(this).attr("name")] = (($(this).prop('required'))
                        ? "<@spring.message 'validation.form.required-field' />"
                        : "");
            });

            validateOptions = {
                ignore: 'input[type=hidden], .select2-search__field',
                rules: rules,
                messages: messages,
                errorPlacement: function (error, element) {

                    // Styled checkboxes, radios, bootstrap switch
                    if (element.parents('div').hasClass("checker") || element.parents('div').hasClass("choice") || element.parent().hasClass('bootstrap-switch-container')) {
                        if (element.parents('label').hasClass('checkbox-inline') || element.parents('label').hasClass('radio-inline')) {
                            error.appendTo(element.parent().parent().parent().parent());
                        }
                        else {
                            error.appendTo(element.parent().parent().parent().parent().parent());
                        }
                    }

                    // Unstyled checkboxes, radios
                    else if (element.parents('div').hasClass('checkbox') || element.parents('div').hasClass('radio')) {
                        error.appendTo(element.parent().parent().parent());
                    }

                    // Input with icons and Select2
                    else if (element.parents('div').hasClass('has-feedback') || element.hasClass('select2-hidden-accessible')) {
                        error.appendTo(element.parent());
                    }

                    // Inline checkboxes, radios
                    else if (element.parents('label').hasClass('checkbox-inline') || element.parents('label').hasClass('radio-inline')) {
                        error.appendTo(element.parent().parent());
                    }

                    // Input group, styled file input
                    else if (element.parent().hasClass('uploader') || element.parents().hasClass('input-group')) {
                        error.appendTo(element.parent().parent());
                    }

                    // Input group, styled file input
                    else if (element.prop("tagName") == "TEXTAREA") {
                        error.appendTo(element.parent());
                    }

                    else {
                        error.insertAfter(element);
                    }

                },
                submitHandler: function (form) {
                    form.submit();
                }
            };

            this.validate(validateOptions);
        };

        $("input").keypress(function(e){
            if(e.keyCode == 13){
                return false;
            }
        });
    }(jQuery));

    srvTime = new Date(${.now?long?c}).getTime();
    timesDiff = new Date().getTime() - srvTime;
</script>
<#--Form validate override-->
</#macro>

<#macro pageHeader pageName>
<div class="page-header">
    <div class="page-header-content">
        <div class="page-title">
            <div class="panel panel-bordered" style="background-color: #8F938F">
                <div class="panel-heading">
                    <@spring.message pageName/>
                </div>
            </div>
        </div>
    </div>
</#macro>

<#macro content>
    <#if error?? && error?has_content>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="alert bg-danger text-center">
                    <button type="button" class="close" data-dismiss="alert"><span>×</span><span
                            class="sr-only">Close</span>
                    </button>
                    <span class="text-semibold">Внимание!</span>
                    ${error}
                </div>
            </div>
        </div>
    </div>
    </#if>
    <div class="page-container">
        <div class="page-content">
            <div class="content-wrapper">
                <#nested />
            </div>
        </div>
    </div>
</#macro>

<#macro footer>
</#macro>

<#macro render pageName title={}>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <@head title/>
    </head>
    <body>
        <@pageHeader pageName/>
        <@content>
            <#nested/>
        </@content>
        <@footer/>
    </body>
    </html>
</#macro>