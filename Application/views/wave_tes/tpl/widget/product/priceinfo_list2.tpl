[{assign var="currency" value=$oView->getActCurrency()}]
<div class="row" style="width: 250px;">
    [{foreach from=$product->loadAmountPriceInfo() item=priceItem name=amountPrice}]
        <div class="col-xs-12 col-sm-7">[{oxmultilang ident="FROM"}] [{$priceItem->oxprice2article__oxamount->value}] [{oxmultilang ident="PCS"}]</div>
         <div class="col-xs-12 col-sm-5">
            [{if $priceItem->oxprice2article__oxaddperc->value}]
                [{$priceItem->oxprice2article__oxaddperc->value}]% [{oxmultilang ident="DISCOUNT"}]
            [{else}]
                [{$priceItem->fbrutprice}] [{$currency->sign}]*
            [{/if}]
        </div>
    [{/foreach}]
</div>