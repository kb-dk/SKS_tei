<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:TEI="http://www.tei-c.org/ns/1.0"
 version="1.0">
 <!-- KK 2017.02.08 -->

 <xsl:import href="../kn1/skstxr.xsl"/>
 <xsl:import href="specs.xsl"/>
 <xsl:import href="../kn1/sksjp.xsl"/>
 
 <xsl:template match="/">
 
  <xsl:apply-imports/>
 </xsl:template>

 <xsl:template match="ref[@type='sk']">
  <xsl:text>*)</xsl:text><xsl:value-of select="substring-before(concat(following-sibling::text()[1],' '),' ')"/>
  <xsl:variable name="refid" select="@id"/>
  <a name="{$refid}" id="{$refid}"/>
  <hr class="notskil" align="left"/>
  <table class="note">
   <tr valign="top">
    <td>*)</td>
    <td>
     <xsl:for-each select="//not[@id=$refid]/*"> <!-- modif. of sks.ts.xsl -->
      <xsl:apply-templates select="."/>
     </xsl:for-each>
     <br/>
    </td>
   </tr>
  </table>
 </xsl:template>

 <xsl:template match="not[@type='sk']"/>

 <xsl:template match="synx/elem">
  <code class="x">
   <xsl:text>&lt;</xsl:text>
    <xsl:apply-templates/>
   <xsl:text>&gt;</xsl:text>
  </code>
 </xsl:template>

 <xsl:template match="synx/elem/name">
  <a href="http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-{.}.html">
   <xsl:apply-templates/>
  </a>
 </xsl:template>
 
 <xsl:template match="synx/elem/attr[@class]">
  <a href="http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-att.{@class}.html#tei_att.{translate(.,':','-')}">
   <xsl:apply-templates/>
  </a>
 </xsl:template>
 
 <xsl:template match="synx/elem/attr[not(@class)]">
  <a href="http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-{ ancestor::elem/name}.html#tei_att.{.}">
   <xsl:apply-templates/>
  </a>
 </xsl:template>
 
 <xsl:template match="meta">
  <xsl:text> </xsl:text>
  <span style="font-family: serif; font-weight: normal; font-style: italic; color: black">
   <xsl:apply-templates/>
  </span>
  <xsl:text> </xsl:text>
 </xsl:template>
 
 <xsl:template match="sepa">
  <span style="font-family: serif; font-weight: normal; color: black">
   <xsl:apply-templates/>
  </span>
 </xsl:template>
 
 <xsl:template match="processing-instruction('elem-index')">
  <table>
   <xsl:for-each select="//synx/elem/name">
    <xsl:sort/>
    <xsl:variable name="elem" select="text()"/>
    <tr>
     <td class="x"><xsl:value-of select="$elem"/></td>
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

 <xsl:template match="sem[@on]">
  <p style="color: navy">
   <a href="http://www.tei-c.org/"><img src="http://www.tei-c.org/About/Badges/I-use-TEI.png" alt="I use TEI" width="50"/></a>
   <span class="x">&lt;<span style="font-family:normal" >on <xsl:value-of select="@on"/>: </span></span>
   <xsl:apply-templates/>
   <span class="x">&gt;</span>
  </p>
 </xsl:template>
 
 <xsl:template match="p|l|row|listWit|head|witness|biblScope|title[@*]|author|resp|rendition|change|editor|availability|authority|teiHeader|text|body|div|note|table|dateline|figure|graphic|correspAction|correspContext|closer|signed|postscript|label|item|additional|*[starts-with(name(),'ms')]|*[contains(name(),'Desc')]|*[contains(name(),'Decl')]|*[contains(name(),'Stmt')]" mode="ex">
  <div> 
   <xsl:if test="not(parent::ex)">
    <xsl:attribute name="class"><xsl:value-of select="&quot;blok&quot;"/></xsl:attribute>
   </xsl:if>
   <xsl:call-template name="elemex"/>
  </div>
 </xsl:template>
 
 <xsl:template match="@*" mode="ex">
  <xsl:choose>
   <xsl:when test="name()='fakeXmlns'">
    <xsl:text> xmlns="</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>"</xsl:text>
   </xsl:when>
   <xsl:otherwise>
    <xsl:text> </xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:text>="</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>"</xsl:text>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="processing-instruction()" mode="ex">
  <xsl:choose>
   <xsl:when test="name()='fakeXml'">
    <div><b class="x">&lt;?xml <xsl:value-of select="."/>?&gt;</b></div>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-imports/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="lit">
  <p>
   <a id="lit.{@id}">[<xsl:value-of select="@id"/>]</a>
   <xsl:text> </xsl:text>
   <xsl:apply-templates/>
  </p>
 </xsl:template>
 
 <xsl:template match="refx[@type='kort']">
  <a onclick="return blank('res',this.href)" 
   href="http://sks.dk/kort/{@nr}_{@id}.htm"
   title="See map">
  <xsl:text>&#x2192; </xsl:text>
  <img src="glob.gif" class="inlicon"/>
  </a>
 </xsl:template>
 
 <xsl:template match="ex[@lang='dt']/dt">
  <span style="font-family: Candara, Century Gothic, Futura Book BT, sans-serif">
   <xsl:apply-templates/>
  </span>
 </xsl:template>
 
 <xsl:template match="udg[@spec='ellipse']" mode="in-tn"/>
 
</xsl:stylesheet>