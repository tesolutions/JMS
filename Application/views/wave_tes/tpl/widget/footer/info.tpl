[{block name="footer_information"}]
    <ul class="information list-unstyled">
        [{oxifcontent ident="oximpressum" object="_cont"}]
            <li><a href="[{$_cont->getLink()}]">[{$_cont->oxcontents__oxtitle->value}]</a></li>
        [{/oxifcontent}]
        <li><a href="[{ oxgetseourl ident="687e2dfa4c494aa6d384b5884e89877a" type="oxcontent" }]">Disclaimer</a></li>
        [{oxifcontent ident="oxagb" object="_cont"}]
            <li><a href="[{$_cont->getLink()}]">[{$_cont->oxcontents__oxtitle->value}]</a></li>
        [{/oxifcontent}]
        [{oxifcontent ident="oxsecurityinfo" object="oCont"}]
            <li><a href="[{$oCont->getLink()}]">[{$oCont->oxcontents__oxtitle->value}]</a></li>
        [{/oxifcontent}]
        [{oxifcontent ident="oxrightofwithdrawal" object="oCont"}]
            <li><a href="[{$oCont->getLink()}]">[{$oCont->oxcontents__oxtitle->value}]</a></li>
        [{/oxifcontent}]
        [{oxifcontent ident="oxdeliveryinfo" object="oCont"}]
            <li><a href="[{$oCont->getLink()}]">[{$oCont->oxcontents__oxtitle->value}]</a></li>
        [{/oxifcontent}]
        <li><a href="[{ oxgetseourl ident="22467b4fbaca2b478b0b83efea3d916e" type="oxcontent" }]">Länderliste</a></li>
        <li><a href="[{ oxgetseourl ident="ab18jahre" type="oxcontent" }]">Verkauf ab 18</a></li>
        <li><a href="[{ oxgetseourl ident="3de0298813b435c627e8ec9ef5d08c0e" type="oxcontent" }]">Waffenrecht</a></li>
        <li><a href="[{ oxgetseourl ident="batterieverordnung" type="oxcontent" }]">Batterieverordnung</a></li>
        <li><a href="[{ oxgetseourl ident="da66ca8383e1cc891a181dba5730a5ba" type="oxcontent" }]">Gewährleistung</a></li>
        [{oxifcontent ident="oxorderinfo" object="oCont"}]
            <li><a href="[{$oCont->getLink()}]">[{$oCont->oxcontents__oxtitle->value}]</a></li>
        [{/oxifcontent}]
        <li><a href="[{ oxgetseourl ident="dcc28203fa2fe890f2f269ea42507b1e" type="oxcontent" }]">FAQ</a></li>
        
        [{oxifcontent ident="oxcredits" object="oCont"}]
            <li><a href="[{$oCont->getLink()}]">[{$oCont->oxcontents__oxtitle->value}]</a></li>
        [{/oxifcontent}]
         <li><a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=newsletter" }]" rel="nofollow">[{ oxmultilang ident="NEWSLETTER" }]</a></li>
        [{*if $oViewConf->getViewThemeParam('blFooterShowNews')}]
            <li><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=news"}]">[{oxmultilang ident="NEWS"}]</a></li>
        [{/if*}]
    </ul>
[{/block}]