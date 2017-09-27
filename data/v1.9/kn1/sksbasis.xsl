<?xml version="1.0"?>
<!DOCTYPE stylesheet [
 <!ENTITY alfa "&#x03b1;">
 <!ENTITY beta "&#x03b2;">
 <!ENTITY o- "&#xF8;">
 <!ENTITY cpunkt "&#183;">
 <!ENTITY anfbeg "&#187;">
 <!ENTITY ae "&#xE6;">
 <!ENTITY hpil "&#x2192;">
 <!ENTITY copy "&#169;">
 <!ENTITY minus "&#x2013;">
 <!ENTITY kors "&#x2020;" >
 <!ENTITY blank "&#160;">
 <!ENTITY anfslut "&#171;">
 <!ENTITY aa "&#xE5;">
 <!ENTITY edobkors "&#x256a;" >
 <!ENTITY rod "&#x221a;" >
 <!ENTITY vsupp "[">
 <!ENTITY hsupp "]">
 <!ENTITY vtvivl "&#x2329;">
 <!ENTITY htvivl "&#x232a;">
 <!ENTITY vvar "&#x231c;">
 <!ENTITY hvar "&#x231d;">
 <!ENTITY varm "&#x2308;">
 <!ENTITY harm "&#x2309;">
 <!ENTITY vfod "&#x230a;">
 <!ENTITY hfod "&#x230b;">
 <!ENTITY hjem     '<img class="barbut" height="11" width="20" src="../vignet/home.gif"/>'>
]>
<!-- Version 1.8 KK 2013-02-20 -->

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 version="1.0">
 <!--xmlns="http://www.w3.org/1999/xhtml" Firefox doesn't read document.cookie with this ns-->

 <xsl:output indent="yes" method="html" doctype-public="-//W3C//DTD HTML 4.01//EN" doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>

 <xsl:template match="kn1|txr">
  <html> 
   <head>
    <title>
     <xsl:if test="kommentar|../txr"><xsl:text>K </xsl:text></xsl:if>
     <xsl:value-of select="kolofon/korttit"/>
     <xsl:text> &cpunkt; </xsl:text>
     <xsl:if test="kommentar|../txr">
      <xsl:if test="kommentar/k[@x='e']">
       <xsl:text>SKS-E-</xsl:text>
      </xsl:if>
      <xsl:if test="kommentar">
        <xsl:text>Kommentarer</xsl:text>
      </xsl:if>
      <xsl:value-of select="kap0/@klum"/> <!--Tekstredeg&o-;relse-->
      <xsl:text> til </xsl:text>
     </xsl:if>
     <xsl:value-of select="kolofon/titel"/>
     <xsl:if test="jp">
      &cpunkt;
      <xsl:value-of select="substring(jp/opt[1]/@dat,1,4)"/><xsl:if test="substring(jp/opt[1]/@dat,1,4)!=substring(jp/opt[last()]/@dat,1,4)">-<xsl:value-of select="substring(jp/opt[last()]/@dat,3,2)"/></xsl:if>
     </xsl:if>
    </title>
    <meta http-equiv="Content-Style-Type" content="text/css"/>
    <link rel="stylesheet" type="text/css" href="../kn1/sks.css"/>
    <link rel="shortcut icon" type="image/vnd.microsoft.icon" href="../vignet/sk32ff.ico"/>
    <script type="text/javascript" src="../kn1/sks.js">
     // empty for MSIE
    </script>
    <script type="text/javascript" src="../kn1/highlight.js">
     // empty
    </script>
   </head>
   <body onload="initrefx();highlight();querytxt()" onfocus="querytxt()"> <!-- onfocus is not strict 4.01 -->
    <xsl:apply-templates/>
   </body>
  </html>
 </xsl:template>

 <xsl:template match="kolofon/intro">
  <a class="barbut" title="Introduction" href="{@fil}" onclick="return blank('kom',this.href)">
   &blank;<xsl:apply-templates select="titel"/>
  </a>
 </xsl:template>

 <xsl:template match="@txt">
  <a href="{.}"
     onclick="return blank('txt',this.href)" 
     class="barbut" 
     title="Text">
   Tekst
  </a>
  &blank;
 </xsl:template>

 <xsl:template match="@txr">
  <a href="{.}" onclick="return blank('kom',this.href)" class="barbut" title="Critical account of the text">
   Tekstredeg&o-;relse
  </a>
  &blank;
 </xsl:template>

 <xsl:template match="@kom">
  <a href="{.}" onclick="return blank('kom',this.href)" class="barbut" title="Explanatory notes">
   Kommentar
  </a>
  &blank;
 </xsl:template>

 <xsl:template match="@ekom">
  <a href="{.}" onclick="return blank('kom',this.href)" class="barbut" title="Explanatory notes">
   E-kommentar
  </a>
  &blank;
 </xsl:template>

 <xsl:template name="vejl">
  <xsl:param name="kat"/>
  <a href="../vejl/{$kat}_d.xml" onclick="return blank('vejl',this.href)" class="barbut" title="Guide">
   Vejledning
  </a>
 </xsl:template>

  <xsl:template match="lin">
   <div>
    <xsl:if test="@ryk!='init'">
     <xsl:attribute name="class">
      <xsl:value-of select="@ryk"/>
     </xsl:attribute>
    </xsl:if>
    <xsl:if test="position()=1 and preceding-sibling::indv">
     <a href="#R{../@id}">
      <xsl:apply-templates select="preceding-sibling::indv"/>
      &blank;
     </a>
    </xsl:if>
    <xsl:apply-templates/>
    <xsl:if test="@dek"><!--put decoration after possible <kor>s-->
     <div class="dek">
      <xsl:call-template name="dekora"/>
     </div>
    </xsl:if>
   </div> 
  </xsl:template>

  <xsl:template name="kolofon">
    <xsl:param name="kat"/>
    <xsl:param name="vis"/>
    <div>
     <div class="plusnav" id="kolop" onclick="showhide('kolo','kolop')" title="Hide/Show colofon">
      <xsl:choose>
       <xsl:when test="$vis">&minus;</xsl:when><xsl:otherwise>+</xsl:otherwise>
      </xsl:choose>
     </div>
     <div class="navigat">
      &blank;Kolofon
     </div>
    </div>
    <div id="kolo" class="kolind">
      <xsl:if test="$vis">
        <xsl:attribute name="style">display:block;</xsl:attribute>
      </xsl:if>
      <p><xsl:apply-templates select="//kolofon/forf|/txr/kolofon/txrforf"/></p>
      <p><xsl:value-of select="$kat"/><i><xsl:apply-templates select="//kolofon/titel"/></i></p>
      <p><xsl:apply-templates select="//kolofon/korttit"/></p>
      <xsl:if test="//kolofon/red.af and not(/txr)">
        <p><i>Redigeret af</i>&blank;<xsl:apply-templates select="//kolofon/red.af"/></p>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="//kolofon/red">
          <p><i>Redaktion</i>&blank;<xsl:apply-templates select="//kolofon/red"/></p>
        </xsl:when>
        <xsl:otherwise>
          <p><i>Udgivet af</i>&blank;<xsl:apply-templates select="//kolofon/udg.af"/></p>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="/kn1/kolofon/etabl.af">
        <p><i>Etableret af</i>&blank;<xsl:apply-templates select="/kn1/kolofon/etabl.af"/></p>
      </xsl:if>
      <xsl:if test="/kn1/kolofon/kilder">
        <p><i>Tekstkilder</i></p>
        <xsl:for-each select="/kn1/kolofon/kilder">
          <p>
            &blank;
            <xsl:call-template name="sigel">
              <xsl:with-param name="s">
                <xsl:value-of select="@kil"/>
              </xsl:with-param>
            </xsl:call-template>
            &blank;
            <xsl:apply-templates/>
          </p>
        </xsl:for-each>
      </xsl:if>
      <p><i>Kodning &blank;</i> <xsl:apply-templates select="//kolofon/kodning"/></p>
      <p>&copy;&blank;<xsl:apply-templates select="//kolofon/copyright"/></p>
      <p><xsl:apply-templates select="//kolofon/fil"/></p>
      <p><xsl:apply-templates select="//kolofon/dato"/></p>
      <p><i>S&o-;ren Kierkegaards Skrifter</i></p>
      <p>Elektronisk version <xsl:value-of select="//kolofon/vers"/>&blank;&copy;&blank;<xsl:value-of select="substring(//kolofon/dato,1,4)"/></p>
      <p><i>ved &blank;</i><xsl:value-of select="//kolofon/ered"/></p>
    </div>
  </xsl:template>

  <xsl:template name="sigel">
    <xsl:param name="s"/>
    <xsl:param name="skil"/>
    <xsl:text> </xsl:text>
    <span class="udg">
      <xsl:choose>
        <xsl:when test="$s='Apunkt'">A&cpunkt;</xsl:when>
        <xsl:when test="$s='Aalfa'">A&alfa;</xsl:when>
        <xsl:when test="$s='aalfa'">a&alfa;</xsl:when>
        <xsl:when test="$s='a1alfa'">a1&alfa;</xsl:when>
        <xsl:when test="$s='a2alfa'">a2&alfa;</xsl:when>
        <xsl:when test="$s='balfa'">b&alfa;</xsl:when>
        <xsl:when test="$s='Ms'">Ms.</xsl:when>
        <xsl:when test="$s='alfa'">&alfa;</xsl:when>
        <xsl:when test="$s='beta'">&beta;</xsl:when>
        <xsl:when test="$s='Bfort'">B-fort.</xsl:when>
        <xsl:when test="$s='Lfort'">L-fort.</xsl:when>
        <xsl:when test="$s='Bafskr'">B-afskrift</xsl:when>
        <xsl:when test="$s='Cafskr'">C-afskrift</xsl:when>
        <xsl:when test="$s='Gafskr'">G-afskrift</xsl:when>
        <xsl:when test="$s='Hafskr'">H-afskrift</xsl:when>
        <xsl:when test="$s='Mafskr'">M-afskrift</xsl:when>
        <xsl:when test="$s='Wafskr'">W-afskrift</xsl:when>
        <xsl:when test="starts-with($s,'EP')"><xsl:text>EP </xsl:text><xsl:value-of select="substring($s,3)"/></xsl:when>
        <xsl:when test="$s='Pap'">Pap.</xsl:when>
        <xsl:when test="$s='Blart'">Bl.art.</xsl:when>
        <!--
        <xsl:when test="$s='KianaIX'">Kiana IX</xsl:when>
        <xsl:when test="$s='Tilskueren1900'">Tilskueren 1900</xsl:when>
        -->
        <xsl:when test="$s='BA'">B&amp;A</xsl:when>
        <xsl:when test="$s='Bogh'">B&o-;gh</xsl:when>
        <xsl:otherwise><xsl:value-of select="$s"/></xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="descendant-or-self::add/udg[@spec='fri']" mode="in-tn"/>
      <xsl:choose>
         <xsl:when test="$skil='komma'"><xsl:text>, </xsl:text></xsl:when>
         <xsl:when test="$skil='semiko'"><xsl:text>; </xsl:text></xsl:when>
         <xsl:when test="$skil='ny'"><xsl:text> &cpunkt; </xsl:text></xsl:when>
         <xsl:when test="$skil='punkt'"><xsl:text>. </xsl:text></xsl:when>
         <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <xsl:template name="dekora">
   <xsl:choose>
    <xsl:when test="@dek='blank'"><br/></xsl:when>
    <xsl:when test="@dek='ast'">*</xsl:when>
    <xsl:when test="@dek='ast2'">* &blank; &blank; &blank; *</xsl:when>
    <xsl:when test="@dek='ast3'">* &blank; * &blank; *</xsl:when>
    <xsl:when test="@dek='ast3op'"><br/>*<br/>* &blank; &blank; &blank; *<br/><br/></xsl:when>
    <xsl:when test="@dek='ast3ned'"><br/>* &blank; &blank; *<br/>*<br/><br/></xsl:when>
    <xsl:when test="@dek='streg3'">&#x2013; &#x2013; &#x2013;</xsl:when>
    <xsl:when test="starts-with(@dek,'vig')"><img class="vignet" src="../vignet/{@dek}.jpg"/></xsl:when>
    <xsl:when test="@dek='klum'"><hr/></xsl:when>
    <xsl:when test="@dek='kryds'"><span class="grad4">&#215;</span></xsl:when>
    <xsl:when test="@dek='dobkors'">#</xsl:when>
    <xsl:when test="@dek='dobkorsblank'">#<br/></xsl:when>
    <xsl:when test="@dek='edobkors'">&edobkors;</xsl:when>
    <xsl:when test="@dek='skil'">&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;</xsl:when>
    <xsl:when test="@dek='skilbag'"><span class="bag">&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;&#x2500;</span></xsl:when>
    <xsl:when test="@dek='dobskil'">&#x2550;&#x2550;&#x2550;&#x2550;&#x2550;&#x2550;&#x2550;&#x2550;&#x2550;&#x2550;</xsl:when>
    <xsl:when test="@dek='blg'"><span class="grad2">~</span></xsl:when>
    <xsl:when test="@dek='blgskil'">&#x223f;&#x223f;&#x223f;&#x223f;&#x223f;&#x223f;&#x223f;&#x223f;&#x223f;</xsl:when>
    <xsl:when test="@dek='blgskilpunkt'">&#x223f;&#x223f;&#x223f;&#x223f;&#x223f;&#x223f;&#x223f;&#x223f;&#x223f;.</xsl:when>
    <xsl:when test="@dek='kors'">&kors;</xsl:when>
    <xsl:when test="@dek='S'"><span class="grad2">~ $ ~</span></xsl:when>
    <xsl:when test="@dek='kors3ned'">+ &blank; +<br/>+</xsl:when>
    <xsl:when test="@dek='streg'">&#x2500;</xsl:when>
    <xsl:when test="@dek='dobstreg'">&#x2550;</xsl:when>
   </xsl:choose>
  </xsl:template>

  <xsl:template match="ant|spa|kur|dt|fed|hoj|lav">
   <span class="{name()}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="bue">
   <span class="bue"><xsl:text>&blank;</xsl:text><xsl:apply-templates/><xsl:text>&blank;</xsl:text></span>
  </xsl:template>

  <xsl:template match="spa[@gen='sic']">
   <span class="spasic"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="spa[@gen='und']">
   <span class="spaund"><xsl:apply-templates/></span>
  </xsl:template>
  
  <xsl:template match="fed[@gen='dobund']">
   <span class="fed dobund"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="typ">
   <span class="{@art}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="gra">
   <xsl:variable name="skyd">
    <xsl:choose>
     <xsl:when test="@str='-1' and @skyd='0'"> skyd1</xsl:when>
     <xsl:when test="@str='-1' and @skyd='+1'"> skyd2</xsl:when>
     <xsl:when test="@str='0' and @skyd='+1'"> skyd1</xsl:when>
    </xsl:choose>
   </xsl:variable>
   <span class="grad{translate(@str,'+','')}{$skyd}">
    <xsl:apply-templates/>
   </span>
  </xsl:template>

  <xsl:template match="vulg">
   <span class="vulg">
    <span class="vulghoj"><xsl:apply-templates select="hoj/node()"/></span>
    <xsl:text>/</xsl:text>
    <span class="vulglav"><xsl:apply-templates select="lav/node()"/></span>
   </span>
  </xsl:template>

  <xsl:template match="stang">
    <span class="stanghoj"><xsl:apply-templates select="hoj/node()"/></span>
    <span class="stanglav"><xsl:apply-templates select="lav/node()"/></span>
  </xsl:template>

  <xsl:template match="rod">
    &rod;<span class="rod"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="blok[substring(@ryk,1,3)='tab']">
   <div>
    <xsl:choose>
     <xsl:when test="@ryk='tabcen'">
      <xsl:attribute name="style">text-align:center</xsl:attribute>
     </xsl:when>
     <xsl:when test="@ryk='tabbag'">
      <xsl:attribute name="style">text-align:right</xsl:attribute>
     </xsl:when>
    </xsl:choose>
    <table>
      <xsl:if test="@ryk='tabbag'"> <!--to please Mozilla el.al.-->
        <xsl:attribute name="style">float:right</xsl:attribute>
      </xsl:if>
      <xsl:for-each select="lin">
        <tr>
          <xsl:for-each select="tab">
            <td class="tab {name(@top)} {name(@hojre)} {name(@bund)} {name(@venstre)}" valign="top">
              <xsl:apply-templates select="@*[contains(name(),'span')]"/>
              <div class="{@ryk}">
                <xsl:apply-templates/>
              </div>
            </td>
          </xsl:for-each>
        </tr>
      </xsl:for-each>
    </table>
    <xsl:if test="@ryk='tabbag'">
     <div style="clear:right"/>
    </xsl:if>
   </div>
  </xsl:template>

  <xsl:template match="@klumspan">
    <xsl:attribute name="colspan">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="@linspan">
    <xsl:attribute name="rowspan">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="blok[@ryk='udspark']">
    <table width="100%">
        <tr>
          <xsl:for-each select="lin/tab[1]">
            <td class="tab" valign="top">
              <div class="{@ryk}">
                <xsl:apply-templates/>
              </div>
            </td>
          </xsl:for-each>
          <xsl:for-each select="lin/tab[last()]">
            <td class="tab" valign="top">
             <xsl:choose>
              <xsl:when test="@ryk">
               <div class="{@ryk}">
                <xsl:apply-templates/>
               </div>
              </xsl:when>
              <xsl:otherwise>
               <div class="bag">
                <xsl:apply-templates/>
               </div>
              </xsl:otherwise>
             </xsl:choose>
            </td>
          </xsl:for-each>
        </tr>
    </table>
  </xsl:template>

  <xsl:template match="blok[@ryk='lyrik']">
    <blockquote>
      <xsl:apply-templates/>
    </blockquote>
  </xsl:template>

  <xsl:template name="tntemp">
    <xsl:for-each select=".//tn">
      <span class="tnote">
        <xsl:attribute name="id">tn<xsl:number level="any"/></xsl:attribute>
            <xsl:apply-templates select=".//udg[@spec='ellipse' and @txt]" mode="in-tn"/>
            <xsl:apply-templates select="text()[normalize-space()!='']/../add"/> <!--for invariant text, reprint <add>-->
            <xsl:if test="add/@kil">
              <xsl:call-template name="sigel">
                <xsl:with-param name="s">
                  <xsl:value-of select="add/@kil"/>
                </xsl:with-param>
                <xsl:with-param name="skil">komma</xsl:with-param>
              </xsl:call-template>
            </xsl:if>
            <xsl:apply-templates select="udg[@spec='fri']|add[contains(@type,'til')]" mode="in-tn"/>
            <xsl:for-each select="sub">
              <xsl:apply-templates select="." mode="in-tn"/>
            </xsl:for-each>
      </span>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="tn">
    <span>
      <xsl:apply-templates/>
    </span><!--no text node here--><a name="dum" class="tn" title="Critical note" onclick="that=this">
       <xsl:attribute name="href">javascript:tny(that,'tn<xsl:number level="any"/>')</xsl:attribute>
      </a>
    <!--tn node will appear here-->
  </xsl:template>

  <xsl:template match="add">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="add[contains(@type,'til')]" mode="in-tn">
    <xsl:text>&blank;</xsl:text>
    <span class="udg">
      tilf&o-;jet
      <xsl:if test="@type='tilmarg'">
        i marginen
      </xsl:if>
    </span>
    <xsl:call-template name="sigel">
      <xsl:with-param name="s">
        <xsl:value-of select="@kil"/>
      </xsl:with-param>
      <xsl:with-param name="skil">
        <xsl:value-of select="following-sibling::sub/@skil"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="sub" mode="in-tn">
    <xsl:text> </xsl:text>
    <xsl:choose>
      <xsl:when test="@type='fs'">
        <span class="udg">f&o-;rst skrevet</span>
      </xsl:when>
      <xsl:when test="@type='aef'">
        <span class="udg">&ae;ndret fra</span>
      </xsl:when>
      <xsl:when test="@type='aefmarg'">
        <span class="udg">&ae;ndret i marginen fra</span>
      </xsl:when>
      <xsl:when test="@type='uvis'">
        <span class="udg">&lt;</span>
      </xsl:when>
      <xsl:when test="@type='sletfor'">
        <span class="udg">foran er slettet</span>
      </xsl:when>
      <xsl:when test="@type='sletbag'">
        <span class="udg">herefter er slettet</span>
      </xsl:when>
      <xsl:when test="@type='mff'">
        <span class="udg">m&aa;ske fejl for</span>
      </xsl:when>
      <xsl:when test="@type='mgl'">
        <span class="udg">ord mangler, fx</span>
      </xsl:when>
      <xsl:when test="@type='so'">
        <span class="udg">s&aa;ledes ogs&aa;</span>
      </xsl:when>
    </xsl:choose>
    <xsl:text> </xsl:text>
    <xsl:apply-templates mode="in-tn"/>
    <xsl:text> </xsl:text>
    <xsl:call-template name="sigel">
      <xsl:with-param name="s">
        <xsl:value-of select="@kil"/>
      </xsl:with-param>
      <xsl:with-param name="skil">
        <xsl:value-of select="following-sibling::sub[1]/@skil"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="sub">
    <!--skip outside tn-->
  </xsl:template>

  <xsl:template match="udg[@spec='fri']" mode="in-tn">
    <xsl:text> </xsl:text>
    <span class="udg"><xsl:value-of select="@txt"/><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="udg" mode="in-tn">
    <xsl:apply-templates select="."/>
  </xsl:template>

  <xsl:template match="udg[@spec='supp']">
    <xsl:variable name="no_ref"><xsl:if test="parent::indv and ancestor::not[@type='mu']">; not referenced in main column by SK</xsl:if></xsl:variable>
    <span class="SKS" title="Supplemented by SKS{$no_ref}">&vsupp;<xsl:apply-templates/>&hsupp;</span>
  </xsl:template>

  <xsl:template match="udg[@spec='tvivl']">
    <span class="SKS" title="Doubious reading">&vtvivl;<xsl:apply-templates/>&htvivl;</span>
  </xsl:template>

  <xsl:template match="udg[@spec='var']">
    <span class="SKS" title="Variant"><sup>&vvar;</sup><xsl:apply-templates/><sup>&hvar;</sup></span>
  </xsl:template>

  <xsl:template match="udg[@spec='slet']">
    <span class="SKS" title="Deleted by SK">&vfod;<xsl:apply-templates/>&hfod;</span>
  </xsl:template>

  <xsl:template match="udg[@spec='ellipse']" mode="in-tn">
    &blank;<i>(...)</i>&blank;
    <xsl:value-of select="@txt"/>
  </xsl:template>

  <xsl:template match="altbeg[@spec='arm']">
    <span>
      <!--empty-->
    </span><!--no text node here--><a name="dum" class="tnx" onClick="that=this" href="javascript:tnx(that)" title="Inserted ms.">&varm;</a><!--no text node here--><span class="tnote">
    <xsl:apply-templates mode="in-tn"/>
    </span>
  </xsl:template>

  <xsl:template match="altbeg[@spec='fod']">
    <span>
      <!--empty-->
    </span><!--no text node here--><a name="dum" class="tnx" onClick="that=this" href="javascript:tnx(that)" title="Deleted">&vfod;</a><!--no text node here--><span class="tnote">
    <xsl:apply-templates mode="in-tn"/>
    </span>
  </xsl:template>

  <xsl:template match="altslut[@spec='arm']">
    <span/><a name="dum" class="tnx">&harm;</a><span/>
  </xsl:template>

  <xsl:template match="altslut[@spec='fod']">
    <span/><a name="dum" class="tnx">&hfod;</a><span/>
  </xsl:template>

  <xsl:template match="fork">
    <span onmouseout="dropkor(this)">
      <xsl:attribute name="onmouseover">dropkor(this,'&anfbeg;<xsl:value-of select='translate(@opl,"&#x27;","´")'/>&anfslut;<xsl:if test="@norm">&blank;(<xsl:value-of select="@norm"/>)</xsl:if>')</xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="dag">
    <span onmouseover="dropkor(this,'dato: {concat(number(substring(@dat,7,2)),'.',number(substring(@dat,5,2)),'.',substring(@dat,1,4))}')"
          onmouseout="dropkor(this)">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="bib">
    <xsl:variable name="bibref">
     <xsl:choose>
      <xsl:when test="@id">
        <xsl:value-of select="@id"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select=".//text()"/>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:variable>
    <span onmouseover="dropkor(this,'Bib. {$bibref}')" onmouseout="dropkor(this)">
     <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="pers|sted">
    <xsl:variable name="norm">
     <xsl:choose>
      <xsl:when test="@norm">
        <xsl:value-of select="@norm"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select=".//text()"/>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:variable>
    <span onmouseover="dropkor(this,'{$norm}')" onmouseout="dropkor(this)">
     <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="lit">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="udpkt">
    . . . <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="refs">
    <a href="#s{@id}" onclick="showpage('s{@id}')">
      <xsl:value-of select="@id"/>
    </a>
  </xsl:template>

  <xsl:template match="refs[@tit]">
    <a href="../{@tit}/txt.xml#s{@id}">
      <xsl:value-of select="@id"/>
    </a>
  </xsl:template>

  <xsl:template match="refi">
    <xsl:variable name="id">
      <xsl:choose>
        <xsl:when test="@id"><xsl:value-of select="@id"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="ill/@id"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <a class="ill"
       title="Facsimile"
       href="ill_{$id}.htm"
       onclick="return blank('res',this.href,screen.availWidth/2,screen.availHeight-100)">
      <xsl:if test="ill or not(//ill[@id=$id]) and not(preceding::refi[@id=$id])"> <!--choose the refi that contains the <ill> or, if the <ill> is not in this file, pick the first one-->
        <xsl:attribute name="id">ill<xsl:value-of select="$id"/></xsl:attribute>
      </xsl:if>
      fax
    </a>
  </xsl:template>

  <xsl:template match='refx'>
    <xsl:variable name="tit"><xsl:choose><xsl:when test="@tit"><xsl:value-of select="@tit"/></xsl:when><xsl:otherwise><xsl:value-of select="//kolofon/korttit"/></xsl:otherwise></xsl:choose></xsl:variable>
    <xsl:variable name="nr"><xsl:if test="@nr">#k<xsl:value-of select="substring-before(concat(@nr,'.'),'.')"/></xsl:if></xsl:variable>
    <xsl:variable name="side"><xsl:if test="@side">#ss<xsl:value-of select="@side"/></xsl:if></xsl:variable>
    <xsl:choose>
      <xsl:when test="@pap and (@type='jp' or @type='uts')">
        <xsl:apply-templates/>
        <xsl:if test="@nr">
          [<a onclick="return blank('txt',this.href)"
              href="../{@tit}/txt.xml{$nr}">
             <xsl:choose>
               <xsl:when test="starts-with(@tit,'p') or starts-with(@tit,'P')"><xsl:text>Papir </xsl:text><xsl:value-of select="@nr"/></xsl:when>
               <xsl:when test="@type='uts'"><xsl:value-of select="@tit"/></xsl:when>
               <xsl:otherwise><xsl:value-of select="@tit"/><xsl:text>:</xsl:text><xsl:value-of select="@nr"/></xsl:otherwise>
             </xsl:choose>
           </a>]
        </xsl:if>
      </xsl:when>
      <xsl:when test="@ba and @type='bd' and @nr">
        <xsl:apply-templates/>
          [<a onclick="return blank('txt',this.href)"
              href="../{@tit}/txt.xml#k{@nr}">
             <xsl:choose>
               <xsl:when test="starts-with(@tit,'b')">
                 <xsl:text>Brev </xsl:text>
               </xsl:when>
               <xsl:otherwise>
                 <xsl:value-of select="@tit"/>
               </xsl:otherwise>
             </xsl:choose>
             <xsl:value-of select="@nr"/>
           </a>]
      </xsl:when>
      <xsl:when test="(@type='jp' or @type='bd') and @nr">
        <a onclick="return blank('txt',this.href)"
           href="../{$tit}/txt.xml{$nr}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="@type='jp' and @side"> <!--ved henvisning til ms. sider bruges <refs>-->
        <a onclick="return blank('txt',this.href)"
           href="../{$tit}/txt.xml{$side}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="@sv2 and (@type='ts' or @type='uts')">
        <xsl:apply-templates/>
        <!--xsl:if test="@side"-->
          [<a onclick="return blank('txt',this.href)"
              href="../{@tit}/txt.xml{$side}">
             <xsl:value-of select="@tit"/>
             <xsl:if test="@side">, <xsl:value-of select="@side"/></xsl:if>
           </a>]
        <!--/xsl:if-->
      </xsl:when>
      <xsl:when test="@type='ts' or @type='uts'">
        <a onclick="return blank('txt',this.href)"
           href="../{$tit}/txt.xml{$side}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="@type='kom'">
        <a onclick="return blank('kom',this.href)"
           href="../{$tit}/kom.xml#k{substring-after(@id,'-')}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="@type='ekom'">
        <a onclick="return blank('kom',this.href)"
           href="../{$tit}/ekom.xml#k{substring-after(@id,'-')}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="@type='int'"> 
        <a onclick="return blank('kom',this.href)"
           href="../{$tit}/int_{@id}.xml{$side}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="@type='txr'">
        <a onclick="return blank('kom',this.href)"
           href="../{$tit}/txr.xml{$side}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="@type='ill'">
        <a onclick="return blank('res',this.href,screen.availWidth/2,screen.availHeight-100)"
           href="../{$tit}/ill_{@id}.htm">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="@type='kort'">
        <a onclick="return blank('res',this.href)" 
           href="../kort/{@nr}_{@id}.htm"
           title="See map">
          <xsl:text>&hpil; </xsl:text>
          <img src="../vignet/glob.gif" class="inlicon"/>
        </a>
      </xsl:when>
      <xsl:when test="@ba and @type='dok'">
        <xsl:apply-templates/>
        <xsl:if test="@nr">
          [<a onclick="return blank('txt',this.href)"
              href="../dok/txt.xml{$nr}">
             <xsl:text>Dok </xsl:text><xsl:value-of select="@nr"/>
           </a>]
        </xsl:if>
      </xsl:when>
      <xsl:when test="@type='pdf'">
        <a onclick="return blank('pdf',this.href)" 
           href="../{@tit}/dok_{@id}.pdf"
           title="See document">
          <xsl:text>&hpil; </xsl:text>
          <img src="../vignet/pdf.gif" class="inlicon"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose> 
  </xsl:template>

  <xsl:template match="kom">
   <span id="r{substring-after(@id,'-')}">
    <a class="k" 
       name="r{substring-after(@id,'-')}" 
       href="{/kn1/ts/@kom|/kn1/uts/@kom|/kn1/jp/@kom|/kn1/bd/@kom}#k{substring-after(@id,'-')}"
       onclick="return blank('kom',this.href,430)">
     <xsl:text> </xsl:text>
    </a>
   </span>
   <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="kom[@x='e']">
   <a class="k"
      name="r{substring-after(@id,'-')}"
      id="r{substring-after(@id,'-')}"
      href="{/kn1/ts/@ekom|/kn1/jp/@ekom}#k{substring-after(@id,'-')}"
      onclick="return blank('kom',this.href,430)"
      style="background-color:silver"
      title="SKS-E note">
    <xsl:text> </xsl:text>
   </a>
   <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="kor[@kil='SK' or not(@kil)]">
    <span class="stregSK">|</span><a class="korSK" name="s{@id}" id="s{@id}"><span class="kor"><xsl:value-of select="@id"/></span></a>
  </xsl:template>

  <xsl:template match="kor[@kil='supp']">
    <span class="stregSK">|</span><a class="korSK" name="s{@id}" id="s{@id}"><span class="kor">[<xsl:value-of select="@id"/>]</span></a>
  </xsl:template>

  <xsl:template match="kor[@kil='SKS' and not( following-sibling::*[ position()=1 and name()='kor' and @kil='SKS'])]">
    <span id="ss{@id}"><a class="korSKS" name="dum{@id}" title="SKS page" href="http://sks.dk/{/kn1/kolofon/korttit}/txt.xml#ss{@id}">|<span class="kor"><xsl:value-of select="/kn1/kolofon/bind"/>, <xsl:value-of select="@id"/></span></a></span>
  </xsl:template>

  <xsl:template match="kor[@kil='Pap']">
    <a name="dum" class="korPap"><span class="kor">Pap.<xsl:value-of select="@id"/></span></a>
  </xsl:template>

  <!--xsl:template match="kor">
    <a class="kor{@kil}" name="dum">|<span class="kor"><xsl:value-of select="@id"/></span></a>
  </xsl:template-->

  <xsl:template match="kolofon"/>

  <xsl:variable name="copyright">
    <p class="copyright">SKS-E <xsl:value-of select="//kolofon/vers"/> sks.dk &copy;&blank;<xsl:value-of select="substring(//kolofon/dato,1,4)"/> S&o-;ren Kierkegaard Forskningscenteret ved K&o-;benhavns Universitet</p>
  </xsl:variable>

  <xsl:template name="reshead">
   <h1 class="reshead"><xsl:value-of select="//kolofon/titel"/></h1>
   <p><span class="bar">
     <a title="Home" href="../forside/indhold.asp" onclick="return blank('SKStop',this.href)">&hjem;</a>
     &blank;&cpunkt;&blank;
     <xsl:if test="//plusref">
       <xsl:apply-templates select="//plusref"/>
       &blank;&cpunkt;&blank;
     </xsl:if>
     <a onclick="return blank('vejl',this.href)" href="../vejl/{//kolofon/korttit}_d.xml" title="Guide">
       Vejledning
     </a>
     &blank;&blank;&blank;
   </span></p>
   <br/>
  </xsl:template>

  <xsl:template name="kapside"> <!-- sidetal for dette kapitel eller optegnelse -->
    <xsl:param name="kil"/>
    <xsl:param name="sigel"/>
    <xsl:param name="korclass" select="$kil"/>
    <xsl:param name="bubble" select="$kil"/>
    <xsl:variable name="n" select="(.//kor[contains(concat('#',$kil,'#'),concat('#',@kil,'#'))])[1]"/> <!--naeste kor-->
    <xsl:variable name="f" select="./preceding::kor[contains(concat('#',$kil,'#'),concat('#',@kil,'#'))][1]"/> <!--forrige kor-->
    <xsl:variable name="id">
      <xsl:choose>
        <xsl:when test="$n and not($n/preceding-sibling::text() or $n/ancestor::lin/preceding-sibling::*//text())">
          <xsl:value-of select="$n/@id"/>
        </xsl:when>
        <xsl:when test="$f and ($f/preceding-sibling::text() or $f/ancestor::lin/preceding-sibling::*//text())">
          <xsl:value-of select="$f/@id"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:if test="normalize-space($id)">
      <xsl:text> </xsl:text>
      <a name="dum" class="kor{$korclass}" title="{$bubble}">
        <xsl:copy-of select="$sigel"/>
        <xsl:value-of select="$id"/>
      </a>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
