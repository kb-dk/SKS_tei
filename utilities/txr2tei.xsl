<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0" version="1.0">

 <xsl:import href="kn12tei.xsl"/>
 <xsl:output method="xml" encoding="UTF-8" indent="no"/>

 <xsl:template match="kodning">
  <change>
   <xsl:text>Transformed to TEI by style sheet </xsl:text>
   <bibl type="file">txr2tei.xsl</bibl>
   <xsl:text> version as of </xsl:text>
   <date>2017-02-15</date>
   <xsl:text> importing </xsl:text>
   <bibl type="file">kn12tei.xsl</bibl>
  </change>
  <xsl:text>
    </xsl:text>
  <xsl:apply-imports/>
 </xsl:template>

 <xsl:template match="txr">
  <TEI>
   <xsl:apply-templates/>
  </TEI>
 </xsl:template>
 
 <xsl:template match="korttit">
  <xsl:apply-imports/>
  <xsl:apply-templates select="../txrforf"/>
 </xsl:template>
 
 <xsl:template match="txrforf" xml:space="preserve">
  <author>
   <xsl:call-template name="nameList"/>
  </author>
 </xsl:template>
 
 <xsl:template match="intro"></xsl:template>
 <xsl:template match="intro/titel"></xsl:template>
 <xsl:template match="intro/@fil"></xsl:template>
 
 <xsl:template match="bind">
  <biblScope unit="volume">
   <xsl:text>K</xsl:text>
   <xsl:apply-templates/>
  </biblScope>
 </xsl:template>
 
 <xsl:template match="kap0">
  <text type="TextCriticalAccount">
   <xsl:call-template name="subtypeAttr">
    <xsl:with-param name="kat" select="/txr/@kat"/>
   </xsl:call-template>
   <body>
    <div>
     <xsl:apply-templates select="@*"/>
     <xsl:apply-templates/>
    </div>
   </body>
  </text>
 </xsl:template>
 
 <xsl:template match="kap0/@klum">
  <head type="topText" n="{.}"/>
 </xsl:template>
 
 <xsl:template match="indhold">
   <list type="TOC">
    <xsl:apply-templates/>
   </list>
 </xsl:template>

 <xsl:template match="irub">
  <item>
   <xsl:apply-templates/>
  </item>
 </xsl:template>

 <xsl:template match="refs">
  <ptr type="chapter" target="{concat('#',@id)}" n="{//*[starts-with(name(),'kap') and @id=current()/@id]/preceding::kor[@kil='SKS'][1]/@id}"/>
    <!-- @n = SKS page number -->
 </xsl:template>

 <xsl:template match=" kap1 | kap2 | kap3 ">
  <div type="level{substring-after(name(),'kap')}">
   <xsl:apply-templates select="@id"/>
   <xsl:apply-templates/>
  </div>
  <xsl:if test="following-sibling::*[1][name()='lin']"> <!-- a bit odd, but valid txr/xml -->
   <div> <!-- wrap in TEI:div -->
    <xsl:apply-templates select="following-sibling::*[1][name()='lin']">
     <xsl:with-param name="linWrap" select="true()"/>
    </xsl:apply-templates>
   </div>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="lin[preceding-sibling::*[starts-with(name(),'kap')]]">
  <xsl:param name="linWrap"/>
  <xsl:if test="$linWrap">
   <xsl:apply-imports/>
   <xsl:apply-templates select="following-sibling::*[1][name()='lin']">
    <xsl:with-param name="linWrap" select="true()"/>
   </xsl:apply-templates>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match=" kap1/@id | kap2/@id | kap3/@id ">
  <xsl:attribute name="xml:id">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="cit">
  <quote>
   <xsl:apply-templates/>
  </quote>
 </xsl:template>

 <xsl:template match="lis">
  <list>
   <xsl:apply-templates/>
  </list>
 </xsl:template>

 <xsl:template match="l">
  <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="lid">
  <label>
   <xsl:apply-templates/>
  </label>
 </xsl:template>
 
 <xsl:template match="ltx">
  <item>
   <xsl:apply-templates/>
  </item>
 </xsl:template>
 
 <xsl:template match="ref">
  <xsl:apply-templates select="not"/>
 </xsl:template>

 <xsl:template match="mslis"> <!-- outermost list -->
  <msDesc>
   <msIdentifier>
    <collection><xsl:value-of select="//korttit"/>
   </collection>
   </msIdentifier>
   <xsl:apply-templates/>
  </msDesc>
 </xsl:template>
 
 <xsl:template match="mstx/mslis"> <!-- inner, skip it -->
  <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="msl">
  <xsl:variable name="msId" select="translate(msid,':[]&#160; ','.')"/>
  <xsl:variable name="edNo">
    <xsl:if test="count(//kap1/mslis|//kap2/mslis|//kap3/mslis)&gt;1">
      <xsl:number level="any" count="kap1/mslis|kap2/mslis|kap3/mslis"/>
    </xsl:if>
  </xsl:variable>
  <xsl:variable name="ed">
   <xsl:if test="$edNo">
    <xsl:value-of select="concat(substring('ABC',$edNo,1),'.')"/>
   </xsl:if>
  </xsl:variable>
  <msPart>
   <xsl:attribute name="xml:id">
      <xsl:value-of select="concat('physDesc',$ed,$msId)"/>
   </xsl:attribute>
   <xsl:attribute name="next">
    <xsl:value-of select="concat('#additional',$ed,$msId)"/>
   </xsl:attribute>
   <xsl:apply-templates select="msid"/>
   <physDesc>
    <xsl:choose>
     <xsl:when test="mstx/mslis">
      <xsl:apply-templates select="mstx/lin[following-sibling::mslis]"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates select="mstx/lin[not(starts-with(.,'('))]"/>
     </xsl:otherwise>
    </xsl:choose>
   </physDesc>
   <xsl:apply-templates select="mstx/mslis"/>
  </msPart>
  <msPart>
   <xsl:attribute name="xml:id">
    <xsl:value-of select="concat('additional',$ed,$msId)"/>
   </xsl:attribute>
   <xsl:attribute name="prev">
    <xsl:value-of select="concat('#physDesc',$ed,$msId)"/>
   </xsl:attribute>
   <xsl:apply-templates select="msid"/>
   <additional>
    <adminInfo>
     <note>
      <xsl:choose>
       <xsl:when test="mstx/mslis">
        <xsl:apply-templates select="mstx/lin[preceding-sibling::mslis]"/>
       </xsl:when>
       <xsl:otherwise>
        <xsl:apply-templates select="mstx/lin[starts-with(.,'(')]"/>
       </xsl:otherwise>
      </xsl:choose>
     </note>
    </adminInfo>
   </additional>
  </msPart>
 </xsl:template>

 <xsl:template match="msid">
  <msIdentifier>
   <idno>
    <xsl:apply-templates select="node()[name()!='kor']"/>
     <!-- TEI:msIdentifier//pb not allowed -->
   </idno>
  </msIdentifier>
 </xsl:template>

 <xsl:template match="lin[parent::mstx[preceding-sibling::msid[kor]]][1]">
  <p>
   <xsl:apply-templates select="parent::mstx/preceding-sibling::msid/kor"/>
   <xsl:apply-templates/>
  </p>
 </xsl:template>

 <xsl:template match="slet">
  <del rendition="#lth">
   <xsl:apply-templates/>
  </del>
 </xsl:template>

 <xsl:template match="slet" mode="rendition">
  <rendition xml:id="lth" scheme="css">
   <xsl:text>text-decoration: line-through</xsl:text>
  </rendition>
 </xsl:template>
 
 <xsl:template match="a">
  <ref type="web" target="{@href}">
   <xsl:apply-templates/>
  </ref>
 </xsl:template>
 
 <xsl:template match="kor[@id=preceding::kor/@id]"> 
  <pb edRef="{@kil}" n="{@id}"/>
  <xsl:comment>fejl, sidenummer duplikat</xsl:comment>
   <!-- error, duplicate page no -->
 </xsl:template>
 
 <xsl:template match="illfil">
  <graphic url="{concat('../',//korttit,'/ill_',translate(substring-after(@id,'ill_'),'K','k'))}"/>
   <!-- make up for lack of dir in KN1:txr coding -->
 </xsl:template>
 
 <xsl:template match="vulg/hoj/udg">
  <xsl:apply-templates/>
    <!-- make up for funny coding in B308, hard to explain -->
 </xsl:template>
 
</xsl:stylesheet>