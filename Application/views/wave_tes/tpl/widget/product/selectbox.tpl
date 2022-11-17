[{assign var="oSelections" value=$oSelectionList->getSelections()}]

[{if $oSelections}]
    <div class="form-group dropDown">
        [{if !$blHideLabel}]
            <p class="variant-label"><strong>[{$oSelectionList->getLabel()}][{oxmultilang ident="COLON"}]</strong></p>
        [{/if}]
        <div class="dropdown">
            <button type="button" class="btn btn-outline-dark btn-sm dropdown-toggle" data-toggle="dropdown" style="min-width: 160px;">
                [{assign var="oActiveSelection" value=$oSelectionList->getActiveSelection()}]
                [{if $oActiveSelection}]
                    <span class="float-left" style="min-width: 150px;">[{$oActiveSelection->getName()}]</span>
                [{elseif !$blHideDefault}]
                    <span class="float-left" style="min-width: 150px;">
                        [{if $sFieldName == "sel"}]
                            [{oxmultilang ident="PLEASE_CHOOSE"}]
                        [{else}]
                            [{$oSelectionList->getLabel()}] [{oxmultilang ident="CHOOSE_VARIANT"}]
                        [{/if}]
                    </span>
                [{/if}]
            </button>
            [{if $editable !== false}]
                <input type="hidden" name="[{$sFieldName|default:"varselid"}][[{$iKey}]]" value="[{if $oActiveSelection}][{$oActiveSelection->getValue()}][{/if}]">
                <ul class="dropdown-menu [{$sJsAction}][{if $sFieldName != "sel"}] vardrop[{/if}]" role="menu">
                    [{if $oActiveSelection && !$blHideDefault}]
                        <li class="dropdown-menu-item">
                            <a href="#" rel="" class="dropdown-menu-link">
                                [{if $sFieldName == "sel"}]
                                    [{oxmultilang ident="PLEASE_CHOOSE"}]
                                [{else}]
                                    [{oxmultilang ident="CHOOSE_VARIANT"}]
                                [{/if}]
                            </a>
                        </li>
                    [{/if}]
                    [{foreach from=$oSelections item=oSelection}]
                        <li class="dropdown-menu-item[{if $oSelection->isDisabled()}] disabled js-disabled[{/if}]">
                            <a href="[{$oSelection->getLink()}]" data-selection-id="[{$oSelection->getValue()}]" class="dropdown-menu-link[{if $oSelection->isActive()}] active[{/if}]">[{$oSelection->getName()}]</a>
                        </li>
                    [{/foreach}]
                </ul>
            [{/if}]
            [{if $oActiveSelection}]
                [{assign var="oParentProduct" value=$oDetailsProduct->getParentArticle()}]
                [{assign var="vater" value=$oParentProduct->getLink()}]
                <div style="margin-top: -0.5rem;">
                    test
                  <a href="[{$vater}]" class="reset" style="color: red;">Auswahl zurücksetzen</a>
                </div>
            [{/if}]
        </div>
    </div>
[{/if}]