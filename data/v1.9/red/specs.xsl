<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/xhtml" version="1.0">
 <!--KK 2012-06-29-->

 <xsl:import href="../kn1/skskom.xsl"/>
 <xsl:import href="../kn1/sksjp.xsl"/>
 <xsl:import href="../kn1/sksts.xsl"/>
 <xsl:import href="../kn1/sksbd.xsl"/>
 
 <xsl:output encoding="UTF-8" indent="yes"/>

 <xsl:template match="/">
  <html>
   <head>
    <title><xsl:value-of select="//kolofon/titel"/></title>
    <link rel="stylesheet" type="text/css" href="../kn1/sks.css"/>
    <style type="text/css">
     html {font: 12pt Times,serif,Arial Unicode MS}
     body {margin: 1em}
     div p.rubrik {font-size: 200%}
     div div p.rubrik {font-size: 150%}
     div div div p.rubrik {font-size: 120%}
     div div div div p.rubrik {font-size: 100%; font-weight: bold}
     div div div div div p.rubrik {font-style: italic}
     p, table {margin: 1em 0 1em 0}
     td {padding: 0 .5em 0 .5em}
     .TOC {margin-left: 1em; font-size: 90%}
     .ex, .vert {color: navy; border: 1px solid; margin: 2px 0 2px 0}
     .x, .ename, .cont, .aname, .atype {font-family: monospace; font-weight: bold; color: maroon}
     .sks-e {font: 14px Georgia,serif,Arial Unicode MS;}
     .korSV3, .korPap, .korSKS {display: inline}
     .tnote {display: inline; background-color: white}
     .tnotex {margin-top: 1em; border-top: solid 1px; padding-top: .5em}
     .vert {font-size: 70%; padding: .5em}
     th {color: silver; font-style: italic}
     .elem {border: solid 1px}
     .ename {background-color: silver; font-size:150%; text-align: center; padding: .25em}
     .adef {font-style: italic}
     .rednote {color: #c08080}
     .blok {margin-left: 1em}
     .specsblock  {font-size: 80%; line-height: 1.2; margin: .5em 0 .5em .5em}
     .kapv, .kaptxt {display: block}
    </style>
    <script type="text/javascript" src="../kn1/highlight.js">
     // empty
    </script>
    <script type="text/javascript" src="../kn1/sks.js">
     // empty
    </script>
    <script type="text/javascript">
      function specsposmn() {
       for ( var i=0; i&lt;document.anchors.length; i++ ) {
        var a= document.anchors[i];
        if ( a.name=='Rjj-106.a' ) {
          posmn( a, 'jj-106.a', 0 );
        }
        if ( a.name=='Rjj-108.a' ) {
          posmn( a, 'jj-108.a', 0 );
        }
       }
      }
    </script>
   </head>
   <body onload="highlight();specsposmn()">
    <h1><xsl:value-of select="//kolofon/titel"/></h1>
    <h2>Revideret udgave <xsl:value-of select="//kolofon/vers"/></h2>
    <p style="font-style: italic"><xsl:value-of select="//kolofon/forf"/></p>
    <p style="font-size: 80%">
     V. <xsl:value-of select="//kolofon/vers"/>;
     <a href="{//kolofon/fil}"><xsl:value-of select="//kolofon/fil"/></a><br/>
     Pdf version <a href="{//kolofon/pfil}"><xsl:value-of select="//kolofon/pfil"/></a><br/>
     <xsl:value-of select="//kolofon/dato"/>
    </p>
    <xsl:apply-templates/>
    <div id="xspace"/>
   </body>
  </html>
 </xsl:template>

 <xsl:template match="specs">
   <h2>Indhold</h2>
   <div style="font-size:120%"> 
    <xsl:call-template name="TOC">
     <xsl:with-param name="tag" select="'sekt'"/>
     <xsl:with-param name="format" select="'1'"/>
    </xsl:call-template>
    <xsl:call-template name="TOC">
     <xsl:with-param name="tag" select="'app'"/>
     <xsl:with-param name="format" select="'A'"/>
    </xsl:call-template>
   </div>
   <xsl:apply-templates/>
 </xsl:template>

 <xsl:template name="TOC">
  <xsl:param name="tag"/>
  <xsl:param name="format"/>
   <xsl:for-each select="*[name()=$tag]">
    <div class="TOC">
     <xsl:number level="multiple" format="{$format}"/>
     <xsl:text> </xsl:text>
     <a>
      <xsl:attribute name="href">#sekt.<xsl:number count="sekt|app" level="multiple"/></xsl:attribute>
      <xsl:value-of select="rubrik"/>
     </a>
     <xsl:if test="sekt">
      <xsl:call-template name="TOC">
       <xsl:with-param name="tag" select="'sekt'"/>
       <xsl:with-param name="format" select="'1'"/>
      </xsl:call-template>
     </xsl:if>
    </div>
   </xsl:for-each>
 </xsl:template>

 <xsl:template match="sekt">
  <div>
   <a>
    <xsl:attribute name="id">sekt.<xsl:number level="multiple"/></xsl:attribute>
   </a>
   <p class="rubrik">
    <xsl:number level="multiple"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="rubrik/node()"/>
   </p>
   <xsl:apply-templates/>
  </div>
 </xsl:template>

 <xsl:template match="rubrik"/>

 <xsl:template match="synx">
  <xsl:choose>
   <xsl:when test="@import">
    <xsl:variable name="import" select="@import"/>
    <xsl:apply-templates select="//app/synx/*[name=$import]" mode="easyread"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="ent">
  <div>
   <a id="dtd.{name}"/>
   <br/>
   <code>
    &lt;!ENTITY %
    <xsl:apply-templates select="name"/><xsl:text> "</xsl:text>
    <xsl:apply-templates select="val"/>"
    &gt;
   </code>
  </div>
 </xsl:template>

 <xsl:template match="ent" mode="easyread">
  <xsl:variable name="ename" select="name/text()"/>
   <table class="attr">
    <tr>
     <th>Samlebegreb</th>
     <th>som kan være</th>
    </tr>
    <tr>
     <td class="aname"><xsl:value-of select="name"/></td>
     <td class="atype">" <xsl:apply-templates select="val" mode="easyread"/> "</td>
    </tr>
   </table>
  <a href="#dtd.{$ename}">[DTD]</a>

 </xsl:template>

 <xsl:template match="val/text()|attr/type/text()" mode="easyread">
  <xsl:call-template name="barformat">
   <xsl:with-param name="t" select="."/>
  </xsl:call-template>
 </xsl:template>

 <xsl:template name="barformat">
  <xsl:param name="t"/>
  <xsl:choose>
   <xsl:when test="contains($t,'|')">
    <xsl:value-of select="substring-before($t,'|')"/>
    <br/>|
    <xsl:call-template name="barformat">
     <xsl:with-param name="t" select="substring-after($t,'|')"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$t"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="elem">
  <div>
   <a id="dtd.{name}"/>
   <br/>
   <code>
    &lt;!ELEMENT
    <xsl:apply-templates select="name"/><xsl:text> </xsl:text>
    <xsl:apply-templates select="cont"/>
    &gt;
   </code>
  </div>
  <xsl:if test="attr">
   <div>
    <code>
     &lt;!ATTLIST
     <xsl:value-of select="name"/><xsl:text> </xsl:text>
     <xsl:for-each select="attr">
      <br/> 
      <xsl:for-each select="node()">
       <xsl:apply-templates select="."/>
       <xsl:text> </xsl:text>
      </xsl:for-each>
<!--
      <xsl:value-of select="name"/><xsl:text> </xsl:text>
      <xsl:apply-templates select="type"/><xsl:text> </xsl:text>
      <xsl:value-of select="def"/>
-->
     </xsl:for-each>
     &gt;
    </code>
   </div>
  </xsl:if>
 </xsl:template>

 <xsl:template match="def">
  <xsl:choose>
   <xsl:when test="contains(text(),'IMPLIED')">
    #IMPLIED
   </xsl:when>
   <xsl:when test="contains(text(),'REQUIRED')">
    #REQUIRED
   </xsl:when>
   <xsl:otherwise>
    "<xsl:value-of select="."/>"
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="elem" mode="easyread">
  <xsl:variable name="ename" select="name/text()"/>
  <table class="elem">
   <tr>
    <th>Elementnavn</th>
    <th>Indhold</th>
   </tr>
   <tr>
    <td class="ename"><xsl:value-of select="$ename"/></td>
    <td class="cont"><xsl:apply-templates select="cont"/></td>
   </tr>
  </table>
  <xsl:if test="attr">
   <table class="attr">
    <tr>
     <th>Attributnavn</th>
     <th>mulig værdi</th>
     <th/>
    </tr>
    <xsl:for-each select="attr">
     <tr>
      <td class="aname"><xsl:value-of select="text()[.='%']"/><xsl:value-of select="name"/><xsl:value-of select="text()[.=';']"/></td>
      <td class="atype"><xsl:apply-templates select="type" mode="easyread"/></td>
      <td class="adef"><xsl:apply-templates select="def" mode="easyread"/></td>
     </tr>
    </xsl:for-each>
   </table>
  </xsl:if>
  <a href="#dtd.{$ename}">[DTD]</a>
 </xsl:template>

 <xsl:template match="def" mode="easyread">
  <xsl:choose>
   <xsl:when test="contains(text(),'IMPLIED')">
    Valgfri
   </xsl:when>
   <xsl:when test="contains(text(),'REQUIRED')">
    Krævet
   </xsl:when>
   <xsl:otherwise>
    "<xsl:value-of select="."/>"
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="refent|refelem|refaval|refpcd|name">
  <xsl:apply-templates select="." mode="easyread"/>
 </xsl:template>

 <xsl:template match="refent|refelem|refaval|refpcd|name" mode="easyread">
  <xsl:variable name="name" select="text()"/>
  <xsl:variable name="id"><xsl:for-each select="//sekt[synx/@import=$name or synx/*/name/text()=$name]">sekt.<xsl:number level="multiple"/></xsl:for-each></xsl:variable>
  <xsl:choose>
   <xsl:when test="$id!=''">
    <a href="#{$id}">
     <xsl:apply-templates/>
    </a>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="sem">
  <p>
   <xsl:apply-templates/>
  </p>
 </xsl:template>

 <xsl:template match="ex">
  <xsl:if test="not(@gen) or @gen!='-kn1-sks'">
  <div class="ex">
   <xsl:if test="not(@gen) or not(contains(@gen,'-kn1'))">
    <blockquote class="specsblock">
     <code><xsl:apply-templates mode="ex"/></code>
    </blockquote>
   </xsl:if>
   <xsl:if test="not(@gen) or not(contains(@gen,'-sks'))">
    <blockquote class="sks-e">
     <div>
      <xsl:apply-templates/>
     </div>
     <xsl:if test=".//tn">
      <div class="tnotex">
       <xsl:apply-templates select=".//tn/text()|.//tn/e|.//tn/add|.//tn//udg[@txt]" mode="lemma"/>]
       <xsl:call-template name="tntemp"/>
      </div>
     </xsl:if>
    </blockquote>
   </xsl:if>
  </div>
  </xsl:if>
 </xsl:template>

 <xsl:template match="ex[@vis='vert']">
  <xsl:variable name="gen" select="@gen"/>
  <table class="vert">
   <xsl:for-each select="*[name()!='forkl']">
    <tr>
     <xsl:if test="not(contains($gen,'-kn1'))">
      <td>
       <code>
       <xsl:choose>
        <xsl:when test=".//tn">
         <xsl:apply-templates select="tn/node()" mode="ex"/>
        </xsl:when>
        <xsl:when test="name()='span'">
         <xsl:apply-templates mode="ex"/>
        </xsl:when>
        <xsl:otherwise>
         <xsl:apply-templates select="." mode="ex"/>
        </xsl:otherwise>
       </xsl:choose>
       </code>
      </td>
     </xsl:if>
     <xsl:if test="not(contains($gen,'-sks'))">
      <xsl:choose>
       <xsl:when test=".//tn">
        <td class="tnotex">
         <xsl:call-template name="tntemp"/>
        </td>
       </xsl:when>
       <xsl:otherwise>
        <td class="sks-e"><xsl:apply-templates select="."/></td>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:if>
     <td><xsl:apply-templates select="following-sibling::*[1][name()='forkl']"/></td>
    </tr>
   </xsl:for-each>
  </table>
 </xsl:template>

 <xsl:template match="kap|rub|opt|hs|ms|not|blok|lin|tab|k|lemma|klin|ts|jp|kolofon|kolofon/*|datering|tiltale|txt|hilsen|efterskrift|endtit|udskrift" mode="ex">
  <div>
   <xsl:if test="not(parent::ex)">
    <xsl:attribute name="class"><xsl:value-of select="&quot;blok&quot;"/></xsl:attribute>
   </xsl:if>
   <xsl:call-template name="elemex"/>
  </div>
 </xsl:template>

 <xsl:template match="*" mode="ex">
  <xsl:call-template name="elemex"/>
 </xsl:template>

 <xsl:template name="elemex">
  <xsl:choose>
   <xsl:when test="child::node()">
    <b class="x">&lt;<xsl:value-of select="name()"/><xsl:apply-templates select="@*" mode="ex"/>&gt;</b><xsl:apply-templates mode="ex"/><b class="x">&lt;/<xsl:value-of select="local-name()"/>&gt;</b>
   </xsl:when>
   <xsl:otherwise>
    <b class="x">&lt;<xsl:value-of select="name()"/><xsl:apply-templates select="@*" mode="ex"/>/&gt;</b>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="comment()" mode="ex">
  <b class="x">&lt;!--<xsl:value-of select="."/>--&gt;</b>
 </xsl:template>

 <xsl:template match="synx/comment()">
  <code>&lt;!--<xsl:value-of select="."/>--&gt;</code>
 </xsl:template>

 <xsl:template match="processing-instruction()" mode="ex">
  <b class="x">&lt;?<xsl:value-of select="."/>?&gt;</b>
 </xsl:template>

 <xsl:template match="e[not(*)]" mode="ex"> <!--char. entity, not the category-->
  <b class="x"><xsl:text>&amp;</xsl:text><xsl:value-of select="@name"/>;</b>
 </xsl:template>

 <xsl:template match="@*" mode="ex">
  <xsl:text> </xsl:text>
  <xsl:value-of select="name()"/>
  <xsl:text>="</xsl:text>
  <xsl:choose> <!--for a most special case-->
   <xsl:when test="contains(.,'–')">
    <xsl:value-of select="concat(substring-before(.,'–'), '&amp;streg;', substring-after(.,'–'))"/>
   </xsl:when>
   <xsl:when test="contains(.,'æ') and contains(.,'å')">
    <xsl:value-of select="concat(substring-before(.,'å'), '&amp;aa;', substring-before(substring-after(.,'å'),'æ'), '&amp;ae;', substring-after(.,'æ'))"/>
   </xsl:when>
   <xsl:when test="contains(.,'ø')">
    <xsl:value-of select="concat(substring-before(.,'ø'), '&amp;o-;', substring-after(.,'ø'))"/>
   </xsl:when> <!--grisekode!-->
   <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
  </xsl:choose>
  <xsl:text>"</xsl:text>
 </xsl:template>

 <xsl:template match="udg[@spec='ellipse']" mode="in-tn"/>

 <xsl:template match="udg[@spec='ellipse']" mode="lemma">
  <xsl:text> </xsl:text>
  <i>(...)</i>
  <xsl:text> </xsl:text>
  <xsl:value-of select="@txt"/>
 </xsl:template>

 <xsl:template match="ex[@lang='dt']/dt">
  <span style="font-family: Candara, Century Gothic, Futura Book BT, sans-serif">
   <xsl:apply-templates/>
  </span>
 </xsl:template>

 <xsl:template match="dt">
  <xsl:apply-templates/>
 </xsl:template>

 <xsl:template match="ex[@gen='+sks-b']/ref[@type='sk']">
  <sup><xsl:number/></sup><xsl:text> </xsl:text>
 </xsl:template>

 <xsl:template match="refk[@gen='+sks-b']">
  → <xsl:value-of select="@side"/>,<span style="font-family:Palatino Linotype;font-size:80%;font-style:italic"><xsl:value-of select="@linie"/></span>
 </xsl:template>

 <xsl:template match="lb">
  <br/>
 </xsl:template>

 <xsl:template match="lb" mode="ex">
  <br/>
 </xsl:template>

 <xsl:template match="refsekt">
  <xsl:choose>
   <xsl:when test="@id">
    <xsl:variable name="to" select="@id"/>
    <xsl:for-each select="//sekt[@id=$to]"> <!--with sekt[...] as context-->
     <a>
      <xsl:attribute name="href">#sekt.<xsl:number level="multiple"/></xsl:attribute>
      <xsl:number level="multiple"/>
     </a>
    </xsl:for-each>
   </xsl:when>
   <xsl:when test="@tag">
    <xsl:variable name="to"><xsl:value-of select="@tag"/></xsl:variable>
    <xsl:for-each select="//sekt[synx/@import=$to]">
     <a>
      <xsl:attribute name="href">#sekt.<xsl:number level="multiple"/></xsl:attribute>
      <xsl:number level="multiple"/>
     </a>
    </xsl:for-each>
   </xsl:when>
   <xsl:when test="@aval">
    <xsl:variable name="to"><xsl:value-of select="@aval"/></xsl:variable>
    <xsl:for-each select="//sekt[synx/*/name/text()=$to]">
     <a>
      <xsl:attribute name="href">#sekt.<xsl:number level="multiple"/></xsl:attribute>
      <xsl:number level="multiple"/>
     </a>
    </xsl:for-each>
   </xsl:when>
   <xsl:otherwise>
    <xsl:variable name="to"><xsl:value-of select="@*"/></xsl:variable>
    <xsl:for-each select="//sekt[synx/@import=$to or synx/*/name/text()=$to]">
     <a>
      <xsl:attribute name="href">#sekt.<xsl:number level="multiple"/></xsl:attribute>
      <xsl:number level="multiple"/>
     </a>
    </xsl:for-each>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="tag">
  <code class="x">&lt;<xsl:apply-templates/>&gt;</code>
 </xsl:template>

 <xsl:template match="note">
  <p>
   <a>
    <xsl:attribute name="id">note.<xsl:number count="sekt|note" level="multiple"/></xsl:attribute>
    Note <xsl:number/>
   </a>
   <xsl:text> </xsl:text>
   <xsl:apply-templates/>
  </p>
 </xsl:template>

 <xsl:template match="refnote">
  <xsl:variable name="id"><xsl:value-of select="@id"/></xsl:variable>
  <xsl:variable name="cont"><xsl:value-of select="."/></xsl:variable>
  <xsl:for-each select="ancestor::sekt[1]//note[@id=$id]">
   <a>
    <xsl:attribute name="href">#note.<xsl:number count="sekt|note" level="multiple"/></xsl:attribute>
    <xsl:value-of select="$cont"/><sup><xsl:number/></sup>
   </a>
  </xsl:for-each>
 </xsl:template>

 <xsl:template match="app">
  <div>
   <a>
    <xsl:attribute name="id">sekt.<xsl:number count="sekt|app" level="multiple"/></xsl:attribute>
    <p class="rubrik">
     Appendiks <xsl:number format="A"/>
    </p>
   </a>
   <div>
    <p class="rubrik">
     <xsl:apply-templates select="rubrik/node()"/>
    </p>
   <xsl:apply-templates/>
   </div>
  </div>
 </xsl:template>

 <xsl:template match="refapp">
  <xsl:variable name="id"><xsl:value-of select="@id"/></xsl:variable>
  <xsl:for-each select="//app[@id=$id]">
   <a>
    <xsl:attribute name="href">#sekt.<xsl:number count="sekt|app" level="multiple"/></xsl:attribute>
    <xsl:text>appendiks </xsl:text><xsl:number format="A"/>
   </a>
  </xsl:for-each>
 </xsl:template>

 <xsl:template match="lit">
  <p>
   <a id="lit.{@id}">[<xsl:value-of select="@id"/>]</a>
   <xsl:text> </xsl:text>
   <xsl:apply-templates/>
  </p>
 </xsl:template>

 <xsl:template match="reflit">
  <xsl:variable name="id"><xsl:value-of select="@id"/></xsl:variable>
  <xsl:for-each select="//lit[@id=$id]">
   <a href="#lit.{@id}">[<xsl:value-of select="@id"/>]</a>
  </xsl:for-each>
 </xsl:template>

 <xsl:template match="processing-instruction('elem-index')">
  <table>
   <xsl:for-each select="//app/synx/elem/name">
    <xsl:sort/>
    <xsl:variable name="elem" select="text()"/>
    <xsl:if test="//sekt/synx/@import=$elem">
     <tr>
      <td class="x"><xsl:value-of select="$elem"/></td>
      <xsl:for-each select="//sekt[synx/@import=$elem]">
       <td>
        <a>
         <xsl:attribute name="href">#sekt.<xsl:number level="multiple"/></xsl:attribute>
         <xsl:number level="multiple"/>
        </a>
       </td>
       <td><xsl:value-of select="rubrik"/></td>
      </xsl:for-each>
     </tr>
    </xsl:if>
   </xsl:for-each>
  </table>
 </xsl:template>

 <xsl:template match="processing-instruction('sag-index')">
  <table>
   <xsl:for-each select="//term">
    <xsl:sort/>
     <tr>
      <td><xsl:value-of select="text()"/></td>
      <xsl:for-each select="ancestor::sekt[1]">
       <td>
        <a>
         <xsl:attribute name="href">#sekt.<xsl:number level="multiple"/></xsl:attribute>
         <xsl:number level="multiple"/>
        </a>
       </td>
       <td><xsl:value-of select="rubrik"/></td>
      </xsl:for-each>
     </tr>
   </xsl:for-each>
  </table>
 </xsl:template>

 <xsl:template match="valgfri">
  [<xsl:apply-templates/>]
 </xsl:template>

 <xsl:template match="x">
  <code class="x"><xsl:apply-templates/></code>
 </xsl:template>

<!--only for internal use
 <xsl:template match="a-int">
  <xsl:apply-templates/>
  <xsl:text> </xsl:text>
  <a href="file:///{@href}">[<xsl:value-of select="@href"/>]</a>
 </xsl:template>
-->

 <xsl:template match="em|cit|tit|frspr|term">
  <i>
   <xsl:apply-templates/>
  </i>
 </xsl:template>

 <xsl:template match="s.k.">
  '<xsl:apply-templates/>'
 </xsl:template>

 <xsl:template match="html:*">
  <xsl:element name="{local-name()}"><!--MSIE hack-->
   <xsl:for-each select="@*">
    <xsl:attribute name="{name()}">
     <xsl:value-of select="."/>
    </xsl:attribute>
   </xsl:for-each>
   <xsl:apply-templates/>
  </xsl:element>
 </xsl:template>

 <xsl:template match="red.note">
  <span class="rednote">[<xsl:apply-templates/>
   <xsl:text> </xsl:text>
   <i>(red.note)</i>]</span>
 </xsl:template>

</xsl:stylesheet>