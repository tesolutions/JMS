[{assign var="oConfig" value=$oViewConf->getConfig()}]
[{assign var="oManufacturer" value=$oView->getManufacturer()}]
[{assign var="aVariantSelections" value=$oView->getVariantSelections()}]

[{if $aVariantSelections && $aVariantSelections.rawselections}]
    [{assign var="_sSelectionHashCollection" value=""}]
    [{foreach from=$aVariantSelections.rawselections item=oSelectionList key=iKey}]
        [{assign var="_sSelectionHash" value=""}]
        [{foreach from=$oSelectionList item=oListItem key=iPos}]
            [{assign var="_sSelectionHash" value=$_sSelectionHash|cat:$iPos|cat:":"|cat:$oListItem.hash|cat:"|"}]
        [{/foreach}]
        [{if $_sSelectionHash}]
            [{if $_sSelectionHashCollection}][{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:","}][{/if}]
            [{assign var="_sSelectionHashCollection" value=$_sSelectionHashCollection|cat:"'`$_sSelectionHash`'"}]
        [{/if}]
    [{/foreach}]
    [{oxscript add="oxVariantSelections  = [`$_sSelectionHashCollection`];"}]

    <form class="js-oxWidgetReload" action="[{$oView->getWidgetLink()}]" method="get">
        [{$oViewConf->getHiddenSid()}]
        [{$oViewConf->getNavFormParams()}]
        <input type="hidden" name="cl" value="[{$oView->getClassName()}]">
        <input type="hidden" name="oxwparent" value="[{$oViewConf->getTopActiveClassName()}]">
        <input type="hidden" name="listtype" value="[{$oView->getListType()}]">
        <input type="hidden" name="nocookie" value="1">
        <input type="hidden" name="cnid" value="[{$oView->getCategoryId()}]">
        <input type="hidden" name="anid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
        <input type="hidden" name="actcontrol" value="[{$oViewConf->getTopActiveClassName()}]">
        [{if $oConfig->getRequestParameter('preview')}]
            <input type="hidden" name="preview" value="[{$oConfig->getRequestParameter('preview')}]">
        [{/if}]
    </form>
[{/if}]

[{oxhasrights ident="TOBASKET"}]
    <form class="js-oxProductForm" action="[{$oViewConf->getSelfActionLink()}]" method="post">
        <div class="hidden">
            [{$oViewConf->getHiddenSid()}]
            [{$oViewConf->getNavFormParams()}]
            <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
            <input type="hidden" name="aid" value="[{$oDetailsProduct->oxarticles__oxid->value}]">
            <input type="hidden" name="anid" value="[{$oDetailsProduct->oxarticles__oxnid->value}]">
            <input type="hidden" name="parentid" value="[{if !$oDetailsProduct->oxarticles__oxparentid->value}][{$oDetailsProduct->oxarticles__oxid->value}][{else}][{$oDetailsProduct->oxarticles__oxparentid->value}][{/if}]">
            <input type="hidden" name="panid" value="">
            [{if !$oDetailsProduct->isNotBuyable()}]
                <input type="hidden" name="fnc" value="tobasket">
            [{/if}]
        </div>
[{/oxhasrights}]

<div class="details-info" itemscope itemtype="http://schema.org/Product">
    <div class="row">
        <div class="col-12 col-md-5 details-col-left">
            [{* article picture with zoom *}]
            [{block name="details_productmain_zoom"}]
                [{oxscript include="js/libs/photoswipe.min.js" priority=8}]
                [{oxscript include="js/libs/photoswipe-ui-default.min.js" priority=8}]
                [{oxscript add="\$( document ).ready( function() { Wave.initDetailsEvents(); });"}]

                [{* Wird ausgeführt, wenn es sich um einen AJAX-Request handelt *}]
                [{if $blWorkaroundInclude}]
                    [{oxscript add="$( document ).ready( function() { Wave.initEvents();});"}]
                [{/if}]

                [{if $oView->showZoomPics()}]
                    [{* ToDo: This logical part should be ported into a core function. *}]
                    [{if $oConfig->getConfigParam('sAltImageUrl') || $oConfig->getConfigParam('sSSLAltImageUrl')}]
                        [{assign var="aPictureInfo" value=$oPictureProduct->getMasterZoomPictureUrl(1)|@getimagesize}]
                    [{else}]
                        [{assign var="sPictureName" value=$oPictureProduct->oxarticles__oxpic1->value}]
                        [{assign var="aPictureInfo" value=$oConfig->getMasterPicturePath("product/1/`$sPictureName`")|@getimagesize}]
                    [{/if}]

                    <div class="picture details-picture">
                        <a class="details-picture-link" href="[{$oPictureProduct->getMasterZoomPictureUrl(1)}]" id="zoom1"[{if $aPictureInfo}] data-width="[{$aPictureInfo.0}]" data-height="[{$aPictureInfo.1}]"[{/if}]>
                            <img src="[{$oView->getActPicture()}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]" itemprop="image" class="img-fluid">
                        </a>
                    </div>
                [{else}]
                    <div class="picture details-picture">
                        <img src="[{$oView->getActPicture()}]" alt="[{$oPictureProduct->oxarticles__oxtitle->value|strip_tags}] [{$oPictureProduct->oxarticles__oxvarselect->value|strip_tags}]" itemprop="image" class="img-fluid">
                    </div>
                [{/if}]
            [{/block}]

            [{block name="details_productmain_morepics"}]
                [{include file="page/details/inc/morepics.tpl"}]
            [{/block}]
        </div>

        <div class="col-12 col-md-7 details-col-middle">
            [{assign var="tprice"  value=$oDetailsProduct->getTPrice()}]
            [{assign var="price"   value=$oDetailsProduct->getPrice()}]
            [{if $oManufacturer or $oDetailsProduct->oxarticles__ab18 == "1"}]
                <div class="brandLogo d-none d-lg-block" style="float:right;text-align: center;position:absolute;right:15px;[{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice() or $oDetailsProduct->oxarticles__ecssale->value == 1}] margin-top:30px;[{/if}][{if $oDetailsProduct->oxarticles__ecsship->value == 1 or $oDetailsProduct->oxarticles__oxfreeshipping->value == 1 }] margin-top:60px;[{/if}]">
                    [{block name="details_productmain_manufacturersicon"}]
                        [{if $oManufacturer}]
                            <a href="[{$oManufacturer->getLink()}]" title="[{$oManufacturer->oxmanufacturers__oxtitle->value}]">
                            [{if $oManufacturer->oxmanufacturers__oxicon->value}]
                                <img src="[{$oManufacturer->getIconUrl()}]" style="max-width: 75px;" alt="[{$oManufacturer->oxmanufacturers__oxtitle->value}]">
                            [{/if}]
                            </a>
                        [{/if}]
                    [{/block}]
                    [{if $oDetailsProduct->oxarticles__ab18 == "1"}]
                        <div>
                            <a href="/Verkauf-ab-18-Jahre/" title="Verkauf ab 18"><img src="/out/wave_tes/img/18.png" class="img-fluid"  style="[{if $oManufacturer}]margin-top:10px;[{/if}]" alt="Verkauf ab 18"></a>
                        </div>
                    [{/if}]
                </div>
            [{/if}]

            [{block name="details_productmain_title"}]
                <h1 id="productTitle" class="details-title" itemprop="name" style="max-width: 580px;">
                    [{$oDetailsProduct->oxarticles__oxtitle->value}] [{$oDetailsProduct->oxarticles__oxvarselect->value}]
                </h1>
            [{/block}]

            [{* ratings *}]
            [{if $oView->ratingIsActive()}]
                [{block name="details_productmain_ratings"}]
                    [{include file="widget/reviews/rating.tpl" itemid="anid=`$oDetailsProduct->oxarticles__oxnid->value`" sRateUrl=$oDetailsProduct->getLink()}]
                [{/block}]
            [{/if}]

            [{* short description *}]
            [{block name="details_productmain_shortdesc"}]
                [{oxhasrights ident="SHOWSHORTDESCRIPTION"}]
                    [{if $oDetailsProduct->oxarticles__oxshortdesc->rawValue}]
                        <p class="details-shortdesc" id="productShortdesc" itemprop="description" style="padding-top:5px">[{$oDetailsProduct->oxarticles__oxshortdesc->rawValue}]</p>
                    [{/if}]
                [{/oxhasrights}]
            [{/block}]

            [{* article number *}]
            <div class="weight" style="font-size: 12px;margin-bottom: 5px;">
                [{* article number *}]
                [{block name="details_productmain_artnumber"}]
                    <div style="line-height: 18px;"><span itemprop="sku">Artikelnummer: [{$oDetailsProduct->oxarticles__oxartnum->value}]</span></div>
                [{/block}]
                [{*if $oDetailsProduct->oxarticles__oxean->value}]
                    <div style="line-height: 18px;">EAN: [{$oDetailsProduct->oxarticles__oxean->value}]</div>
                [{/if*}]
                [{assign var="oManufacturer" value=$oView->getManufacturer()}]
                [{if $oManufacturer->oxmanufacturers__fimierung->value}]
                    <div style="line-height: 18px;">Hersteller: [{$oManufacturer->oxmanufacturers__fimierung->value}]</div>
                [{/if}]
                [{*if $oDetailsProduct->oxarticles__oxweight->value}]
                    <div style="line-height: 18px;">
                        [{block name="details_productmain_weight"}]
                            Versandgewicht: [{$oDetailsProduct->oxarticles__oxweight->value}] [{oxmultilang ident="KG"}]
                        [{/block}]
                    </div>
                [{/if*}]
            </div>

            <div itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                [{* article main info block *}]
                <div class="details-information[{if $oManufacturer->oxmanufacturers__oxicon->value}] hasBrand[{/if}]">
                    <span class="hidden" itemprop="url" content="[{$oDetailsProduct->getMainLink()}]"></span>

                    [{* additional info *}]
                    
                    [{block name="details_productmain_vpe"}]
                        [{if $oDetailsProduct->oxarticles__oxvpe->value > 1}]
                            <span class="vpe small">[{oxmultilang ident="DETAILS_VPE_MESSAGE_1"}] [{$oDetailsProduct->oxarticles__oxvpe->value}] [{oxmultilang ident="DETAILS_VPE_MESSAGE_2"}]</span>
                        [{/if}]
                    [{/block}]

                    [{assign var="blCanBuy" value=true}]
                    [{* variants | md variants *}]
                    [{block name="details_productmain_variantselections"}]
                        [{if $aVariantSelections && $aVariantSelections.selections}]
                            [{oxscript include="js/widgets/oxajax.min.js" priority=10 }]
                            [{oxscript include="js/widgets/oxarticlevariant.min.js" priority=10 }]
                            [{oxscript add="$( '#variants' ).oxArticleVariant();"}]
                            [{assign var="blCanBuy" value=$aVariantSelections.blPerfectFit}]
                            [{if !$blHasActiveSelections}]
                                [{if !$blCanBuy && !$oDetailsProduct->isParentNotBuyable()}]
                                    [{assign var="blCanBuy" value=true}]
                                [{/if}]
                            [{/if}]
                            <div id="variants" class="selectorsBox variant-dropdown js-fnSubmit">
                                [{assign var="blHasActiveSelections" value=false}]
                                [{foreach from=$aVariantSelections.selections item=oList key=iKey}]
                                    [{if $oList->getActiveSelection()}]
                                        [{assign var="blHasActiveSelections" value=true}]
                                    [{/if}]
                                    [{include file="widget/product/selectbox.tpl" oSelectionList=$oList iKey=$iKey blInDetails=true}]
                                [{/foreach}]
                            </div>
                        [{/if}]
                    [{/block}]

                    [{* selection lists *}]
                    [{block name="details_productmain_selectlists"}]
                        [{if $oViewConf->showSelectLists()}]
                            [{assign var="oSelections" value=$oDetailsProduct->getSelections()}]
                            [{if $oSelections}]
                                <div class="selectorsBox variant-dropdown js-fnSubmit clear" id="productSelections">
                                    [{foreach from=$oSelections item=oList name=selections}]
                                        [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop"}]
                                    [{/foreach}]
                                </div>
                            [{/if}]
                        [{/if}]
                    [{/block}]

                    <div class="price-wrapper">

                        [{block name="details_productmain_tprice"}]
                            [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                [{if $oDetailsProduct->getTPrice()}]
                                    <del class="price-old">[{oxprice price=$oDetailsProduct->getTPrice() currency=$currency}]</del>
                                    <br />
                                [{/if}]
                            [{/oxhasrights}]
                        [{/block}]

                        [{block name="details_productmain_watchlist"}][{/block}]
                        [{block name="details_productmain_price"}]
                            [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                [{block name="details_productmain_price_value"}]
                                    [{if $oDetailsProduct->getFPrice()}]
                                        <label id="productPrice" class="price-label">
                                            [{assign var="sFrom" value=""}]
                                            [{assign var="oPrice" value=$oDetailsProduct->getPrice()}]
                                            [{if $oDetailsProduct->isParentNotBuyable()}]
                                                [{assign var="oPrice" value=$oDetailsProduct->getVarMinPrice()}]
                                                [{if $oDetailsProduct->isRangePrice()}]
                                                    [{assign var="sFrom" value="PRICE_FROM"|oxmultilangassign}]
                                                [{/if}]
                                            [{/if}]
                                            <span[{if $oDetailsProduct->getTPrice()}] class="text-danger"[{/if}]>
                                                <span class="price-from">[{$sFrom}]</span>
                                                <span class="price">[{oxprice price=$oPrice currency=$currency}] *</span>
                                                [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                                    [{assign var="oUnitPrice" value=$oDetailsProduct->getUnitPrice()}]
                                                    [{block name="details_productmain_priceperunit"}]
                                                        [{if $oUnitPrice}]
                                                            <span id="productPriceUnit" style="padding-left: 15x;color: #333">([{oxprice price=$oUnitPrice currency=$currency}]/[{$oDetailsProduct->getUnitName()}])</span>
                                                        [{/if}]
                                                    [{/block}]
                                                [{/oxhasrights}]
                                                <span class="d-none">
                                                    <span itemprop="price">[{$oPrice->getPrice()}]</span>
                                                    <span itemprop="priceCurrency">[{$currency->name}]</span>
                                                </span>
                                            </span>
                                        </label>
                                    [{/if}]
                                [{/block}]
                            [{/oxhasrights}]
                        [{/block}]
                    </div>
                </div>

                <div class="tobasket">
                    [{* pers params *}]
                    [{block name="details_productmain_persparams"}]
                        [{if $oView->isPersParam()}]
                            <div class="persparamBox clear form-group">
                                <label for="persistentParam" class="control-label">[{oxmultilang ident="LABEL"}]</label>
                                <input type="text" id="persistentParam" name="persparam[details]" value="[{$oDetailsProduct->aPersistParam.text}]" size="35" class="form-control">
                            </div>
                        [{/if}]
                    [{/block}]
                    
                    [{if $oDetailsProduct->isParentNotBuyable()}]
                        [{assign var="blCanBuy" value=false}]
                    [{/if}]

                    [{block name="details_productmain_tobasket"}]
                        <div class="tobasketFunction tobasket-function">
                            [{oxhasrights ident="TOBASKET"}]
                                [{if !$oDetailsProduct->isNotBuyable()}]
                                [{if $oxcmp_shop->oxshops__urlaub->value == "0"}]
                                    <div class="input-group tobasket-input-group">
                                        <input id="amountToBasket" type="number" name="am" value="1" autocomplete="off" class="form-control">
                                        <div class="input-group-append">
                                            <button id="toBasket" type="submit" [{if !$blCanBuy}]disabled="disabled"[{/if}] class="btn btn-primary submitButton" data-disabledtext="[{oxmultilang ident="TO_CART_NOVARIANT"}]"><i class="fa fa-shopping-cart"></i> [{oxmultilang ident="TO_CART"}]</button>
                                        </div>
                                    </div>
                                [{else}]
                                    <p style="background-color: #87B921;color: #fff;padding: 10px;border-radius: 4px;text-align: left;font-weight: 700;">
                                        [{ oxcontent ident=kauffunktion }]
                                    </p>
                                [{/if}]
                                [{/if}]
                            [{/oxhasrights}]
                        </div>
                    [{/block}]

                    [{block name="details_productmain_stockstatus"}]
                        [{if $oDetailsProduct->getStockStatus() == -1}]
                            <span class="stockFlag notOnStock">
                                <i class="fa fa-circle text-danger"></i>
                                [{if $oDetailsProduct->oxarticles__oxnostocktext->value}]
                                    <link itemprop="availability" href="http://schema.org/OutOfStock"/>
                                    [{$oDetailsProduct->oxarticles__oxnostocktext->value}]
                                [{elseif $oViewConf->getStockOffDefaultMessage()}]
                                    <link itemprop="availability" href="http://schema.org/OutOfStock"/>
                                    [{oxmultilang ident="MESSAGE_NOT_ON_STOCK"}]
                                [{/if}]
                                [{if $oDetailsProduct->getDeliveryDate()}]
                                    <link itemprop="availability" href="http://schema.org/PreOrder"/>
                                    [{oxmultilang ident="AVAILABLE_ON"}] [{$oDetailsProduct->getDeliveryDate()}]
                                [{/if}]
                            </span>
                        [{elseif $oDetailsProduct->getStockStatus() == 1}]
                            <link itemprop="availability" href="http://schema.org/InStock"/>
                            <span class="stockFlag lowStock">
                                <i class="fa fa-circle text-warning"></i> [{oxmultilang ident="LOW_STOCK2"}] [{$oDetailsProduct->oxarticles__oxstock->value}] [{oxmultilang ident="LOW_STOCK3"}][{*oxmultilang ident="LIEFERZEIT"*}]
                            </span>
                        [{elseif $oDetailsProduct->getStockStatus() == 0}]
                            <span class="stockFlag">
                                <link itemprop="availability" href="http://schema.org/InStock"/>
                                <i class="fa fa-circle text-success"></i>
                                [{if $oDetailsProduct->oxarticles__oxstocktext->value}]
                                    [{$oDetailsProduct->oxarticles__oxstocktext->value}]
                                [{elseif $oViewConf->getStockOnDefaultMessage()}]
                                    [{oxmultilang ident="READY_FOR_SHIPPING"}][{*oxmultilang ident="LIEFERZEIT"*}]
                                [{/if}]
                            </span>
                        [{/if}]
                    [{/block}]

                    [{oxhasrights ident="TOBASKET"}]
                        [{if $oDetailsProduct->isBuyable()}]
                            [{block name="details_productmain_deliverytime"}]
                                [{include file="page/details/inc/deliverytime.tpl"}]**
                            [{/block}]
                        [{/if}]
                    [{/oxhasrights}]

                    [{block name="details_productmain_social"}]
                    [{/block}]
                    [{if $oDetailsProduct->loadAmountPriceInfo()}]           
                        [{assign var="currency" value=$oView->getActCurrency()}]
                        <div class="clearfix" style="clear:both;">
                            <div class="staffelpreise-body">
                                <dl class="dl-horizontal2">
                                    <hr style="margin-top: 0.5rem;margin-bottom: 0.5rem;">
                                    <p style="font-weight: 700;margin: 0;">Staffelpreise:</p>
                                    [{foreach from=$oDetailsProduct->loadAmountPriceInfo() item=priceItem name=amountPrice}]
                                        <dt style="font-size: 12px;">ab [{$priceItem->oxprice2article__oxamount->value}] [{oxmultilang ident="PCS"}]</dt>
                                        <dd style="font-size: 12px;margin-bottom: 0;">
                                            [{if $priceItem->oxprice2article__oxaddperc->value}]
                                                [{$priceItem->oxprice2article__oxaddperc->value}]% [{oxmultilang ident="DISCOUNT"}]
                                            [{else}]
                                                [{$priceItem->fbrutprice}] [{$currency->sign}]
                                                [{assign var="oUnitPrice" value=$oDetailsProduct->getUnitPrice()}]
                                                [{if $oUnitPrice}]
                                                    [{math assign="ox_ek" equation="(x/y)" x=$priceItem->oxprice2article__oxaddabs->value y=$oDetailsProduct->oxarticles__oxunitquantity->value }] 
                                                    &nbsp;<span style="color: #777;font-size: 11px;">([{ $ox_ek|number_format:2:",":"."}] [{$currency->sign}] / [{$oDetailsProduct->getUnitName()}])</span>
                                                [{/if}]
                                            [{/if}]
                                        </dd>
                                    [{/foreach}]
                                </dl>
                            </div>
                        </div>
                    [{/if}]
                </div>

                <hr>
                
                [{block name="details_productmain_productlinksselector"}]
                    [{block name="details_productmain_productlinks"}]
                        <div>
                        <ul class="list-unstyled action-links">
                            [{if $oDetailsProduct->oxarticles__ab18 == "1"}]
                                <li class="d-lg-none">
                                    <a href="/Verkauf-ab-18-Jahre/" style="color: red;" title="Verkauf ab 18"><i class="fa fa-exclamation-circle" aria-hidden="true"></i> Verkauf ab 18</a>
                                </li>
                            [{/if}]
                            [{*if $oManufacturer}]
                                <li>
                                    <a href="[{$oManufacturer->getLink()}]" title="[{$oManufacturer->oxmanufacturers__oxtitle->value}]"><i class="fa fa-list" aria-hidden="true"></i> Alle Artikel dieser Marke</a>
                                </li>
                            [{/if*}]
                            [{if !$oDetailsProduct->oxarticles__oxnonmaterial->value}]
                            [{if $oViewConf->getShowCompareList()}]
                                <li>
                                    [{oxid_include_dynamic file="page/details/inc/compare_links.tpl" testid="" type="compare" aid=$oDetailsProduct->oxarticles__oxid->value anid=$oDetailsProduct->oxarticles__oxnid->value in_list=$oDetailsProduct->isOnComparisonList() page=$oView->getActPage() text_to_id="COMPARE" text_from_id="REMOVE_FROM_COMPARE_LIST"}]
                                </li>
                            [{/if}]
                            <li>
                                [{if $oViewConf->getShowSuggest()}]
                                    <a id="suggest" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=suggest" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:$oViewConf->getNavUrlParams()}]">[{oxmultilang ident="RECOMMEND"}]</a>
                                [{/if}]
                            </li>

                            [{if $oViewConf->getShowListmania()}]
                                <li>
                                    [{if $oxcmp_user}]
                                        <a id="recommList" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=recommadd" params="aid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:$oViewConf->getNavUrlParams()|cat:"&amp;stoken="|cat:$oViewConf->getSessionChallengeToken()}]"><i class="fa fa-heart" aria-hidden="true"></i> [{oxmultilang ident="ADD_TO_LISTMANIA_LIST"}]</a>
                                    [{else}]
                                        <a id="loginToRecommlist" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]"><i class="fa fa-heart" aria-hidden="true"></i> [{oxmultilang ident="ADD_TO_LISTMANIA_LIST"}]</a>
                                    [{/if}]
                                </li>
                            [{/if}]
                            [{/if}]

                            <li>
                                [{if $oxcmp_user}]
                                    <a id="linkToNoticeList" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl="|cat:$oViewConf->getTopActiveClassName() params="aid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;anid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;fnc=tonoticelist&amp;am=1"|cat:$oViewConf->getNavUrlParams()|cat:"&amp;stoken="|cat:$oViewConf->getSessionChallengeToken()}]"><i class="fa fa-bookmark" aria-hidden="true"></i> [{oxmultilang ident="ADD_TO_WISH_LIST"}]</a>
                                [{else}]
                                    <a id="loginToNotice" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]"><i class="fa fa-bookmark" aria-hidden="true"></i> [{oxmultilang ident="ADD_TO_WISH_LIST"}]</a>
                                [{/if}]
                            </li>

                            [{if $oViewConf->getShowWishlist()}]
                                <li>
                                    [{if $oxcmp_user}]
                                        <a id="linkToWishList" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl="|cat:$oViewConf->getTopActiveClassName() params="aid=`$oDetailsProduct->oxarticles__oxnid->value`&anid=`$oDetailsProduct->oxarticles__oxnid->value`&amp;fnc=towishlist&amp;am=1"|cat:$oViewConf->getNavUrlParams()|cat:"&amp;stoken="|cat:$oViewConf->getSessionChallengeToken()}]"><i class="fa fa-list" aria-hidden="true"></i> [{oxmultilang ident="ADD_TO_GIFT_REGISTRY"}]</a>
                                    [{else}]
                                        <a id="loginToWish" href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account" params="anid=`$oDetailsProduct->oxarticles__oxnid->value`"|cat:"&amp;sourcecl="|cat:$oViewConf->getTopActiveClassName()|cat:$oViewConf->getNavUrlParams()}]"><i class="fa fa-list" aria-hidden="true"></i> [{oxmultilang ident="ADD_TO_GIFT_REGISTRY"}]</a>
                                    [{/if}]
                                </li>
                            [{/if}]
                            <li>
                                [{mailto extra='id="questionMail"' address=$oDetailsProduct->oxarticles__oxquestionemail->value|default:$oxcmp_shop->oxshops__oxinfoemail->value subject='Fragen zu Artikel'|oxmultilangassign|cat:" "|cat:$oDetailsProduct->oxarticles__oxartnum->value text='QUESTIONS_ABOUT_THIS_PRODUCT'|oxmultilangassign}]
                            </li>
                        </ul>
                        </div>
                        <div class="clearfix"></div>
                    [{/block}]
                [{/block}]

            </div>
        </div>
    </div>
</div>

[{oxhasrights ident="TOBASKET"}]
    </form>
[{/oxhasrights}]
