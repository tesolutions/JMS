[{capture append="oxidBlock_content"}]

    [{* ordering steps *}]
    [{include file="page/checkout/inc/steps.tpl" active=5}]

    [{block name="checkout_thankyou_main"}]
        [{assign var="order" value=$oView->getOrder()}]
        [{assign var="basket" value=$oView->getBasket()}]

        <div id="thankyouPage">
            <h3 class="blockHead">[{oxmultilang ident="THANK_YOU"}]</h3>

            [{block name="checkout_thankyou_info"}]
                [{oxmultilang ident="THANK_YOU_FOR_ORDER"}] [{$oxcmp_shop->oxshops__oxname->value}]. <br>
                [{oxmultilang ident="REGISTERED_YOUR_ORDER" args=$order->oxorder__oxordernr->value}] <br>
                [{if !$oView->getMailError()}]
                    [{oxmultilang ident="MESSAGE_YOU_RECEIVED_ORDER_CONFIRM"}]<br>
                [{else}]<br>
                    [{oxmultilang ident="MESSAGE_CONFIRMATION_NOT_SUCCEED"}]<br>
                [{/if}]
                <br>
                [{oxmultilang ident="MESSAGE_WE_WILL_INFORM_YOU"}]<br><br>
            [{/block}]

            [{block name="checkout_thankyou_proceed"}]
                [{oxmultilang ident="YOU_CAN_GO"}]
                <a id="backToShop" rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getHomeLink()}]" class="link">[{oxmultilang ident="BACK_TO_START_PAGE"}]</a>
                [{if $oxcmp_user->oxuser__oxpassword->value}]
                    [{oxmultilang ident="OR"}]
                    <a id="orderHistory" rel="nofollow" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_order"}]" class="link">[{oxmultilang ident="CHECK_YOUR_ORDER_HISTORY"}]</a>.
                [{/if}]
            [{/block}]

            [{* Shopauskunft *}]
            <script type="text/javascript"> var xc_label = 'SA0015611'; var fetched_data = {
            'xc_label': xc_label,
            'shop_name': 'Scherzwelt', 'email': '[{$order->oxorder__oxbillemail->value}]',
            'shop_type': '12',
            'order_id': '[{$order->oxorder__oxordernr->value}]',
            'order_value': '[{$order->oxorder__oxtotalbrutsum->value}]', 'shipping_value': '[{$order->oxorder__oxdelcost->value}]', 'language': 'de',
            'url': 'https://www.scherzwelt.de',
            'token': 'IEqggoqlBJdA/gCRrKsRmQ'
            } </script>
            <script type="text/javascript" src="https://rba.shopauskunft.de/js/rba_widget.js" id="rba_widget" async></script>
            
            [{* Google Reviews *}]
            <div class="row" style="border-top: 1px solid #eeeeee;margin-top: 10px;padding-top: 15px;">
                <div class="col-xs-12 col-sm-12 col-md-4">
                    <center>
                        <img src="/out/media/gr.jpg" alt="Google Reviews" />
                    </center>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-8">
                    <p style="padding-top: 5px;padding-bottom: 5px;">Wenn Sie mit Ihrer Bestellung zufrieden sind, würden wir uns sehr über eine Bewertung freuen!</p>
                    <a href="https://search.google.com/local/writereview?placeid=ChIJ45SGvTEykUcRr8UPbWT_OI0" target="_blank" title="Google Reviews"><button class="btn btn-primary" style="min-width: 250px;">Jetzt bei Google bewerten</button></a> 
                    <a href="https://www.shopauskunft.de/neue-bewertung?xc__label=SA0015611&bestellnr=[{$order->oxorder__oxordernr->value}]" target="_blank" title="Shopauskunft"><button class="btn btn-primary" style="min-width: 250px;">Jetzt bei Shopauskunft bewerten</button></a>
                </div>
            </div>

            [{*<br><br>
            <!-- bonusbox Anfang-->
                <a href='https://fb.bonusbox.me/banners/01e5654f-1c00-4b58-921b-f5b4303a6416'> <img alt="Bonusbox" src="https://fb.bonusbox.me/banners/01e5654f-1c00-4b58-921b-f5b4303a6416.jpg" /></a>
            <!-- bonusbox Ende-->*}]

            <script type="text/javascript">
            //  adroll_conversion_value_in_dollars = [{ $order->getTotalOrderSum() }]
              adroll_conversion_value = [{ $order->getTotalOrderSum() }];
              adroll_currency = "EUR";
            </script>

            <!-- Google Code for scherzwelt Conversion Page -->
            [{*
            <script type="text/javascript">
            /* <![CDATA[ */
            var google_conversion_id = 1071665805;
            var google_conversion_language = "de";
            var google_conversion_format = "3";
            var google_conversion_color = "ffffff";
            var google_conversion_label = "RL34CO-v1gEQjaWB_wM";
            var google_conversion_value = 0;
            if (1) {
              google_conversion_value = 1;
            }
            /* ]]> */
            </script>
            <script type="text/javascript" src="https://www.googleadservices.com/pagead/conversion.js">
            </script>
            <noscript>
            <div style="display:inline;">
            <img height="1" width="1" style="border-style:none;" alt="" src="https://www.googleadservices.com/pagead/conversion/1071665805/?value=1&amp;label=RL34CO-v1gEQjaWB_wM&amp;guid=ON&amp;script=0"/>
            </div>
            </noscript>
            *}]

            [{*<script type="text/javascript" src="https://www.adcell.de/js/jsadlib.js"></script><script type="text/javascript">Adcell.user.track({'pid' : '3162','eventid' : '3897','referenz' : '[{ $order->oxorder__oxordernr->value }]','betrag' : '[{ $order->getTotalOrderSum() }]'});</script><noscript><img src="https://www.adcell.de/event.php?pid=3162&eventid=3897&referenz=[{ $order->oxorder__oxordernr->value }]&betrag=[{ $order->getTotalOrderSum() }]" border=0 width=1 height=1></noscript>*}]
            
            <script type="text/javascript" src="https://t.adcell.com/t/track.js?pid=3162&eventid=3897&referenz=[{ $order->oxorder__oxordernr->value }]&betrag=[{ $order->getTotalOrderSum() }]" async> </script>
            <noscript>
                <img border="0" width="1" height="1" src="https://t.adcell.com/t/track?pid=3162&eventid=3897&referenz=[{ $order->oxorder__oxordernr->value }]&betrag=[{ $order->getTotalOrderSum() }]">
            </noscript>
            
            <!-- adfocus.ch-->
            <script async src="https://www.getback.ch/app/tracking/9kkkv"></script>
            
            
            [{if $order->getVoucherNrList() }]
              [{assign var="allvouchers" value=''}]
                [{foreach from=$order->getVoucherNrList() item=voucher}]
                  [{if $allvouchers}]
                      [{assign var="allvouchers" value=$allvouchers|cat:'|'}]
                  [{/if}]  
                  [{assign var="allvouchers" value=$allvouchers|cat:$voucher}] 
                [{/foreach }]
              [{assign var="wgVoucherCode" value=$allvouchers|rawurlencode }]
            [{/if}]
            
            <!-- adfocus.ch DE-->
            [{if $order->oxorder__oxbillcountryid->value == "a7c40f631fc920687.20179984" }]
                <img src="https://www.profity.de/imp/?s=694&b=6&lp=1&ordervalue=[{ $order->getTotalOrderSum() }]&ordernumber=[{ $order->oxorder__oxordernr->value }]&vouchercode=[{$wgVoucherCode}]">
            [{/if}]
            
            <!-- adfocus.ch AT-->
            [{if $order->oxorder__oxbillcountryid->value == "a7c40f6320aeb2ec2.72885259" }]
                <img src="https://www.profity.at/imp/?s=695&b=6&lp=1&ordervalue=[{ $order->getTotalOrderSum() }]&ordernumber=[{ $order->oxorder__oxordernr->value }]&vouchercode=[{$wgVoucherCode}]">
            [{/if}]
            
            <!-- Ende adfocus.ch-->

            [{block name="checkout_thankyou_partners"}]
            [{/block}]

            [{if $oView->getAlsoBoughtTheseProducts()}]
                <br><br>
                <h1 class="page-header">[{oxmultilang ident="WHO_BOUGHT_ALSO_BOUGHT"}]</h1>
                [{include file="widget/product/list.tpl" type=$oView->getListDisplayType() listId="alsoBoughtThankyou" products=$oView->getAlsoBoughtTheseProducts() blDisableToCart=true}]
            [{/if}]
        </div>
    [{/block}]
    [{insert name="oxid_tracker" title=$template_title}]
[{/capture}]
[{include file="layout/page.tpl"}]
