[{* basket contents *}]
[{*oxscript include="js/widgets/oxbasketchecks.min.js" priority=10*}]
[{*oxscript add="$('#checkAll, #basketRemoveAll').oxBasketChecks();"*}]
[{oxscript add="$('input,select,textarea').not('[type=submit]').jqBootstrapValidation();"}]
[{assign var="currency" value=$oView->getActCurrency()}]

<form name="basket[{$basketindex}]" id="basket_form" action="[{$oViewConf->getSelfActionLink()}]" method="post">
    [{$oViewConf->getHiddenSid()}]
    <input type="hidden" name="cl" value="basket">
    <input type="hidden" name="fnc" value="changebasket">
    <input type="hidden" name="CustomError" value="basket">

    <div class="basket" id="basketcontents_list">
        [{block name="checkout_basketcontents_list"}]
            [{include file="page/checkout/inc/basketcontents_list.tpl"}]
        [{/block}]
    </div>

</form>
<div class="row">
    <div class="col-12 col-md-6">
        [{if $oViewConf->getShowVouchers() && $oViewConf->getActiveClassName() == 'basket'}]
            [{block name="checkout_basket_vouchers"}]
                <div id="basketVoucher">
                    <form name="voucher" action="[{$oViewConf->getSelfActionLink()}]" method="post" class="js-oxValidate form-inline" role="form" novalidate="novalidate">
                        <div class="couponBox" id="coupon">
                            <div class="hidden">
                                [{$oViewConf->getHiddenSid()}]
                                <input type="hidden" name="cl" value="basket">
                                <input type="hidden" name="fnc" value="addVoucher">
                                <input type="hidden" name="CustomError" value="basket">
                            </div>
        
                            <div class="form-group">
                                <label class="req sr-only voucher-label" for="input_voucherNr">[{oxmultilang ident="ENTER_COUPON_NUMBER"}]</label>
                                <div class="input-group">
                                    <input type="text" name="voucherNr" size="30" class="form-control voucher-code js-oxValidate js-oxValidate_notEmpty" id="input_voucherNr" placeholder="[{oxmultilang ident="ENTER_COUPON_NUMBER"}]" required="required">
                                    <span class="input-group-append">
                                        <button type="submit" class="btn btn-primary submitButton"><i class="fa fa-gift"></i> [{oxmultilang ident="REDEEM_COUPON"}]</button>
                                    </span>
                                </div>
                                <div class="help-block"></div>
                            </div>
        
        
                            [{foreach from=$Errors.basket item=oEr key=key}]
                                [{if $oEr->getErrorClassType() == 'oxVoucherException'}]
                                    <div class="alert alert-danger">
                                        [{oxmultilang ident="COUPON_NOT_ACCEPTED" args=$oEr->getValue('voucherNr')}]
                                        <strong>[{oxmultilang ident="REASON" suffix="COLON"}]</strong>
                                        [{$oEr->getOxMessage()}]
                                    </div>
                                [{/if}]
                            [{/foreach}]
                        </div>
                    </form>
                </div>
            [{/block}]
        [{/if}]

        [{if $oView->getClassName() == "basket"}]
        <div style="padding:16px 0px;line-height:1.3;">
            <hr>
            [{*if $oxcmp_basket->getWeight() > 0}]
                Gesamtgewicht: [{$oxcmp_basket->getWeight()}] Kg<br>
            [{/if*}]

            [{assign var="bestellwert" value=$oxcmp_basket->getFProductsPrice()|replace:',':'.'}]
            [{*math assign="ox_bonus" equation="(x*10/100)" x=$bestellwert y=10 }] 
            <strong>Für diese Bestellung erhalten Sie [{ $ox_bonus|number_format:"0"}] <a href="/Bonuspunkte-Rabatte">Bonuspunkte</a>.</strong>*}] 
            [{ if $oxcmp_user && $oxcmp_user->oxuser__oxpassword->value }][{else}]<br>Zum einlösen Ihrer Bonuspunkte loggen Sie sich bitte ein.[{/if}] 

            [{math assign="versandfrei" equation="(80-x)" x=$bestellwert y=10 }] 
            [{ if $oxcmp_user && $oxcmp_user->oxuser__oxpassword->value }]
                <div style="font-size: 13px;margin-top: 15px;margin-bottom: 15px;">
                    [{ if $oxcmp_user->oxuser__oxcountryid->value == "a7c40f631fc920687.20179984" }]
                        [{ if $versandfrei <= 0 }]
                            <strong>Der Versand erfolgt kostenfrei!</strong>
                        [{else}] 
                            <strong>Noch [{ $versandfrei|number_format:"2"|replace:'.':','}] € für einen kostenfreien Versand.</strong> 
                        [{/if}]     
                    [{/if}]
                </div>
            [{else}] 
                <div style="font-size: 13px;margin-top: 15px;margin-bottom: 15px;">
                    Die angezeigten Versandkosten, MwSt.-Sätze und Preise gelten für einen Versand innerhalb Deutschland.<br>
                    Bitte loggen Sie sich zur Anzeige der endgültigen <a href="[{ oxgetseourl ident="4dd1fb8071adca39561cd57cbdb7da8e" type="oxcontent" }]" target="_blank">Versandkosten</a> und <a href="[{ oxgetseourl ident="dfa7ef9f134b44111f70bc756b6e980d" type="oxcontent" }]">MwSt.-Sätze</a> ein.<br>
                    [{ if $versandfrei >= 0 }]
                    Ab 80 € Bestellwert liefern wir innerhalb Deutschlands versandkostenfrei.
                    <br><strong>Noch [{ $versandfrei|number_format:"2"|replace:'.':','}] € für einen kostenfreien Versand innerhalb Deutschlands.</strong>
                    [{/if}] 
                </div>
            [{/if}] 
            </div>
        [{/if}]
        
    </div>

[{block name="checkout_basketcontents_summary"}]

    <div id="basketSummary" class="col-12 col-md-6 summary[{if $oViewConf->getShowVouchers() && $oViewConf->getActiveClassName() != 'basket'}] offset-md-6[{/if}][{if $oViewConf->getActiveClassName() == 'order'}] orderSummary[{/if}]">
        [{*  basket summary  *}]
        <table class="table table-bordered table-striped">
            [{block name="checkout_basketcontents_summary_table_inner"}]
                [{if !$oxcmp_basket->getDiscounts()}]
                    [{block name="checkout_basketcontents_nodiscounttotalnet"}]
                        <tr>
                            <th class="text-right">[{oxmultilang ident="TOTAL_NET"}]</th>
                            <td id="basketTotalProductsNetto" class="text-right">[{oxprice price=$oxcmp_basket->getNettoSum() currency=$currency}]</td>
                        </tr>
                    [{/block}]

                    [{block name="checkout_basketcontents_nodiscountproductvats"}]
                        [{foreach from=$oxcmp_basket->getProductVats(false) item=VATitem key=key}]
                            <tr>
                                <th class="text-right">[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$key}]</th>
                                <td class="text-right">[{oxprice price=$VATitem currency=$currency}]</td>
                            </tr>
                        [{/foreach}]
                    [{/block}]

                    [{block name="checkout_basketcontents_nodiscounttotalgross"}]
                        <tr>
                            <th class="text-right">[{oxmultilang ident="TOTAL_GROSS" suffix="COLON"}]</th>
                            <td id="basketTotalProductsGross" class="text-right">[{oxprice price=$oxcmp_basket->getBruttoSum() currency=$currency}]</td>
                        </tr>
                    [{/block}]
                [{else}]
                    [{if $oxcmp_basket->isPriceViewModeNetto()}]
                        [{block name="checkout_basketcontents_discounttotalnet"}]
                            <tr>
                                <th class="text-right">[{oxmultilang ident="TOTAL_NET"}]</th>
                                <td id="basketTotalProductsNetto" class="text-right">[{oxprice price=$oxcmp_basket->getNettoSum() currency=$currency}]</td>
                            </tr>
                        [{/block}]
                    [{else}]
                         [{block name="checkout_basketcontents_discounttotalgross"}]
                            <tr>
                                <th class="text-right">[{oxmultilang ident="TOTAL_GROSS" suffix="COLON"}]</th>
                                <td id="basketTotalProductsGross" class="text-right">[{oxprice price=$oxcmp_basket->getBruttoSum() currency=$currency}]</td>
                            </tr>
                        [{/block}]
                    [{/if}]

                    [{block name="checkout_basketcontents_discounts"}]
                        [{foreach from=$oxcmp_basket->getDiscounts() item=oDiscount name=test_Discounts}]
                            <tr>
                                <th class="text-right">
                                    <b>[{if $oDiscount->dDiscount < 0}][{oxmultilang ident="SURCHARGE"}][{else}][{oxmultilang ident="DISCOUNT"}][{/if}]&nbsp;</b>
                                    [{$oDiscount->sDiscount}]
                                </th>
                                <td class="text-right">
                                    [{oxprice price=$oDiscount->dDiscount*-1 currency=$currency}]
                                </td>
                            </tr>
                        [{/foreach}]
                    [{/block}]

                    [{if !$oxcmp_basket->isPriceViewModeNetto()}]
                        [{block name="checkout_basketcontents_totalnet"}]
                            <tr>
                                <th class="text-right">[{oxmultilang ident="TOTAL_NET"}]</th>
                                <td id="basketTotalNetto" class="text-right">[{oxprice price=$oxcmp_basket->getNettoSum() currency=$currency}]</td>
                            </tr>
                        [{/block}]
                    [{/if}]

                    [{block name="checkout_basketcontents_productvats"}]
                        [{foreach from=$oxcmp_basket->getProductVats(false) item=VATitem key=key}]
                            <tr>
                                <th class="text-right">[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$key}]</th>
                                <td class="text-right">[{oxprice price=$VATitem currency=$currency}]</td>
                            </tr>
                        [{/foreach}]
                    [{/block}]

                    [{if $oxcmp_basket->isPriceViewModeNetto()}]
                        [{block name="checkout_basketcontents_totalgross"}]
                            <tr>
                                <th class="text-right">[{oxmultilang ident="TOTAL_GROSS" suffix="COLON"}]</th>
                                <td id="basketTotalGross" class="text-right">[{oxprice price=$oxcmp_basket->getBruttoSum() currency=$currency}]</td>
                            </tr>
                        [{/block}]
                    [{/if}]
                [{/if}]
            [{/block}]

            [{block name="checkout_basketcontents_voucherdiscount"}]
                [{if $oViewConf->getShowVouchers() && $oxcmp_basket->getVoucherDiscValue()}]
                    [{foreach from=$oxcmp_basket->getVouchers() item=sVoucher key=key name=Voucher}]
                        <tr class="couponData">
                            <th class="text-right"><span><strong>[{oxmultilang ident="COUPON"}]</strong>&nbsp;([{oxmultilang ident="NUMBER"}] [{$sVoucher->sVoucherNr}])</span>
                            [{if $editable}]
                                <a href="[{$oViewConf->getSelfLink()}]&amp;cl=basket&amp;fnc=removeVoucher&amp;voucherId=[{$sVoucher->sVoucherId}]&amp;CustomError=basket&amp;stoken=[{$oViewConf->getSessionChallengeToken()}]" class="removeFn">[{oxmultilang ident="REMOVE"}]</a>
                            [{/if}]
                            </th>
                            <td class="text-right"><strong>[{oxprice price=$sVoucher->dVoucherdiscount*-1 currency=$currency}]</strong></td>
                        </tr>
                    [{/foreach}]
                [{/if}]
            [{/block}]

            [{block name="checkout_basketcontents_delcosts"}]
                [{assign var="deliveryCost" value=$oxcmp_basket->getDeliveryCost()}]
                [{if $deliveryCost && ($oxcmp_basket->getBasketUser() || $oViewConf->isFunctionalityEnabled('blCalculateDelCostIfNotLoggedIn') ) }]
                    [{if $oViewConf->isFunctionalityEnabled('blShowVATForDelivery') }]
                        <tr>
                            <th class="text-right">[{ oxmultilang ident="SHIPPING_NET" suffix="COLON" }]</th>
                            <td id="basketDeliveryNetto" class="text-right">[{oxprice price=$deliveryCost->getNettoPrice() currency=$currency }]</td>
                        </tr>
                        [{if $deliveryCost->getVatValue()}]
                        <tr>
                            [{if $oxcmp_basket->isProportionalCalculationOn() }]
                                <th class="text-right">[{oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON"}]</th>
                            [{else}]
                                <th class="text-right">[{oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$deliveryCost->getVat()}]</th>
                            [{/if}]
                            <td id="basketDeliveryVat" class="text-right">[{oxprice price=$deliveryCost->getVatValue() currency=$currency}]</td>
                        </tr>
                        [{/if}]
                    [{else}]
                    <tr>
                        <th class="text-right">[{ oxmultilang ident="SHIPPING_COST" suffix="COLON" }]</th>
                        <td id="basketDeliveryGross" class="text-right">[{oxprice price=$deliveryCost->getBruttoPrice() currency=$currency}]</td>
                    </tr>
                    [{/if}]
                [{/if}]
            [{/block}]

            [{block name="checkout_basketcontents_paymentcosts"}]
                [{assign var="paymentCost" value=$oxcmp_basket->getPaymentCost()}]
                [{if $paymentCost && $paymentCost->getPrice() }]
                    [{if $oViewConf->isFunctionalityEnabled('blShowVATForPayCharge') }]
                        <tr>
                            <th class="text-right">[{if $paymentCost->getPrice() >= 0}][{ oxmultilang ident="SURCHARGE" }][{else}][{ oxmultilang ident="DEDUCTION" }][{/if}] [{ oxmultilang ident="PAYMENT_METHOD" suffix="COLON"}]</th>
                            <td id="basketPaymentNetto">[{oxprice price=$paymentCost->getNettoPrice() currency=$currency }]</td>
                        </tr>
                        [{if $paymentCost->getVatValue()}]
                            <tr>
                                [{if $oxcmp_basket->isProportionalCalculationOn() }]
                                    <th class="text-right">[{ oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]</th>
                                [{else}]
                                    <th class="text-right">[{ oxmultilang ident="SURCHARGE_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$paymentCost->getVat() }]</th>
                                [{/if}]
                                <td id="basketPaymentVat">[{oxprice price=$paymentCost->getVatValue() currency=$currency }]</td>
                            </tr>
                        [{/if}]
                    [{else}]
                        <tr>
                            <th class="text-right">[{if $paymentCost->getPrice() >= 0}][{ oxmultilang ident="SURCHARGE" }][{else}][{ oxmultilang ident="DEDUCTION" }][{/if}] [{ oxmultilang ident="PAYMENT_METHOD" suffix="COLON" }]</th>
                            <td id="basketPaymentGross">[{oxprice price=$paymentCost->getBruttoPrice() currency=$currency }]</td>
                        </tr>
                    [{/if}]
                [{/if}]
            [{/block}]

            [{block name="checkout_basketcontents_wrappingcosts"}]
                [{if $oViewConf->getShowGiftWrapping() }]

                    [{assign var="wrappingCost" value=$oxcmp_basket->getWrappingCost()}]
                    [{if $wrappingCost && $wrappingCost->getPrice() > 0 }]
                        [{if $oViewConf->isFunctionalityEnabled('blShowVATForWrapping') }]
                            <tr>
                                <th class="text-right">[{ oxmultilang ident="BASKET_TOTAL_WRAPPING_COSTS_NET" suffix="COLON" }]</th>
                                <td id="basketWrappingNetto" class="text-right">[{oxprice price=$wrappingCost->getNettoPrice() currency=$currency}]</td>
                            </tr>
                            [{if $oxcmp_basket->getWrappCostVat() }]
                                <tr>
                                    <th class="text-right">[{ oxmultilang ident="PLUS_VAT" suffix="COLON" }]</th>
                                    <td id="basketWrappingVat" class="text-right">[{oxprice price=$wrappingCost->getVatValue() currency=$currency}]</td>
                                </tr>
                            [{/if}]
                        [{else}]
                            <tr>
                                <th class="text-right">[{ oxmultilang ident="GIFT_WRAPPING" suffix="COLON" }]</th>
                                <td id="basketWrappingGross" class="text-right">[{oxprice price=$wrappingCost->getBruttoPrice() currency=$currency }]</td>
                            </tr>
                        [{/if}]
                    [{/if}]

                    [{assign var="giftCardCost" value=$oxcmp_basket->getGiftCardCost()}]
                    [{if $giftCardCost && $giftCardCost->getPrice() > 0 }]
                        [{if $oViewConf->isFunctionalityEnabled('blShowVATForWrapping') }]
                            <tr>
                                <th class="text-right">[{ oxmultilang ident="BASKET_TOTAL_GIFTCARD_COSTS_NET" suffix="COLON" }]</th>
                                <td id="basketGiftCardNetto" class="text-right">[{oxprice price=$giftCardCost->getNettoPrice() currency=$currency }]</td>
                            </tr>
                            <tr>
                                [{if $oxcmp_basket->isProportionalCalculationOn() }]
                                    <th class="text-right">[{ oxmultilang ident="BASKET_TOTAL_PLUS_PROPORTIONAL_VAT" suffix="COLON" }]</th>
                                [{else}]
                                <th class="text-right">[{ oxmultilang ident="VAT_PLUS_PERCENT_AMOUNT" suffix="COLON" args=$giftCardCost->getVat() }] </th>
                                [{/if}]
                                <td id="basketGiftCardVat" class="text-right">[{oxprice price=$giftCardCost->getVatValue() currency=$currency}]</td>
                            </tr>
                        [{else}]
                            <tr>
                                <th class="text-right">[{ oxmultilang ident="GREETING_CARD" suffix="COLON" }]</th>
                                <td id="basketGiftCardGross" class="text-right">[{oxprice price=$giftCardCost->getBruttoPrice() currency=$currency}]</td>
                            </tr>
                        [{/if}]
                    [{/if}]
                [{/if}]
            [{/block}]

            [{block name="checkout_basketcontents_grandtotal"}]
                <tr>
                    <th class="lead text-right"><strong>[{oxmultilang ident="GRAND_TOTAL" suffix="COLON"}]</strong></th>
                    <td id="basketGrandTotal" class="lead text-right"><strong>[{oxprice price=$oxcmp_basket->getPrice() currency=$currency}]</strong></td>
                </tr>
            [{/block}]

            [{if $oxcmp_basket->hasSkipedDiscount()}]
                <tr>
                    <th class="text-right"><span class="note">**</span> [{oxmultilang ident="MESSAGE_COUPON_NOT_APPLIED_FOR_ARTICLES"}]</span></th>
                    <td></td>
                </tr>
            [{/if}]
        </table>
    </div>
[{/block}]
</div>
