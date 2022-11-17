[{oxscript add="$('a.js-external').attr('target', '_blank');"}]
[{if $oDetailsProduct->oxarticles__oxfile->value}]
  <a id="productFile" class="js-external" href="[{$oDetailsProduct->getFileUrl()}][{$oDetailsProduct->oxarticles__oxfile->value}]">[{$oDetailsProduct->oxarticles__oxfile->value}]</a>
[{/if}]

[{if $oView->getMediaFiles()}]
  <div>
    [{foreach from=$oView->getMediaFiles() item=oMediaUrl}]
      <p style="font-size: 90%; margin-bottom: 3px;"><i class="fa fa-file-pdf" style="padding: 6px 3px 2px;"></i>[{$oMediaUrl->getHtml()}]</p>
    [{/foreach}]
  </div>
[{/if}]