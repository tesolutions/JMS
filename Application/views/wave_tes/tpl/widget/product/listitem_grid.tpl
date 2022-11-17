[{block name="widget_product_listitem_grid"}]
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

        [{block name="widget_product_listitem_infogrid_gridpicture"}]
        <div class="picture text-center">
            <a href="[{$_productLink}]" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                <img src="[{$oViewConf->getImageUrl('spinner.gif')}]" data-src="[{$product->getThumbnailUrl()}]" alt="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]" class="img-fluid">
            </a>
        </div>
        [{/block}]

        <div class="listDetails text-center">
            [{block name="widget_product_listitem_infogrid_titlebox"}]
                <div class="title">
                    <a id="[{$testid}]" href="[{$_productLink}]" class="title" title="[{$product->oxarticles__oxtitle->value}] [{$product->oxarticles__oxvarselect->value}]">
                        <span>[{$product->oxarticles__oxtitle->value|truncate:58:"..."}] [{$product->oxarticles__oxvarselect->value}]</span>
                    </a>
                </div>
            [{/block}]

            <div class="price text-center">
                <div class="content">
                    <div class="list_staffelpreise d-none d-lg-block" style="height: 18px;">
                        [{if $product->loadAmountPriceInfo()}]
                            <!-- Popover #1 -->
                            <a data-placement="top" data-popover-content="#a1_[{$testid}]" data-toggle="popover" data-trigger="hover" href="#" tabindex="0" style="color: #A74645;font-size: 12px;">Staffelpreise</a>
                            <!-- Content for Popover #1 -->
                            <div class="hidden" id="a1_[{$testid}]">
                              <div class="popover-heading">
                                Staffelpreise
                              </div>
                              <div class="popover-body">
                                [{include file="widget/product/priceinfo_list2.tpl"}]
                              </div>
                            </div>
                        [{/if}]
                    </div>
                    [{block name="widget_product_listitem_grid_price"}]
                        [{oxhasrights ident="SHOWARTICLEPRICE"}]
                            [{assign var="oUnitPrice" value=$product->getUnitPrice()}]
                            [{assign var="tprice"     value=$product->getTPrice()}]
                            [{assign var="price"      value=$product->getPrice()}]

                            [{if $tprice && $tprice->getBruttoPrice() > $price->getBruttoPrice()}]
                                <span style="font-size: 12px;">
	                                Statt <span class="oldPrice text-muted">
	                                    <del>[{$product->getFTPrice()}] [{$currency->sign}]</del>
	                                </span>&nbsp;&nbsp;
	                            </span>
                            [{/if}]

                            [{block name="widget_product_listitem_grid_price_value"}]
                                [{if $product->getFPrice() == "0,00"}]
                                    <span class="lead text-nowrap" style="font-size: 16px;line-height: 24px;">Preis auf Anfrage</span>
                                [{else}]
                                [{if $product->getFPrice()}]
                                    <span class="lead text-nowrap" style="font-size: 1.2rem;">
                                        [{if $product->isRangePrice()}]
                                            [{oxmultilang ident="PRICE_FROM"}]&nbsp;
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
                                        [{$currency->sign}] *
                                    </span>
                                [{/if}]
                                [{/if}]
                            [{/block}]
                            [{if $oUnitPrice}]
                                <span id="productPricePerUnit_[{$testid}]" class="pricePerUnit" style="font-size: 12px;">
                                    ([{oxprice price=$oUnitPrice currency=$currency}]/[{$product->getUnitName()}])
                                </span>
                            [{/if}]
                        [{/oxhasrights}]
                    [{/block}]
                        <div class="ampel_list">
                            <div class="ampel_list_ig text-center" style="font-size:11px;margin-top: 5px;">
                                [{if $product->getStockStatus() == -1}]
                                    <span class="stockFlag notOnStock">
                                        <i class="fa fa-circle text-danger"></i>&nbsp;
                                        [{if $product->oxarticles__oxnostocktext->value}]
                                            [{$product->oxarticles__oxnostocktext->value}]
                                        [{elseif $oViewConf->getStockOffDefaultMessage()}]
                                            [{oxmultilang ident="MESSAGE_NOT_ON_STOCK2"}]
                                        [{/if}]
                                    </span>
                                [{elseif $product->getStockStatus() == 1}]
                                    <span class="stockFlag lowStock">
                                        <i class="fa fa-circle text-warning"></i>&nbsp;[{oxmultilang ident="LOW_STOCK"}]
                                    </span>
                                [{elseif $product->getStockStatus() == 0}]
                                    <span class="stockFlag">
                                        <i class="fa fa-circle text-success"></i>&nbsp; 
                                        [{if $product->oxarticles__oxstocktext->value}]
                                            [{$product->oxarticles__oxstocktext->value}]
                                        [{elseif $oViewConf->getStockOnDefaultMessage()}]
                                            [{oxmultilang ident="READY_FOR_SHIPPING"}]
                                        [{/if}]
                                    </span>
                                [{/if}]
                            </div>
                        </div>
                        [{if $product->getStockStatus() != -1}]
                            <div class="value" style="font-size: 12px;">
                                [{ if $product->getAttributes() }] 
                                    [{foreach from=$product->getAttributes() item=oAttr name=attribute}]
                                        [{ if $oAttr->oxattribute__oxtitle->value == "Größe"}]
                                              <span class="listattribut_left">[{ $oAttr->oxattribute__oxtitle->value }]: [{ $oAttr->oxattribute__oxvalue->value|truncate:21:"..." }]</span>
                                          [{else}]
                                          &nbsp;
                                          [{/if}]
                                      [{/foreach}] 
                                [{/if}]
                            </div> 
                        [{/if}]
                </div>
            </div>
            [{*block name="widget_product_listitem_grid_tobasket"}]
                <div class="actions text-center">
                    <div class="btn-group">
                        [{if $blShowToBasket}]
                            [{oxhasrights ident="TOBASKET"}]
                                <button type="submit" class="btn btn-outline-dark hasTooltip" aria-label="[{oxmultilang ident="TO_CART"}]" data-placement="bottom" title="[{oxmultilang ident="TO_CART"}]" data-container="body">
                                    <i class="fa fa-shopping-cart"></i>
                                </button>
                            [{/oxhasrights}]
                            <a class="btn btn-primary" href="[{$_productLink}]" >[{oxmultilang ident="MORE_INFO"}]</a>
                        [{else}]
                            <a class="btn btn-primary" href="[{$_productLink}]" >[{oxmultilang ident="MORE_INFO"}]</a>
                        [{/if}]
                    </div>
                </div>
            [{/block*}]
        </div>
    </form>
[{/block}]