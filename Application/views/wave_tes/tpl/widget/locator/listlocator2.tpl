<div class="refineParams row clear">
    [{if $listDisplayType || $sort || $itemsPerPage}]
        <div class="col options">
            [{if $listDisplayType}]
                [{include file="widget/locator/listdisplaytype.tpl"}]
            [{/if}]

            [{if $sort}]
                [{include file="widget/locator/sort.tpl"}]
            [{/if}]

            [{if $itemsPerPage}]
                [{include file="widget/locator/itemsperpage.tpl"}]
            [{/if}]
        </div>
        <div class="col-12 text-right" style="margin-top: 20px;">
            [{include file="widget/locator/attributes.tpl"}]
        </div>
    [{/if}]
</div>