<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
 <!ENTITY up "ABCDEFGHIJKLMNOPQRSTUVWXYZ">
 <!ENTITY low "abcdefghijklmnopqrstuvwxyz">
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:TEI="http://www.tei-c.org/ns/1.0"
 version="1.0">
 
 <!-- tei2htm.xsl
  html presentation of SKS
  KK 2016-12-15 -->
 
 <xsl:import href="tei2htm.app.xsl"/>
 
 <xsl:template match="TEI:TEI">
  <html>
   <head>
    <title>
     <xsl:value-of select="TEI:teiHeader//TEI:title[@type='short']"/>;
     html version
    </title>
    <style type="text/css">
     a {color: #008bbc; text-decoration: none}
     a:hover {color: darkorange}
     .kolofon {width: 30em; margin: 5em; font-size: 80%; text-align: center}
     .versaler {text-transform: uppercase}
     .italic {font-style: italic}
     .small {font-size: 12px}
     .large {font-size: 120%}
     .SKSblue {color: #008bbc;}
     .pageNo {text-align: right; margin-bottom: 1em; font: normal normal normal 12px serif}
     .print {width: 30em; text-align: justify}
     .ms {width: 40em; text-align: left}
     .mainColumn {width: 25em; padding-right: 1em}
     .marginalColumn {width: 15em; font-size: 85%; padding-left: 1em}
     .decoration {margin: 1em 0 1em 0; text-align: center}
     .subnote {padding-left: 1em; font-size: smaller}
     .lyrics {padding-left: 1em; font-size: smaller; margin: 1em}
     <xsl:apply-templates select="TEI:teiHeader/TEI:encodingDesc/TEI:tagsDecl/TEI:rendition"/>
    </style>
   </head>
   <body>
    <div class="SKSblue" style="border: thin solid; padding: 5px">TEI version af <xsl:value-of select="//TEI:change[1]/TEI:date"/></div>
    <xsl:apply-templates/>
   </body>
  </html>
 </xsl:template>
 
 <xsl:template match="TEI:rendition[not(@scheme) or @scheme='css']">
  <xsl:text>.</xsl:text>
  <xsl:value-of select="@xml:id"/>
  <xsl:apply-templates select="@scope"/>
  <xsl:text>{</xsl:text>
  <xsl:choose>
   <xsl:when test="@xml:id='spa'">font-style: italic</xsl:when>
   <xsl:when test="@xml:id='und'">font-style: italic</xsl:when>
   <xsl:when test="@xml:id='dun'">font-weight: bold</xsl:when>
   <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
  </xsl:choose>
  <xsl:text>}
  </xsl:text>
 </xsl:template>
 
 <xsl:template match="TEI:rendition[@scheme='free']">
  <xsl:text>.</xsl:text>
  <xsl:value-of select="@xml:id"/>
  <xsl:apply-templates select="@scope"/>
  <xsl:text>{</xsl:text>
  <xsl:choose>
   <xsl:when test="@xml:id='ant'">font-family: sans-serif; font-size: 85%</xsl:when>
   <xsl:when test="@xml:id='lat'">font-family: sans-serif; font-size: 85%</xsl:when>
   <xsl:when test="@xml:id='schwTyp'">font-wieght: bold</xsl:when>
   <xsl:when test="@xml:id='capiTyp'">font-variant: small-caps;</xsl:when>
  </xsl:choose>
  <xsl:text>}
  </xsl:text>
 </xsl:template>
 
 <xsl:template match="TEI:rendition/@scope">
  <xsl:text>:</xsl:text>
  <xsl:value-of select="."/>
 </xsl:template>
 
 <!-- 2.3.1 - 2.3.9 -->
 <xsl:template match="TEI:hi">
  <span>
   <xsl:apply-templates select="@rendition"/>
   <xsl:apply-templates/>
  </span>
 </xsl:template>
 
 <!-- 2.3.9 -->
 <xsl:template match="m:mfrac"
  xmlns:m="http://www.w3.org/1998/Math/MathML">
  <sup><xsl:apply-templates select="m:*[1]"/></sup>
  <xsl:text>/</xsl:text>
  <sub><xsl:apply-templates select="m:*[2]"/></sub>
  <xsl:if test="@bevelled!='true'">
   <span class="smaller">[vandret brøkstreg]</span>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="m:mroot"
  xmlns:m="http://www.w3.org/1998/Math/MathML">
  <sup><xsl:apply-templates select="*[2]"/></sup>
  <xsl:text>√</xsl:text>
  <span style="text-decoration: overline"><xsl:apply-templates select="*[1]"/></span>
 </xsl:template>
 
 <xsl:template match="m:msqrt"
  xmlns:m="http://www.w3.org/1998/Math/MathML">
  <xsl:text>√</xsl:text>
  <span style="text-decoration: overline"><xsl:apply-templates/></span>
 </xsl:template>
 
 <!-- 2.3.10 -->
 <xsl:template match="TEI:seg[@type='leaders']">
  <xsl:text> . . . </xsl:text>
 </xsl:template>
 
 <!-- 2.3.11.1 -->
 <xsl:template match="TEI:unclear">
  <xsl:text>&#x2329;</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>&#x232a;</xsl:text>
 </xsl:template>
 
 <!-- 2.3.11.2 -->
 <xsl:template match="TEI:supplied">
  <xsl:text>[</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>]</xsl:text>
 </xsl:template>
 
 <!-- 2.3.11.3 -->
 <xsl:template match="TEI:app//TEI:del">
  <xsl:apply-imports/>
 </xsl:template>
 
 <xsl:template match="TEI:del">
  <xsl:text>⌊</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>⌋</xsl:text>
 </xsl:template>
 
 <!-- 2.3.11.4 -->
 <xsl:template match="TEI:add[@status='variant']">
  <xsl:text>⌜</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>⌝</xsl:text>
 </xsl:template>
 
 <!-- 2.3.11.5 -->
 <xsl:template match="TEI:choice[TEI:reg]">
  <xsl:apply-templates select="TEI:reg"/>
 </xsl:template>
 
 <!-- 2.3.12 -->
 <xsl:template match="TEI:witDetail[@wit='#EP' and @resp='#EP']">
  <span class="small"> <!-- Barfod -->
   <xsl:text>[</xsl:text>
   <xsl:apply-templates/>
   <xsl:text>]</xsl:text>
  </span>
 </xsl:template>
 
  
 <!-- 2.4.5 -->
 <xsl:template match="TEI:choice[TEI:abbr]">
  <xsl:apply-templates select="TEI:abbr"/>
 </xsl:template>
 
 <xsl:template match="*[@key]">
  <span title="{@key}"><xsl:apply-templates/></span>
 </xsl:template>
 
 <xsl:template match="TEI:date[@when]">
  <span title="{@when}"><xsl:apply-templates/></span>
 </xsl:template>
 
 <!-- 2.5.1 -->
 <xsl:template match="TEI:seg[@type='refMarker']">
   <sup>
    <xsl:apply-templates select="parent::TEI:note/@anchored"/>
    <xsl:apply-templates/>
   </sup>
   <xsl:apply-templates select="parent::TEI:note/@source"/>
 </xsl:template>
 
 <xsl:template match="@anchored">
  <xsl:if test=".='false'">
   <xsl:attribute name="class">italic</xsl:attribute>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="TEI:note/@source[.='#EP']">
  <xsl:text>)</xsl:text>
 </xsl:template>
 
 <xsl:template match="TEI:ptr[@type='author']">
  <sup><xsl:number count="TEI:ptr[@type='author']" level="any"/></sup>
 </xsl:template>
 
 <!-- 2.5.2, 2.5.3 -->
 <xsl:template match="TEI:app">
  <xsl:apply-templates select="TEI:lem"/>
 </xsl:template>
 
 <xsl:template match="TEI:lem//TEI:witDetail"/>
 <!-- rest is imported from tei2html.app.xsl -->
 
 <xsl:template match="TEI:app[.//TEI:witStart]">
  <span class="{translate(.//TEI:witStart/@rendition,'#','')}"/>
 </xsl:template>
 
 <xsl:template match="TEI:app[.//TEI:witEnd]">
  <span class="{translate(.//TEI:witEnd/@rendition,'#','')}"/>
 </xsl:template>
 
 <!-- 2.6.1 -->
 <xsl:template match="TEI:pb[not(@edRef)]">
  <span title="{@n}">|</span>
 </xsl:template>
 
 <xsl:template match="TEI:pb[@edRef='#SKS']">
  <hr/>
  <xsl:call-template name="appsOfPrevPage"/>
  <div class="pageNo" id="{@xml:id}"><xsl:value-of select="@n"/></div>
 </xsl:template>
 
 <!-- 3.1 -->
 <xsl:template match="TEI:p|TEI:l|TEI:head">
  <div>
   <xsl:apply-templates select="@rendition"/>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:*[@rend='decoration']/TEI:figure">
  <div class="decoration">
  <xsl:choose>
   <xsl:when test="@type='columnRuler'"><hr/></xsl:when>
   <xsl:when test="@type='divisionRuler'"><hr width="25%"/></xsl:when>
   <xsl:when test="@type='divisionRulerDouble'">═════════</xsl:when>
   <xsl:when test="@type='divisionRulerRight'"><hr width="25%" align="right"/></xsl:when>
   <xsl:when test="@type='asterisk'">*</xsl:when>
   <xsl:when test="@type='2asterisks'">* &#160; *</xsl:when>
   <xsl:when test="@type='3asterisks'">* &#160; * &#160; *</xsl:when>
   <xsl:when test="@type='3asterisksUp'">*<br/>* &#160; *</xsl:when>
   <xsl:when test="@type='3asterisksDown'">* &#160; *<br/></xsl:when>
   <xsl:when test="@type='3dashes'">— — —</xsl:when>
   <xsl:when test="@type='dashDouble'">═</xsl:when>
   <xsl:when test="@type='x'">╳</xsl:when>
   <xsl:when test="@type='hash'">#</xsl:when>
   <xsl:when test="@type='hashBlank'">#</xsl:when>
   <xsl:when test="@type='hashSingleDouble'">╪</xsl:when>
   <xsl:when test="@type='wave'">~</xsl:when>
   <xsl:when test="@type='divisionRulerWaved'">~~~~~~~~~~~~~~~~</xsl:when>
   <xsl:when  test="@type='divisionRulerWavedPoint'">~~~~~~~~~~~~~~~~.</xsl:when>
   <xsl:when test="@type='hashEntwined'">~ $ ~</xsl:when>
   <xsl:when test="@type='cross'">†</xsl:when>
   <xsl:when test="@type='vignet'"><img src="{concat( 'http://sks.dk/', substring-after(TEI:graphic/@url, '../'))}" alt="{TEI:figDesc}"/></xsl:when>
   <xsl:when test="@type='3crossesDown'">† &#160; †<br/>†</xsl:when>
   <xsl:when test="@type='blankHalfLine'"/>
   <xsl:when test="@type='blank'"/>
   <xsl:otherwise>[<xsl:value-of select="@type"/>]</xsl:otherwise>
  </xsl:choose>
  </div>
 </xsl:template>
 
 <!-- 3.2.1 -->
 <xsl:template match="TEI:table">
  <table>
   <xsl:apply-templates select="@rendition"/>
   <xsl:apply-templates/>
  </table>
 </xsl:template>
 
 <xsl:template match="TEI:row">
  <tr valign="top">
   <xsl:apply-templates/>
  </tr>
 </xsl:template>
 
 <xsl:template match="TEI:cell">
  <td>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
  </td>
 </xsl:template>
 
 <xsl:template match="TEI:cell[not(normalize-space())]"> <!-- empty -->
  <td>&#160;</td>
 </xsl:template>
 
 <xsl:template match="TEI:cell/@role"/>
 
 <xsl:template match="TEI:cell/@rows">
  <xsl:if test=".!=1">
   <xsl:attribute name="rowspan">
    <xsl:value-of select="."/>
   </xsl:attribute>
  </xsl:if>
 
 </xsl:template>
 
 <xsl:template match="TEI:cell/@cols">
  <xsl:if test=".!=1">
   <xsl:attribute name="colspan">
    <xsl:value-of select="."/>
   </xsl:attribute>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="TEI:hi/@rendition|TEI:div/@rendition|TEI:p/@rendition|TEI:l/@rendition|TEI:table/@rendition|TEI:cell/@rendition">
  <xsl:attribute name="class">
   <xsl:value-of select="translate(.,'#','')"/>
  </xsl:attribute>
 </xsl:template>
 
 <!-- 3.2.4 -->
 <xsl:template match="TEI:lg">
  <div class="lyrics">
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <!-- 3.3 -->
 <xsl:template match="TEI:note[@subtype='subnote']">
  <div class="subnote">
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:note[@type='author' and not(TEI:seg[@type='refMarker'])]">
  <xsl:if test="not(preceding-sibling::TEI:note)"> <!-- første note -->
   <hr/>
   <div class="pageNo">[Noter]</div>
  </xsl:if>
  <sup><xsl:number count="TEI:note[@type='author']" level="any"/></sup>
  <xsl:text>)</xsl:text>
  <xsl:apply-templates/>
 </xsl:template>
 
 <!-- 3.4 -->
 <xsl:template match="TEI:figure">
  <div style="font-size: 80%; text-align: center; border: thin solid navy; margin: 1em">
   <img src="{concat( 'http://sks.dk/', substring-after( TEI:graphic/@url, '../'))}" width="50%" style="float: center"/>
   <xsl:apply-templates select="TEI:head"/>
  </div>
 </xsl:template>

 <!-- 3.6 -->
 <xsl:template match="TEI:div[@type='entry']">
  <div id="n{@n}" class="mainColumn">
   <xsl:apply-templates select="TEI:p"/> <!-- decoration -->
   <b><xsl:value-of select="@n"/></b>
   <xsl:apply-templates select="TEI:head"/>
   <xsl:apply-templates select="TEI:dateline"/>
  </div>
  <table>
   <tr valign="top">
    <td class="mainColumn">
     <xsl:apply-templates select="TEI:div[@type='mainColumn']"/>
    </td>
    <td class="marginalColumn">
     <xsl:apply-templates select="TEI:div[@type='marginalColumn']"/>
    </td>
   </tr>
  </table>
 </xsl:template>
 
 <xsl:template match="TEI:head[@n]">
  &#160; <span class="small">[<xsl:value-of select="@n"/>]</span>
 </xsl:template>
 
 <xsl:template match="TEI:dateline">
  &#160;
  <span class="small">
   <xsl:text>[</xsl:text>
   <xsl:choose>
    <xsl:when test="substring(TEI:date/@when,5,4)='0000'">
     <xsl:value-of select="substring(TEI:date/@when,1,4)"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="TEI:date/@when"/>
    </xsl:otherwise>
   </xsl:choose>
   <xsl:apply-templates select="TEI:date/@notAfter"/>
   <xsl:text>]</xsl:text>
  </span>
 </xsl:template>
 
 <xsl:template match="@notAfter">
  <xsl:text>-</xsl:text>
  <xsl:choose>
   <xsl:when test="substring(.,5,4)='0000'">
    <xsl:value-of select="substring(.,1,4)"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="."/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <!-- 3.7 -->
 <xsl:template match="TEI:div[@type='correspondance']">
  <div class="large SKSblue decoration">
   <xsl:apply-templates select="//TEI:correspContext[@xml:id=substring-after(current()/@corresp,'#')]"/>
  </div>
  <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="TEI:div[@type='letter']">
  <div>
   <b><xsl:value-of select="@n"/></b>
   <xsl:apply-templates select="//TEI:correspDesc[@xml:id=substring-after(current()/@corresp,'#')]"/>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:correspDesc">
  [<span class="small">
   <xsl:apply-templates select="TEI:correspAction[@type='sent']/TEI:name|TEI:correspAction[@type='sent']/TEI:note"/>
   <xsl:text> &gt; </xsl:text>
   <xsl:apply-templates select="TEI:correspAction[@type='received']/TEI:name"/>
   (<xsl:value-of select="TEI:correspAction[@type='sent']/TEI:date/@when"/>,
    <xsl:value-of select="TEI:correspAction[@type='sent']/TEI:date/@source"/>)
  </span>]
 </xsl:template>
 
 <xsl:template match="TEI:persName[@type='receiver']" priority="2">
  &#160; <span class="small">[<xsl:value-of select="@key"/>]</span>
  <br/><br/>
 </xsl:template>
 
 <xsl:template match="TEI:div[@type='letter']/TEI:head[@type='letterHeader']" priority="2">
  &#160; <span class="small SKSblue"><xsl:value-of select="@n"/></span>
 </xsl:template>
 
 <xsl:template match="TEI:dateline[text()]">
  <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="TEI:lb">
  <br/>
 </xsl:template>
 
 <xsl:template match="TEI:trailer[@type='addrOnEnvelope']">
  <div style="border: thin solid #008bbc;">
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:div[@type='work']">
  <xsl:apply-templates />
 </xsl:template>
 
 <xsl:template match="TEI:div[@type='dedication']">
  <br/>
  <b><xsl:value-of select="@n"/></b>
  <xsl:apply-templates/>
  <br/>
 </xsl:template>
 
 <xsl:template match="TEI:div[@type='dedication']/TEI:head">
  &#160;
  <span class="small">[>
  <xsl:value-of select="TEI:name/@key"/>,
  <xsl:value-of select=".//TEI:institution/@key"/>]</span>
 </xsl:template>
 
 <xsl:template match="TEI:head[@type='workHeader']" priority="2">
  <div class="small SKSblue"><xsl:value-of select="@n"/></div>
 </xsl:template>
 
 <!-- 3.8 -->
 <!-- 3.8.1 -->
 <xsl:template match="TEI:note[@type='commentary']">
  <div id="{@xml:id}">
   <xsl:value-of select="substring-after(//TEI:seriesStmt/TEI:biblScope[@unit='volume'],'K')"/>
   <xsl:text>, </xsl:text>
   <xsl:value-of select="substring-before(@n,',')"/>
   <xsl:text>,</xsl:text>
   <i><small><xsl:value-of select="substring-after(@n,',')"/></small></i>
   <xsl:text> </xsl:text>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <!-- 3.8.1 -->
 <xsl:template match="TEI:note[@type='commentary']/TEI:label">
  <xsl:apply-templates/>
  <xsl:text>] </xsl:text>
 </xsl:template>
 
 <!-- 3.8.2 -->
 <xsl:template match="TEI:note[@type='commentary']/TEI:p[1]">
  <xsl:apply-templates/>
 </xsl:template>

 <xsl:template match="TEI:note[@type='commentary']/TEI:p[not(position()=1)]">
  <div style="text-indent: 1em"><xsl:apply-templates/></div>
 </xsl:template>
 
 <!-- 3.8.3 -->
 <xsl:template match="TEI:ptr[@type='commentary']">
  <a>
   <xsl:apply-templates select="@target"/>
   <xsl:text>&#x2192; </xsl:text> <!-- arrow -->
   <xsl:apply-templates select="@subtype"/>
   <xsl:value-of select="substring-before(@n,',')"/>
   <xsl:text>,</xsl:text>
   <i><small><xsl:value-of select="substring-after(@n,',')"/></small></i>
  </a>
 </xsl:template>

 <xsl:template match="TEI:ptr[@type='commentary']/@subtype">
  <xsl:choose>
   <xsl:when test=".='e'"><span class="ita">SKS-E</span></xsl:when>
   <xsl:when test=".='b'"><span class="ita">SKS-B</span></xsl:when>
  </xsl:choose>
 </xsl:template>
 
 <!-- 3.8.4 -->
 <xsl:template match="TEI:ref">
  <a title="{@type}">
   <xsl:apply-templates select="@target"/>
   <xsl:apply-templates select="@rend"/>
   <xsl:apply-templates/>
   <xsl:if test="@type='pdf'">
    <xsl:text>&#x2192;</xsl:text>
    <img src="http://sks.dk/vignet/pdf.gif" alt="PDF"/>
   </xsl:if>
  </a>
 </xsl:template>

 <xsl:template match="@target">
  <xsl:attribute name="href">
   <xsl:choose>
    <xsl:when test="contains(.,'.xml')">
     <xsl:value-of select="translate(concat(substring-before(.,'.xml'),'.htm',substring-after(.,'.xml')),'&up;','&low;')"/>
    </xsl:when>
    <xsl:when test="contains(.,'.pdf')">
     <xsl:value-of select="translate(concat('http://sks.dk/',substring-after(.,'../')),'&up;','&low;')"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="translate(.,'&up;','&low;')"/>
    </xsl:otherwise>
   </xsl:choose>
   
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="TEI:ref/@rend">
  [<xsl:value-of select="."/>]
 </xsl:template>
 
 <!-- 3.9 -->
 <xsl:template match="TEI:text">
  <div class="{@type}">
   <xsl:apply-templates/>
   <xsl:call-template name="appsOfLastPage"/>
  </div>
 </xsl:template>
 
 <!-- 3.10 -->
 <xsl:template match="TEI:teiHeader">
  <xsl:apply-templates select="TEI:fileDesc"/>
 </xsl:template>

 <xsl:template match="TEI:fileDesc">
  <div class="kolofon">
   <div class="versaler"><xsl:apply-templates select="TEI:titleStmt/TEI:title[@level='s']"/></div>
   <xsl:apply-templates select="TEI:titleStmt/TEI:editor"/>
   <div>
    <xsl:text>Bind </xsl:text>
    <xsl:apply-templates select="TEI:seriesStmt/TEI:biblScope[ @unit='volume']"/>
   </div>
   <div>
    <xsl:text>© </xsl:text>
    <xsl:apply-templates select="TEI:publicationStmt/TEI:authority"/>
   </div>
   <br/>
   <div class="versaler">
    <xsl:apply-templates select="TEI:titleStmt/TEI:title[not(@*)]"/>
   </div>
   <xsl:apply-templates select="TEI:titleStmt/TEI:respStmt[TEI:resp='udgivet af']"/>
   <xsl:if test="//TEI:text[not(@type='print' or @type='ms')]"> <!-- not author's text -->
    <xsl:apply-templates select="TEI:titleStmt/TEI:author"/>
   </xsl:if>
   <xsl:apply-templates select="TEI:titleStmt/TEI:respStmt[not(TEI:resp='udgivet af')]"/>
   <br/><br/>
   <xsl:apply-templates select="TEI:sourceDesc/TEI:listWit"/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:author">
  <div><b>Kommentarer</b></div>
  <xsl:call-template name="nameList">
   <xsl:with-param name="names" select="TEI:name"/>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template match="TEI:editor">
  <div>Redaktion</div>
  <xsl:call-template name="nameList">
   <xsl:with-param name="names" select="TEI:name"/>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template match="TEI:respStmt">
  <div><xsl:apply-templates select="TEI:resp"/></div>
  <xsl:call-template name="nameList">
   <xsl:with-param name="names" select="TEI:name"/>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template match="TEI:listWit">
  <div>Tekstkilder</div>
  <div>
   <xsl:apply-templates select="TEI:listWit|TEI:witness"/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:listWit/TEI:listWit">
  <div><xsl:apply-templates select="TEI:head"/></div>
  <div>
   <xsl:apply-templates select="TEI:listWit|TEI:witness"/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:witness">
  <div>
   <i><xsl:apply-templates select="@xml:id"/></i>
   <xsl:text> &#160; </xsl:text>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:witness/TEI:title">
  <i><xsl:apply-templates/></i>
 </xsl:template>
 
 <xsl:template name="nameList">
  <xsl:param name="names"/>
  <xsl:for-each select="$names">
   <i><xsl:value-of select="."/></i>
   <xsl:choose>
    <xsl:when test="position()=last()"/>
    <xsl:when test="position()=last()-1">
     <xsl:text> og </xsl:text>
    </xsl:when>
    <xsl:otherwise>
     <xsl:text>, </xsl:text>
    </xsl:otherwise>
   </xsl:choose>
   
  </xsl:for-each>
 </xsl:template>
 
</xsl:stylesheet>