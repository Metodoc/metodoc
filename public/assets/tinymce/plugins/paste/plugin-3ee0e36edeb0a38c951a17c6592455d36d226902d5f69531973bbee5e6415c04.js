!function(e,t){"use strict";function n(e,t){for(var n,i=[],a=0;a<e.length;++a){if(n=o[e[a]]||r(e[a]),!n)throw"module definition dependecy not found: "+e[a];i.push(n)}t.apply(null,i)}function i(e,i,r){if("string"!=typeof e)throw"invalid module definition, module id must be defined and be a string";if(i===t)throw"invalid module definition, dependencies must be specified";if(r===t)throw"invalid module definition, definition function must be specified";n(i,function(){o[e]=r.apply(null,arguments)})}function r(t){for(var n=e,i=t.split(/[.\/]/),r=0;r<i.length;++r){if(!n[i[r]])return;n=n[i[r]]}return n}function a(n){var i,r,a,s,l;for(i=0;i<n.length;i++){r=e,a=n[i],s=a.split(/[.\/]/);for(var u=0;u<s.length-1;++u)r[s[u]]===t&&(r[s[u]]={}),r=r[s[u]];r[s[s.length-1]]=o[a]}if(e.AMDLC_TESTS){l=e.privateModules||{};for(a in o)l[a]=o[a];for(i=0;i<n.length;i++)delete l[n[i]];e.privateModules=l}}var o={};i("tinymce/pasteplugin/Utils",["tinymce/util/Tools","tinymce/html/DomParser","tinymce/html/Schema"],function(e,t,n){function i(t,n){return e.each(n,function(e){t=e.constructor==RegExp?t.replace(e,""):t.replace(e[0],e[1])}),t}function r(r){function a(e){var t=e.name,n=e;if("br"===t)return void(l+="\n");if(u[t]&&(l+=" "),c[t])return void(l+=" ");if(3==e.type&&(l+=e.value),!e.shortEnded&&(e=e.firstChild))do a(e);while(e=e.next);f[t]&&n.next&&(l+="\n","p"==t&&(l+="\n"))}var o=new n,s=new t({},o),l="",u=o.getShortEndedElements(),c=e.makeMap("script noscript style textarea video audio iframe object"," "),f=o.getBlockElements();return r=i(r,[/<!\[[^\]]+\]>/g]),a(s.parse(r)),l}function a(e){function t(e,t,n){return t||n?"\xa0":" "}return e=i(e,[/^[\s\S]*<body[^>]*>\s*|\s*<\/body[^>]*>[\s\S]*$/g,/<!--StartFragment-->|<!--EndFragment-->/g,[/( ?)<span class="Apple-converted-space">\u00a0<\/span>( ?)/g,t],/<br class="Apple-interchange-newline">/g,/<br>$/i])}function o(e){var t=0;return function(){return e+t++}}return{filter:i,innerText:r,trimHtml:a,createIdGenerator:o}}),i("tinymce/pasteplugin/SmartPaste",["tinymce/util/Tools"],function(e){var t=function(e){return/^https?:\/\/[\w\?\-\/+=.&%@~#]+$/i.test(e)},n=function(e){return t(e)&&/.(gif|jpe?g|png)$/.test(e)},i=function(e,t,n){return e.undoManager.extra(function(){n(e,t)},function(){e.insertContent('<img src="'+t+'">')}),!0},r=function(e,t,n){return e.undoManager.extra(function(){n(e,t)},function(){e.execCommand("mceInsertLink",!1,t)}),!0},a=function(e,n,i){return!(e.selection.isCollapsed()!==!1||!t(n))&&r(e,n,i)},o=function(e,t,r){return!!n(t)&&i(e,t,r)},s=function(e,t){return e.insertContent(t,{merge:e.settings.paste_merge_formats!==!1,paste:!0}),!0},l=function(t,n){e.each([a,o,s],function(e){return e(t,n,s)!==!0})},u=function(e,t){e.settings.smart_paste===!1?s(e,t):l(e,t)};return{isImageUrl:n,isAbsoluteUrl:t,insertContent:u}}),i("tinymce/pasteplugin/Clipboard",["tinymce/Env","tinymce/dom/RangeUtils","tinymce/util/VK","tinymce/pasteplugin/Utils","tinymce/pasteplugin/SmartPaste","tinymce/util/Delay"],function(e,t,n,i,r,a){return function(o){function s(e){var t,n=o.dom;if(t=o.fire("BeforePastePreProcess",{content:e}),t=o.fire("PastePreProcess",t),e=t.content,!t.isDefaultPrevented()){if(o.hasEventListeners("PastePostProcess")&&!t.isDefaultPrevented()){var i=n.add(o.getBody(),"div",{style:"display:none"},e);t=o.fire("PastePostProcess",{node:i}),n.remove(i),e=t.node.innerHTML}t.isDefaultPrevented()||r.insertContent(o,e)}}function l(e){e=o.dom.encode(e).replace(/\r\n/g,"\n");var t,n=o.dom.getParent(o.selection.getStart(),o.dom.isBlock),r=o.settings.forced_root_block;r&&(t=o.dom.createHTML(r,o.settings.forced_root_block_attrs),t=t.substr(0,t.length-3)+">"),n&&/^(PRE|DIV)$/.test(n.nodeName)||!r?e=i.filter(e,[[/\n/g,"<br>"]]):(e=i.filter(e,[[/\n\n/g,"</p>"+t],[/^(.*<\/p>)(<p>)$/,t+"$1"],[/\n/g,"<br />"]]),e.indexOf("<p>")!=-1&&(e=t+e)),s(e)}function u(){function t(e){var t,n,r,a=e.startContainer;if(t=e.getClientRects(),t.length)return t[0];if(e.collapsed&&1==a.nodeType){for(r=a.childNodes[k.startOffset];r&&3==r.nodeType&&!r.data.length;)r=r.nextSibling;if(r)return"BR"==r.tagName&&(n=i.doc.createTextNode("\ufeff"),r.parentNode.insertBefore(n,r),e=i.createRng(),e.setStartBefore(n),e.setEndAfter(n),t=e.getClientRects(),i.remove(n)),t.length?t[0]:void 0}}var n,i=o.dom,r=o.getBody(),a=o.dom.getViewPort(o.getWin()),s=a.y,l=20;if(k=o.selection.getRng(),o.inline&&(n=o.selection.getScrollContainer(),n&&n.scrollTop>0&&(s=n.scrollTop)),k.getClientRects){var u=t(k);if(u)l=s+(u.top-i.getPos(r).y);else{l=s;var c=k.startContainer;c&&(3==c.nodeType&&c.parentNode!=r&&(c=c.parentNode),1==c.nodeType&&(l=i.getPos(c,n||r).y))}}C=i.add(o.getBody(),"div",{id:"mcepastebin",contentEditable:!0,"data-mce-bogus":"all",style:"position: absolute; top: "+l+"px;width: 10px; height: 10px; overflow: hidden; opacity: 0"},S),(e.ie||e.gecko)&&i.setStyle(C,"left","rtl"==i.getStyle(r,"direction",!0)?65535:-65535),i.bind(C,"beforedeactivate focusin focusout",function(e){e.stopPropagation()}),C.focus(),o.selection.select(C,!0)}function c(){if(C){for(var e;e=o.dom.get("mcepastebin");)o.dom.remove(e),o.dom.unbind(e);k&&o.selection.setRng(k)}C=k=null}function f(){var e,t,n,i,r="";for(e=o.dom.select("div[id=mcepastebin]"),t=0;t<e.length;t++)n=e[t],n.firstChild&&"mcepastebin"==n.firstChild.id&&(n=n.firstChild),i=n.innerHTML,r!=S&&(r+=i);return r}function d(e){var t={};if(e){if(e.getData){var n=e.getData("Text");n&&n.length>0&&n.indexOf(M)==-1&&(t["text/plain"]=n)}if(e.types)for(var i=0;i<e.types.length;i++){var r=e.types[i];t[r]=e.getData(r)}}return t}function p(e){return d(e.clipboardData||o.getDoc().dataTransfer)}function g(e){return w(e,"text/html")||w(e,"text/plain")}function m(e){var t;return t=e.indexOf(","),t!==-1?e.substr(t+1):null}function v(e,t){return!e.images_dataimg_filter||e.images_dataimg_filter(t)}function h(e,t,n){e&&(o.selection.setRng(e),e=null);var i=t.result,r=m(i),a=new Image;if(a.src=i,v(o.settings,a)){var l,u,c=o.editorUpload.blobCache;u=c.findFirst(function(e){return e.base64()===r}),u?l=u:(l=c.create(E(),n,r),c.add(l)),s('<img src="'+l.blobUri()+'">')}else s('<img src="'+i+'">')}function y(e,t){function n(n){var i,r,a,o=!1;if(n)for(i=0;i<n.length;i++)if(r=n[i],/^image\/(jpeg|png|gif|bmp)$/.test(r.type)){var s=r.getAsFile?r.getAsFile():r;a=new FileReader,a.onload=h.bind(null,t,a,s),a.readAsDataURL(s),e.preventDefault(),o=!0}return o}var i=e.clipboardData||e.dataTransfer;if(o.settings.paste_data_images&&i)return n(i.items)||n(i.files)}function b(e){var t=e.clipboardData;return navigator.userAgent.indexOf("Android")!=-1&&t&&t.items&&0===t.items.length}function x(e){return t.getCaretRangeFromPoint(e.clientX,e.clientY,o.getDoc())}function w(e,t){return t in e&&e[t].length>0}function P(e){return n.metaKeyPressed(e)&&86==e.keyCode||e.shiftKey&&45==e.keyCode}function _(){function t(e,t,n){var r;return w(e,"text/html")?r=e["text/html"]:(r=f(),r==S&&(n=!0)),r=i.trimHtml(r),C&&C.firstChild&&"mcepastebin"===C.firstChild.id&&(n=!0),c(),r.length||(n=!0),n&&(r=w(e,"text/plain")&&r.indexOf("</p>")==-1?e["text/plain"]:i.innerText(r)),r==S?void(t||o.windowManager.alert("Please use Ctrl+V/Cmd+V keyboard shortcuts to paste contents.")):void(n?l(r):s(r))}function n(e){var t=e["text/plain"];return!!t&&0===t.indexOf("file://")}o.on("keydown",function(t){function n(e){P(e)&&!e.isDefaultPrevented()&&c()}if(P(t)&&!t.isDefaultPrevented()){if(T=t.shiftKey&&86==t.keyCode,T&&e.webkit&&navigator.userAgent.indexOf("Version/")!=-1)return;if(t.stopImmediatePropagation(),F=(new Date).getTime(),e.ie&&T)return t.preventDefault(),void o.fire("paste",{ieFake:!0});c(),u(),o.once("keyup",n),o.once("paste",function(){o.off("keyup",n)})}});var r=function(){return k||o.selection.getRng()};o.on("paste",function(n){var i=(new Date).getTime(),s=p(n),l=(new Date).getTime()-i,d=(new Date).getTime()-F-l<1e3,m="text"==D.pasteFormat||T;return T=!1,n.isDefaultPrevented()||b(n)?void c():!g(s)&&y(n,r())?void c():(d||n.preventDefault(),!e.ie||d&&!n.ieFake||(u(),o.dom.bind(C,"paste",function(e){e.stopPropagation()}),o.getDoc().execCommand("Paste",!1,null),s["text/html"]=f()),void(w(s,"text/html")?(n.preventDefault(),t(s,d,m)):a.setEditorTimeout(o,function(){t(s,d,m)},0)))}),o.on("dragstart dragend",function(e){R="dragstart"==e.type}),o.on("drop",function(e){var t,r;if(r=x(e),!e.isDefaultPrevented()&&!R&&(t=d(e.dataTransfer),(g(t)&&!n(t)||!y(e,r))&&r&&o.settings.paste_filter_drop!==!1)){var u=t["mce-internal"]||t["text/html"]||t["text/plain"];u&&(e.preventDefault(),a.setEditorTimeout(o,function(){o.undoManager.transact(function(){t["mce-internal"]&&o.execCommand("Delete"),o.selection.setRng(r),u=i.trimHtml(u),t["text/html"]?s(u):l(u)})}))}}),o.on("dragover dragend",function(e){o.settings.paste_data_images&&e.preventDefault()})}var C,k,T,D=this,F=0,R=!1,S="%MCEPASTEBIN%",M="data:text/mce-internal,",E=i.createIdGenerator("mceclip");D.pasteHtml=s,D.pasteText=l,D.pasteImageData=y,o.on("preInit",function(){_(),o.parser.addNodeFilter("img",function(t,n,i){function r(e){return e.data&&e.data.paste===!0}function a(t){t.attr("data-mce-object")||c===e.transparentSrc||t.remove()}function s(e){return 0===e.indexOf("webkit-fake-url")}function l(e){return 0===e.indexOf("data:")}if(!o.settings.paste_data_images&&r(i))for(var u=t.length;u--;){var c=t[u].attributes.map.src;c&&(s(c)?a(t[u]):!o.settings.allow_html_data_urls&&l(c)&&a(t[u]))}})})}}),i("tinymce/pasteplugin/WordFilter",["tinymce/util/Tools","tinymce/html/DomParser","tinymce/html/Schema","tinymce/html/Serializer","tinymce/html/Node","tinymce/pasteplugin/Utils"],function(e,t,n,i,r,a){function o(e){return/<font face="Times New Roman"|class="?Mso|style="[^"]*\bmso-|style='[^'']*\bmso-|w:WordDocument/i.test(e)||/class="OutlineElement/.test(e)||/id="?docs\-internal\-guid\-/.test(e)}function s(t){var n,i;return i=[/^[IVXLMCD]{1,2}\.[ \u00a0]/,/^[ivxlmcd]{1,2}\.[ \u00a0]/,/^[a-z]{1,2}[\.\)][ \u00a0]/,/^[A-Z]{1,2}[\.\)][ \u00a0]/,/^[0-9]+\.[ \u00a0]/,/^[\u3007\u4e00\u4e8c\u4e09\u56db\u4e94\u516d\u4e03\u516b\u4e5d]+\.[ \u00a0]/,/^[\u58f1\u5f10\u53c2\u56db\u4f0d\u516d\u4e03\u516b\u4e5d\u62fe]+\.[ \u00a0]/],t=t.replace(/^[\u00a0 ]+/,""),e.each(i,function(e){if(e.test(t))return n=!0,!1}),n}function l(e){return/^[\s\u00a0]*[\u2022\u00b7\u00a7\u25CF]\s*/.test(e)}function u(u){var c=u.settings;u.on("BeforePastePreProcess",function(f){function d(e){function t(e){var n="";if(3===e.type)return e.value;if(e=e.firstChild)do n+=t(e);while(e=e.next);return n}function n(e,t){if(3===e.type&&t.test(e.value))return e.value=e.value.replace(t,""),!1;if(e=e.firstChild)do if(!n(e,t))return!1;while(e=e.next);return!0}function i(e){if(e._listIgnore)return void e.remove();if(e=e.firstChild)do i(e);while(e=e.next)}function a(e,t,a){var s=e._listLevel||c;s!=c&&(s<c?o&&(o=o.parent.parent):(u=o,o=null)),o&&o.name==t?o.append(e):(u=u||o,o=new r(t,1),a>1&&o.attr("start",""+a),e.wrap(o)),e.name="li",s>c&&u&&u.lastChild.append(o),c=s,i(e),n(e,/^\u00a0+/),n(e,/^\s*([\u2022\u00b7\u00a7\u25CF]|\w+\.)/),n(e,/^\u00a0+/)}for(var o,u,c=1,f=[],d=e.firstChild;"undefined"!=typeof d&&null!==d;)if(f.push(d),d=d.walk(),null!==d)for(;"undefined"!=typeof d&&d.parent!==e;)d=d.walk();for(var p=0;p<f.length;p++)if(e=f[p],"p"==e.name&&e.firstChild){var g=t(e);if(l(g)){a(e,"ul");continue}if(s(g)){var m=/([0-9]+)\./.exec(g),v=1;m&&(v=parseInt(m[1],10)),a(e,"ol",v);continue}if(e._listLevel){a(e,"ul",1);continue}o=null}else u=o,o=null}function p(t,n){var i,a={},o=u.dom.parseStyle(n);return e.each(o,function(e,r){switch(r){case"mso-list":i=/\w+ \w+([0-9]+)/i.exec(n),i&&(t._listLevel=parseInt(i[1],10)),/Ignore/i.test(e)&&t.firstChild&&(t._listIgnore=!0,t.firstChild._listIgnore=!0);break;case"horiz-align":r="text-align";break;case"vert-align":r="vertical-align";break;case"font-color":case"mso-foreground":r="color";break;case"mso-background":case"mso-highlight":r="background";break;case"font-weight":case"font-style":return void("normal"!=e&&(a[r]=e));case"mso-element":if(/^(comment|comment-list)$/i.test(e))return void t.remove()}return 0===r.indexOf("mso-comment")?void t.remove():void(0!==r.indexOf("mso-")&&("all"==g||m&&m[r])&&(a[r]=e))}),/(bold)/i.test(a["font-weight"])&&(delete a["font-weight"],t.wrap(new r("b",1))),/(italic)/i.test(a["font-style"])&&(delete a["font-style"],t.wrap(new r("i",1))),a=u.dom.serializeStyle(a,t.name),a?a:null}var g,m,v=f.content;if(v=v.replace(/<b[^>]+id="?docs-internal-[^>]*>/gi,""),v=v.replace(/<br class="?Apple-interchange-newline"?>/gi,""),g=c.paste_retain_style_properties,g&&(m=e.makeMap(g.split(/[, ]/))),c.paste_enable_default_filters!==!1&&o(f.content)){f.wordContent=!0,v=a.filter(v,[/<!--[\s\S]+?-->/gi,/<(!|script[^>]*>.*?<\/script(?=[>\s])|\/?(\?xml(:\w+)?|img|meta|link|style|\w:\w+)(?=[\s\/>]))[^>]*>/gi,[/<(\/?)s>/gi,"<$1strike>"],[/&nbsp;/gi,"\xa0"],[/<span\s+style\s*=\s*"\s*mso-spacerun\s*:\s*yes\s*;?\s*"\s*>([\s\u00a0]*)<\/span>/gi,function(e,t){return t.length>0?t.replace(/./," ").slice(Math.floor(t.length/2)).split("").join("\xa0"):""}]]);var h=c.paste_word_valid_elements;h||(h="-strong/b,-em/i,-u,-span,-p,-ol,-ul,-li,-h1,-h2,-h3,-h4,-h5,-h6,-p/div,-a[href|name],sub,sup,strike,br,del,table[width],tr,td[colspan|rowspan|width],th[colspan|rowspan|width],thead,tfoot,tbody");var y=new n({valid_elements:h,valid_children:"-li[p]"});e.each(y.elements,function(e){e.attributes["class"]||(e.attributes["class"]={},e.attributesOrder.push("class")),e.attributes.style||(e.attributes.style={},e.attributesOrder.push("style"))});var b=new t({},y);b.addAttributeFilter("style",function(e){for(var t,n=e.length;n--;)t=e[n],t.attr("style",p(t,t.attr("style"))),"span"==t.name&&t.parent&&!t.attributes.length&&t.unwrap()}),b.addAttributeFilter("class",function(e){for(var t,n,i=e.length;i--;)t=e[i],n=t.attr("class"),/^(MsoCommentReference|MsoCommentText|msoDel)$/i.test(n)&&t.remove(),t.attr("class",null)}),b.addNodeFilter("del",function(e){for(var t=e.length;t--;)e[t].remove()}),b.addNodeFilter("a",function(e){for(var t,n,i,r=e.length;r--;)if(t=e[r],n=t.attr("href"),i=t.attr("name"),n&&n.indexOf("#_msocom_")!=-1)t.remove();else if(n&&0===n.indexOf("file://")&&(n=n.split("#")[1],n&&(n="#"+n)),n||i){if(i&&!/^_?(?:toc|edn|ftn)/i.test(i)){t.unwrap();continue}t.attr({href:n,name:i})}else t.unwrap()});var x=b.parse(v);c.paste_convert_word_fake_lists!==!1&&d(x),f.content=new i({validate:c.validate},y).serialize(x)}})}return u.isWordContent=o,u}),i("tinymce/pasteplugin/Quirks",["tinymce/Env","tinymce/util/Tools","tinymce/pasteplugin/WordFilter","tinymce/pasteplugin/Utils"],function(e,t,n,i){return function(r){function a(e){r.on("BeforePastePreProcess",function(t){t.content=e(t.content)})}function o(e){if(!n.isWordContent(e))return e;var a=[];t.each(r.schema.getBlockElements(),function(e,t){a.push(t)});var o=new RegExp("(?:<br>&nbsp;[\\s\\r\\n]+|<br>)*(<\\/?("+a.join("|")+")[^>]*>)(?:<br>&nbsp;[\\s\\r\\n]+|<br>)*","g");return e=i.filter(e,[[o,"$1"]]),e=i.filter(e,[[/<br><br>/g,"<BR><BR>"],[/<br>/g," "],[/<BR><BR>/g,"<br>"]])}function s(e){if(n.isWordContent(e))return e;var t=r.settings.paste_webkit_styles;if(r.settings.paste_remove_styles_if_webkit===!1||"all"==t)return e;if(t&&(t=t.split(/[, ]/)),t){var i=r.dom,a=r.selection.getNode();e=e.replace(/(<[^>]+) style="([^"]*)"([^>]*>)/gi,function(e,n,r,o){var s=i.parseStyle(r,"span"),l={};if("none"===t)return n+o;for(var u=0;u<t.length;u++){var c=s[t[u]],f=i.getStyle(a,t[u],!0);/color/.test(t[u])&&(c=i.toHex(c),f=i.toHex(f)),f!=c&&(l[t[u]]=c)}return l=i.serializeStyle(l,"span"),l?n+' style="'+l+'"'+o:n+o})}else e=e.replace(/(<[^>]+) style="([^"]*)"([^>]*>)/gi,"$1$3");return e=e.replace(/(<[^>]+) data-mce-style="([^"]+)"([^>]*>)/gi,function(e,t,n,i){return t+' style="'+n+'"'+i})}e.webkit&&a(s),e.ie&&a(o)}}),i("tinymce/pasteplugin/Plugin",["tinymce/PluginManager","tinymce/pasteplugin/Clipboard","tinymce/pasteplugin/WordFilter","tinymce/pasteplugin/Quirks"],function(e,t,n,i){var r;e.add("paste",function(a){function o(){return r||a.settings.paste_plaintext_inform===!1}function s(){if("text"==u.pasteFormat)u.pasteFormat="html",a.fire("PastePlainTextToggle",{state:!1});else if(u.pasteFormat="text",a.fire("PastePlainTextToggle",{state:!0}),!o()){var e=a.translate("Paste is now in plain text mode. Contents will now be pasted as plain text until you toggle this option off.");a.notificationManager.open({text:e,type:"info"}),r=!0}a.focus()}function l(){var e=this;e.active("text"===u.pasteFormat),a.on("PastePlainTextToggle",function(t){e.active(t.state)})}var u,c=this,f=a.settings;return/(^|[ ,])powerpaste([, ]|$)/.test(f.plugins)&&e.get("powerpaste")?void("undefined"!=typeof console&&console.log&&console.log("PowerPaste is incompatible with Paste plugin! Remove 'paste' from the 'plugins' option.")):(c.clipboard=u=new t(a),c.quirks=new i(a),c.wordFilter=new n(a),a.settings.paste_as_text&&(c.clipboard.pasteFormat="text"),f.paste_preprocess&&a.on("PastePreProcess",function(e){f.paste_preprocess.call(c,c,e)}),f.paste_postprocess&&a.on("PastePostProcess",function(e){f.paste_postprocess.call(c,c,e)}),a.addCommand("mceInsertClipboardContent",function(e,t){t.content&&c.clipboard.pasteHtml(t.content),t.text&&c.clipboard.pasteText(t.text)}),a.settings.paste_block_drop&&a.on("dragend dragover draggesture dragdrop drop drag",function(e){e.preventDefault(),e.stopPropagation()}),a.settings.paste_data_images||a.on("drop",function(e){var t=e.dataTransfer;t&&t.files&&t.files.length>0&&e.preventDefault()}),a.addCommand("mceTogglePlainTextPaste",s),a.addButton("pastetext",{icon:"pastetext",tooltip:"Paste as text",onclick:s,onPostRender:l}),void a.addMenuItem("pastetext",{text:"Paste as text",selectable:!0,active:u.pasteFormat,onclick:s,onPostRender:l}))})}),a(["tinymce/pasteplugin/Utils"])}(window);