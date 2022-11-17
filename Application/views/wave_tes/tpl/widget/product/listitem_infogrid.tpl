[{block name="widget_product_listitem_infogrid"}]
    [{assign var="product"         value=$oView->getProduct()}]
    [{assign var="blDisableToCart" value=$oView->getDisableToCart()}]
    [{assign var="iIndex"          value=$oView->getIndex()}]
    [{assign var="showMainLink"    value=$oView->getShowMainLink()}]

    [{assign var="currency" value=$oView->getActCurrency()}]
    [{if $showMainLink}]
        [{assign var='_productLink' value=$product->getMainLink()}]
    [{else}]
        [{assign var='_productLink' value=$product->getLink()}]
    [{/if}]
    [{assign var="aVariantSelections" value=$product->getVariantSelections(null,null,1)}]
    [{assign var="blShowToBasket" value=false}] [{* tobasket or more info ? *}]
    [{if $blDisableToCart || $product->isNotBuyable() || ($aVariantSelections&&$aVariantSelections.selections) || $product->hasMdVariants() || ($oViewConf->showSelectListsInList() && $product->getSelections(1)) || $product->getVariants()}]
        [{assign var="blShowToBasket" value=false}]
    [{/if}]

    [{if !$testid }]
        [{assign var=testid value=$oView->getViewParameter('testid')}]
    [{/if}]
    [{if !$listId }]
        [{assign var=listId value=$oView->getViewParameter('listId')}]
    [{/if}]

    <form name="tobasket[{$testid}]" [{if $blShowToBasket}]action="[{$oViewConf->getSelfActionLink()}]" method="post"[{else}]action="[{$_productLink}]" method="get"[{/if}]>
        <div class="hidden">
            [{$oViewConf->getNavFormParams()}]
            [{$oViewConf->getHiddenSid()}]
            <input type="hidden" name="pgNr" value="[{$oView->getActPage()}]">
            [{if $recommid}]
                <input type="hidden" name="recommid" value="[{$recommid}]">
            [{/if}]
            [{if $blShowToBasket}]
                [{oxhasrights ident="TOBASKET"}]
                    <input type="hidden" name="cl" value="[{$oViewConf->getTopActiveClassName()}]">
                [{if $owishid}]
                    <input type="hidden" name="owishid" value="[{$owishid}]">
                [{/if}]
                [{if $toBasketFunction}]
                    <input type="hidden" name="fnc" value="[{$toBasketFunction}]">
                [{else}]
                    <input type="hidden" name="fnc" value="tobasket">
                [{/if}]
                    <input type="hidden" name="aid" value="[{$product->oxarticles__oxid->value}]">
                [{if $altproduct}]
                    <input type="hidden" name="anid" value="[{$altproduct}]">
                [{else}]
                    <input type="hidden" name="anid" value="[{$product->oxarticles__oxnid->value}]">
                [{/if}]
                    <input type="hidden" name="am" value="1">
                [{/oxhasrights}]
            [{else}]
                <input type="hidden" name="cl" value="details">
                <input type="hidden" name="anid" value="[{$product->oxarticles__oxnid->value}]">
            [{/if}]
        </div>

        <div class="row">
            <div class="col-12 col-lg-5">
                [{block name="widget_product_listitem_infogrid_gridpicture"}]
                    <div class="picture text-center">
                        <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                            <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$product->getThumbnailUrl()}]" alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]" class="img-fluid">
                        </a>
                    </div>
                [{/block}]
            </div>
            <div class="col-12 col-lg-7">
                <div class="listDetails">
                    [{block name="widget_product_listitem_infogrid_titlebox"}]
                        <div class="title">
                            <a id="[{$testid}]" href="[{$_productLink}]" class="title" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                                <span>[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]</span>
                            </a>
                        </div>
                    [{/block}]

                    [{block name="widget_product_listitem_infogrid_shortdesc"}]
                        <div class="shortdesc" style="font-size:12px;">
                            [{$product->oxarticles__oxshortdesc->rawValue|truncate:110:"..."}]
                            [{if $product->getStockStatus() != -1}]
                            [{ if $product->getAttributes() }] 
                                [{foreach from=$product->getAttributes() item=oAttr name=attribute}]
                                    [{ if $oAttr->oxattribute__oxtitle->value == "Größe"}]
                                        <div>Größe: [{ $oAttr->oxattribute__oxvalue->value|truncate:21:"..." }]</div>
                                    [{else}]
                                      &nbsp;
                                    [{/if}]
                                [{/foreach}] 
                            [{/if}]
                            [{/if}]
                        </div>
                    [{/block}]

                    [{*block name="widget_product_listitem_infogrid_selections"}]
                        [{if $aVariantSelections && $aVariantSelections.selections }]
                            <div id="variantselector_[{$iIndex}]" class="selectorsBox variant-dropdown js-fnSubmit clear">
                                [{foreach from=$aVariantSelections.selections item=oSelectionList key=iKey}]
                                    [{include file="widget/product/selectbox.tpl" oSelectionList=$oSelectionList sJsAction="js-fnSubmit" blHideLabel=true}]
                                [{/foreach}]
                            </div>
                        [{elseif $oViewConf->showSelectListsInList()}]
                            [{assign var="oSelections" value=$product->getSelections(1)}]
                            [{if $oSelections}]
                                <div id="selectlistsselector_[{$iIndex}]" class="selectorsBox js-fnSubmit clear">
                                    [{foreach from=$oSelections item=oList name=selections}]
                                        [{include file="widget/product/selectbox.tpl" oSelectionList=$oList sFieldName="sel" iKey=$smarty.foreach.selections.index blHideDefault=true sSelType="seldrop" sJsAction="js-fnSubmit" blHideLabel=true}]
                                    [{/foreach}]
                                </div>
                            [{/if}]
                        [{/if}]
                    [{/block*}]

                    <div class="price">
                        <div class="content">
                            [{block name="widget_product_listitem_infogrid_price"}]
                                [{oxhasrights ident="SHOWARTICLEPRICE"}]
                                    [{assign var="oUnitPrice" value=$product->getUnitPrice()}]
                                    [{assign var="tprice"     value=$product->getTPrice()}]
                                    [{assign var="price"      value=$product->getPrice()}]

                                    [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                                        <span class="oldPrice text-muted" style="font-size: 12px;">
                                            Unser bisheriger Preis <del>[{$product->getFTPrice()}] [{$currency->sign}]</del><br>
                                        </span>
                                    [{/if}]

                                    [{block name="widget_product_listitem_infogrid_price_value"}]
                                        [{if $product->getFPrice() == "0,00"}]
                                            <span class="lead text-nowrap" style="font-size: 16px;line-height: 24px;">Preis auf Anfrage</span>
                                        [{else}]
                                        [{if $product->getFPrice()}]
                                            <span class="lead text-nowrap">
                                            [{if $product->isRangePrice()}]
                                                [{oxmultilang ident="PRICE_FROM"}]
                                                [{if !$product->isParentNotBuyable()}]
                                                    [{$product->getFMinPrice()}]
                                                [{else}]
                                                    [{$product->getFVarMinPrice()}]
                                                [{/if}]
                                            [{else}]
                                                [{if !$product->isParentNotBuyable()}]
                                                    [{$product->getFPrice()}]
                                                [{else}]
                                                    [{$product->getFVarMinPrice()}]
                                                [{/if}]
                                            [{/if}]
                                            [{$currency->sign}]
                                            [{if $oView->isVatIncluded()}]
                                                [{if !($product->hasMdVariants() || ($oViewConf->showSelectListsInList() && $product->getSelections(1)) || $product->getVariants())}]*[{/if}]
                                            [{/if}]
                                        </span>
                                        [{/if}]
                                        [{/if}]
                                    [{/block}]
                                    [{if $oUnitPrice}]
                                        <span id="productPricePerUnit_[{$testid}]" class="pricePerUnit" style="font-size: 12px;"><br>
                                            [{$product->oxarticles__oxunitquantity->value}] [{$product->getUnitName()}] | [{oxprice price=$oUnitPrice currency=$currency}]/[{$product->getUnitName()}]
                                        </span>
                                    [{/if}]
                                [{/oxhasrights}]
                            [{/block}]
                        </div>
                    </div>
                        <div class="ampel_list">
                        <div class="ampel_list_ig text-left" style="font-size:12px;margin-top: 2px;">
                            [{if $product->getStockStatus() == -1}]
                                <span class="stockFlag notOnStock">
                                    <i class="fa fa-circle text-danger"></i>
                                    [{if $product->oxarticles__oxnostocktext->value}]
                                        [{$product->oxarticles__oxnostocktext->value}]
                                    [{elseif $oViewConf->getStockOffDefaultMessage()}]
                                        [{oxmultilang ident="MESSAGE_NOT_ON_STOCK2"}]
                                    [{/if}]
                                </span>
                            [{elseif $product->getStockStatus() == 1}]
                                <span class="stockFlag lowStock">
                                    <i class="fa fa-circle text-warning"></i> [{oxmultilang ident="LOW_STOCK"}]
                                </span>
                            [{elseif $product->getStockStatus() == 0}]
                                <span class="stockFlag">
                                    <i class="fa fa-circle text-success"></i>
                                    [{if $product->oxarticles__oxstocktext->value}]
                                        [{$product->oxarticles__oxstocktext->value}]
                                    [{elseif $oViewConf->getStockOnDefaultMessage()}]
                                        [{oxmultilang ident="READY_FOR_SHIPPING"}]
                                    [{/if}]
                                </span>
                            [{/if}]
                        </div>
                    </div>  
                    [{block name="widget_product_listitem_infogrid_tobasket"}]
                        <div class="actions">
                            <div class="btn-group">
                                [{if $blShowToBasket}]
                                    [{oxhasrights ident="TOBASKET"}]
                                        <button type="submit" aria-label="[{oxmultilang ident="TO_CART"}]" class="btn btn-outline-dark hasTooltip" data-placement="bottom" title="[{oxmultilang ident="TO_CART"}]" data-container="body">
                                            <i class="fa fa-shopping-cart"></i>
                                        </button>
                                    [{/oxhasrights}]
                                    <a class="btn btn-primary" href="[{$_productLink}]" >[{oxmultilang ident="MORE_INFO"}]</a>
                                [{else}]
                                    <a class="btn btn-primary" href="[{$_productLink}]" >[{oxmultilang ident="MORE_INFO"}]</a>
                                [{/if}]
                            </div>
                        </div>
                    [{/block}]
                </div>
            </div>
        </div>
    </form>
[{/block}]
