[{assign var="blFirstTab" value=true}]

[{block name="details_tabs_longdescription"}]
    [{oxhasrights ident="SHOWLONGDESCRIPTION"}]
        [{assign var="oLongdesc" value=$oDetailsProduct->getLongDescription()}]
        [{if $oLongdesc->value}]
            [{capture append="tabs"}]<a class="nav-link[{if $blFirstTab}] active[{/if}]" href="#description" data-toggle="tab"><i class="fa fa-book"></i> [{oxmultilang ident="DESCRIPTION"}]</a>[{/capture}]
            [{capture append="tabsContent"}]
                <div id="description" class="tab-pane[{if $blFirstTab}] active[{/if}]" itemprop="description">
                    [{oxeval var=$oLongdesc}]
                    [{if $oDetailsProduct->oxarticles__oxexturl->value}]
                        <a id="productExturl" class="js-external" href="[{$oDetailsProduct->oxarticles__oxexturl->value}]">
                        [{if $oDetailsProduct->oxarticles__oxurldesc->value}]
                            [{$oDetailsProduct->oxarticles__oxurldesc->value}]
                        [{else}]
                            [{$oDetailsProduct->oxarticles__oxexturl->value}]
                        [{/if}]
                        </a>
                    [{/if}]
                    [{assign var="oConfig" value=$oViewConf->getConfig()}]

                    [{*if $oView->getMediaFiles()}]
                        <hr>
                        [{foreach from=$oView->getMediaFiles() item="oMediaUrl" name="mediaURLs"}]
                            [{assign var="sUrl" value=$oMediaUrl->oxmediaurls__oxurl->value}]
                            [{assign var="blIsYouTubeMedia" value=false}]
                            [{if $sUrl|strpos:'youtube.com' || $sUrl|strpos:'youtu.be'}]
                                [{assign var="blIsYouTubeMedia" value=true}]
                            [{/if}]

                            <div class="[{if $blIsYouTubeMedia}]embed-responsive embed-responsive-4by3[{/if}]">
                                [{if $oMediaUrl->oxmediaurls__oxdesc->value == "MP4"}]
                                     <div class="media-file btn btn-default btn-sm btn-block" style="display: block;z-index: 1;line-height: 0;position: relative;">
                                    <video style="width: 100%;height: auto;max-width: 100%;" controls>
                                        <source src="[{$oViewConf->getBaseDir()}]out/media/[{$oMediaUrl->oxmediaurls__oxurl->value}]" type="video/mp4">  
                                    </video>
                                </div>
                                [{else}]
                                    [{if !$smarty.foreach.mediaURLs.first}]
                                        <hr/>
                                    [{/if}]
                                    [{$oMediaUrl->getHtml()}]
                                [{/if}]
                                [{assign var="ozusatzinfo" value=$oDetailsProduct->oxarticles__tes_zusatzinfo->value}]
                                [{oxeval var=$ozusatzinfo}]
                            </div>
                        [{/foreach}]
                    [{/if}]

                    [{if $oDetailsProduct->oxarticles__oxfile->value}]
                        <hr>
                        <a id="productFile" href="[{$oConfig->getPictureUrl('media/')}][{$oDetailsProduct->oxarticles__oxfile->value}]">[{$oDetailsProduct->oxarticles__oxfile->value}]</a>
                    [{/if*}]
                </div>
            [{/capture}]
            [{assign var="blFirstTab" value=false}]
        [{/if}]
    [{/oxhasrights}]
[{/block}]

[{if $oDetailsProduct->oxarticles__articleingredients->value}]
    [{capture append="tabs"}]
    <a class="nav-link[{if $blFirstTab}] active[{/if}]" href="#tab_9" data-toggle="tab">Zutaten & N&auml;hrwertangaben</a>
    [{/capture}]
    [{capture append="tabsContent"}]
    <div id="tab_9" class="tab-pane[{if $blFirstTab}] active[{/if}]">
        [{$oDetailsProduct->oxarticles__articleingredients->value|html_entity_decode }]
        [{oxifcontent ident="8fa4e027c040a83660945daff1e8b8f6" object="oCont"}]
            <hr>[{ oxcontent ident=8fa4e027c040a83660945daff1e8b8f6 }]
        [{/oxifcontent}]
    </div>
    [{assign var="blFirstTab" value=false}]
    [{/capture}]
[{/if }]

[{block name="details_tabs_attributes"}]
    [{if $oView->getAttributes() OR $oView->oxarticles__oxweight->value}]
        [{capture append="tabs"}]<a class="nav-link[{if $blFirstTab}] active[{/if}]" href="#attributes" data-toggle="tab"><i class="fa fa-info"></i> [{oxmultilang ident="SPECIFICATION"}]</a>[{/capture}]
        [{capture append="tabsContent"}]
            <div id="attributes" class="tab-pane[{if $blFirstTab}] active[{/if}]">[{include file="page/details/inc/attributes.tpl"}]</div>
            [{assign var="blFirstTab" value=false}]
        [{/capture}]
    [{/if}]
[{/block}]

[{block name="details_tabs_media"}]
    [{if $oView->getMediaFiles() || $oDetailsProduct->oxarticles__oxfile->value}]
        [{capture append="tabs"}]<a class="nav-link[{if $blFirstTab}] active[{/if}]" href="#media" data-toggle="tab">[{oxmultilang ident="MEDIA"}]</a>[{/capture}]
        [{capture append="tabsContent"}]
            <div id="media" class="tab-pane[{if $blFirstTab}] active[{/if}]">[{include file="page/details/inc/media.tpl"}]</div>
            [{assign var="blFirstTab" value=false}]
        [{/capture}]
    [{/if}]
[{/block}]

[{*if $oViewConf->getViewThemeParam('bl_showPriceAlarm')}]
    [{block name="details_tabs_pricealarm"}]
        [{if $oView->isPriceAlarm() && !$oDetailsProduct->isParentNotBuyable()}]
            [{capture append="tabs"}]<a class="nav-link[{if $blFirstTab}] active[{/if}]" href="#pricealarm" data-toggle="tab">[{oxmultilang ident="PRICE_ALERT"}]</a>[{/capture}]
            [{capture append="tabsContent"}]
                <div id="pricealarm" class="tab-pane[{if $blFirstTab}] active[{/if}]">[{include file="form/pricealarm.tpl"}]</div>
                [{assign var="blFirstTab" value=false}]
            [{/capture}]
        [{/if}]
    [{/block}]
[{/if*}]

[{block name="details_tabs_tags"}]
[{/block}]

[{if $oView->ratingIsActive()}]
    [{capture append="tabs"}]<a class="nav-link[{if $blFirstTab}] active[{/if}]" href="#review" data-toggle="tab"><i class="fa fa-comment"></i> [{oxmultilang ident="DETAILS_PRODUCTREVIEW"}]</a>[{/capture}]
    [{capture append="tabsContent"}]
        <div id="review" class="tab-pane[{if $blFirstTab}] active[{/if}]">
            [{include file="widget/reviews/reviews.tpl"}]
        </div>
        [{assign var="blFirstTab" value=false}]
    [{/capture}]
[{/if}]

[{block name="details_tabs_comments"}]
[{/block}]

[{block name="details_tabs_invite"}]
[{/block}]

[{block name="details_tabs_main"}]
    [{if $tabs}]
        <div class="details-tabs">
            <ul class="nav nav-tabs">
                [{foreach from=$tabs item="tab" name="tabs"}]
                    <li class="nav-item">[{$tab}]</li>
                [{/foreach}]
                [{block name="details_tabs_social_navigation"}][{/block}]
            </ul>
            <div class="tab-content">
                [{foreach from=$tabsContent item="tabContent" name="tabsContent"}]
                    [{$tabContent}]
                [{/foreach}]
                [{block name="details_tabs_social_content"}][{/block}]
            </div>
        </div>
    [{/if}]
[{/block}]

