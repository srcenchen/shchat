import{F as T,j as B,f as A,m as N,o as F,G as D,c as C,i as M,H as R,d as z,q as V,I as K,p as X,s as m,v as P,L as $,J,K as U,y as W,N as _}from"./index-934f1aca.js";/**
 * tdesign v1.0.4
 * (c) 2023 tdesign
 * @license MIT
 */var q={block:Boolean,content:{type:[String,Function]},default:{type:[String,Function]},disabled:Boolean,ghost:Boolean,href:{type:String,default:""},icon:{type:Function},loading:Boolean,shape:{type:String,default:"rectangle",validator:function(e){return e?["rectangle","square","round","circle"].includes(e):!0}},size:{type:String,default:"medium",validator:function(e){return e?["small","medium","large"].includes(e):!0}},suffix:{type:Function},tag:{type:String,validator:function(e){return e?["button","a","div"].includes(e):!0}},theme:{type:String,validator:function(e){return e?["default","primary","danger","warning","success"].includes(e):!0}},type:{type:String,default:"button",validator:function(e){return e?["submit","reset","button"].includes(e):!0}},variant:{type:String,default:"base",validator:function(e){return e?["base","outline","dashed","text"].includes(e):!0}},onClick:Function};/**
 * tdesign v1.0.4
 * (c) 2023 tdesign
 * @license MIT
 */var H=T.expand,Z=T.ripple,G=T.fade;function Q(){var t=B("animation"),e=t.globalConfig,a=function(u){var d,f,o=e.value;return o&&!((d=o.exclude)!==null&&d!==void 0&&d.includes(u))&&((f=o.include)===null||f===void 0?void 0:f.includes(u))};return{keepExpand:a(H),keepRipple:a(Z),keepFade:a(G)}}/**
 * tdesign v1.0.4
 * (c) 2023 tdesign
 * @license MIT
 */function L(t,e){var a=Object.keys(e);a.forEach(function(n){t.style[n]=e[n]})}/**
 * tdesign v1.0.4
 * (c) 2023 tdesign
 * @license MIT
 */var j=200,Y="rgba(0, 0, 0, 0)",ee="rgba(0, 0, 0, 0.35)",te=function(e,a){var n;if(a)return a;if(e!=null&&(n=e.dataset)!==null&&n!==void 0&&n.ripple){var u=e.dataset.ripple;return u}var d=getComputedStyle(e).getPropertyValue("--ripple-color");return d||ee};function ne(t,e){var a=A(null),n=N(),u=Q(),d=u.keepRipple,f=function(p){var i=t.value,y=te(i,e==null?void 0:e.value);if(!(p.button!==0||!t||!d)&&!(i.classList.contains("".concat(n.value,"-is-active"))||i.classList.contains("".concat(n.value,"-is-disabled"))||i.classList.contains("".concat(n.value,"-is-checked"))||i.classList.contains("".concat(n.value,"-is-loading")))){var g=getComputedStyle(i),v=parseInt(g.borderWidth,10),s=v>0?v:0,c=i.offsetWidth,l=i.offsetHeight;a.value.parentNode===null&&(L(a.value,{position:"absolute",left:"".concat(0-s,"px"),top:"".concat(0-s,"px"),width:"".concat(c,"px"),height:"".concat(l,"px"),borderRadius:g.borderRadius,pointerEvents:"none",overflow:"hidden"}),i.appendChild(a.value));var r=document.createElement("div");L(r,{marginTop:"0",marginLeft:"0",right:"".concat(c,"px"),width:"".concat(c+20,"px"),height:"100%",transition:"transform ".concat(j,"ms cubic-bezier(.38, 0, .24, 1), background ").concat(j*2,"ms linear"),transform:"skewX(-8deg)",pointerEvents:"none",position:"absolute",zIndex:0,backgroundColor:y,opacity:"0.9"});for(var b=new WeakMap,x=i.children.length,h=0;h<x;++h){var O=i.children[h];O.style.zIndex===""&&O!==a.value&&(O.style.zIndex="1",b.set(O,!0))}var S=i.style.position?i.style.position:getComputedStyle(i).position;(S===""||S==="static")&&(i.style.position="relative"),a.value.insertBefore(r,a.value.firstChild),setTimeout(function(){r.style.transform="translateX(".concat(c,"px)")},0);var w=function I(){r.style.backgroundColor=Y,t.value&&(t.value.removeEventListener("pointerup",I,!1),t.value.removeEventListener("pointerleave",I,!1),setTimeout(function(){r.remove(),a.value.children.length===0&&a.value.remove()},j*2+100))};t.value.addEventListener("pointerup",w,!1),t.value.addEventListener("pointerleave",w,!1)}};F(function(){var o=t==null?void 0:t.value;o&&(a.value=document.createElement("div"),o.addEventListener("pointerdown",f,!1))}),D(function(){var o;t==null||(o=t.value)===null||o===void 0||o.removeEventListener("pointerdown",f,!1)})}/**
 * tdesign v1.0.4
 * (c) 2023 tdesign
 * @license MIT
 */function ae(t){var e=R(),a=C(function(){return e.props.disabled}),n=M("formDisabled",Object.create(null)),u=n.disabled;return C(function(){return a.value||(u==null?void 0:u.value)||(t==null?void 0:t.value)||!1})}/**
 * tdesign v1.0.4
 * (c) 2023 tdesign
 * @license MIT
 */function k(t,e){var a=Object.keys(t);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(t);e&&(n=n.filter(function(u){return Object.getOwnPropertyDescriptor(t,u).enumerable})),a.push.apply(a,n)}return a}function E(t){for(var e=1;e<arguments.length;e++){var a=arguments[e]!=null?arguments[e]:{};e%2?k(Object(a),!0).forEach(function(n){m(t,n,a[n])}):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(a)):k(Object(a)).forEach(function(n){Object.defineProperty(t,n,Object.getOwnPropertyDescriptor(a,n))})}return t}var re=z({name:"TButton",props:q,setup:function(e,a){var n=a.attrs,u=a.slots,d=V(),f=K(),o=N("button"),p=X(),i=p.STATUS,y=p.SIZE,g=ae(),v=A();ne(v);var s=C(function(){return e.disabled||e.loading||g.value}),c=C(function(){var r=e.theme,b=e.variant;return r||(b==="base"?"primary":"default")}),l=C(function(){var r;return["".concat(o.value),"".concat(o.value,"--variant-").concat(e.variant),"".concat(o.value,"--theme-").concat(c.value),(r={},m(r,y.value[e.size],e.size!=="medium"),m(r,i.value.disabled,e.disabled||g.value),m(r,i.value.loading,e.loading),m(r,"".concat(o.value,"--shape-").concat(e.shape),e.shape!=="rectangle"),m(r,"".concat(o.value,"--ghost"),e.ghost),m(r,y.value.block,e.block),r)]});return function(){var r=f("default","content"),b=e.loading?P($,{inheritColor:!0},null):d("icon"),x=b&&!r,h=e.suffix||u.suffix?P("span",{className:"".concat(o.value,"__suffix")},[d("suffix")]):null;r=r?P("span",{class:"".concat(o.value,"__text")},[r]):"",b&&(r=[b,r]),h&&(r=[r].concat(h));var O=function(){return!e.tag&&e.href?"a":e.tag||"button"},S={class:[].concat(J(l.value),[m({},"".concat(o.value,"--icon-only"),x)]),type:e.type,disabled:s.value,href:e.href};return U(O(),E(E(E({ref:v},n),S),{},{onClick:e.onClick}),[r])}}});/**
 * tdesign v1.0.4
 * (c) 2023 tdesign
 * @license MIT
 */var oe=W(re);/**
 * tdesign v1.0.4
 * (c) 2023 tdesign
 * @license MIT
 */function ue(t,e,a,n){var u=arguments.length>4&&arguments[4]!==void 0?arguments[4]:"value",d=R(),f=d.emit,o=d.vnode,p=A(),i=o.props||{},y=Object.prototype.hasOwnProperty.call(i,"modelValue")||Object.prototype.hasOwnProperty.call(i,"model-value"),g=Object.prototype.hasOwnProperty.call(i,u)||Object.prototype.hasOwnProperty.call(i,_(u));return y?[e,function(v){f("update:modelValue",v);for(var s=arguments.length,c=new Array(s>1?s-1:0),l=1;l<s;l++)c[l-1]=arguments[l];n==null||n.apply(void 0,[v].concat(c))}]:g?[t,function(v){f("update:".concat(u),v);for(var s=arguments.length,c=new Array(s>1?s-1:0),l=1;l<s;l++)c[l-1]=arguments[l];n==null||n.apply(void 0,[v].concat(c))}]:(p.value=a,[p,function(v){p.value=v;for(var s=arguments.length,c=new Array(s>1?s-1:0),l=1;l<s;l++)c[l-1]=arguments[l];n==null||n.apply(void 0,[v].concat(c))}])}/**
 * tdesign v1.0.4
 * (c) 2023 tdesign
 * @license MIT
 */var le=Symbol("FormItemProvide");export{oe as B,le as F,ue as a,ae as u};
