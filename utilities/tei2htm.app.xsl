<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:TEI="http://www.tei-c.org/ns/1.0"
 version="1.0">
 
 <!-- tei2htm.app.xsl
  html presentation of text critical apparatus of SKS
  KK 2016-12-08 -->
 
 <xsl:template match="TEI:TEI">
  <html>
   <head>
    <title>
     <xsl:value-of select="TEI:teiHeader//TEI:title[@type='short']"/>;
     tekstkritiske noter
    </title>
    <style type="text/css">
      .pageNo {text-align: right; margin-bottom: 1em}
      <xsl:apply-templates select="TEI:teiHeader/TEI:encodingDesc/TEI:tagsDecl/TEI:rendition"/>
    </style>
   </head>
   <body>
    <xsl:apply-templates select="//TEI:pb[@edRef='#SKS']"/>
    <xsl:call-template name="appsOfLastPage"/>
   </body>
  </html>
 </xsl:template>
 
 <xsl:template match="TEI:rendition[not(@scheme) or @scheme='css']">
  <xsl:text>.</xsl:text>
  <xsl:value-of select="@xml:id"/>
  <xsl:apply-templates select="@scope"/>
  <xsl:text>{</xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>}
  </xsl:text>
 </xsl:template>
 
 <xsl:template match="TEI:rendition"/>
 
 <xsl:template match="TEI:rendition/@scope">
  <xsl:text>:</xsl:text>
  <xsl:value-of select="."/>
 </xsl:template>
 
 <xsl:template match="TEI:pb[@edRef='#SKS']">
  <xsl:call-template name="appsOfPrevPage"/>
  <xsl:if test="following::TEI:app[not(.//TEI:witEnd)][1]/preceding::TEI:pb[@edRef='#SKS'][1]/@n=current()/@n">
   <div class="pageNo"><xsl:value-of select="@n"/></div>
   <hr/>
  </xsl:if>
 </xsl:template>
 
 <xsl:template name="appsOfPrevPage">
  <xsl:if test="preceding::TEI:app[not(.//TEI:witEnd) and (following::TEI:pb[@edRef='#SKS'][1]/@n=current()/@n or not(following::TEI:pb[@edRef='#SKS']))]">
   <xsl:apply-templates select="preceding::TEI:app[following::TEI:pb[@edRef='#SKS'][1]/@n=current()/@n or not(following::TEI:pb[@edRef='#SKS'])]" mode="appsOnFooter"/>
  </xsl:if>
 </xsl:template>

 <xsl:template name="appsOfLastPage">
  <hr/>
  <xsl:apply-templates select="//TEI:app[not(following::TEI:pb[@edRef='#SKS'])]" mode="appsOnFooter"/>
 </xsl:template>
 
 <xsl:template match="TEI:app" mode="appsOnFooter">
  <div style="text-align: left; text-indent: 0; font-size: 12px; font-weight: normal">
   <xsl:apply-templates select="TEI:lem" mode="beforeMarker"/>
   <xsl:if test="not(.//TEI:witStart)">
    <xsl:text>] </xsl:text>
   </xsl:if>
   <xsl:apply-templates select="TEI:lem" mode="afterMarker"/>
   <xsl:apply-templates select="TEI:rdg|TEI:rdgGrp"/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:app[TEI:rdg[TEI:witEnd]]" mode="appsOnFooter"/> <!-- treated at witStart -->
 
 <xsl:template match="TEI:*" mode="beforeMarker">
  <xsl:apply-templates mode="beforeMarker"/>
 </xsl:template>
 
 <xsl:template match="TEI:lem//text()[position()=last() and normalize-space()='']" mode="beforeMarker"/>
 <!-- gets rid of most spaces before ] -->
 
 <xsl:template match="TEI:witDetail" mode="beforeMarker"/>
 
 <xsl:template match="TEI:witDetail">
  <xsl:text> </xsl:text>
  <i><xsl:apply-templates/></i>
 </xsl:template>
 
 <xsl:template match="TEI:lem//TEI:witDetail" mode="afterMarker">
  <xsl:text> </xsl:text>
  <i><xsl:apply-templates/></i>
 </xsl:template>
 
 <xsl:template match="TEI:rdg//TEI:seg[@type='ellipsis']" priority="2">
  <i>(...)</i>
 </xsl:template>
 
 <xsl:template match="TEI:lem//TEI:seg[@type='ellipsis']" mode="beforeMarker">
  <i>(...)</i>
 </xsl:template>
 
 <xsl:template match="TEI:milestone[@type='ellipsis']" mode="beforeMarker">
  <i> (...) </i>
  <xsl:value-of select="substring-after(@spanTo,'#')"/>
 </xsl:template>
 
 <xsl:template match="TEI:lem" mode="afterMarker">
   <xsl:variable name="allText">
    <xsl:apply-templates select="text()"/>
   </xsl:variable>
    <xsl:apply-templates select="@wit"/>
    <xsl:apply-templates select=".//TEI:witDetail" mode="afterMarker"/>
    <xsl:if test="@wit">
     <i>, </i>
    </xsl:if>
  <xsl:if test="TEI:add and normalize-space($allText)"> <!-- add is not whole lemma -->
   <xsl:apply-templates select="TEI:add"/>
   <xsl:text> </xsl:text>
  </xsl:if>
  <xsl:apply-templates select="TEI:add/@rendition"/> <!-- legend -->
 </xsl:template>
 
 <xsl:template match="TEI:rdg|TEI:rdgGrp">
  <xsl:apply-templates select="@rendition"/> <!-- delimiter -->
  <xsl:apply-templates select="node()[not(local-name()='witDetail' and @rendition)]"/>
  <xsl:apply-templates select="@wit"/>
  <xsl:apply-templates select="TEI:witStart/@n"/>
  <xsl:apply-templates select="TEI:witDetail[@rendition]"/> <!-- msifB -->
 </xsl:template>
 
 <xsl:template match="TEI:rdg/*">
  <xsl:text> </xsl:text>
  <xsl:apply-templates select="@rendition"/> <!-- legend -->
  <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="TEI:witStart/@n">
  <xsl:if test="not(ancestor::TEI:rdg[@wit='#B-fort.'])">
   <xsl:text>, s.</xsl:text>
  </xsl:if>
  <xsl:text> </xsl:text>
  <xsl:value-of select="."/>
 </xsl:template>

 <xsl:template match="TEI:rdg/TEI:witDetail" priority="2">
  <xsl:if test="node()">
   <i>
    <!--<xsl:text>, </xsl:text> OBS STullberg-->
    <xsl:if test="@place='elsewhere'"> <!-- @kn1:paa -->
     <xsl:text>,</xsl:text>
    </xsl:if>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
    <xsl:text> </xsl:text>
   </i>
  </xsl:if>
  <xsl:apply-templates select="@rendition">
   <xsl:with-param name="n" select="@n"/>
  </xsl:apply-templates> <!-- ms. s. n if B-fort. -->
 </xsl:template>
 
 <xsl:template match="@wit">
  <i><xsl:value-of select="translate(.,' #',', ')"/></i>
 </xsl:template>
 
 <xsl:template match="@rendition">
  <xsl:param name="n"/>
  <i class="{translate(.,' #',' ')}"><xsl:value-of select="$n"/></i>
  <xsl:text> </xsl:text>
 </xsl:template>
 
 <xsl:template match="TEI:witStart/@rendition">
  <xsl:variable name="markbeg" select="substring-after(.,'#')"/>
  <xsl:variable name="markslut" select="concat(substring-before($markbeg,'beg'),'slut')"/>
  <span class="{$markbeg}"/>...<span class="{$markslut}"/>
  <xsl:text> </xsl:text>
 </xsl:template>
 
 <xsl:template match="TEI:choice|TEI:unclear|TEI:supplied" mode="beforeMarker">
  <xsl:apply-templates select="."/>
 </xsl:template>
 
 <xsl:template match="TEI:supplied">
  <xsl:text>[</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>]</xsl:text>
 </xsl:template>
 
 <xsl:template match="TEI:unclear">
  <xsl:text>&#x2329;</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>&#x232a;</xsl:text>
 </xsl:template>
 
 <xsl:template match="TEI:choice[TEI:abbr]">
  <xsl:apply-templates select="TEI:abbr"/>
 </xsl:template>
 
 <xsl:template match="TEI:choice[TEI:reg]">
  <xsl:apply-templates select="TEI:reg"/>
 </xsl:template>
 
</xsl:stylesheet>