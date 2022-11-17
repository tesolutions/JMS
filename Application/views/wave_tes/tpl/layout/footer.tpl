[{block name="footer_main"}]
    [{assign var="blShowFullFooter" value=$oView->showSearch()}]
    [{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]
    [{$oView->setShowNewsletter($oViewConf->getViewThemeParam('blFooterShowNewsletterForm'))}]

    [{if $oxcmp_user}]
    [{assign var="force_sid" value=$oView->getSidForWidget()}]
    [{/if}]

    [{*<div class="row footer_promo" style="background-color: #F1F1F1;padding: 20px 0; margin: 0;font-size: 12px;">
        <div class="col-xs-12 col-sm-3">
            <center>
                <a href="/Versandarten-und-kosten/"><i class="fa fa-check fa-2x" style="color: #73070A;"></i></a><br>
                    Schnelle Bearbeitung<br>&amp; Lieferung
            </center>
        </div>
        <div class="col-xs-12 col-sm-3">
            <center>
                <a href="/Versandarten-und-kosten/"><i class="fa fa-truck fa-2x" style="color: #73070A;"></i></a><br>
                    Günstiger Versand<br>mit DHL
            </center>
        </div>
        <div class="col-xs-12 col-sm-3">
            <center>
                <a href="https://www.shopauskunft.de/review/www.scherzwelt.de-" target="_blank"><i class="fa fa-star fa-2x" style="color: #73070A;"></i></a><br>
                Top bewerteter<br>Onlineshop
            </center>
        </div>
        <div class="col-xs-12 col-sm-3">
            <center>
                <a href="/Preisgarantie-enthalten"><i class="fa fa-euro-sign fa-2x" style="color: #73070A;"></i></a><br>Preisgarantie <br>Günstig einkaufen
            </center>
        </div>
    </div>*}]
    <div class="footertop footer-box-content">
        <div class="container">
            <div class="row">
                <div class="col-12 col-lg-6" style="padding-left: 0;padding-right: 0;">
                            [{oxifcontent ident="oxdeliveryinfo" object="oCont"}]
                                <a href="[{ oxgetseourl ident="oxdeliveryinfo" type="oxcontent" }]"><img src="/out/wave_tes/img/payments.png" class="img-fluid" alt="Zahlungsarten" style="display:inline;" /></a>
                            [{/oxifcontent}]
                </div>
                <div class="col-12 col-lg-6 d-none d-lg-block" style="float: right;">
                   <img style="text-align: right;float: right" src="/out/wave_tes/img/versand.png" class="img-responsive" alt="Versand mit DHL" style="display:inline;" />
                </div>
            </div>
        </div>
    </div>

    <footer class="footer" id="footer">
        <div class="[{if $blFullwidth}]container[{else}]container-fluid[{/if}]">
            <div class="row mb-4">
                <div class="col-12 col-lg-8">
                    <div class="row">
                        [{block name="dd_footer_servicelist"}]
                        <section
                                class="col-12 [{if $blShowFullFooter}]col-md-6 col-lg-3[{else}]col-lg-6[{/if}] footer-box footer-box-service">
                            <div class="h4 footer-box-title">[{oxmultilang ident="SERVICES"}]</div>
                            <div class="footer-box-content">
                                [{block name="dd_footer_servicelist_inner"}]
                                [{oxid_include_widget cl="oxwServiceList" noscript=1 nocookie=1 force_sid=$force_sid}]
                                [{/block}]
                            </div>
                        </section>
                        [{/block}]
                        [{block name="dd_footer_information"}]
                        <section
                                class="col-12 [{if $blShowFullFooter}]col-md-6 col-lg-3[{else}]col-lg-6[{/if}] footer-box footer-box-information">
                            <div class="h4 footer-box-title">[{oxmultilang ident="INFORMATION"}]</div>
                            <div class="footer-box-content">
                                [{block name="dd_footer_information_inner"}]
                                [{oxid_include_widget cl="oxwInformation" noscript=1 nocookie=1 force_sid=$force_sid}]
                                [{/block}]
                            </div>
                        </section>
                        [{/block}]

                        [{oxifcontent ident="footer_kontakt" object="oCont"}]
                            <section class="col-xs-12 col-sm-6 col-md-3 footer-box footer-box-categories">
                            [{assign var="title" value=$oCont->oxcontents__oxtitle->value}]
                                <div class="h4 footer-box-title" style="font-weight: 400;">[{$title}]</div>
                                <div class="footer-box-content">                                        
                                    [{oxcontent ident=footer_kontakt}]
                                </div>
                            </section>
                        [{/oxifcontent}]

                        [{oxifcontent ident="footer_versand" object="oCont"}]
                            <section class="col-xs-12 col-sm-6 col-md-3 footer-box footer-box-categories">
                            [{assign var="title" value=$oCont->oxcontents__oxtitle->value}]
                                <div class="h4 footer-box-title" style="font-weight: 400;">[{$title}]</div>
                                <div class="footer-box-content">                                        
                                    [{oxcontent ident=footer_versand}]
                                </div>
                            </section>
                        [{/oxifcontent}]
                    </div>
                </div>
                <div class="col-12 col-lg-4">
                    <div class="row">
                        <div class="col-12 mx-auto mx-lg-0">
                            <section class="footer-box footer-box-newsletter">
                                <div class="footer-box-content">
                                        [{if $oView->showNewsletter()}]
                                             <div class="h4 footer-box-title">[{oxmultilang ident="NEWSLETTER"}]</div>
                                             [{block name="dd_footer_newsletter"}]
                                            <p class="small" style="margin-bottom: 5px;">[{oxmultilang ident="FOOTER_NEWSLETTER_INFO"}]</p>
                                            [{include file="widget/footer/newsletter.tpl"}]
                                            [{/block}]
                                        [{/if}]
                                        <hr>
                                <div class="h4 footer-box-title">SSL-Gesichert</div>
                                    <div class="footer-box-content">
                                        <img style="margin-right: 5px;" src="https://www.joes-messershop.de/out/media/image/ssl.png" alt="" width="93" height="75" align="left"><span style="font-family: arial, helvetica, sans-serif; font-size: 10pt;">Diese Seite ist mit einem SSL-Zertifikat gesichert. Alle Eingaben von persönlichen Daten werden verschlüsselt übertragen.</span><br><span style="font-family: arial, helvetica, sans-serif; font-size: 10pt;">(Erkennbar an der HTTPS-Verbindung.)<br><br><br></span>
                                    </div>
                                </div>
                            </section>

                            [{block name="footer_social"}][{/block}]

                        </div>
                    </div>
                </div>
            </div>

            [{if $oView->isPriceCalculated()}]
            [{block name="layout_page_vatinclude"}]
                [{block name="footer_deliveryinfo"}]
                    [{oxifcontent ident="oxdeliveryinfo" object="oCont"}]
                        <div id="incVatInfo">
                            [{if $oView->isVatIncluded()}]
                            * <span class="deliveryInfo">[{oxmultilang ident="PLUS_SHIPPING"}]<a href="[{$oCont->getLink()}]">[{oxmultilang ident="PLUS_SHIPPING2"}]</a></span>
                            [{else}]
                            * <span class="deliveryInfo">[{oxmultilang ident="PLUS"}]<a href="[{$oCont->getLink()}]">[{oxmultilang ident="PLUS_SHIPPING2"}]</a></span>
                            [{/if}]
                        </div>
                    [{/oxifcontent}]
                [{/block}]
            [{/block}]
            [{/if}]

            [{* <<START>> Social Links *}]
            [{block name="dd_footer_social_links"}]
                [{if $oViewConf->getViewThemeParam('sFacebookUrl') || $oViewConf->getViewThemeParam('sGooglePlusUrl') || $oViewConf->getViewThemeParam('sTwitterUrl') || $oViewConf->getViewThemeParam('sYouTubeUrl') || $oViewConf->getViewThemeParam('sBlogUrl')}]
                    <div class="social-links">
                        <hr>
                    [{block name="dd_footer_social_links_inner"}]
                    <ul class="social-links-list ">
                        [{block name="dd_footer_social_links_list"}]
                        [{if $oViewConf->getViewThemeParam('sFacebookUrl')}]
                        <li class="social-links-item">
                            <a target="_blank" class="social-links-link"
                               rel="noopener"
                               href="[{$oViewConf->getViewThemeParam('sFacebookUrl')}]">
                                <i class="fab fa-facebook-f"></i> <span>Facebook</span>
                            </a>
                        </li>
                        [{/if}]
                        [{if $oViewConf->getViewThemeParam('sGooglePlusUrl')}]
                        <li class="social-links-item">
                            <a target="_blank" class="social-links-link"
                               rel="noopener"
                               href="[{$oViewConf->getViewThemeParam('sGooglePlusUrl')}]">
                                <i class="fab fa-instagram"></i> <span>Instagram</span>
                            </a>
                        </li>
                        [{/if}]
                        [{if $oViewConf->getViewThemeParam('sTwitterUrl')}]
                        <li class="social-links-item">
                            <a target="_blank" class="social-links-link"
                               rel="noopener"
                               href="[{$oViewConf->getViewThemeParam('sTwitterUrl')}]">
                                <i class="fab fa-twitter"></i> <span>Twitter</span>
                            </a>
                        </li>
                        [{/if}]
                        [{if $oViewConf->getViewThemeParam('sYouTubeUrl')}]
                        <li class="social-links-item">
                            <a target="_blank" class="social-links-link"
                               rel="noopener"
                               href="[{$oViewConf->getViewThemeParam('sYouTubeUrl')}]">
                                <i class="fab fa-youtube"></i> <span>YouTube</span>
                            </a>
                        </li>
                        [{/if}]
                        [{if $oViewConf->getViewThemeParam('sBlogUrl')}]
                        <li class="social-links-item">
                            <a target="_blank" class="social-links-link"
                               rel="noopener"
                               href="[{$oViewConf->getViewThemeParam('sBlogUrl')}]">
                                <i class="fab fa-wordpress"></i> <span>Blog</span>
                            </a>
                        </li>
                        [{/if}]
                        [{/block}]
                    </ul>
                    [{/block}]
                    [{oxifcontent ident="oxstdfooter" object="oCont"}]
                    <hr>
                    <section class="legal-box" style="padding-top:15px;font-size: 12px;">
                        [{block name="dd_footer_copyright"}]
                            [{$oCont->oxcontents__oxcontent->value}]
                        [{/block}]
                    </section>
                    [{/oxifcontent}]
                    [{*<section class="col-sm-12">
                        [{if $oView->isVatIncluded()}]
                            * <span class="deliveryInfo">[{oxmultilang ident="PLUS_SHIPPING"}]<a href="[{$oCont->getLink()}]">[{oxmultilang ident="PLUS_SHIPPING2"}]</a></span>
                        [{else}]
                            * <span class="deliveryInfo">[{oxmultilang ident="PLUS"}]<a href="[{$oCont->getLink()}]">[{oxmultilang ident="PLUS_SHIPPING2"}]</a></span>
                        [{/if}]
                    </section>*}]
                    [{if $oView->getClassName() == "details" }]
                        <section class="col-sm-12">
                            <span style="font-size: 12px;">* Preise verstehen sich inkl. deutscher MwSt. und zzgl. Versandkosten. Bei Lieferung in ein anderes Land ändert sich der MwSt.-Satz und der Bruttopreis gem. <a href="[{ oxgetseourl ident="dfa7ef9f134b44111f70bc756b6e980d" type="oxcontent" }]">Lieferland</a>.</span><br>
                            <span style="font-size: 12px;">** Lieferzeit gilt für Lieferungen innerhalb Deutschlands, Lieferzeiten für andere Länder entnehmen Sie bitte den Versandinformationen unter <a href="[{ oxgetseourl ident="oxdeliveryinfo" type="oxcontent" }]">Zahlung und Versand</a>.</span>
                        </section>
                    [{/if}]
                </div>
                [{/if}]
            [{/block}]
            [{* <<ENDE>> Social Links *}]
        </div>
    </footer>
    [{/block}]

    [{if $oView->isRootCatChanged()}]
        <div id="scRootCatChanged" class="popupBox corners FXgradGreyLight glowShadow" style="display: none;">
            [{include file="form/privatesales/basketexcl.tpl"}]
        </div>
    [{/if}]