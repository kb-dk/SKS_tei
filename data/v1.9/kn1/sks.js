// sks.js; JavaScript for SKS-E
// Version 1.8 KK 2013-02-21
/*jslint browser: true, forin: true, passfail: false, undef: true */

var minus= '&#x2013;', chk= '&#x221a;', space= "&#160;&#160;",
    SKSblue_1= '#00c0ff', SKSblue_2= '#bccbcf',
    skaktikon= '&#x2195;',

    cl=          [ "korSK", "korSKS", "korSV3", "k"  , "tn" , "skt", "korPap", "korEPI-II", "korBA" ],
    tick=        [ space  , space   , space   , space, space, space, space   ,  space     , space   ],
    defaulttick= [ space  , space   , space   , space, space, space, space   ,  space     , space   ],

    userpref, neww= false,

    g1, g2, g3, g4;

if (!window.name) {
    window.name= "SKStop";
}

function blankdrop( droparea ) {
  droparea.innerHTML= ""; 
  }

function blinkdrop( droparea, msg ) {
  if ( !msg ) { msg= "Vent"; }
  droparea.innerHTML= "<p style=\"text-decoration:blink;background-color:magenta\">"+msg+" ...</p>"; 
  }

function posmn( ref, id, freespace ) {
  var not= document.getElementById( id ),
      room= 0 ;
  if ( not.className!="margen" ) { return freespace; }
  not.style.position= "static"; // i.e. default placement
  var orig= not.offsetTop,
      y= ref.offsetTop;
  if ( ref.offsetParent && ref.offsetParent.className=="tab" ) { // in case of <blok>/<tab>
    var p= ref;
    while ( p.tagName.toLowerCase()!="table" ) {
      p= p.offsetParent;
      y+= p.offsetTop;
      } 
    }
  if( not.offsetParent ) {
   room= not.offsetParent.offsetHeight;
   if ( orig<3 ) { // first <not> in <opt>
    if ( freespace<0 ) {
      freespace= room + freespace;
      }
    else {
      freespace= room;
      }
    }
   }
  var top= room - freespace;
  if ( top > y ) { y= top; }
  top= y + not.offsetHeight;
  freespace= (room - top) - 10;
  y-= orig;
  not.style.position= "relative";
  not.style.top=y+"px";
  return freespace;
  }

function allposmn() {
  var r= false,
      savefree= 0 , num, savenum= 0,
      xspace= document.getElementById( "xspace" );
  if ( !xspace ) { // no mn's
    return;
    }
  for ( var i=0; i<document.anchors.length; i++ ) {
    var a= document.anchors[i];
    if ( a.className=='ref' ) {
      var aid= a.name.substr(1) /*skip leading R*/;
      num= aid.substring( aid.indexOf("-")+1, aid.indexOf(".") );
      if ( num-savenum>1 ) { savefree= 0; }
      savenum= num;
      savefree= posmn( a, aid, savefree );
    }
  }
  while ( xspace.offsetHeight<-savefree ) {
    xspace.innerHTML+= "<br>";
    if( xspace.offsetHeight==0 ) { //better leave
      return;
    }
  }
}

function show( id, idp ) {
  var elem= document.getElementById( id );
  if ( !elem ) { return false; }
  var plus= document.getElementById( idp );
  elem.style.display= 'block';
  if ( plus ) { plus.innerHTML= minus; }
  return true;
  }

function hide( id, idp ) {
  var elem= document.getElementById( id );
  if ( !elem ) { return false; }
  var plus= document.getElementById( idp );
  if ( elem.style.display=='block' || (plus && !plus.innerHTML.match(/\+/)) ) {
    elem.style.display= 'none';
    if ( plus) { plus.innerHTML= '+'; }
    }
  return true;
  }

function showhide( id, idp ) {
  var elem= document.getElementById( id );
  if ( !elem ) { return false; }
  var plus= document.getElementById( idp );
  if ( elem.style.display=='block' || (plus && !plus.innerHTML.match(/\+/)) ) {
    elem.style.display= 'none';
    if ( plus) { plus.innerHTML= '+'; }
    }
  else {
    elem.style.display= 'block';
    if ( plus ) { plus.innerHTML= minus; }
    }
  return true;
  }


function showhidetop( id, idp ) {
  window.scrollTo( 0,0 );
  return showhide( id, idp );
  }

function showhideall( id ) {
  var plus= document.getElementById( id+"p" ),
      hidden= plus.innerHTML.match( /\+/ );
  if ( hidden ) { plus.innerHTML= minus; }
  else         { plus.innerHTML= '+'; }
  var all= document.getElementById( id ),
      DIVS= all.getElementsByTagName( "div" ),
      i;
  for ( i=0; i<DIVS.length; i++ ) {
    var div= DIVS[i];
    if ( div.className=="kapv" ) {
      if ( hidden ) {
        show( div.id, div.id+"p" );
        }
      else {
        hide( div.id, div.id+"p" );
        }
      }
    }
  }

function showtxt( id ) {
  var elem= document.getElementById( id );
  if ( !elem ) { return false; }
  var p= elem.parentNode;
  if( p.id+"tx"==id ) { //optimise jp
  // Unfold all parent chapters
  while ( p && p.id!='al' ) {
   if ( p.id ) {
    show( p.id, p.id+"p" );
    }
   p= p.parentNode;
   }
  }
  var plus= document.getElementById( id+'p' );
  elem.style.display= 'block';
  if ( plus ) { plus.innerHTML= '&lt;'; }
  var curnrinput= document.getElementById( 'curnr' );
  curnrinput.value= id.replace(/[^0-9:]/g,'');
  return true;
  }

function goshowtxt( nr ) {
  var id= 'k'+nr+'tx';
  if( showtxt(id) || showtxt(id='k'+nr+':1tx') ) { // last try is for Papir with subentries
    allposmn(); /**/
    window.location= "#"+id;
    return true;
    }
  else {
    return false ;
    }
  }

function hidetxt( id ) {
  var elem= document.getElementById( id );
  if ( !elem ) { return false; }
  var plus= document.getElementById( id+'p' );
  if ( elem.style.display=='block' ) {
    elem.style.display= 'none';
    if ( plus) { plus.innerHTML= '&gt;'; }
    }
  return true;
  }

function showhidetxt( id ) {
  var elem= document.getElementById( id+'tx' );
  if ( !elem ) { return false; }
  var plus= document.getElementById( id+'txp' ),
      curnrinput= document.getElementById( 'curnr' );
  curnrinput.value= id.replace(/[^0-9:]/g,'');
  if ( elem.style.display=='block' ) { // hide
   elem.style.display= 'none';
   if ( plus ) { plus.innerHTML= '&gt;'; }
   }
  else { // show
    show( id, id+"p" );
    elem.style.display= 'block';
    if ( plus ) { plus.innerHTML= '&lt;'; }
    allposmn(); /**/
    }
  return true;
  }

function showhidealltxt( id ) {
  var droparea= document.getElementById( "Her-rulles" ),
      txp= document.getElementById( id+"txp" ),
      plus= document.getElementById( id+"p" ),
      hidden= txp.innerHTML.match( /Vis/ ),
      state;
  blinkdrop( droparea );
  if ( hidden ) {
    state= "Skjul al tekst &lt;";}
  else {
    state= "Vis al tekst &gt;";}
  txp.innerHTML= state;
  if( plus ) plus.innerHTML= minus;
  window.setTimeout( "shatdelayed('"+state+"')", 0 );
  }

function shatdelayed( state ) {
  var id= "al",
      hidden= state.match( /Skjul/ ),
      all= document.getElementById( id ),
      DIVS= all.getElementsByTagName( "div" ),
      div, i;
  if ( hidden ) {
    for ( i=0; i<DIVS.length; i++ ) {
      div= DIVS[i];
      if ( div.className=="kaptxt" ) {
        showtxt( div.id );
        }
      }
    allposmn(); /**/
    }
  else {
    for ( i=0; i<DIVS.length; i++ ) {
      div= DIVS[i];
      if ( div.className=="kaptxt" ) {
        hidetxt( div.id );
        }
      }
    }
  var droparea= document.getElementById( "Her-rulles" );
  blankdrop( droparea );
  }

function showpage( id ) {
  var kor= document.getElementById( id );
  if ( !kor ) { return; }
  var p= kor.parentNode;
  while ( p && p.className!="kaptxt" ) { p= p.parentNode; }
  if ( !p ) return;
  showtxt( p.id );
  allposmn(); /**/
  }

function goshowpage( s, p ) {
  var id= s+p;
  showpage( id );
  window.location= "#"+id;
  window.scrollBy( 0,-50 );
  }

function pct2iso( s ) {
  while ( s.search(/%([0-9A-F][0-9A-F])/)>=0 ) {
    s= s.replace( /%([0-9A-F][0-9A-F])/, String.fromCharCode(parseInt(RegExp.$1,16)) );
    }
  return s ;
  }

function hl( norm ) {
  var SPANS= document.getElementsByTagName( "span" ), i;
  norm= norm.replace(/[\x80-\xff]+/g,".*");
//alert( norm );
  for ( i=0; i<SPANS.length; i++ ) {
    var span= SPANS[i], omo= span.getAttribute("onmouseover");
    if( omo && omo.search(/'(Bib. )?(.*)'/)>=0 ) {
//      if( RegExp.$2==norm ) {
      if( RegExp.$2.match(norm) ) {
        span.style.backgroundColor= "yellow";
      }
    }
  }
}

var query_done= "";

function querytxt() {
  var query= window.location.search,
      hash= window.location.hash.substring(1),
      gotoloc, pairs, pos, argname, id;
  if ( !hash && query.search(/hash=([^&#?]*)/)>=0 ) {
    hash= RegExp.$1;
  }
  if ( query.search(/hl=/)>=0 ) {
    hl( pct2iso(query.substring(4)) )
    }
  if ( hash && hash!=query_done ) {
   if ( hash.substr(0,1)=="k" ) {
      if ( !showtxt(hash+"tx") ) { showtxt( hash+":1tx" ); }
      allposmn();
   }
   else {
    showpage( hash );
    }
   window.location= "#"+hash;
   window.scrollBy( 0,-50 );
   query_done= hash;
   }
 }

function tny( elem, tnid ) {
  var tntxt= document.getElementById( tnid ),
      lemma= elem.previousSibling,
      tnote= elem.nextSibling;
  if ( tnote && tnote.nodeType==1 /*ELEMENT_NODE*/ && tnote.getAttribute("id")==tnid ) {
    // tnote present and visible
    elem.parentNode.removeChild( elem.nextSibling );
    lemma.style.backgroundColor= ''; // inherited color
    }
  else { // no tnote
    var newtnote= tntxt.cloneNode( true );
    newtnote.style.display= 'inline';
    elem.parentNode.insertBefore( newtnote, tnote );
    lemma.style.backgroundColor= SKSblue_2;
    }
}

function tnx( elem ) {
  var lemma= elem.previousSibling,
      tnote= elem.nextSibling;
  if ( tnote.style.display ) {
    tnote.style.display= '';
    lemma.style.backgroundColor= ''; // inherited color
    }
  else { // Initially visibility may be undefined, therefore this must be the default
    tnote.style.display= 'inline';
    lemma.style.backgroundColor= SKSblue_2;
    }
}

function loadcookie( name ) {
  var allcookie= document.cookie,
      pos= allcookie.indexOf( name );
  if ( pos==-1 ) { return false; }
  var start= pos + 5,
      end= allcookie.indexOf( ";", start );
      if ( end==-1 ) { end= allcookie.length; }
  var cookieval= allcookie.substring( start, end );
  if ( name=="tick" ) {
    if ( cookieval=="000000000" ) { return false; }
    for ( var i in cl ) {
      tick[i]= cookieval.substr(i,1)=="0" ? space : chk;
      }
    }
  if ( name=="neww" ) {
    neww= cookieval=="true" ? true : false;
    userpref= true;
    }
  return true;
}

function storecookie( name ) {
 var path= "; path=/";
 if ( name=="tick" ) {
  var cookieval= "";
  for ( var i in cl ) {
    cookieval+= tick[i]==space ? "0" : "1";
    }
  document.cookie= "tick=" + cookieval + path;
  }
 else {
  if ( neww ) {
    document.cookie= "neww=true" + path;
    }
  else {
    document.cookie= "neww=false" + path;
    }
  }  
}

function chk_box( ix, chkd ) {
  var chkbox;
    chkbox= document.getElementById( cl[ix]+"top" );
    if ( chkbox ) { chkbox.checked= chkd; }
    chkbox= document.getElementById( cl[ix]+"bottom" );
    if ( chkbox ) { chkbox.checked= chkd; }
  }

function showhiderefx( ix ) {
  var droparea= document.getElementById( "Her-rulles" ),
      thiscl= cl[ix], dis, icon;
      if (tick[ix]!=space) {
        dis= "none";
        tick[ix]= space;
        chk_box( ix, false );
        switch( ix ) {
          case 3: case 4: case 5: icon= "";
            break;
          default: icon= "noicon";
          }
        }
      else {
        dis= "inline";
        tick[ix]= chk;
        chk_box( ix, true );
        switch( ix ) {
          case 3: icon= "*";
            break;
          case 4: icon= "]";
            break;
          case 5: icon= skaktikon;
            break;
          default: icon= "noicon";
          }
        }
  storecookie( "tick" );
  blinkdrop( droparea );
  g1=thiscl; g2=dis; g3=droparea; g4=icon;
  window.setTimeout( "anchorsaway()", 0 );
  }

function alltnx() {
  if ( tick[4]==space ) {
    showhiderefx( 4 );
    }
  window.setTimeout( "alltndelayed()", 0 );
}

function alltndelayed() {
  for ( var i=0; i<document.anchors.length; i++ ) {
    var a= document.anchors[i];
    if ( a.className=='tn' ) {
      var tnid= a.href.match( /'([^']*)'/ );
      tny( a, tnid[1] );
    }
  }
  allposmn();
}

function alttn( here ) {
  here.style.backgroundColor= 'navy';
}

function blank(target, loc, x, y) {
  var danMsg= "æ".charCodeAt(0)==230
        ? "Teksten vises i et nyt vindue\n(Vælg Annuller for at få teksten vist i nuværende vindue)"
        : "Teksten vises i et nyt vindue\n(VÃ¦lg Annuller for at fÃ¥ teksten vist i nuvÃ¦rende vindue)" ;
  if ( !userpref ) { loadcookie( "neww" ); }
  if ( !userpref && target!='SKStop' ) {
    neww= window.confirm( danMsg+"\nThe text is shown in a new window\n(Choose Cancel to stay in current window)" );
    userpref= true;
    storecookie( "neww" );
    }
  if ( neww ) {
    if ( !x) { x= "675"; }
    if ( !y) { y= screen.availHeight-100; }
    var w= window.open(loc,target,"width="+x+",height="+y+",resizable=yes,scrollbars=yes,status=no,menubar=no,titlebar=no,location=yes",true);
    w.focus();
    return false;
    }
  else {
    return true;
    }
 }

function initrefx() { //optimised version
 if ( loadcookie( "tick" ) ) {
  var dis= [ "none","none","none","none","none","none","none","none","none" ],
      icon= [ "noicon","noicon","noicon","","","","noicon","noicon","noicon" ];
  for ( var ix in cl ) {
   if ( tick[ix]!=defaulttick[ix] ) {
    chk_box( ix, tick[ix]!=space );
    if ( tick[ix]!=space ) {
     dis[ix]= "inline";
     switch( ix ) {
      case "3": icon[ix]= "*";
       break;
      case "4": icon[ix]= "]";
       break;
      case "5": icon[ix]= skaktikon;
       break;
      default: icon[ix]= "noicon";
      }
     }
    }
   }
  for ( var i=0; i<document.anchors.length; i++ ) {
   var a= document.anchors[i];
   for ( ix in cl ) {
    if ( tick[ix]!=defaulttick[ix] ) {
     var thiscl=cl[ix];
     if ( a.className==thiscl ) {
      a.style.display= dis[ix];
      if ( icon[ix]!="noicon" ) {
       a.innerHTML= icon[ix];
       }
      if ( dis[ix]=="none" && thiscl=="tn" )   {
       var tnote= a.nextSibling;
       if ( tnote!==null && tnote.nodeType==1 && tnote.className=="tnote" ) { // see anchorsaway()
        a.previousSibling.style.backgroundColor= "";
        a.parentNode.removeChild( tnote );
        }
       }
      }
     }
    }
   }
  allposmn();
  }
 }

function anchorsaway() {
  var thiscl=g1 , dis=g2 , droparea=g3, icon=g4;
  for ( var i=0; i<document.anchors.length; i++ ) {
    var a= document.anchors[i];
    if ( a.className==thiscl ) {
      a.style.display= dis;
      if ( icon!="noicon" ) {
        a.innerHTML= icon;
        }
      if ( dis=="none" && thiscl=="tn" )   {
        var tnote= a.nextSibling;
        if ( tnote!==null && tnote.nodeType==1 /*ELEMENT_NODE*/ && tnote.className=="tnote" ) {
          a.previousSibling.style.backgroundColor= ""; // lemma
          a.parentNode.removeChild( tnote );           // tnote
          }
        }
      }
    }
  if ( droparea ) { blankdrop( droparea ); }
  window.setTimeout( "allposmn()", 0 );
  }

var oldcol;
function hoover( here ) {
  oldcol= here.style.backgroundColor;
  here.style.backgroundColor= SKSblue_1;
  }

function unhoover( here ) {
  here.style.backgroundColor= oldcol;
  }

var kormenu0= "<p>Sidetal</p><p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\"><a href=\"javascript:showhiderefx(0)\" title=\"Show first print page numbers\">";
var kormenu1= "&#160;A</a></p><p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\"><a href=\"javascript:showhiderefx(1)\" title=\"Show SKS page numbers\">";
var kormenu2= "&#160;SKS</a></p><p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\"><a href=\"javascript:showhiderefx(2)\" title=\"Show SV3 page numbers\">";
var kormenu3= "&#160;SV3</a></p><p>Henvisninger til</p><p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\"><a href=\"javascript:showhiderefx(3)\" title=\"Show references * for explanatory notes\">";
var kormenu4= "&#160;kommentarer</a></p><p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\"><a href=\"javascript:showhiderefx(4)\" title=\"Show references ] for critical notes\">";
var kormenu5= "&#160;tekstkritik</a></p>";
/* incl. shafts
var kormenu5= "&#160;tekstkritik</a></p><p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\"><a href=\"javascript:showhiderefx(5)\" title=\"Show shafts for underlying text layers\">";
var kormenu6= "&#160;skakter</a></p>";
*/
var korjp0= "<p>Sidetal mv...</p><p><a onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\" href=\"javascript:showhiderefx(0)\" title=\"Show ms. page numbers\">";
var korjp1= "&#160;Ms.</a></p><p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\"><a href=\"javascript:showhiderefx(1)\" title=\"Show SKS page numbers\">";
var korjp2= "&#160;SKS</a></p><p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\"><a href=\"javascript:showhiderefx(6)\" title=\"Show Pap. entry numbers\">";
var korjp3= "&#160;Pap.</a></p><p>Henvisninger til...</p><p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\"><a href=\"javascript:showhiderefx(3)\" title=\"Show references * for explanatory notes\">";

function dropkor( kor, droptxt ) {
  var droparea= document.getElementById( "Her-rulles" ),
      x= kor.offsetLeft,// + kor.offsetWidth,
      y= kor.offsetTop + kor.offsetHeight,
      p= kor.offsetParent;
  while (p!==null) {
    x+= p.offsetLeft;
    y+= p.offsetTop;
    p= p.offsetParent;
    }
  x= x+"px"; y= y+"px"; 
  if ( droparea.innerHTML &&
      x==droparea.style.left &&
      y==droparea.style.top ) {
    blankdrop( droparea );
    }
  else {
    droparea.innerHTML= droptxt;
/*
    if ( x=="0px" ) // if id=="fix" in Netscape a.o. browsers
      droparea.style.position= "fixed";
    else // <kor>s in text or anywhere in MSIExplorer
*/
    droparea.style.position= "absolute";
    droparea.style.left=x;
    droparea.style.top=y;
    }
  }

function dropkorts( id ) {
  var kor= document.getElementById( id );
  dropkor( kor,
           kormenu0+tick[0]+
           kormenu1+tick[1]+
           kormenu2+tick[2]+
           kormenu3+tick[3]+
           kormenu4+tick[4]+
           kormenu5/*+tick[5]+
           kormenu6*/ );
  }

function dropkorjp( id ) {
  var kor= document.getElementById( id );
  dropkor( kor,
           korjp0+tick[0]+
           korjp1+tick[1]+
           korjp2+tick[6]+
           korjp3+tick[3]+
           kormenu4+tick[4]+
           kormenu5/*+tick[5]+
           kormenu6*/ );
  }

function dropskt( id, mss ) {
  var droparea= document.getElementById( "sktp" ); // dangerous if sktp is not initialised !
  var skt= document.getElementById( id ),
      x= skt.offsetLeft,
      y= skt.offsetTop + skt.offsetHeight,
      p= skt.offsetParent,
      ms= mss.split( /\s+/ ),
      sktmenu= "",
      pkt, kol, und, lit, litra, helms, prevms, fil, msn, tit;
  id= id.replace( /[a-z]$/, "" ); // Remove trailing litra
  while (p!==null) {
    x+= p.offsetLeft;
    y+= p.offsetTop;
    p= p.offsetParent;
    }
  for ( var i in ms ) {
    var msi= ms[i];
    lit= msi.search(/[a-z]$/);
    litra= lit>0?msi.substr(lit,1):"";
    und= msi.indexOf("_");
    if ( und>=0 ) { msi= msi.replace( "_", "" ); }
    kol= msi.indexOf(":");
    pkt= msi.indexOf(".");
    if ( pkt<0 ) { pkt= msi.lenght; }
    helms= msi.substring( kol+1, pkt );
    if ( helms=="0" ) {
      fil= "txt.htm#" + id + litra;
      msn= "A";
      }
    else {
      fil= "ms" + helms + ".htm#" + id + litra;
      msn= "Ms. " + msi;
      }
    if ( kol>0 ) { // Foreign title
      tit= msi.substring( 0, kol );
      if ( helms=="0" ) {
        msn= tit + ":" + msn;
        }
      fil= "../" + tit + "/" + fil;
      }
    if ( i>0 ) { // but not the first time: Collations
      sktmenu+= "<p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\">" +
                "<a href=\"dif" + helms + "-" + prevms +
                ".htm#" + id + litra +  "\" target=\"dif" + helms + 
                "\" onClick=\"blankdrop(this.parentNode.parentNode);blank(\'dif" + helms + "\')\">&#160;&#160;&lt;&gt;&#160;&#160;</a></p>";
      }
    prevms= helms;
    if ( und>=0 ) {
      sktmenu+= "<p>*" + msn + "</p>";
      }
    else {
      sktmenu+= "<p onMouseOver=\"hoover(this)\" onMouseOut=\"unhoover(this)\"><a href=\"" +
                fil + "\" target=\"ms" + helms + 
                "\" onClick=\"blankdrop(this.parentNode.parentNode);blank(\'ms" + helms + "\')\">&#160;&#160;" + 
                msn + "</a></p>";
      }
    }
  if ( droparea.innerHTML && x==parseInt(droparea.style.left,10) &&
                            y==parseInt(droparea.style.top,10) ) {
    blankdrop( droparea );
    }
  else {
    droparea.innerHTML= sktmenu;
    droparea.style.top=y+"px";
    droparea.style.left=x+"px";
    }
  }

function codeUTF8( s ) { // code UTF-8 chars as entities to make up for a deficiency in MSIE
  var res="", ent= "",
      byte1= 0, byte2= 0, byte3= 0, byte4= 0;
  for ( var i=0; i<=s.length; i++ ) {
    if ( (byte1= s.charCodeAt(i)) > 127 ) {
      if ( byte1 > 191 ) {
        if ( byte1 > 223 ) {
          if ( byte1 > 239 )
            {byte2= s.charCodeAt(++i); byte3= s.charCodeAt(++i); byte4= s.charCodeAt(++i);}
          else
            {byte2= s.charCodeAt(++i); byte3= s.charCodeAt(++i);}
          }
        else {
          byte2= s.charCodeAt(++i);
          }
        }
      else {
        /*not UTF-8 encoded*/ return s;
        }
      if ( byte2 && byte2 < 128 || byte2 > 191 ) { // following bytes must start with 10
          /*not UTF-8 encoded*/ return s;
          }
      if ( byte3 && byte3 < 128 || byte3 > 191 ) {
          /*not UTF-8 encoded*/ return s;
          }
      if ( byte4 && byte4 < 128 || byte4 > 191 ) {
          /*not UTF-8 encoded*/ return s;
          }
      if ( byte4 ) {
        ent= "&#" + ((((byte1 & 0x7)*64 + (byte2 & 0x3f))*64 + (byte3 & 0x3f))*64 + (byte4 & 0x3f)) + ";";
        }
      else if ( byte3 ) {
        ent= "&#" + (((byte1 & 0xf)*64 + (byte2 & 0x3f))*64 + (byte3 & 0x3f)) + ";";
        }
      else if ( byte2 ) {
        ent= "&#" + ((byte1 & 0x1f)*64 + (byte2 & 0x3f)) + ";";
        }
      else {
        /*not UTF-8 encoded*/ return s;
        }
      res= res + ent;
      }
    else {
      res= res + s.charAt(i);
      }
    }
  return res;
  }

function gotoreg( fil, name ) {
  var suf, zoom, i;
  if ( fil=="bib" ) {
    if ( name.substr(1,1)==" " ) {
      suf= name.substr(0,1) + name.substr(2);
      }
    else {
      suf= name;
      }
    if ( (i=suf.indexOf(" "))>0 ) {
      suf= suf.substr(0,i);
      }
    }
  else {
    suf= name.substr(0,1);
    }
  suf= suf.replace(/(æ|Æ|Ã¦|Ã†|%E6|%C6)/g,"1");
  suf= suf.replace(/(ø|Ø|Ã¸|Ã˜|%F8|%D8)/g,"2");
  suf= suf.replace(/(å|Å|Ã¥|Ã…|%E5|%C5)/g,"3");
  if ( name.length>1 ) {
    zoom= "?zoom_highlightsub=%B7" + name;
    }
  else {
    zoom= "";
    }
  window.location= fil + "_" + suf + ".asp" + zoom;
}

function showbut( button ) {
}

function pushbut( button ) {
}

function leavebut( button ) {
}


