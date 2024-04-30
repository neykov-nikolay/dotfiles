/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */const t=globalThis,e=t.trustedTypes,i=e?e.createPolicy("lit-html",{createHTML:t=>t}):void 0,s="$lit$",n=`lit$${(Math.random()+"").slice(9)}$`,r="?"+n,o=`<${r}>`,h=document,l=()=>h.createComment(""),a=t=>null===t||"object"!=typeof t&&"function"!=typeof t,$=Array.isArray,c=t=>$(t)||"function"==typeof t?.[Symbol.iterator],p="[ 	\n\f\r]",d=/<(?:(!--|\/[^a-zA-Z])|(\/?[a-zA-Z][^>\s]*)|(\/?$))/g,u=/-->/g,A=/>/g,g=RegExp(`>|${p}(?:([^\\s"'>=/]+)(${p}*=${p}*(?:[^ 	
\f\r"'\`<>=]|("|')|))|$)`,"g"),_=/'/g,v=/"/g,f=/^(?:script|style|textarea|title)$/i,m=t=>(e,...i)=>({_$litType$:t,strings:e,values:i}),y=m(1),x=(m(2),Symbol.for("lit-noChange")),w=Symbol.for("lit-nothing"),b=new WeakMap,H=h.createTreeWalker(h,129);function N(t,e){if(!Array.isArray(t)||!t.hasOwnProperty("raw"))throw Error("invalid template strings array");return void 0!==i?i.createHTML(e):e}const M=(t,e)=>{let i=t.length-1,r=[],h,l=2===e?"<svg>":"",a=d;for(let e=0;e<i;e++){let i=t[e],$,c,p=-1,m=0;for(;m<i.length&&(a.lastIndex=m,null!==(c=a.exec(i)));)m=a.lastIndex,a===d?"!--"===c[1]?a=u:void 0!==c[1]?a=A:void 0!==c[2]?(f.test(c[2])&&(h=RegExp("</"+c[2],"g")),a=g):void 0!==c[3]&&(a=g):a===g?">"===c[0]?(a=h??d,p=-1):void 0===c[1]?p=-2:(p=a.lastIndex-c[2].length,$=c[1],a=void 0===c[3]?g:'"'===c[3]?v:_):a===v||a===_?a=g:a===u||a===A?a=d:(a=g,h=void 0);let y=a===g&&t[e+1].startsWith("/>")?" ":"";l+=a===d?i+o:p>=0?(r.push($),i.slice(0,p)+s+i.slice(p)+n+y):i+n+(-2===p?e:y)}return[N(t,l+(t[i]||"<?>")+(2===e?"</svg>":"")),r]};class T{constructor({strings:t,_$litType$:i},o){let h;this.parts=[];let a=0,$=0,c=t.length-1,p=this.parts,[d,u]=M(t,i);if(this.el=T.createElement(d,o),H.currentNode=this.el.content,2===i){let t=this.el.content.firstChild;t.replaceWith(...t.childNodes)}for(;null!==(h=H.nextNode())&&p.length<c;){if(1===h.nodeType){if(h.hasAttributes())for(let t of h.getAttributeNames())if(t.endsWith(s)){let e=u[$++],i=h.getAttribute(t).split(n),s=/([.?@])?(.*)/.exec(e);p.push({type:1,index:a,name:s[2],strings:i,ctor:"."===s[1]?U:"?"===s[1]?B:"@"===s[1]?I:L}),h.removeAttribute(t)}else t.startsWith(n)&&(p.push({type:6,index:a}),h.removeAttribute(t));if(f.test(h.tagName)){let t=h.textContent.split(n),i=t.length-1;if(i>0){h.textContent=e?e.emptyScript:"";for(let e=0;e<i;e++)h.append(t[e],l()),H.nextNode(),p.push({type:2,index:++a});h.append(t[i],l())}}}else if(8===h.nodeType){if(h.data===r)p.push({type:2,index:a});else{let t=-1;for(;-1!==(t=h.data.indexOf(n,t+1));)p.push({type:7,index:a}),t+=n.length-1}}a++}}static createElement(t,e){let i=h.createElement("template");return i.innerHTML=t,i}}function C(t,e,i=t,s){if(e===x)return e;let n=void 0!==s?i._$Co?.[s]:i._$Cl,r=a(e)?void 0:e._$litDirective$;return n?.constructor!==r&&(n?._$AO?.(!1),void 0===r?n=void 0:(n=new r(t))._$AT(t,i,s),void 0!==s?(i._$Co??=[])[s]=n:i._$Cl=n),void 0!==n&&(e=C(t,n._$AS(t,e.values),n,s)),e}class S{constructor(t,e){this._$AV=[],this._$AN=void 0,this._$AD=t,this._$AM=e}get parentNode(){return this._$AM.parentNode}get _$AU(){return this._$AM._$AU}u(t){let{el:{content:e},parts:i}=this._$AD,s=(t?.creationScope??h).importNode(e,!0);H.currentNode=s;let n=H.nextNode(),r=0,o=0,l=i[0];for(;void 0!==l;){if(r===l.index){let e;2===l.type?e=new E(n,n.nextSibling,this,t):1===l.type?e=new l.ctor(n,l.name,l.strings,this,t):6===l.type&&(e=new z(n,this,t)),this._$AV.push(e),l=i[++o]}r!==l?.index&&(n=H.nextNode(),r++)}return H.currentNode=h,s}p(t){let e=0;for(let i of this._$AV)void 0!==i&&(void 0!==i.strings?(i._$AI(t,i,e),e+=i.strings.length-2):i._$AI(t[e])),e++}}class E{get _$AU(){return this._$AM?._$AU??this._$Cv}constructor(t,e,i,s){this.type=2,this._$AH=w,this._$AN=void 0,this._$AA=t,this._$AB=e,this._$AM=i,this.options=s,this._$Cv=s?.isConnected??!0}get parentNode(){let t=this._$AA.parentNode,e=this._$AM;return void 0!==e&&11===t?.nodeType&&(t=e.parentNode),t}get startNode(){return this._$AA}get endNode(){return this._$AB}_$AI(t,e=this){a(t=C(this,t,e))?t===w||null==t||""===t?(this._$AH!==w&&this._$AR(),this._$AH=w):t!==this._$AH&&t!==x&&this._(t):void 0!==t._$litType$?this.g(t):void 0!==t.nodeType?this.$(t):c(t)?this.T(t):this._(t)}k(t){return this._$AA.parentNode.insertBefore(t,this._$AB)}$(t){this._$AH!==t&&(this._$AR(),this._$AH=this.k(t))}_(t){this._$AH!==w&&a(this._$AH)?this._$AA.nextSibling.data=t:this.$(h.createTextNode(t)),this._$AH=t}g(t){let{values:e,_$litType$:i}=t,s="number"==typeof i?this._$AC(t):(void 0===i.el&&(i.el=T.createElement(N(i.h,i.h[0]),this.options)),i);if(this._$AH?._$AD===s)this._$AH.p(e);else{let t=new S(s,this),i=t.u(this.options);t.p(e),this.$(i),this._$AH=t}}_$AC(t){let e=b.get(t.strings);return void 0===e&&b.set(t.strings,e=new T(t)),e}T(t){$(this._$AH)||(this._$AH=[],this._$AR());let e=this._$AH,i,s=0;for(let n of t)s===e.length?e.push(i=new E(this.k(l()),this.k(l()),this,this.options)):i=e[s],i._$AI(n),s++;s<e.length&&(this._$AR(i&&i._$AB.nextSibling,s),e.length=s)}_$AR(t=this._$AA.nextSibling,e){for(this._$AP?.(!1,!0,e);t&&t!==this._$AB;){let e=t.nextSibling;t.remove(),t=e}}setConnected(t){void 0===this._$AM&&(this._$Cv=t,this._$AP?.(t))}}class L{get tagName(){return this.element.tagName}get _$AU(){return this._$AM._$AU}constructor(t,e,i,s,n){this.type=1,this._$AH=w,this._$AN=void 0,this.element=t,this.name=e,this._$AM=s,this.options=n,i.length>2||""!==i[0]||""!==i[1]?(this._$AH=Array(i.length-1).fill(new String),this.strings=i):this._$AH=w}_$AI(t,e=this,i,s){let n=this.strings,r=!1;if(void 0===n)(r=!a(t=C(this,t,e,0))||t!==this._$AH&&t!==x)&&(this._$AH=t);else{let s,o;let h=t;for(t=n[0],s=0;s<n.length-1;s++)(o=C(this,h[i+s],e,s))===x&&(o=this._$AH[s]),r||=!a(o)||o!==this._$AH[s],o===w?t=w:t!==w&&(t+=(o??"")+n[s+1]),this._$AH[s]=o}r&&!s&&this.j(t)}j(t){t===w?this.element.removeAttribute(this.name):this.element.setAttribute(this.name,t??"")}}class U extends L{constructor(){super(...arguments),this.type=3}j(t){this.element[this.name]=t===w?void 0:t}}class B extends L{constructor(){super(...arguments),this.type=4}j(t){this.element.toggleAttribute(this.name,!!t&&t!==w)}}class I extends L{constructor(t,e,i,s,n){super(t,e,i,s,n),this.type=5}_$AI(t,e=this){if((t=C(this,t,e,0)??w)===x)return;let i=this._$AH,s=t===w&&i!==w||t.capture!==i.capture||t.once!==i.once||t.passive!==i.passive,n=t!==w&&(i===w||s);s&&this.element.removeEventListener(this.name,this,i),n&&this.element.addEventListener(this.name,this,t),this._$AH=t}handleEvent(t){"function"==typeof this._$AH?this._$AH.call(this.options?.host??this.element,t):this._$AH.handleEvent(t)}}class z{constructor(t,e,i){this.element=t,this.type=6,this._$AN=void 0,this._$AM=e,this.options=i}get _$AU(){return this._$AM._$AU}_$AI(t){C(this,t)}}const R=t.litHtmlPolyfillSupport;R?.(T,E),(t.litHtmlVersions??=[]).push("3.0.0");const P=(t,e,i)=>{let s=i?.renderBefore??e,n=s._$litPart$;if(void 0===n){let t=i?.renderBefore??null;s._$litPart$=n=new E(e.insertBefore(l(),t),t,void 0,i??{})}return n._$AI(t),n},V=t=>(...e)=>({_$litDirective$:t,values:e});class k{constructor(t){}get _$AU(){return this._$AM._$AU}_$AT(t,e,i){this._$Ct=t,this._$AM=e,this._$Ci=i}_$AS(t,e){return this.update(t,e)}update(t,e){return this.render(...e)}}/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */class W extends k{constructor(t){if(super(t),this.et=w,2!==t.type)throw Error(this.constructor.directiveName+"() can only be used in child bindings")}render(t){if(t===w||null==t)return this.vt=void 0,this.et=t;if(t===x)return t;if("string"!=typeof t)throw Error(this.constructor.directiveName+"() called with a non-string value");if(t===this.et)return this.vt;this.et=t;let e=[t];return e.raw=e,this.vt={_$litType$:this.constructor.resultType,strings:e,values:[]}}}W.directiveName="unsafeHTML",W.resultType=1,V(W);/**
 * @license
 * Copyright 2017 Google LLC
 * SPDX-License-Identifier: BSD-3-Clause
 */class D extends W{}D.directiveName="unsafeSVG",D.resultType=2;const O=V(D),j=["https://hoppscotch.io"];let q=[],J="",Z="https://hoppscotch.io",G="";const F=t=>new Promise((e,i)=>{chrome.storage.sync.set({originList:JSON.stringify(t)},()=>{e()})}),K=t=>{t.preventDefault();try{let t=new URL(J);q.includes(t.origin)?G="Origin is already on the list":(q.push(t.origin),J="",F(q),G=""),P(Y(),document.body)}catch(t){G="Improper URL",P(Y(),document.body)}},Q=t=>{J=t.target.value,G="",P(Y(),document.body)},X=async t=>{q.splice(t,1),await F(q),P(Y(),document.body)},Y=()=>y`
  ${te(J,Q,K)}
  ${tt(G)} ${ti(q,X)}
`,tt=t=>y`
  ${t.length>0?y`
        <div class="err">
          ${O('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="18px" height="18px"><path d="M0 0h24v24H0z" fill="none"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z"/></svg>\n')}
          <span class="err-text"> ${t} </span>
        </div>
      `:y``}
`,te=(t,e,i)=>y`
  <form novalidate class="origin-input-box">
    <label class="origin-input-label" for="origin-input">Enter new origin</label>

    <div class="origin-input-wrapper">
      <input id="origin-input" required placeholder="${Z}" class="origin-input" .value=${t} @input=${e}></input>
      <button class="origin-add" type="submit" @click=${i}>
        ${O('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="18px" height="18px"><path d="M0 0h24v24H0z" fill="none"/><path d="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"/></svg>\n')}
        <span class="button-text">Add</span>
      </button>
    </div>
  </form>
`,ti=(t,e)=>y`
  <label class="origin-input-label">Active origins</label>
  <ul class="origin-list">
    ${t.map((t,i)=>y`
        <li class="origin-list-entry">
          <span class="origin-list-entry-origin">${t}</span>
          <button
            class="origin-delete"
            .disabled=${"https://hoppscotch.io"===t}
            @click=${()=>e(i)}
          >
            ${O('<svg xmlns="http://www.w3.org/2000/svg" height="18" viewBox="0 0 24 24" fill="currentColor" width="18"><path d="M0 0h24v24H0z" fill="none"/><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM19 4h-3.5l-1-1h-5l-1 1H5v2h14V4z"/></svg>\n')}
          </button>
        </li>
      `)}
  </ul>
`;new Promise((t,e)=>{chrome.storage.sync.get(["originList"],async e=>{e&&e.originList||(await F(j),t(j)),t(JSON.parse(e.originList))})}).then(t=>{q=t,P(Y(),document.body)}).catch(()=>{// Just fail silently :P
}),chrome.tabs.query({active:!0},t=>{if(t.length>0)try{if(t[0].url){if(!t[0].url.startsWith("http"))return;let e=new URL(t[0].url);e&&e.origin&&(Z=e.origin,J=e.origin),P(Y(),document.body)}}catch(t){}});//# sourceMappingURL=popup.f0c84d90.js.map

//# sourceMappingURL=popup.f0c84d90.js.map
