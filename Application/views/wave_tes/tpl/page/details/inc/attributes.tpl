<dl class="attributes dl-horizontal">
    <dt id="attrTitle_artnr" class="hasTooltip" title="Artikelnummer" data-placement="right" >Artikelnummer</dt>
    [{*<dd id="attrValue_gewicht">[{$oDetailsProduct->oxarticles__oxartnum->value}]</dd>*}]
    <dt id="attrTitle_gewicht class="hasTooltip" title="Gewicht" data-placement="right" >Gewicht</dt>
    <dd id="attrValue_gewicht">[{$oDetailsProduct->oxarticles__oxweight->value}] Kg</dd>
    [{foreach from=$oView->getAttributes() item=oAttr name=attribute}]
        <dt id="attrTitle_[{$smarty.foreach.attribute.iteration}]" class="hasTooltip" title="[{$oAttr->title}]" data-placement="right" >[{$oAttr->title}]</dt>
        <dd id="attrValue_[{$smarty.foreach.attribute.iteration}]">[{$oAttr->value}]</dd>
    [{/foreach}]
</dl>