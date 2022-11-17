[{capture append="oxidBlock_content"}]
    [{assign var="oConfig" value=$oViewConf->getConfig()}]
    [{assign var='rsslinks' value=$oView->getRssLinks()}]
    [{assign var="oTopArticles" value=$oView->getTop5ArticleList()}]

    [{agcms ident="start_top"}]
  
    [{block name="start_bargain_articles"}]
        [{assign var="oBargainArticles" value=$oView->getBargainArticleList()}]
        [{if $oBargainArticles && $oBargainArticles->count()}]
            [{include file="widget/product/list.tpl" type=$oViewConf->getViewThemeParam('sStartPageListDisplayType') head="START_BARGAIN_HEADER"|oxmultilangassign subhead="START_BARGAIN_SUBHEADER"|oxmultilangassign listId="bargainItems" products=$oBargainArticles rsslink=$rsslinks.bargainArticles rssId="rssBargainProducts" showMainLink=true iProductsPerLine=4}]
        [{/if}]
    [{/block}]
    <div class="spacer" style="height: 15px;"></div>
    
    [{block name="start_top_articles"}]
        [{if $oTopArticles && $oTopArticles->count()}]
            [{include file="widget/product/list.tpl" type=$oViewConf->getViewThemeParam('sStartPageListDisplayType') head="START_TOP_PRODUCTS_HEADER"|oxmultilangassign subhead="START_TOP_PRODUCTS_SUBHEADER"|oxmultilangassign:$oTopArticles->count() listId="topBox" products=$oTopArticles rsslink=$rsslinks.topArticles rssId="rssTopProducts" showMainLink=true iProductsPerLine=4}]
        [{/if}]
    [{/block}]
    
    [{block name="start_manufacturer_slider"}]
        [{if $oViewConf->getViewThemeParam('bl_showManufacturerSlider')}]
            <hr>
            [{include file="widget/manufacturersslider.tpl"}]
            <hr>
        [{/if}]
    [{/block}]

    [{*if $oNewestArticles && $oNewestArticles->count() && $oTopArticles && $oTopArticles->count()}]
        <div class="row">
            <hr>
        </div>
    [{/if*}]

    [{block name="start_newest_articles"}]
        [{assign var="oNewestArticles" value=$oView->getNewestArticles()}]
        [{if $oNewestArticles && $oNewestArticles->count()}]
            [{include file="widget/product/list.tpl" type=$oViewConf->getViewThemeParam('sStartPageListDisplayType') head="START_NEWEST_HEADER"|oxmultilangassign subhead="START_NEWEST_SUBHEADER"|oxmultilangassign listId="newItems" products=$oNewestArticles rsslink=$rsslinks.newestArticles rssId="rssNewestProducts" showMainLink=true iProductsPerLine=4}]
        [{/if}]
    [{/block}]

    [{block name="start_welcome_text"}]
        <hr>
        <div class="welcome-teaser" style="padding-top: 20px;">[{agcms ident="startseite_unten"}]</div>
    [{/block}]

    [{insert name="oxid_tracker"}]
[{/capture}]
[{include file="layout/page.tpl"}]