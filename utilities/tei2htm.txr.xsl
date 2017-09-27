<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:TEI="http://www.tei-c.org/ns/1.0"
 version="1.0">
 
 <!-- tei2htm.xsl
  html presentation of SKS text critical accounts
  KK 2017-02-22 -->
 
 <xsl:import href="tei2htm.xsl"/>
 
 <xsl:template match="TEI:teiHeader/TEI:encodingDesc/TEI:tagsDecl/TEI:rendition[1]">
  .mainHead {margin: 2em; text-align: center; font-size: 150%}
  .level1 {margin: 1em; text-align: center; font-size: 120%; font-style: italic}
  .level2 {margin: 1em; text-align: center; font-size: 110%; font-style: italic}
  .level3 {margin-top: 1em; text-align: center; font-style: italic}
  .quote  {margin: 1em 0 1em 1em}
  .lb     {margin-top: 1em}
  <xsl:apply-imports/>
 </xsl:template>
 
 <xsl:template match="TEI:author">
  <div><b><xsl:apply-templates select="//TEI:body/TEI:div/TEI:head[@type='topText']/@n"></xsl:apply-templates></b></div>
  <xsl:call-template name="nameList">
   <xsl:with-param name="names" select="TEI:name"/>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template match="TEI:div">
  <div id="{@xml:id}">
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:div[@type]/TEI:head">
  <div class="{../@type}">
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:text">
  <div class="print">
   <xsl:apply-templates/>
   <xsl:call-template name="notesOfLastPage"/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:text/TEI:body/TEI:div/TEI:head">
  <div class="mainHead">
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:list[not(TEI:label)]/TEI:item">
  <div>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:list[TEI:label]">
  <table>
   <xsl:apply-templates select="TEI:item"/>
  </table>
 </xsl:template>
 
 <xsl:template match="TEI:list[TEI:label]/TEI:item">
  <tr valign="top">
   <td>
    <xsl:apply-templates select="preceding-sibling::TEI:label[1]"/>
    <xsl:text>.&#160;</xsl:text>
   </td>
   <td>
    <xsl:apply-templates/>
   </td>
  </tr>
 </xsl:template>
 
 <xsl:template match="TEI:p[not(@rendition)]">
  <div class="lb">
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="TEI:ptr[@type='chapter']">
  <xsl:text> </xsl:text>
  <a class="ita" href="{@target}"><xsl:value-of select="@n"/></a>
 </xsl:template>
 
 <xsl:template match="TEI:note[not(parent::TEI:adminInfo)]">
  <sup><xsl:number level="any" from="TEI:pb|TEI:text"/>)</sup>
 </xsl:template>
 
 <xsl:template match="TEI:note[not(parent::TEI:adminInfo)]" mode="notesOnFooter">
  <table class="small" style="text-align: justify">
   <tr valign="top">
    <td><sup><xsl:number level="any" from="TEI:pb|TEI:text"/>)</sup></td>
    <td><xsl:apply-templates/></td>
   </tr>
  </table>
 </xsl:template>
 
 <xsl:template name="notesOfPrevPage">
  <xsl:if test="preceding::TEI:note[not(parent::TEI:adminInfo)][following::TEI:pb[1]/@n=current()/@n]">
   <br/>
   <hr width="25%" align="left"/>
   <xsl:apply-templates select="preceding::TEI:note[not(parent::TEI:adminInfo)][following::TEI:pb[1]/@n=current()/@n]" mode="notesOnFooter"/>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="TEI:pb[@edRef='#SKS']">
  <xsl:call-template name="notesOfPrevPage"/>
  <hr/>
  <div class="pageNo" id="{@xml:id}"><xsl:value-of select="@n"/></div>
 </xsl:template>
 
 <xsl:template name="notesOfLastPage">
  <br/>
  <hr width="25%" align="left"/>
  <xsl:apply-templates select="//TEI:note[not(parent::TEI:adminInfo)][not(following::TEI:pb[@edRef='#SKS'])]" mode="notesOnFooter"/>
 </xsl:template>
 
 <xsl:template match="TEI:msDesc">
  <table>
   <xsl:apply-templates select="TEI:msPart[TEI:physDesc]"/>
  </table>
 </xsl:template>
 
 <xsl:template match="TEI:msPart[TEI:physDesc]">
  <tr valign="top">
   <td>
    <xsl:apply-templates select="TEI:msIdentifier"/>
   </td>
   <td>
    <xsl:apply-templates select="TEI:physDesc"/>
    <xsl:if test="TEI:msPart">
     <table>
      <xsl:apply-templates select="TEI:msPart[TEI:physDesc]"/>
     </table>
    </xsl:if>
    <xsl:apply-templates select="following-sibling::TEI:msPart[@xml:id=substring-after(current()/@next,'#')]/TEI:additional"/>
   </td>
  </tr>
 </xsl:template>
 
 <xsl:template match="TEI:del">
  <span>
   <xsl:apply-templates select="@rendition"/>
   <xsl:apply-templates/>
  </span>
 </xsl:template>
 
 <xsl:template match="TEI:del/@rendition">
  <xsl:attribute name="class">
   <xsl:value-of select="translate(.,'#','')"/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="TEI:quote">
  <div class="quote">
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
</xsl:stylesheet>