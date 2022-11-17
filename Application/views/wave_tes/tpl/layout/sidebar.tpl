[{foreach from=$oxidBlock_sidebar item="_block"}]
    [{$_block}]
[{/foreach}]

[{block name="sidebar"}]

    [{block name="sidebar_categoriestree"}]
        [{if $oView->getClassName() == 'alist'}]
            <div class="box categorytree d-none d-lg-block">
                <section>
                    <div class="page-header h3">[{oxmultilang ident="CATEGORIES"}]</div>
                    [{oxid_include_widget cl="oxwCategoryTree" cnid=$oView->getCategoryId() deepLevel=0 noscript=1 nocookie=1}]
                </section>
            </div>
        [{/if}]
    [{/block}]
    
    [{if $oView->getClassName() == 'alist'}]
      <div class="box filter categorytree" style="margin-top: 35px;">
          <section>
            <div class="page-header h3">
                <a class="float-right d-lg-none" data-toggle="collapse" role="button" href="#collapseNav" aria-expanded="true" aria-controls="collapseNav">
                    <i class="fa fa-caret-up toggleTree"></i>
                </a>
                Ansicht & Filter
            </div>
            <div class="collapse show" id="collapseNav" style="padding-bottom:20px;">
                [{include file="widget/locator/listlocator2.tpl" locator=$oView->getPageNavigationLimitedTop() attributes=$oView->getAttributes() listDisplayType=true itemsPerPage=true sort=true}]
            </div>
          </section>
      </div>
    [{/if}]

    [{if $oView->getClassName() == "alist" && $actCategory->oxcategories__oxlongdesc2->value}]
        <div class="box sidebarcontent d-none d-lg-block">
            <section>
                <div class="page-header h3">Beschreibung</div>
            <div class="content">
                [{oxeval var=$actCategory->oxcategories__oxlongdesc2}]
            </div>
        </div>
    [{/if}]
    
    [{*Spezial*}]
    [{if $oView->getClassName() == 'alist' }]
    [{oxifcontent ident="sidebarbox" object="oCont"}]
    [{assign var="title" value=$oCont->oxcontents__oxtitle->value}]
    <div class="box sidebarcontent d-none d-lg-block">
        <section>
            <div class="page-header h3">[{$title}]</div>
            [{ oxcontent ident=sidebarbox }]
        </section>
    </div>
    [{/oxifcontent}]
    [{/if}]
    
    [{*if $oView->getClassName() == 'alist' OR $oView->getClassName() == 'oetagstagcontroller'}]
        <div class="box d-none d-lg-block">
            <section>
                <div class="page-header h3">[{oxmultilang ident="DD_SIDEBAR_TAGCLOUD"}]</div>
                [{oxid_include_widget cl="oetagsTagCloudWidget" nocookie=1 noscript=1}]
            </section>
        </div>
    [{/if*}]

    [{block name="sidebar_boxproducts"}][{/block}]

    [{*block name="sidebar_recommendation"}]
        [{if $oViewConf->getShowListmania() && $oView->getSimilarRecommListIds()}]
            [{oxid_include_widget nocookie=1 cl="oxwRecommendation" aArticleIds=$oView->getSimilarRecommListIds() searchrecomm=$oView->getRecommSearch()}]
        [{elseif $oViewConf->getShowListmania() && $oView->getRecommSearch()}]
            [{oxid_include_widget nocookie=1 cl="oxwRecommendation" _parent=$oView->getClassName() searchrecomm=$oView->getRecommSearch()}]
        [{/if}]
    [{/block*}]

    [{*block name="sidebar_news"}]
        [{if $oxcmp_news}]
            [{if $oxcmp_news|count}]
                [{include file="widget/sidebar/news.tpl" oNews=$oxcmp_news}]
            [{/if}]
        [{/if}]
    [{/block}]

    [{block name="sidebar_social"}]
    [{/block}]

    [{block name="sidebar_shopluperatings"}]
        [{if $oView->getClassName() eq "start"}]
           [{include file="widget/shoplupe/ratings.tpl"}]
        [{/if}]
    [{/block*}]
[{/block}]