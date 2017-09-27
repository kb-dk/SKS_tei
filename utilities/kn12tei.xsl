<?xml version="1.0"?>

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns="http://www.tei-c.org/ns/1.0"
 version="1.0">

 <xsl:output method="xml" encoding="UTF-8" indent="no"/>

 <!--        doctype-system="http://www.tei-c.org/release/xml/tei/custom/schema/dtd/tei_all.dtd" -->

 <xsl:template match="kodning">
  <change>
   <xsl:text>Transformed to TEI by style sheet </xsl:text>
   <bibl type="file">kn12tei.xsl</bibl>
   <xsl:text> version </xsl:text>
   <idno type="version">1.9</idno>
   <xsl:text> as of </xsl:text>
   <date>2017-02-21</date>
   <xsl:text> by </xsl:text>
   <name>Karsten Kynde</name>
   <xsl:text>, </xsl:text>
   <orgName>Det Kongelige Bibiliotek</orgName>
   <xsl:text>, </xsl:text>
   <placeName>København</placeName>
  </change>
  <xsl:text>
    </xsl:text>
  <change>
   <xsl:apply-templates select="../dato"/>
   <xsl:apply-templates/> <!-- kodning, specs. 3.10.8 -->
   <xsl:text>, </xsl:text>
   <bibl>
    <xsl:apply-templates select="../vers"/>
    <xsl:text>, </xsl:text>
    <xsl:apply-templates select="../fil"/>
   </bibl>
  </change>
 </xsl:template>

 <!-- Typografical signals, specs. 2.3 -->

 <!-- 2.3.1-5, 9 --> 
 <xsl:template match="spa">
  <hi rendition="#spa"> <!-- printed text, spa means spatialised -->
   <xsl:apply-templates select="@gen"/>
   <xsl:apply-templates/>
  </hi>
 </xsl:template>

 <xsl:template match="jp//spa | uts[//korttit!='SFV' and //korttit!='OiA']//spa | bd//spa"> <!-- ms., spa means underlined -->
  <hi rendition="#und">
   <xsl:apply-templates select="@gen"/>
   <xsl:apply-templates/>
  </hi>
 </xsl:template>
 
 <xsl:template match="kur">
  <hi rendition="#ita">
   <xsl:apply-templates/>
  </hi>
 </xsl:template>
 
 <xsl:template match="fed"> <!-- printed text, fed means bold -->
  <hi rendition="#bol">
   <xsl:apply-templates/>
  </hi>
 </xsl:template>
 
 <xsl:template match="jp//fed | uts[//korttit!='SFV' and //korttit!='OiA']//fed | bd//fed"> <!-- ms., fed means doubly undelined -->
  <hi rendition="#dun">
   <xsl:apply-templates select="@gen"/>
   <xsl:apply-templates/>
  </hi>
 </xsl:template>
 
 <xsl:template match="ant"> <!-- printed text, ant means antiqua -->
  <hi rendition="#ant">
   <xsl:apply-templates/>
  </hi>
 </xsl:template>
 
 <xsl:template match="jp//ant | uts[//korttit!='SFV' and //korttit!='OiA']//ant | bd//ant"> <!-- ms., ant means Latin hand -->
  <hi rendition="#lat">
   <xsl:apply-templates/>
  </hi>
 </xsl:template>
 
 <xsl:template match="bue">
  <hi rendition="#cun">
   <xsl:apply-templates/>
  </hi>
 </xsl:template>
 
 <xsl:template match="hoj">
  <hi rendition="#sup">
   <xsl:apply-templates/>
  </hi>
 </xsl:template>
 
 <xsl:template match="lav">
  <hi rendition="#sub">
   <xsl:apply-templates/>
  </hi>
 </xsl:template>

 <xsl:template match="@gen">
  <xsl:attribute name="rend">
   <xsl:choose>
    <xsl:when test=".='sic'"><xsl:value-of select="name(parent::*)"/></xsl:when>
    <xsl:when test=".='dobund'">dun</xsl:when>
    <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
   </xsl:choose>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="spa" mode="rendition"> <!-- print, spa means spatialised -->
  <rendition scheme="css">
   <xsl:attribute name="xml:id">spa</xsl:attribute>
   <xsl:text>letter-spacing: 0.2em</xsl:text>
  </rendition>
  <xsl:comment>spaced out, in SKS rendered italic</xsl:comment>
 </xsl:template>

 <xsl:template match="jp//spa | uts[//korttit!='SFV' and //korttit!='OiA']//spa | bd//spa" mode="rendition"> <!-- ms. spa means underlined -->
  <rendition scheme="css">
   <xsl:attribute name="xml:id">und</xsl:attribute>
   <xsl:text>text-decoration: underline</xsl:text>
  </rendition>
  <xsl:comment>underlined, in SKS rendered italic</xsl:comment>
 </xsl:template>

 <xsl:template match="kur" mode="rendition">
  <rendition xml:id="ita" scheme="css">font-style: italic</rendition>
 </xsl:template>
 
 <xsl:template match="fed" mode="rendition"> <!-- print, fed means bold -->
  <rendition scheme="css">
   <xsl:attribute name="xml:id">bol</xsl:attribute>
   <xsl:text>font-weight: bold</xsl:text>
  </rendition>
 </xsl:template>

 <xsl:template match="jp//fed | uts[//korttit!='SFV' and //korttit!='OiA']//fed | bd//fed" mode="rendition"> <!-- ms., fed means double underlined -->
  <rendition scheme="css">
   <xsl:attribute name="xml:id">dun</xsl:attribute>
   <xsl:text>border-bottom-style: double</xsl:text>
  </rendition>
  <xsl:comment>double underlined, in SKS rendered bold</xsl:comment>
 </xsl:template>

 <xsl:template match="ant" mode="rendition"> <!-- print, ant means antiqua -->
  <rendition scheme="free">
   <xsl:attribute name="xml:id">ant</xsl:attribute>
   <xsl:text>antiqua typeface, in SKS rendered sans-serif</xsl:text>
  </rendition>
 </xsl:template>

 <xsl:template match="jp//ant | uts[//korttit!='SFV' and //korttit!='OiA']//ant | bd//ant" mode="rendition">
  <rendition scheme="free"> <!-- print, ant means Latin hand -->
   <xsl:attribute name="xml:id">lat</xsl:attribute>
   <xsl:text>Latin hand, in SKS rendered sans-serif</xsl:text>
  </rendition>
 </xsl:template>

 <xsl:template match="bue" mode="rendition">
  <rendition xml:id="cun" scheme="css">text-decoration: underline</rendition>
  <xsl:comment>curved underlining</xsl:comment>
 </xsl:template>
 
 <xsl:template match="hoj" mode="rendition">
  <rendition xml:id="sup" scheme="css">vertical-align: super; font-size:      80%;</rendition>
 </xsl:template>

 <xsl:template match="lav" mode="rendition">
  <rendition xml:id="sub" scheme="css">vertical-align: sub; font-size: 80%;</rendition>
 </xsl:template>
 
 <!-- 2.3.6 -->
 <xsl:template match="dt">
  <foreign xml:lang="de"><xsl:apply-templates/></foreign>
 </xsl:template>
 
 <!-- 2.3.7 -->
 <xsl:template match="typ">
  <hi rendition="#{@art}Typ"><xsl:apply-templates/></hi>
 </xsl:template>
 
 <xsl:template match="typ/@art[.='schw']" mode="rendition">
  <rendition xml:id="schwTyp" scheme="free">Schwabacher, in SKS rendered bold</rendition>
 </xsl:template>
 
 <xsl:template match="typ/@art[.='capi']" mode="rendition">
  <rendition xml:id="capiTyp" scheme="free">Some spectacular type setting, in SKS rendered in small caps</rendition>
 </xsl:template>
 
 <xsl:template match="typ/@art[.='init']" mode="rendition">
  <rendition xml:id="initTyp" scheme="css">font-size: 200%</rendition>
  <xsl:comment>Initial letter</xsl:comment>
 </xsl:template>
 
 <xsl:template match="typ/@art[.='got']" mode="rendition">
  <rendition xml:id="gotTyp" scheme="free">Gothic typeface</rendition>
 </xsl:template>
 
 <!-- 2.3.8 -->
 <xsl:template match="gra">
  <xsl:variable name="skyd">
   <xsl:choose>
    <xsl:when test="@str='-1' and @skyd='0'"> #lineHight1</xsl:when>
    <xsl:when test="@str='-1' and @skyd='+1'"> #lineHight2</xsl:when>
    <xsl:when test="@str='0' and @skyd='+1'"> #lineHight1</xsl:when>
    <xsl:when test="@str='0' and @skyd='+2'"> #lineHight2</xsl:when>
   </xsl:choose>
  </xsl:variable>
  <hi rendition="#size{translate(@str,'+','')}{$skyd}">
   <xsl:apply-templates/>
  </hi>
 </xsl:template>
 
 <xsl:template match="gra/@str[.='1']" mode="rendition"> <!-- make up fo missing + -->
  <xsl:if test="not(//gra/@str[.='+1'])"> <!-- only if a proper one is not present -->
   <rendition scheme="css">
     <xsl:attribute name="xml:id">size1</xsl:attribute>
     font-size: 120%</rendition>
  </xsl:if>
 </xsl:template>
 <xsl:template match="gra/@str[.='2']" mode="rendition">
  <xsl:if test="not(//gra/@str[.='+2'])">
   <rendition scheme="css">
     <xsl:attribute name="xml:id">size2</xsl:attribute>
     font-size: 150%</rendition>
  </xsl:if>
 </xsl:template> 
 <xsl:template match="gra/@str[.='+1']" mode="rendition">
  <rendition xml:id="size1" scheme="css">font-size: 120%</rendition>
 </xsl:template>
 <xsl:template match="gra/@str[.='+2']" mode="rendition">
  <rendition xml:id="size2" scheme="css">font-size: 150%</rendition>
 </xsl:template>
 <xsl:template match="gra/@str[.='+3']" mode="rendition">
  <rendition xml:id="size3" scheme="css">font-size: 175%</rendition>
 </xsl:template>
 <xsl:template match="gra/@str[.='+4']" mode="rendition">
  <rendition xml:id="size4" scheme="css">font-size: 200%</rendition>
 </xsl:template>
 <xsl:template match="gra/@str[.='+5']" mode="rendition">
  <rendition xml:id="size5" scheme="css">font-size: 240%</rendition>
 </xsl:template>
 <xsl:template match="gra/@str[.='+6']" mode="rendition">
  <rendition xml:id="size6" scheme="css">font-size: 300%</rendition>
 </xsl:template>
 <xsl:template match="gra/@str[.='-1']" mode="rendition">
  <rendition xml:id="size-1" scheme="css">font-size: 83%</rendition>
 </xsl:template>
 <xsl:template match="gra/@str[.='-2']" mode="rendition">
  <rendition xml:id="size-2" scheme="css">font-size: 70%</rendition>
 </xsl:template>
 <xsl:template match="gra/@str[.='-3']" mode="rendition">
  <rendition xml:id="size-3" scheme="css">font-size: 58%</rendition>
 </xsl:template>
 <xsl:template match="gra" mode="rendition">
  <rendition xml:id="lineHight1" scheme="css">line-height:150%</rendition>
  <rendition xml:id="lineHight2" scheme="css">line-height:200%</rendition>
 </xsl:template> 

 <!-- 2.3.9 -->
 <xsl:template match="vulg|stang">
  <formula notation="mathml" xmlns:m="http://www.w3.org/1998/Math/MathML">
   <m:math>
    <m:mfrac>
     <xsl:if test="name()='vulg'">
      <xsl:attribute name="bevelled">true</xsl:attribute>
     </xsl:if>
     <m:mi><xsl:apply-templates select="hoj/node()"/></m:mi>
     <m:mi><xsl:apply-templates select="lav/node()"/></m:mi>
    </m:mfrac>
   </m:math>
  </formula>
 </xsl:template>

 <xsl:template match="vulg|stang|rod" mode="schema">
  <xsl:processing-instruction name="xml-model">
   href="http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_allPlus.rng"
   type="application/xml"
   schematypens="http://relaxng.org/ns/structure/1.0"
  </xsl:processing-instruction>
 </xsl:template>  
 
 <xsl:template match="hoj[following-sibling::*[1][name()='rod']]"/> <!-- index, see next -->
 
 <xsl:template match="rod">
  <formula notation="mathml" xmlns:m="http://www.w3.org/1998/Math/MathML">
   <m:math>
    <xsl:choose>
     <xsl:when test="preceding-sibling::*[1][name()='hoj']">
      <m:mroot>
       <m:mi><xsl:apply-templates/></m:mi>
       <m:mi><xsl:apply-templates select="preceding-sibling::*[1][name()='hoj']/node()"/></m:mi>
      </m:mroot>
     </xsl:when>
     <xsl:otherwise>
      <m:msqrt>
       <m:mi><xsl:apply-templates/></m:mi>
      </m:msqrt>
     </xsl:otherwise>
    </xsl:choose>
   </m:math>
  </formula>
 </xsl:template>
 
 
 <!-- 2.3.10 -->
 <xsl:template match="udpkt">
  <seg type="leaders"/>
 </xsl:template>
 
 <!-- 2.3.11.1 -->
 <xsl:template match="udg[@spec='tvivl']">
  <unclear><xsl:apply-templates/></unclear>
 </xsl:template>
 
 <!-- 2.3.11.2 -->
 <xsl:template match="udg[@spec='supp']">
  <supplied><xsl:apply-templates/></supplied>
 </xsl:template>
 
 <!-- 2.3.11.3 -->
 <xsl:template match="udg[@spec='slet']">
  <del><xsl:apply-templates/></del>
 </xsl:template>
 
 <!-- 2.3.11.4 -->
 <xsl:template match="udg[@spec='var']">
  <add status="variant"><xsl:apply-templates/></add>
 </xsl:template>
 
 <!-- 2.3.11.5 -->
 <xsl:template match="udg[@spec='stil']">
  <choice>
   <orig><xsl:value-of select="@txt"/></orig>
   <reg><xsl:apply-templates/></reg>
  </choice>
 </xsl:template>

 <!-- 2.3.11.6 -->
 <xsl:template match="udg[@spec='ellipse']">
  <seg type="ellipsis">
   <xsl:apply-templates/>
  </seg>
 </xsl:template>

 <xsl:template match="udg[@spec='ellipse' and @txt]" priority="2">
  <milestone type="ellipsis" unit="appLem" spanTo="#{@txt}"/>
  <xsl:apply-templates/> <!-- should be empty -->
 </xsl:template>
 
 <!-- 2.3.11.7 -->
 <xsl:template match="udg[@spec='fri']">
  <witDetail>
   <xsl:call-template name="inheritWit"/>
   <xsl:value-of select="@txt"/>
   <xsl:apply-templates/>
  </witDetail>
 </xsl:template>

 <xsl:template name="inheritWit">
  <xsl:variable name="wit">
   <xsl:choose>
    <xsl:when test="@kil">
     <xsl:value-of select="@kil"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="ancestor::add/@kil|ancestor::sub/@kil">
       <xsl:value-of select="ancestor::add/@kil|ancestor::sub/@kil"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="(//kolofon/kilder/@kil)[1]"/>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <xsl:attribute name="wit">
   <xsl:text>#</xsl:text>
   <xsl:call-template name="witAttr">
    <xsl:with-param name="wit" select="$wit"/>
   </xsl:call-template>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template name="witAttr">
  <xsl:param name="wit" select="."/>
  <xsl:choose>
   <xsl:when test="contains($wit,'fort')"><xsl:value-of select="substring-before($wit,'fort')"/>-fort.</xsl:when>
   <xsl:when test="contains($wit,'afskr')"><xsl:value-of select="substring-before($wit,'afskr')"/>-afskrift</xsl:when>
   <xsl:when test="contains($wit,'alfa')"><xsl:value-of select="substring-before($wit,'alfa')"/>α</xsl:when>
   <xsl:when test="contains($wit,'beta')"><xsl:value-of select="substring-before($wit,'beta')"/>β</xsl:when>
   <xsl:when test="contains($wit,'punkt')"><xsl:value-of select="substring-before($wit,'punkt')"/>·</xsl:when>
   <xsl:when test="$wit='Pap'">Pap.</xsl:when>
   <xsl:when test="$wit='Ms'">Ms.</xsl:when>
   <xsl:when test="$wit='Blart'">Bl.art.</xsl:when>
   <xsl:when test="$wit='BA'">BogA</xsl:when>
   <xsl:when test="$wit='Bogh'">Bøgh</xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="$wit"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- 2.3.12 -->
 <xsl:template match="barfod">
  <witDetail wit="#EP" resp="#EP">
   <xsl:value-of select="@kom"/>
   <xsl:apply-templates/>
  </witDetail>
 </xsl:template>
 
 <!-- Registration, specs. 2.4 -->
 <!-- 2.4.1 -->
 <xsl:template match="dag">
  <date when="{@dat}">
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
  </date>
 </xsl:template>
 
 <xsl:template match="dag/@dat">
  <!-- don't subdivide dates with hyphens:
       when="1846-00-00" is invalid whereas "18460000" is not -->
  <xsl:attribute name="when">
   <xsl:choose>
    <xsl:when test="string-length(.)&gt;4 and starts-with(.,'0')"> <!-- year starting with 0 is not valid -->
     <xsl:value-of select="string(number(.))"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="."/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:attribute>
 </xsl:template>
 
 <!-- 2.4.2 -->
 <xsl:template match="pers">
  <persName>
   <xsl:apply-templates select="@norm"/>
   <xsl:apply-templates select="@alt"/>
   <xsl:apply-templates select="@init"/>
   <xsl:apply-templates/>
  </persName>
 </xsl:template>

 <!-- 2.4.3 -->
 <xsl:template match="sted">
  <placeName>
   <xsl:apply-templates select="@norm"/>
   <xsl:apply-templates select="@alt"/>
   <xsl:apply-templates/>
  </placeName>
 </xsl:template>

 <xsl:template match="@norm">
  <xsl:attribute name="key">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="@alt">
  <xsl:attribute name="sameAs">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>

 <!-- 2.4.4 -->
 <xsl:template match="lit">
  <title>
   <xsl:apply-templates select="@id"/>
   <xsl:apply-templates/>
  </title>
 </xsl:template>

 <xsl:template match="@id">
  <xsl:attribute name="key">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>

 <!-- 2.4.5 -->
 <xsl:template match="fork">
  <choice>
   <abbr>
    <xsl:apply-templates/>
   </abbr>
   <expan>
    <xsl:apply-templates select="@norm" mode="meansRef"/>
    <xsl:value-of select="@opl"/>
   </expan>
  <xsl:apply-templates select="@norm"/>
  </choice>
 </xsl:template>
 
 <xsl:template match="fork/@norm">
  <expan rend="means">
   <xsl:attribute name="xml:id">means<xsl:number count="fork" level="any"/></xsl:attribute>
   <xsl:value-of select="."/>
  </expan>
 </xsl:template>
 
 <xsl:template match="fork/@norm" mode="meansRef">
   <xsl:attribute name="ana">#means<xsl:number count="fork" level="any"/></xsl:attribute>
 </xsl:template>
 
 <!-- 2.4.6 -->
 <xsl:template match="bib">
  <rs type="bible">
   <xsl:apply-templates select="@id"/>
   <xsl:apply-templates/>
  </rs>
 </xsl:template>

 <!-- Internal references, specs 2.5 -->

 <!-- 2.5.1 -->
 <xsl:template match="ref[@type='sk' or @type='mu' or @type='su']"> 
  <ptr>
   <xsl:apply-templates select="@*"/>
   <!-- skip marker if any, found in DD:28.c, NB24:51.b, NB24:125.a -->
  </ptr>
 </xsl:template>

 <xsl:template match="ref"> <!-- ref.s with a marker -->
  <ref>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
  </ref>
 </xsl:template>
 
 <xsl:template match="ref/@id|refk/@id">
  <xsl:attribute name="target">
   <xsl:value-of select="concat('#',.)"/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="ref/@type">
  <xsl:attribute name="type">author</xsl:attribute>
 </xsl:template>
 
 <xsl:template match="not/@type">
  <xsl:attribute name="type">author</xsl:attribute>
  <xsl:if test="substring(.,1,1)=substring(.,2,1)">
   <xsl:attribute name="subtype">subnote</xsl:attribute>
  </xsl:if>
  <xsl:attribute name="place">
   <xsl:choose>
    <xsl:when test="starts-with(.,'m')">margin</xsl:when>
    <xsl:otherwise>bottom</xsl:otherwise>
   </xsl:choose>
  </xsl:attribute>
  <xsl:if test="contains(.,'u')">
   <xsl:attribute name="anchored">false</xsl:attribute>
  </xsl:if>
  <xsl:if test="starts-with(.,'e')">
   <xsl:attribute name="source">#EP</xsl:attribute>
  </xsl:if>   
 </xsl:template>
 
 <xsl:template match="indv[normalize-space()]">
  <seg type="refMarker"><xsl:apply-templates/></seg>
 </xsl:template>
 
 <xsl:template match="indv"/> <!-- if empty, skip it (found in newspaper articles & NB11) -->
 
 <!-- 2.5.2 -->
 <xsl:template match="tn">
  <app>
   <lem>
    <xsl:apply-templates select="add/@kil"/>
    <xsl:choose>
     <xsl:when test="sub/@type='sletfor'">
      <xsl:attribute name="varSeq">2</xsl:attribute>
     </xsl:when>
     <xsl:when test="sub/@type='sletbag'">
      <xsl:attribute name="varSeq">1</xsl:attribute>
     </xsl:when>
    </xsl:choose>
    <xsl:apply-templates select="*[name()!='sub']|text()[normalize-space()]"/>
   </lem>
   <xsl:choose>
    <xsl:when test="sub[@skil='semiko' or @skil='ny' or @skil='ny']"> <!-- readings should be grouped -->
     <rdgGrp> <!-- first group -->
      <xsl:for-each select="sub[1][@skil='komma' or not(@skil)]">
       <xsl:apply-templates select="."/>
       <xsl:call-template name="nxRdgInGrp"/>
      </xsl:for-each>
     </rdgGrp>
     <xsl:apply-templates select="sub[@skil='semiko' or @skil='ny' or @skil='ny']"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates select="sub"/>
    </xsl:otherwise>
   </xsl:choose>
  </app>
 </xsl:template>
 
 <xsl:template match="add[@kil]"> <!-- emendation -->
  <corr>
   <xsl:apply-templates/>
  </corr>
 </xsl:template>
 
 <xsl:template match="add">
  <add>
   <xsl:apply-templates select="@type"/>
   <xsl:if test="contains(@type,'marg') or following-sibling::sub/@type='aefmarg' or preceding-sibling::sub/@type='aefmarg'">
    <xsl:attribute name="place">margin</xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
  </add>
 </xsl:template>
 
 <xsl:template match="add/@type">
  <xsl:attribute name="instant">false</xsl:attribute>
  <xsl:attribute name="rendition"><xsl:value-of select="concat('#',.)"/></xsl:attribute>
 </xsl:template>

 <xsl:template match="sub[@skil='semiko' or @skil='ny' or @skil='ny']"> <!-- group delimiter -->
  <rdgGrp>
   <xsl:apply-templates select="@skil"/>
   <rdg>
    <!--xsl:apply-templates select="@kil|@type"/>
    <xsl:apply-templates/-->
    <xsl:apply-templates select="@kil"/>
    <xsl:call-template name="subType"/>
   </rdg>
   <xsl:call-template name="nxRdgInGrp"/>
  </rdgGrp>
 </xsl:template>
 
 <xsl:template name="nxRdgInGrp">
  <xsl:for-each select="following-sibling::sub[1]">
   <xsl:if test="@skil='komma' or not(@skil)">
    <xsl:apply-templates select="."/>
    <xsl:call-template name="nxRdgInGrp"/>
   </xsl:if> 
  </xsl:for-each>
 </xsl:template>
 
 <xsl:template match="sub">
  <rdg>
   <xsl:apply-templates select="@kil"/>
   <xsl:apply-templates select="@skil"/>
   <xsl:call-template name="subType"/>
   <!--xsl:apply-templates select="@type"/> - must be last, constructs inner element -
   <xsl:apply-templates/-->
  </rdg>
 </xsl:template>
 
 <xsl:template match="altbeg/sub">
  <rdg rendition="#komma">
   <xsl:apply-templates select="@kil"/>
   <xsl:apply-templates/>
  </rdg>
 </xsl:template>
 
 <xsl:template match="add/@kil|sub/@kil">
  <xsl:attribute name="wit">
   <xsl:text>#</xsl:text>
   <xsl:call-template name="witAttr"/>
   <!--<xsl:value-of select="concat('#',.)"/>-->
   <xsl:apply-templates select="parent::sub/following-sibling::sub[1][@kil and @skil='komma' and not(@type) and not(*) and normalize-space()='']" mode="wit"/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="sub" mode="wit">
  <xsl:text> </xsl:text>
  <xsl:text>#</xsl:text>
  <xsl:call-template name="witAttr">
   <xsl:with-param name="wit" select="@kil"/>
  </xsl:call-template>
  <xsl:apply-templates select="following-sibling::sub[1][@kil and @skil='komma' and not(@type) and not(*) and normalize-space()='']" mode="wit"/>
 </xsl:template>
 
 <xsl:template match="sub[@kil and @skil='komma' and not(@type) and not(*) and normalize-space()='']"/>

 <xsl:template name="subType">
  <xsl:choose>
   <xsl:when test="@type">
    <xsl:variable name="elem">
     <xsl:choose>
      <xsl:when test="@type='mff'">corr</xsl:when>
      <xsl:when test="@type='mgl'">supplied</xsl:when>
      <xsl:when test="@type='so'">sic</xsl:when>
      <xsl:otherwise>del</xsl:otherwise>
     </xsl:choose>
    </xsl:variable>
    <xsl:if test="starts-with(@type,'slet')">
     <xsl:attribute name="varSeq">
      <xsl:choose>
       <xsl:when test="contains(@type,'for')">1</xsl:when>
       <xsl:when test="contains(@type,'bag')">2</xsl:when>
      </xsl:choose>
     </xsl:attribute>
    </xsl:if>
    <xsl:element name="{$elem}">
     <xsl:choose>
      <xsl:when test="@type='fs'">
       <xsl:attribute name="instant">true</xsl:attribute> <!-- instant correction -->
      </xsl:when>
      <xsl:when test="@type='aef'">
       <xsl:attribute name="instant">false</xsl:attribute> <!-- later correction -->
      </xsl:when>
      <xsl:when test="@type='aefmarg'">
       <xsl:attribute name="instant">false</xsl:attribute>
      </xsl:when>
      <xsl:when test="@type='sletfor'">
       <xsl:attribute name="instant">unknown</xsl:attribute> <!-- genetically unknown correction -->
      </xsl:when>
      <xsl:when test="@type='sletbag'">
       <xsl:attribute name="instant">unknown</xsl:attribute>
      </xsl:when>
      <xsl:when test="@type='uvis'">
       <xsl:attribute name="instant">unknown</xsl:attribute>
      </xsl:when>
      <xsl:when test="@type='mff'">
       <xsl:attribute name="evidence">suggestedConjecture</xsl:attribute>
      </xsl:when>
      <xsl:when test="@type='mgl'">
       <xsl:attribute name="evidence">suggestedConjecture</xsl:attribute>
      </xsl:when>
     </xsl:choose>
     <xsl:attribute name="rendition">
      <xsl:value-of select="concat('#',@type)"/>
     </xsl:attribute>
     <xsl:apply-templates/>
    </xsl:element>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="sub/@skil">
  <xsl:attribute name="rendition">
   <xsl:value-of select="concat('#',.)"/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="add/@type[.='til']" mode="rendition">
  <rendition xml:id="til" selector="add" scope="after">content:" tilføjet"</rendition>
 </xsl:template>
 <xsl:template match="add/@type[.='tilmarg']" mode="rendition">
  <rendition xml:id="tilmarg" selector="add" scope="before">content:" tilføjet i marginen"</rendition>
 </xsl:template>
 <xsl:template match="sub/@type[.='fs']" mode="rendition">
  <rendition xml:id="fs" selector="rdg" scope="before">content:"først skrevet "</rendition>
 </xsl:template>
 <xsl:template match="sub/@type[.='aef']" mode="rendition">
  <rendition xml:id="aef" selector="rdg" scope="before">content:"ændret fra "</rendition>
 </xsl:template>
 <xsl:template match="sub/@type[.='aefmarg']" mode="rendition">
  <rendition xml:id="aefmarg" selector="rdg" scope="before">content:"ændret i marginen fra "</rendition>
 </xsl:template>
 <xsl:template match="sub/@type[.='sletfor']" mode="rendition">
  <rendition xml:id="sletfor" selector="rdg" scope="before">content:"foran er slettet "</rendition>
 </xsl:template>
 <xsl:template match="sub/@type[.='sletbag']" mode="rendition">
  <rendition xml:id="sletbag" selector="rdg" scope="before">content:"herefter er slettet "</rendition>
 </xsl:template>
 <xsl:template match="sub/@type[.='uvis']" mode="rendition">
  <rendition xml:id="uvis" selector="rdg" scope="before">content:"&lt; "</rendition>
 </xsl:template>
 <xsl:template match="sub/@type[.='mgl']" mode="rendition">
  <rendition xml:id="mgl" selector="supplied" scope="before">content:"ord mangler, fx "</rendition>
 </xsl:template>
 <xsl:template match="sub/@type[.='mff']" mode="rendition">
  <rendition xml:id="mff" selector="corr" scope="before">content:"måske fejl for "</rendition>
 </xsl:template>
 <xsl:template match="sub/@type[.='so']" mode="rendition">
  <rendition xml:id="so" selector="sic" scope="before">content:"således også "</rendition>
 </xsl:template>
 <xsl:template match="sub" mode="rendition">
  <!-- all subs to make up for the artificial delimiter invented for altbeg/sub > app/rdg -->
  <rendition xml:id="komma" selector="rdg" scope="before">content:", "</rendition>
 </xsl:template>
 <xsl:template match="sub/@skil[.='semiko']" mode="rendition">
  <rendition xml:id="semiko" selector="rdg" scope="before">content:"; "</rendition>
 </xsl:template>
 <xsl:template match="sub/@skil[.='punkt']" mode="rendition">
  <rendition xml:id="punkt" selector="rdg" scope="before">content:". "</rendition>
 </xsl:template>
 <xsl:template match="sub/@skil[.='ny']" mode="rendition">
  <rendition xml:id="ny" selector="rdg" scope="before">content:" · "</rendition>
 </xsl:template>

 <!-- 2.5.3 -->
 <xsl:template match="altbeg">
  <app>
   <rdg>
    <xsl:apply-templates select="@kil"/>
    <witStart>
     <xsl:apply-templates select="@n"/>
     <xsl:apply-templates select="@spec"/>
    </witStart>
    <xsl:if test="@msifB or @paa">
     <witDetail>
<!--      <xsl:apply-templates select="@kil"/>-->
      <xsl:call-template name="inheritWit"/>
      <xsl:apply-templates select="@msifB"/>
      <xsl:apply-templates select="@paa"/>
     </witDetail>
    </xsl:if>
   </rdg>
   <xsl:apply-templates/>
  </app>
 </xsl:template>

 <xsl:template match="altslut">
  <app>
   <rdg>
    <witEnd>
     <xsl:apply-templates select="@*"/>
    </witEnd>
   </rdg>
  </app>
 </xsl:template>
 
 <xsl:template match="altbeg/@spec">
  <xsl:attribute name="rendition">
   <xsl:value-of select="concat('#',.,'beg')"/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="altslut/@spec">
  <xsl:attribute name="rendition">
   <xsl:value-of select="concat('#',.,'slut')"/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="altbeg/@n">
  <xsl:attribute name="n">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="altbeg/@kil">
  <xsl:attribute name="wit">
   <xsl:text>#</xsl:text>
   <xsl:call-template name="witAttr"/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="altbeg/@paa">
  <xsl:attribute name="place">elsewhere</xsl:attribute>
  <xsl:value-of select="."/>
 </xsl:template>
 
 <xsl:template match="altbeg/@msifB">
  <xsl:attribute name="rendition">#msifBbeg #msifBslut</xsl:attribute>
  <xsl:attribute name="n">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="@spec[.='hak']" mode="rendition">
  <rendition xml:id="hakbeg" selector="witStart" scope="before">content:"▶"</rendition>
  <rendition xml:id="hakslut" selector="witEnd" scope="after">content:"◀"</rendition>
 </xsl:template>
 
 <xsl:template match="@spec[.='hakhak']" mode="rendition">
  <rendition xml:id="hakhakbeg" selector="witStart" scope="before">content:"▶▶"</rendition>
  <rendition xml:id="hakhakslut" selector="witEnd" scope="after">content:"◀◀"</rendition>
 </xsl:template>
 
 <xsl:template match="@spec[.='hakbag']" mode="rendition">
  <rendition xml:id="hakbagbeg" selector="witStart" scope="before">content:"▶"; text-align: justify</rendition>
  <rendition xml:id="hakbagslut" selector="witEnd" scope="after">content:"◀"</rendition>
 </xsl:template>
 
 <xsl:template match="@spec[.='arm']" mode="rendition">
  <rendition xml:id="armbeg" selector="witStart" scope="before">content:"⌈"</rendition>
  <rendition xml:id="armslut" selector="witEnd" scope="after">content:"⌉"</rendition>
 </xsl:template>
 
 <xsl:template match="@spec[.='fod']" mode="rendition">
  <rendition xml:id="fodbeg" selector="witStart" scope="before">content:"⌊"</rendition>
  <rendition xml:id="fodslut" selector="witEnd" scope="after">content:"⌋"</rendition>
 </xsl:template>

 <xsl:template match="@msifB" mode="rendition">
   <rendition xml:id="msifBbeg" selector="witDetail" scope="before">content:" (ms s. "</rendition>
   <rendition xml:id="msifBslut" selector="witDetail" scope="after">content:" if. B-fort.)"</rendition>
 </xsl:template>
 
 <!-- 2.5.4 -->
 <xsl:template match="refi[not(ill)]">
  <xsl:variable name="fileName">
    <!-- merely guesswork, cmp. 3.8.4 -->
    <xsl:if
     test="starts-with(@id,'k') or starts-with(@id,'K')">txr.xml</xsl:if>
    <!-- otherwise local -->
  </xsl:variable>
  <ptr type="figure" target="{$fileName}#ill_{@id}"/>
  <!-- relative location of the figure and figure description --> 
 </xsl:template>

 <xsl:template match="refi[ill]">
  <xsl:apply-templates/>
 </xsl:template>

 <!-- External references, specs 2.6 -->
 <!-- 2.6.1 -->
 <xsl:template match="kor[@kil='SK' or @kil='supp' or not(@kil)]"> <!-- Base text page number -->
  <pb>
   <xsl:if test="@id">
    <xsl:if test="not(preceding::kor[(@kil='SK' or @kil='supp' or not(@kil)) and @id=current()/@id])"> <!-- @id may not be unique -->
      <xsl:attribute name="xml:id">
       <xsl:value-of select="concat('s',@id)"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:attribute name="n">
     <xsl:value-of select="@id"/>
    </xsl:attribute>
    <xsl:if test="@kil='supp'">
     <xsl:attribute name="rend">supplied</xsl:attribute>
    </xsl:if>
   </xsl:if>
   <xsl:apply-templates select="following-sibling::refi" mode="pbFacs"/>
  </pb>
 </xsl:template>
 
 <xsl:template match="kor[@kil='SKS']"> <!-- SKS page number -->
  <pb>
   <xsl:attribute name="xml:id">
    <xsl:value-of select="concat('ss',@id)"/>
   </xsl:attribute>
   <xsl:apply-templates select="@*"/>
  </pb>
 </xsl:template>

 <xsl:template match="kor[starts-with(@kil,'SV') or starts-with(@kil,'EP')]"> <!-- other page numbers -->
  <pb>
   <xsl:apply-templates select="@*"/>
  </pb>
 </xsl:template>
 
 <xsl:template match="kor"> <!-- Pap, BA, B-fort, KA and others -->
  <milestone unit="entry">
   <xsl:apply-templates select="@*"/>
  </milestone>
 </xsl:template>
 
 <xsl:template match="kor/@kil">
  <xsl:attribute name="edRef">
   <xsl:text>#</xsl:text>
   <xsl:call-template name="witAttr"/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="kor/@id">
  <xsl:choose>
   <xsl:when test=".='0'">
    <xsl:attribute name="unit">unnumbered</xsl:attribute>
   </xsl:when>
   <xsl:otherwise>
    <xsl:attribute name="n">
     <xsl:value-of select="."/>
    </xsl:attribute>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="refi" mode="pbFacs">
  <xsl:attribute name="facs">
   <xsl:choose>
    <xsl:when test="ill/illfil/@id">
     <xsl:choose>
      <xsl:when test="contains(ill/illfil/@id,'/sks.dk/')">
       <xsl:text>../</xsl:text>
       <xsl:value-of select="translate(substring-after(ill/illfil/@id,'/sks.dk/'),'K','k')"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="translate(ill/illfil/@id,'K','k')"/>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
     <xsl:text>ill_</xsl:text>
     <xsl:choose>
      <xsl:when test="ill/@id">
       <xsl:value-of select="translate(ill/@id,'K','k')"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="translate(@id,'K','k')"/>
      </xsl:otherwise>
     </xsl:choose>
     <xsl:text>.jpg</xsl:text>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:attribute>
 </xsl:template>
 
 <!-- 2.6.2 --> 
 <xsl:template match="kom">
  <xsl:variable name="comFile">
   <xsl:choose>
    <xsl:when test="@x='e'"><xsl:value-of select="/kn1/ts/@ekom|/kn1/uts/@ekom|/kn1/jp/@ekom|/kn1/bd/@ekom"/></xsl:when>
    <xsl:otherwise><xsl:value-of select="/kn1/ts/@kom|/kn1/uts/@kom|/kn1/jp/@kom|/kn1/bd/@kom"/></xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <ref type="commentary" target="{$comFile}#{@id}">
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
  </ref>
 </xsl:template>

 <xsl:template match="kom/@id|skakt/@id|k/@id|not/@id">
  <xsl:attribute name="xml:id">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>

 <!-- 2.6.3 -->  
 <xsl:template match="skakt">
  <seg type="shaft">
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
  </seg>
 </xsl:template>

 <xsl:template match="skakt/@mss"> <!-- not used -->
  <xsl:attribute name="n">
   <xsl:value-of select="@mss"/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="@mss|@init">
  <xsl:attribute name="n"><xsl:value-of select="."/></xsl:attribute>
 </xsl:template>

 <!-- 2.6.4 --> 
 <xsl:template match="refs">
  <xsl:variable name="txtFile">
   <xsl:if test="@tit">
    <xsl:text>../</xsl:text><xsl:value-of select="@tit"/><xsl:text>/txt.xml</xsl:text>
   </xsl:if>
  </xsl:variable>
  <ref type="page" target="{$txtFile}#s{@id}">
   <xsl:choose>
    <xsl:when test="not(translate(.,'0123456789',''))"> <!-- content is a number or empty  -->
     <xsl:if test=".!='' and .!=@id"> <!-- a number different from @id -->
      <xsl:attribute name="n">
       <xsl:value-of select="."/> <!-- @n = SKS page number -->
      </xsl:attribute>
     </xsl:if>
     <xsl:value-of select="@id"/> <!-- new content = base text page number -->
    </xsl:when>
    <xsl:otherwise>
     <xsl:apply-templates/>
    </xsl:otherwise>
   </xsl:choose>
  </ref>
 </xsl:template>

 <!-- Line, specs. 3.1 -->
 <xsl:template match="lin">
  <p>
   <xsl:apply-templates select="@ryk"/> 
   <xsl:apply-templates select="@dek"/>
   <!-- call for @ryk before @dek in case they are both present
        together with <lin> content (DS p.152)
        (a blank line with a content makes no sense, but anyway) -->
   <xsl:apply-templates/>
  </p>
 </xsl:template>
 
 <xsl:template match="lin/@ryk">
  <xsl:attribute name="rendition">
   <xsl:value-of select="concat('#',.)"/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="@ryk" mode="rendition">
   <rendition selector="p,l,cell" scheme="css">
    <xsl:attribute name="xml:id"><xsl:value-of select="."/></xsl:attribute>
    <xsl:choose>
     <xsl:when test=".='ind'">text-indent: 1em</xsl:when>
     <xsl:when test=".='ind2'">text-indent: 2em</xsl:when>
     <xsl:when test=".='kort'">margin-left: 1em</xsl:when>
     <xsl:when test=".='lang'">margin-left: 2em</xsl:when>
     <xsl:when test=".='xlang'">margin-left: 3em</xsl:when>
     <xsl:when test=".='x1lang'">margin-left: 3em</xsl:when>
     <xsl:when test=".='xxlang'">margin-left: 4em</xsl:when>
     <xsl:when test=".='x2lang'">margin-left: 4em</xsl:when>
     <xsl:when test=".='x3lang'">margin-left: 5em</xsl:when>
     <xsl:when test=".='x4lang'">margin-left: 6em</xsl:when>
     <xsl:when test=".='x5lang'">margin-left: 7em</xsl:when>
     <xsl:when test=".='x6lang'">margin-left: 8em</xsl:when>
     <xsl:when test=".='x7lang'">margin-left: 9em</xsl:when>
     <xsl:when test=".='x8lang'">margin-left: 10em</xsl:when>
     <xsl:when test=".='x9lang'">margin-left: 11em</xsl:when>
     <xsl:when test=".='kortind'">margin-left: 1em; text-indent: 1em</xsl:when>
     <xsl:when test=".='langind'">margin-left: 2em; text-indent: 1em</xsl:when>
     <xsl:when test=".='xlangind'">margin-left: 3em; text-indent: 1em</xsl:when>
     <xsl:when test=".='ud'">margin-left: 1em; text-indent: -1em</xsl:when>
     <xsl:when test=".='indud'">margin-left: 2em; text-indent: -1em</xsl:when>
     <xsl:when test=".='cen'">text-align:center</xsl:when>
     <xsl:when test=".='bag'">text-align: right</xsl:when>
     <xsl:when test=".='bagind'">text-align: right;
    margin-right: 1em</xsl:when>
     <xsl:when test=".='baglang'">text-align: right; margin-right: 2em</xsl:when>
     <xsl:when test=".='bagxlang'">text-align: right; margin-right: 3em</xsl:when>
    </xsl:choose>
   </rendition>
 </xsl:template>

 <xsl:template match="opt/@dek|lin/@dek">
  <xsl:attribute name="rend">decoration</xsl:attribute>
  <figure>
   <xsl:attribute name="type">
    <xsl:choose>
     <xsl:when test=".='klum'">columnRuler</xsl:when>
     <xsl:when test=".='skil'">divisionRuler</xsl:when>
     <xsl:when test=".='dobskil'">divisionRulerDouble</xsl:when>
     <xsl:when test=".='skilbag'">divisionRulerRight</xsl:when>
     <xsl:when test=".='ast'">asterisk</xsl:when>
     <xsl:when test=".='ast2'">2asterisks</xsl:when>
     <xsl:when test=".='ast3'">3asterisks</xsl:when>
     <xsl:when test=".='ast3op'">3asterisksUp</xsl:when>
     <xsl:when test=".='ast3ned'">3asterisksDown</xsl:when>
     <xsl:when test=".='streg3'">3dashes</xsl:when>
     <xsl:when test=".='dobstreg'">dashDouble</xsl:when>
     <xsl:when test=".='kryds'">x</xsl:when>
     <xsl:when test=".='dobkors'">hash</xsl:when>
     <xsl:when test=".='dobkorsblank'">hashBlank</xsl:when>
     <xsl:when test=".='edobkors'">hashSingleDouble</xsl:when>
     <xsl:when test=".='blg'">wave</xsl:when>
     <xsl:when test=".='blgskil'">divisionRulerWaved</xsl:when>
     <xsl:when test=".='blgskilpunkt'">divisionRulerWavedPoint</xsl:when>
     <xsl:when test=".='S'">hashEntwined</xsl:when>
     <xsl:when test=".='kors'">cross</xsl:when>
     <xsl:when test="starts-with(.,'vig')">vignet</xsl:when>
     <xsl:when test=".='kors3ned'">3crossesDown</xsl:when>
     <xsl:when test=".='halvblank'">blankHalfLine</xsl:when>
     <xsl:when test=".='blank'">blank</xsl:when>
     <xsl:otherwise>kn1:<xsl:value-of select="."/></xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
   <xsl:if test="starts-with(.,'vig')">
    <figDesc>
     <xsl:choose>
      <xsl:when test=".='vig-dd-207'">large curlicue</xsl:when>
      <xsl:when test=".='vig-ee-178'">illustration: C . &lt;.-.- A .-.-.-&gt;. B, arc connecting left arrow head and B</xsl:when>
      <xsl:when test=".='vig-not13-23'">stick figure</xsl:when>
      <xsl:when test=".='vig-nb-7'">small curlicue</xsl:when>
      <xsl:when test=".='vig-papir-21'">circle with a dot in center</xsl:when>
      <xsl:when test=".='vig-sfv'">illustration: Mercury holding a shield with C A R</xsl:when>
     </xsl:choose>
    </figDesc>
    <graphic url="../vignet/{.}.jpg"/>
   </xsl:if>
  </figure>
 </xsl:template>
<!-- 
 <xsl:template match="@dek[.='blank']" priority="2"> <! special treatment for this one >
  <xsl:apply-templates select="@ryk"/> <! should be empty >
  <xsl:text>&#160;</xsl:text><xsl:comment>blank</xsl:comment> <xsl:apply-templates/><! should be empty >
 </xsl:template>
-->
 <!-- Block, specs. 3.2 -->
 <!-- 3.2.1-2 -->
 <xsl:template match="blok[@ryk='tab']">
  <table>
   <xsl:apply-templates select="@kol"/>
   <xsl:apply-templates/>
  </table>
 </xsl:template>

 <xsl:template match="blok[@ryk='udspark']">
  <table cols="2" rows="1" rendition="{concat('#',@ryk)}">
   <xsl:apply-templates/>
  </table>
 </xsl:template>
 
 <xsl:template match="blok/@ryk[.='udspark']" mode="rendition">
  <xsl:if test="not(preceding::blok[@ryk='udspark'])">
   <rendition xml:id="udspark" selector="table" scheme="css">width:100%</rendition>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="blok/@kol">
  <xsl:attribute name="cols">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="blok[@ryk='tab' or @ryk='udspark']/lin" priority="2"> <!-- should be the normal case -->
  <xsl:call-template name="tablerow"/>
 </xsl:template>
 
 <xsl:template match="lin[tab]"> <!-- not catched above, i.e. missing surrounding <blok ryk="tab"> -->
  <table>
   <xsl:call-template name="tablerow"/>
  </table>
 </xsl:template>
 
 <xsl:template name="tablerow">
  <xsl:if test="kor">
   <xsl:apply-templates select="kor"/> <!-- page break not allowed in row -->
  </xsl:if>
  <row>
   <xsl:if test="not(tab)">
    <cell/> <!-- <row> must not be empty -->
   </xsl:if>
   <xsl:apply-templates select="node()[name()!='kor' and not(starts-with(name(),'alt'))]"/> <!-- apparatus not allowed outside cell -->
  </row>
 </xsl:template>

 <xsl:template match="tab">
  <cell>
   <xsl:apply-templates select="@klumspan|@linspan"/>
   <xsl:if test="@ryk|@top|@hojre|@bund|@venstre">
    <xsl:attribute name="rendition">
     <xsl:if test="@ryk">
      <xsl:text>#</xsl:text>
      <xsl:value-of select="@ryk"/>
      <xsl:if test="@top|@hojre|@bund|@venstre">
       <xsl:text> </xsl:text>
      </xsl:if>
     </xsl:if>
     <xsl:for-each select="@top|@hojre|@bund|@venstre">
      <xsl:text>#</xsl:text>
      <xsl:value-of select="name()"/><xsl:value-of select="."/>
      <xsl:if test="position()!=last()">
       <xsl:text> </xsl:text>
      </xsl:if>
     </xsl:for-each>
    </xsl:attribute>
   </xsl:if>
   <xsl:apply-templates/>
   <xsl:apply-templates select="parent::lin/altbeg|parent::lin/altslut"/> <!-- errorneous coding in NB24:2 -->
  </cell>
 </xsl:template>
 
 <xsl:template match="@top|@hojre|@bund|@venstre" mode="rendition">
  <xsl:if test="not(preceding::*/@*[name()=name(current()) and .=current()])">
   <rendition selector="cell" scheme="css">
    <xsl:attribute name="xml:id"><xsl:value-of select="concat(name(),.)"/></xsl:attribute>
    <xsl:text>border-</xsl:text>
    <xsl:choose>
     <xsl:when test="name()='top'">top</xsl:when>
     <xsl:when test="name()='hojre'">right</xsl:when>
     <xsl:when test="name()='bund'">bottum</xsl:when>
     <xsl:when test="name()='venstre'">left</xsl:when>
    </xsl:choose>
    <xsl:text>:thin solid</xsl:text>
   </rendition>
  <xsl:if test="contains(.,'ark-')">
   <xsl:comment>
    <xsl:text>accolade pointing </xsl:text>
    <xsl:choose>
     <xsl:when test="contains(.,'-ind')">in</xsl:when>
     <xsl:when test="contains(.,'-ud')">out</xsl:when>
    </xsl:choose>
   </xsl:comment>
  </xsl:if>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="@klumspan">
  <xsl:attribute name="cols">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="@linspan">
  <xsl:attribute name="rows">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
 
 <!-- 3.2.3 -->
 <xsl:template match="blok[@ryk='etiket']">
  <div type="label">
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <!-- 3.2.4 -->
 <xsl:template match="blok[@ryk='lyrik']">
  <lg>
   <xsl:apply-templates/>
  </lg>
 </xsl:template>

 <xsl:template match="blok[@ryk='lyrik']/lin">
  <l>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
  </l>
 </xsl:template>

 <!-- Notes, specs. 3.3 -->
 <xsl:template match="not">
  <note>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
  </note>
 </xsl:template>
 
 <!-- Illustration, specs. 3.4 -->
 <xsl:template match="ill">
  <figure>
   <xsl:apply-templates select="@*"/>
   <xsl:if test="not(illfil)">
    <graphic url="{concat('../',//korttit,'/ill_',translate(@id,'K','k'),'.jpg')}"/>
   </xsl:if>
   <xsl:apply-templates/>
  </figure>
 </xsl:template>
 
 <!-- ill/@side (fax of page) transf. to @n, ok?? -->
 
 <xsl:template match="ill/@id">
  <xsl:attribute name="xml:id">
   <xsl:value-of select="concat('ill_',translate(.,'K','k'))"/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="ill/@nr"/> <!-- not used -->
 
 <xsl:template match="@tving">
  <xsl:for-each select="..">
   <xsl:call-template name="tvingRyk"/>
  </xsl:for-each>
 </xsl:template>
 
 <xsl:template match="ill/lin">
  <head><xsl:apply-templates/></head>
 </xsl:template>
 
 <xsl:template match="illfil">
  <graphic url="{concat('..',translate(substring-after(@id,'sks.dk'),'K','k'))}"/>
 </xsl:template>
 
 <!-- Chapter and rubric, specs. 3.5 -->
 <xsl:template match="kap">
  <!--<xsl:call-template name="chkPb"/>-->
  <div type="chapter">
   <xsl:apply-templates select="@sp|@nr"/>
   <xsl:call-template name="tvingRyk"/>
   <xsl:apply-templates select="@klum|@vklum"/>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template name="chkPb">
  <xsl:variable name="nextPb" select="generate-id((.//kor)[1])"/>
  <xsl:variable name="txtBefore">
   <xsl:apply-templates select=".//text()[following::kor[generate-id()=$nextPb]]"/>
  </xsl:variable>
   <xsl:if test="not(normalize-space($txtBefore))">
    <pb test="test"/>    
   </xsl:if>
    <!--<xsl:comment>
     <xsl:value-of select="$txtBefore"/>
     <xsl:text>|</xsl:text>
     <xsl:for-each select="(.//kor)[1]/@*">
      <xsl:text>|</xsl:text>
      <xsl:value-of select="."/>
     </xsl:for-each>
    </xsl:comment>-->
 </xsl:template>

 <xsl:template name="tvingRyk">
  <xsl:variable name="rend">
   <xsl:choose>
    <xsl:when test="@tving='nyside'">newPage</xsl:when>
    <xsl:when test="@tving='recto'">recto</xsl:when>
    <xsl:when test="@tving='verso'">verso</xsl:when>
    <xsl:when test="@tving='ops'">opening</xsl:when>
    <xsl:when test="@tving='sep'">separate</xsl:when>
    <xsl:when test="@tving='blankverso'">blankVerso</xsl:when>
    <xsl:when test="@tving='nyBfort'">newBlist</xsl:when>
    <xsl:when test="@tving='nyBfort-nyside'">newBlist</xsl:when> <!-- not used -->
   </xsl:choose>
   <xsl:text> </xsl:text>
   <xsl:choose>
    <xsl:when test="@ryk='kort'">short</xsl:when>
    <xsl:when test="@ryk='lang'">long</xsl:when>
   </xsl:choose>
  </xsl:variable>
  <xsl:if test="normalize-space($rend)">
   <xsl:attribute name="rend">
    <xsl:value-of select="normalize-space($rend)"/>
   </xsl:attribute>
  </xsl:if>
 </xsl:template>

 <xsl:template match="opt/@klum|kap/@klum|kap/@vklum|korrespondance/@klum">
  <head type="topText" n="{.}">
   <xsl:if test="name()='vklum'">
    <xsl:attribute name="subtype">versoPage</xsl:attribute>
   </xsl:if>
  </head>
 </xsl:template>
 
 <xsl:template match="kap/@sp">
  <xsl:if test=".!='1'">
   <xsl:attribute name="subtype">col<xsl:value-of select="."/></xsl:attribute>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="kap/@ryk">
  <xsl:attribute name="rendition"><xsl:value-of select="."/></xsl:attribute>
 </xsl:template>
 
 <xsl:template match="kap/@nr"/> <!-- not used -->
  
 <xsl:template match="rub">
  <head>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
  </head>
 </xsl:template>
 
 <xsl:template match="rub/lin">
  <l>
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
  </l>
 </xsl:template>
 
 <xsl:template match="rub/@niv">
  <xsl:attribute name="rendition">
   <xsl:text>#niv</xsl:text>
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="@niv" mode="rendition">
   <rendition selector="head" scheme="css">
    <xsl:attribute name="xml:id"><xsl:value-of select="concat('niv',.)"/></xsl:attribute>
    <xsl:text>margin-top: </xsl:text>
    <xsl:choose>
     <xsl:when test=".='00'">0</xsl:when>
     <xsl:when test=".='0'">1</xsl:when>
     <xsl:when test=".='1'">2</xsl:when>
    </xsl:choose>
    <xsl:text>em; margin-bottom: </xsl:text>
    <xsl:choose>
     <xsl:when test=".='00'">0</xsl:when>
     <xsl:when test=".='0'">0</xsl:when>
     <xsl:when test=".='1'">1</xsl:when>
    </xsl:choose>
    <xsl:text>em</xsl:text>
   </rendition>
 </xsl:template>

 <!-- Notebook entries, specs. 3.6 -->
 <xsl:template match="opt">
  <div type="entry" n="{@nr}">
   <xsl:attribute name="xml:id">
    <xsl:text>n</xsl:text>
    <xsl:choose>
     <xsl:when test="contains(@nr,':')">
      <xsl:value-of select="translate(@nr,':','-')"/>
     </xsl:when>
     <xsl:when test="@nr=preceding-sibling::opt/@nr"> <!-- error in Papir 443 -->
      <xsl:value-of select="preceding-sibling::opt[1]/@nr+1"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="@nr"/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
   <xsl:attribute name="n">
    <xsl:choose>
     <xsl:when test="@nr=preceding-sibling::opt/@nr"> <!-- error in Papir 443 -->
      <xsl:value-of select="preceding-sibling::opt[1]/@nr+1"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="@nr"/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
   <xsl:call-template name="tvingRyk"/>
   <xsl:apply-templates select="@klum"/>
  <dateline>
    <date>
     <xsl:apply-templates select="@dat"/>
     <xsl:apply-templates select="@senest"/>
     <xsl:apply-templates select="@kil"/>
    </date>
   </dateline>
   <p>
    <xsl:apply-templates select="@dek"/>
   </p>
    <xsl:apply-templates/>
  </div>
 </xsl:template>

 <xsl:template match="@dat|@udk">
  <xsl:attribute name="when">
   <xsl:choose>
    <xsl:when test="string-length(.)&gt;8 and not(translate(.,'0123456789',''))"> <!-- digits, more than 8, making up for an erroneous coding of p52:2-->
     <xsl:value-of select="concat(substring(.,1,4),substring(.,7,2),substring(.,5,2))"/>
    </xsl:when>
    <xsl:when test="contains(.,'-')"> <!-- making up for an erroneous coding of p94 -->
     <xsl:value-of select="concat(substring-before(.,'-'),'0000')"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="."/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:attribute>
  <xsl:if test="contains(.,'-')"> <!-- making up for an erroneous coding of p94 -->
   <xsl:attribute name="notAfter">
    <xsl:value-of select="concat(substring-after(.,'-'),'0000')"/>
   </xsl:attribute>
  </xsl:if>
 </xsl:template>
 
 <xsl:template match="opt/@senest|brev/@senest">
  <xsl:attribute name="notAfter">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="opt/@kil">
  <xsl:if test=".!='SK'">
   <xsl:attribute name="resp">
    <xsl:value-of select="concat('#',.)"/>
   </xsl:attribute>
  </xsl:if>
 </xsl:template>
 
 <!-- 3.6.1 -->
 <xsl:template match="hs">
  <div type="mainColumn">
   <xsl:apply-templates select="@klum"/>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="hs/@klum">
  <xsl:attribute name="rend">
   <xsl:choose>
    <xsl:when test=".='bred'">wide</xsl:when>
    <xsl:when test=".='fuld'">full</xsl:when>
    <xsl:when test=".='tvaers'">transverse</xsl:when>
   </xsl:choose>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="ms">
  <div type="marginalColumn">
   <xsl:apply-templates/>
  </div>
 </xsl:template>

 <!-- Letters and dedications, specs. 3.7 -->
 <xsl:template match="bd" mode="profileDesc"> <!-- to appear in the teiHeader -->
  <profileDesc>
   <xsl:apply-templates select="..//brev" mode="profileDesc"/>
  </profileDesc>
 </xsl:template>
 
 <xsl:template match="korrespondance" mode="profileDesc">
  <xsl:param name="notFirst"/>
  <correspContext>
   <xsl:choose>
    <xsl:when test="$notFirst">
     <xsl:attribute name="sameAs">#correspContext<xsl:number count="korrespondance"/></xsl:attribute>
     <p/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:attribute name="xml:id">correspContext<xsl:number count="korrespondance"/></xsl:attribute>
     <p><xsl:apply-templates select="@med"/></p>
    </xsl:otherwise>
   </xsl:choose>
  </correspContext>
 </xsl:template>
 
 <xsl:template match="brev" mode="profileDesc">
  <correspDesc>
   <xsl:attribute name="xml:id">correspDesc<xsl:apply-templates select="@nr"/></xsl:attribute>
   <correspAction type="sent">
    <xsl:apply-templates select="@fra"/>
    <xsl:apply-templates select="@fri"/>
    <date>
     <xsl:apply-templates select="@dat|@senest|@datkil"/>
    </date>
   </correspAction>
   <xsl:if test="normalize-space(@til)">
    <correspAction type="received">
     <xsl:apply-templates select="@til"/>
    </correspAction>
   </xsl:if>
   <xsl:apply-templates select="parent::korrespondance" mode="profileDesc">
    <xsl:with-param name="notFirst" select="preceding-sibling::brev"/>
   </xsl:apply-templates>
  </correspDesc>
 </xsl:template>
 
 <xsl:template match="brev/@nr">
  <xsl:choose>
   <xsl:when test=".='-'">
    <xsl:value-of select="concat(../preceding-sibling::brev/@nr,'a')"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="."/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template match="brev/@fri">
  <note><xsl:value-of select="."/></note>
 </xsl:template>
 
 <xsl:template match="korrespondance">
  <div type="correspondance">
   <xsl:attribute name="corresp">#correspContext<xsl:number/></xsl:attribute>
   <xsl:apply-templates select="@tving|@klum"/>
   <xsl:apply-templates/>
  </div>
 </xsl:template>

 <xsl:template match="@med">
  <name>
   <xsl:value-of select="."/>
  </name>
 </xsl:template>

 <xsl:template match="brev">
  <div type="letter" n="{@nr}">
   <xsl:attribute name="xml:id">n<xsl:apply-templates select="@nr"/></xsl:attribute>
   <xsl:attribute name="corresp">#correspDesc<xsl:apply-templates select="@nr"/></xsl:attribute>
   <xsl:apply-templates select="@txt"/>
   <xsl:choose>
    <xsl:when test="count(txt)&gt;1 or efterskrift[following-sibling::txt] or datering/blok">
     <xsl:apply-templates mode="wrap"/>
    </xsl:when>
    <xsl:when test="not(txt)">
     <opener>
      <xsl:apply-templates select="node()[following-sibling::hilsen]"/>
     </opener>
     <div type="mainText"/>
     <closer>
      <xsl:apply-templates select="node()[not(following-sibling::hilsen) and not(self::efterskrift or preceding-sibling::efterskrift or self::endtit or preceding-sibling::endtit or self::udskrift or preceding-sibling::udskrift)]"/>
     </closer>
     <xsl:apply-templates select="node()[not(following-sibling::hilsen) and (self::efterskrift or preceding-sibling::efterskrift or self::endtit or preceding-sibling::endtit or self::udskrift or preceding-sibling::udskrift)]"/>
    </xsl:when>
    <xsl:otherwise>
     <opener>
      <xsl:apply-templates select="node()[following-sibling::txt]"/>
     </opener>
     <xsl:apply-templates select="txt"/> <!-- of which is one and only one -->
     <closer>
      <xsl:apply-templates select="node()[preceding-sibling::txt and not(self::efterskrift or preceding-sibling::efterskrift or self::endtit or preceding-sibling::endtit or self::udskrift or preceding-sibling::udskrift)]"/>
     </closer>
     <xsl:apply-templates select="node()[preceding-sibling::txt and (self::efterskrift or preceding-sibling::efterskrift or self::endtit or preceding-sibling::endtit or self::udskrift or preceding-sibling::udskrift)]"/>
    </xsl:otherwise>
   </xsl:choose>
  </div>
 </xsl:template>
 
 <xsl:template match="@datkil">
  <xsl:attribute name="source">
   <xsl:choose>
    <xsl:when test=".='udateret'">supplied</xsl:when> 
    <xsl:when test=".='udateret-blank'">undated</xsl:when>
    <xsl:when test=".='uaar'">suppliedYear</xsl:when>
    <xsl:when test=".='stemplet'">stamp</xsl:when>
   </xsl:choose>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="@fra">
  <name>
   <xsl:apply-templates select="../@frakil"/>
   <xsl:value-of select="."/>
  </name> 
 </xsl:template>
 
 <xsl:template match="@til">
  <name>
   <xsl:apply-templates select="../@tilkil"/>
   <xsl:value-of select="."/>
  </name> 
 </xsl:template>
 
 <xsl:template match="@frakil|@tilkil">
  <xsl:attribute name="source">supplied</xsl:attribute>
 </xsl:template>
 
 <xsl:template match="brev/@txt">
  <head type="letterHeader" n="{.}"/>
 </xsl:template>
 
 <xsl:template match="datering">
  <dateline>
   <xsl:apply-templates select="lin/@ryk"/>
   <xsl:apply-templates/>
  </dateline>
 </xsl:template>
 
 <xsl:template match="datering[blok]">
  <div type="dateline">
   <xsl:apply-templates select="lin/@ryk"/>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="datering[not(blok)]/lin">
  <xsl:apply-templates/>
 </xsl:template>
 
 <xsl:template match="datering/lin[@dek='blank']" priority="2">
  <lb/>
 </xsl:template>
 
 <xsl:template match="tiltale">
  <salute>
   <xsl:apply-templates select="@ryk"/>
   <xsl:apply-templates/>
  </salute>
 </xsl:template>
 
 <xsl:template match="txt">
  <div type="mainText">
   <xsl:apply-templates select="@ryk"/>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="hilsen">
  <signed>
   <xsl:apply-templates select="@ryk"/>
   <xsl:apply-templates/>
  </signed>
 </xsl:template>
 
 <xsl:template match="efterskrift">
  <postscript>
   <xsl:apply-templates select="@ryk"/>
   <xsl:apply-templates/>
  </postscript>
 </xsl:template>
 
 <xsl:template match="endtit">
  <trailer type="addrInLetter">
   <xsl:apply-templates select="@ryk"/>
   <xsl:apply-templates/>
  </trailer>
 </xsl:template>
 
 <xsl:template match="udskrift">
  <trailer type="addrOnEnvelope">
   <xsl:apply-templates/>
  </trailer>
 </xsl:template>
 
 <xsl:template match="tiltale/@ryk | txt/@ryk | hilsen/@ryk | efterskrift/@ryk | endtit/@ryk">
  <xsl:attribute name="rendition">
   <xsl:value-of select="concat('#',.)"/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="datering[blok]/lin |  tiltale/lin | hilsen/lin | efterskrift/lin | endtit/lin | udskrift/lin">
  <l>
   <xsl:apply-templates select="@*"/>
   <xsl:if test="not(tab)">
    <xsl:apply-templates/>
   </xsl:if>
   <!-- otherwise coding error (B70) -->
  </l>
 </xsl:template>
 
 <xsl:template match="txt" mode="wrap">
  <xsl:apply-templates select="."/> <!-- don't wrap, <div> already -->
 </xsl:template>
 
 <xsl:template match="datering | tiltale | hilsen | efterskrift | endtit | udskrift" mode="wrap">
  <div>
   <xsl:if test="name()='efterskrift' or name()='endtit' or name()='udskrift'">
    <div/> <!-- must come after a div -->
   </xsl:if>
   <xsl:apply-templates select="."/>
  </div>
 </xsl:template>

 <xsl:template match="ded">
  <div type="dedication" n="{@nr}">
   <xsl:attribute name="xml:id">n<xsl:value-of select="@nr"/></xsl:attribute>
   <head>
    <xsl:apply-templates select="@til|@prov"/>
   </head>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="@prov">
  <bibl>
   <msIdentifier>
    <institution key="{.}"/>
   </msIdentifier>
  </bibl>
 </xsl:template>
 
 <xsl:template match="ded/@til">
   <name key="{.}"/>
 </xsl:template>
 
 <xsl:template match="skr">
  <div type="work">
   <xsl:apply-templates select="@tving"/>
   <xsl:apply-templates select="@txt"/>
   <xsl:apply-templates select="@titel"/>
   <xsl:if test="@udk!=''"> <!-- lex ded 117 -->
    <dateline>
     <date>
      <xsl:apply-templates select="@udk"/>
     </date>
    </dateline>
   </xsl:if>
   <xsl:apply-templates/>
  </div>
 </xsl:template>
 
 <xsl:template match="skr/@titel">
  <head type="workTitle" n="{.}"/>
 </xsl:template>
 
 <xsl:template match="skr/@txt">
  <head type="workHeader" n="{.}"/>
 </xsl:template>
 
 <!-- Commentaries (explanatory notes), specs. 3.8 -->
 <xsl:template match="k">
  <note type="commentary">
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/>
  </note>
 </xsl:template>
 
 <xsl:template match="k/@nr|k/@klum|refkx/@nr"/> <!-- obsolete -->

 <xsl:template match="@x">
  <xsl:if test=".!='1'">
   <xsl:attribute name="subtype"><xsl:value-of select="."/></xsl:attribute>
  </xsl:if>
 </xsl:template>

 <!-- 3.8.1 -->
 <xsl:template match="lemma">
  <label><xsl:apply-templates/></label>
 </xsl:template>
 
 <!-- 3.8.2 -->
 <xsl:template match="klin">
  <p><xsl:apply-templates/></p>
 </xsl:template>

 <!-- 3.8.3 -->
 <xsl:template match="refk|refkx">
  <ptr type="commentary">
   <xsl:apply-templates select="@*"/>
   <xsl:apply-templates/> <!-- should not be -->
  </ptr>
 </xsl:template>

 <xsl:template match="dok//refkx"/> <!-- superflous/misplaced -->

 <xsl:template match="refkx/@id">
  <xsl:attribute name="target">
   <xsl:text>../</xsl:text>
   <xsl:choose>
    <xsl:when test="../@tit"><xsl:value-of select="../@tit"/></xsl:when>
    <xsl:otherwise><xsl:value-of select="//korttit"/></xsl:otherwise>
   </xsl:choose>
   <xsl:text>/</xsl:text>
   <xsl:if test="../@x='e'">
    <xsl:text>e</xsl:text>
   </xsl:if>
   <xsl:text>kom.xml#</xsl:text>
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="refkx/@tit"/> <!-- used in cxion w @id -->
 
 <!-- 3.8.4 -->
 <xsl:template match="refx">

  <xsl:variable name="dir">
   <xsl:choose>
    <xsl:when test="@type='kort'">kort</xsl:when>
    <xsl:when test="@type='dok'">dok</xsl:when>
    <xsl:otherwise> <!-- short titel -->
     <xsl:choose>
      <xsl:when test="@tit"><xsl:value-of select="@tit"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="//kolofon/korttit"/></xsl:otherwise>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose> 
  </xsl:variable>

  <xsl:variable name="fileName">
   <xsl:choose>
    <xsl:when test="@type='kom'">kom</xsl:when>
    <xsl:when test="@type='ekom'">ekom</xsl:when>
    <xsl:when test="@type='int'">int</xsl:when>
    <xsl:when test="@type='txr'">txr</xsl:when>
    <xsl:when
     test="@type='ill' and (starts-with(@id,'k') or starts-with(@id,'K'))
     and ancestor::kommentar">kom</xsl:when>
    <xsl:when
     test="@type='ill' and (starts-with(@id,'k') or starts-with(@id,'K'))
     and ancestor::txr">txr</xsl:when>
    <xsl:when test="@type='ill' and (starts-with(@id,'k') or starts-with(@id,'K')) and ancestor::kommentar">kom</xsl:when>
    <xsl:when test="@type='kort'"><xsl:value-of select="@nr"/></xsl:when>
    <xsl:when test="@type='pdf'">dok</xsl:when>
    <xsl:otherwise>txt</xsl:otherwise>
   </xsl:choose>
  </xsl:variable>

  <xsl:variable name="fileId">
   <xsl:choose>
    <xsl:when test="@type='int'"><xsl:value-of select="concat('_',@id)"/></xsl:when>
    <xsl:when test="@type='kort'"><xsl:value-of select="concat('_',@id)"/></xsl:when>
    <xsl:when test="@type='pdf'"><xsl:value-of select="concat('_',@id)"/></xsl:when>
   </xsl:choose>
  </xsl:variable>

  <xsl:variable name="fileExt">
   <xsl:choose>
    <xsl:when test="@type='kort'">.htm</xsl:when>
    <xsl:when test="@type='pdf'">.pdf</xsl:when>
    <xsl:otherwise>.xml</xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="frag">
   <xsl:choose>
    <xsl:when test="(@type='jp' or @type='ts' or @type='uts') and @side">
     <xsl:value-of select="concat('#ss',@side)"/>
    </xsl:when>
    <xsl:when test="@type='kom' or @type='ekom'">
     <xsl:value-of select="concat('#',@id)"/>
    </xsl:when>
    <xsl:when test="(@type='int' or @type='txr') and @side">
     <xsl:value-of select="concat('#ss',@side)"/>
    </xsl:when>
    <xsl:when test="@type='ill'">
     <xsl:value-of select="concat('#ill_',translate(@id,'K','k'))"/>
    </xsl:when>
    <xsl:when test="@type='kort' or @type='pdf'"/>
    <xsl:otherwise> <!-- nr -->
     <xsl:if test="@nr">
      <xsl:value-of select="concat('#n',translate(substring-before(concat(@nr, '.'), '.'),':','-'))"/>
     </xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>

  <ref>
   <xsl:if test="not(@type='e' or (@pap or @ba or @sv2) and not(@tit or @nr or @side))">
    <xsl:attribute name="target">
     <xsl:text>../</xsl:text>
     <xsl:value-of select="$dir"/>
     <xsl:text>/</xsl:text>
     <xsl:value-of select="$fileName"/>
     <xsl:value-of select="$fileId"/>
     <xsl:value-of select="$fileExt"/>
     <xsl:value-of select="$frag"/>
    </xsl:attribute>
   </xsl:if>
   <!-- otherwise not represented in SKS -->
   <xsl:apply-templates select="@type"/>
   <xsl:apply-templates select="@nr"/>
   <xsl:apply-templates select="@side"/>
   <xsl:apply-templates select="@pap|@ba|@sv2|@blart"/>
   <xsl:choose> <!-- supplied SKS reference -->
    <xsl:when test="@type='e' and @tit">
     <xsl:attribute name="rend">
      <xsl:value-of select="@tit"/>
      <xsl:value-of select="concat(',',@nr)"/>
     </xsl:attribute>
    </xsl:when>
    <xsl:when test="@pap and (@type='jp' or @type='uts') and @tit and @nr">
     <xsl:attribute name="rend">
      <xsl:choose>
       <xsl:when test="starts-with(@tit, 'p') or starts-with(@tit, 'P')">
        <xsl:text>Papir </xsl:text>
        <xsl:value-of select="@nr"/>
       </xsl:when>
       <xsl:when test="@type='uts'">
        <xsl:value-of select="@tit"/>
       </xsl:when>
       <xsl:otherwise>
        <xsl:value-of select="@tit"/>
        <xsl:text>:</xsl:text>
        <xsl:value-of select="@nr"/>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:attribute>
    </xsl:when>
    <xsl:when test="@ba and @type='bd' and @nr">
     <xsl:attribute name="rend">
      <xsl:choose>
      <xsl:when test="starts-with(@tit, 'b')">
       <xsl:text>Brev </xsl:text>
      </xsl:when>
      <xsl:otherwise>
       <xsl:value-of select="@tit"/>
      </xsl:otherwise>
     </xsl:choose>
     <xsl:value-of select="@nr"/>
     </xsl:attribute>
    </xsl:when>
    <xsl:when test="@sv2 and (@type='ts' or @type='uts') and @tit">
     <xsl:attribute name="rend">
      <xsl:value-of select="@tit"/>
     <xsl:if test="@side"><xsl:value-of select="concat(', ',@side)"/></xsl:if>
     </xsl:attribute>
    </xsl:when>
    <xsl:when test="@ba and @type='dok' and @nr">
     <xsl:attribute name="rend">
      <xsl:text>Dok </xsl:text><xsl:value-of select="@nr"/>
     </xsl:attribute>
    </xsl:when>
   </xsl:choose>
   <xsl:apply-templates/>
  </ref>
 </xsl:template>
 
 <xsl:template match="refx/@nr">
  <xsl:attribute name="n">
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="@pap|@ba|@sv2|@blart">
  <xsl:attribute name="n">
   <xsl:value-of select="name()"/>
   <xsl:text>:</xsl:text>
   <xsl:value-of select="."/>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="@side">
  <xsl:attribute name="n">
   <xsl:value-of select="."/>
   <xsl:if test="../@linie">
    <xsl:value-of select=" concat(',',../@linie)"/>
   </xsl:if>
  </xsl:attribute>
 </xsl:template>
 
 <xsl:template match="@linie"/> <!-- only used in connexion with @side -->
 
 <xsl:template match="refx/@type">
  <xsl:attribute name="type">
   <xsl:choose>
    <xsl:when test=".='ts'">publishedWritings</xsl:when>
    <xsl:when test=".='uts'">unpublishedWritings</xsl:when>
    <xsl:when test=".='jp'">journalsAndPapers</xsl:when>
    <xsl:when test=".='bd'">lettersAndDedications</xsl:when>
    <xsl:when test=".='e'">preparatoryManuscript</xsl:when>
    <xsl:when test=".='dok'">documents</xsl:when>
    <xsl:when test=".='kom'">commentary</xsl:when>
    <xsl:when test=".='ekom'">eCommentary</xsl:when>
    <xsl:when test=".='txr'">textCriticalAccount</xsl:when>
    <xsl:when test=".='int'">introduction</xsl:when>
    <xsl:when test=".='ill'">figure</xsl:when>
    <xsl:when test=".='kort'">map</xsl:when>
    <xsl:when test=".='pdf'">pdf</xsl:when>
    <xsl:otherwise>kn1:<xsl:value-of select="."/></xsl:otherwise>
   </xsl:choose>
  </xsl:attribute>
 </xsl:template>
 
 <!-- Document category, specs. 3.9  -->
 <xsl:template match="ts|uts|jp|bd|e|dok">
  <text>
   <xsl:attribute name="type">
    <xsl:choose>
     <xsl:when test="name()='ts'
      or //korttit='SFV' or //korttit='OiA'">print</xsl:when>
      <!-- @KN1:bagkant="fast" is not used -->
     <xsl:otherwise>ms</xsl:otherwise>
    </xsl:choose>
   </xsl:attribute>
   <xsl:call-template name="subtypeAttr"/>
   <body>
    <xsl:apply-templates/>
   </body>
  </text>
 </xsl:template>

 <xsl:template name="subtypeAttr">
  <xsl:param name="kat" select="name()"/>
  <xsl:attribute name="subtype">
   <xsl:choose>
    <xsl:when test="$kat='ts'">publishedWritings</xsl:when>
    <xsl:when test="$kat='uts'">unpublishedWritings</xsl:when>
    <xsl:when test="$kat='jp'">journalsAndPapers</xsl:when>
    <xsl:when test="$kat='bd'">lettersAndDedications</xsl:when>
    <xsl:when test="$kat='e'">preparatoryManuscript</xsl:when> <!-- not used -->
    <xsl:when test="$kat='dok'">documents</xsl:when>
    <xsl:otherwise>kn1:<xsl:value-of select="$kat"/></xsl:otherwise>
   </xsl:choose>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="kommentar">
  <text type="commentary" subtype="{@kat}">
   <body>
    <div>
     <xsl:apply-templates/>
    </div>
   </body>
  </text>
 </xsl:template>
 
 <!-- Colophon, specs 3.10 -->
 <xsl:template match="kolofon" xml:space="preserve">
  <teiHeader>
   <fileDesc>
    <titleStmt>
     <xsl:apply-templates select="i"/>
     <xsl:apply-templates select="titel"/>
     <xsl:apply-templates select="utitel"/>
     <xsl:apply-templates select="korttit"/>
     <xsl:apply-templates select="forf|red|udg.af|red.af|etabl.af|ered"/>
    </titleStmt>
    <publicationStmt>
     <xsl:apply-templates select="copyright"/>
     <availability status="restricted"><p>copyright</p></availability>
    </publicationStmt>
    <seriesStmt>
     <title xml:id="SKS">Søren Kierkegaards Skrifter</title>
     <xsl:apply-templates select="bind"/>
     <xsl:apply-templates select="fil"/>
    </seriesStmt>
    <sourceDesc>
      <xsl:if test="kilder">
        <listWit>
         <!-- distinguish here between 'Manuskript(er)' [mss] and 'Udgave(r)' [editions] (used in loose papers and letters) -->
         <xsl:apply-templates select="kilder[1]"/>
        </listWit>
      </xsl:if>
      <xsl:if test="not(kilder)">
       <bibl copyOf="#SKS"/>
      </xsl:if>
    </sourceDesc>
   </fileDesc>
   <xsl:apply-templates select="following-sibling::bd" mode="profileDesc"/>
   <encodingDesc>
    <!--
    <editorialDecl>
     <quotation marks="all">
      <p>All quotation marks are retained in the text and are represented by the characters » and «, resp.</p>
     </quotation>
     http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-quotation.html
    </editorialDecl>
    -->
    <xsl:element name="tagsDecl" xml:space="default">
     <xsl:variable name="root" select="//ts | //uts | //jp | //bd | //dok | //kommentar | //txr "/>
     <xsl:for-each select="document('rendition.xml')//tag">
      <!-- for all relevant tag names in document -->
      <xsl:apply-templates
       select="($root//*[name()=current()])[1]" 
       mode="rendition"/> <!-- select the first one -->
     </xsl:for-each>
     <xsl:for-each select="document('rendition.xml')//attr">
      <!-- for all name,value pairs -->
      <xsl:apply-templates
       select="($root//@*[name()=current()/name
                          and (.=current()/value
                          or not(current()/value))])[1]"
       mode="rendition"/>
       <!-- select one sample of each -->
     </xsl:for-each>
    </xsl:element>
   </encodingDesc>
   <revisionDesc>
    <xsl:apply-templates select="kodning"/>
   </revisionDesc>
  </teiHeader>
 </xsl:template>

 <!-- 3.10.1 -->
 <xsl:template match="forf" xml:space="preserve">
  <author>
   <xsl:call-template name="nameList"/>
  </author>
 </xsl:template>
 
 <!-- 3.10.2 -->
 <xsl:template match="titel">
  <title><xsl:apply-templates/></title>
 </xsl:template>
 
 <xsl:template match="titel/tn"/> <!-- text critical apparatus in title makes no sense (p339) -->
 
 <xsl:template match="titel/spa">
  <xsl:choose>
   <xsl:when test="//korttit='P339'">
    <hi rendition="#und"><xsl:apply-templates/></hi>
   </xsl:when>
   <xsl:when test="//korttit='P345'">
    <title><xsl:apply-templates/></title>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates/>
   </xsl:otherwise>
  </xsl:choose>
  
 </xsl:template>
 
 <xsl:template match="utitel">
  <title level="j"><xsl:apply-templates/></title> <!-- (journal) newspaper title and issue -->
 </xsl:template>
 
 <xsl:template match="i">
  <title level="s"><xsl:apply-templates/></title> <!-- (series) the book version SKS-B -->
 </xsl:template>
 
 <xsl:template match="bind">
  <biblScope unit="volume">
   <xsl:if test="//kommentar">
    <xsl:text>K</xsl:text>
   </xsl:if>
   <xsl:apply-templates/>
  </biblScope>
 </xsl:template>

 <!-- 3.10.3 -->
 <xsl:template match="korttit">
  <title type="short"><xsl:apply-templates/></title>
 </xsl:template>
 
 <!-- 3.10.4 -->
 <!-- 3.10.5 -->
 <xsl:template match="red" xml:space="preserve">
  <editor>
   <xsl:call-template name="nameList"/>
  </editor>
 </xsl:template>
 
 <xsl:template match="red.af" xml:space="preserve">
  <respStmt>
   <resp>redigeret af</resp>
   <xsl:call-template name="nameList"/>
  </respStmt>
 </xsl:template>
 
 <xsl:template match="udg.af" xml:space="preserve">
  <respStmt>
   <resp>udgivet af</resp>
   <xsl:call-template name="nameList"/>
  </respStmt>
 </xsl:template>
 
 <!-- 3.10.6 -->
 <xsl:template match="etabl.af" xml:space="preserve">
  <respStmt>
   <resp>etableret af</resp>
   <xsl:call-template name="nameList"/>
  </respStmt>
 </xsl:template>

 <!-- 3.10.7 -->
 <xsl:template match="kilder[starts-with(.,'Udgave') or starts-with(.,'Manus')]">
  <listWit>
   <head><xsl:apply-templates/></head>
   <xsl:apply-templates select="following-sibling::kilder[1][not(starts-with(.,'Udgave')) and not(starts-with(.,'Manus'))]"/>
  </listWit>
  <xsl:apply-templates select="following-sibling::kilder[starts-with(.,'Udgave') or starts-with(.,'Manus')]"/>
 </xsl:template>
 
 <xsl:template match="kilder[@kil='Ms' and count(parent::*/kilder[@kil='Ms'])&gt;1][1]">
  <listWit xml:id="Ms.">
   <witness>
    <xsl:apply-templates/>
   </witness>
   <xsl:for-each select="following-sibling::kilder[@kil='Ms']">
    <witness><xsl:apply-templates/></witness>
   </xsl:for-each>
  </listWit>
  <xsl:apply-templates select="following-sibling::kilder[1][not(starts-with(.,'Udgave')) and not(starts-with(.,'Manus')) and @kil!='Ms']"/>
 </xsl:template>
 
 <xsl:template match="kilder[starts-with(@kil,'EP')][1]">
  <listWit>
   <xsl:if test="not(@kil='EP' or following-sibling::kilder[@kil='EP'])">
    <xsl:attribute name="xml:id">EP</xsl:attribute>
   </xsl:if>
   <witness>
    <xsl:apply-templates select="@kil"/>
    <xsl:apply-templates/>
   </witness>
   <xsl:for-each select="following-sibling::kilder[starts-with(@kil,'EP')]">
    <witness>
     <xsl:attribute name="xml:id"><xsl:value-of select="@kil"/></xsl:attribute>
     <xsl:apply-templates/>
    </witness>
   </xsl:for-each>
  </listWit>
  <xsl:apply-templates select="following-sibling::kilder[not(starts-with(.,'Udgave')) and not(starts-with(.,'Manus')) and not(starts-with(@kil,'EP'))][1]"/>
 </xsl:template>
 
 <xsl:template match="kilder">
  <witness>
   <xsl:apply-templates select="@kil"/>
   <xsl:apply-templates/>
  </witness>
  <xsl:apply-templates select="following-sibling::kilder[1][not(starts-with(.,'Udgave')) and not(starts-with(.,'Manus'))]"/>
 </xsl:template>
 
 <xsl:template match="kilder/@kil">
  <xsl:attribute name="xml:id">
   <xsl:call-template name="witAttr"/>
  </xsl:attribute>
 </xsl:template>

 <xsl:template match="kilder/kur|kilder/spa">
  <title><xsl:apply-templates/></title>
 </xsl:template>

 <!-- 3.10.9 -->
 <xsl:template match="copyright">
  <authority><xsl:apply-templates/></authority>
 </xsl:template>
 
 <!-- 3.10.10 -->
 <xsl:template match="fil">
  <biblScope unit="file"><xsl:apply-templates/></biblScope>
 </xsl:template>
 
 <!-- 3.10.11 -->
 <xsl:template match="dato">
  <xsl:attribute name="when">
   <xsl:apply-templates/>
  </xsl:attribute>
 </xsl:template>
 
 <!-- 3.10.12 -->
 <xsl:template match="ered" xml:space="preserve">
  <respStmt>
   <resp>elektronisk redigeret af</resp>
   <xsl:call-template name="nameList"/>
  </respStmt>
 </xsl:template>
 
 <!-- 3.10.13 -->
 <xsl:template match="vers">
  <idno type="version"><xsl:apply-templates/></idno>
 </xsl:template>

 <xsl:template name="nameList">
  <xsl:param name="l" select="."/>
  <xsl:choose>
   <xsl:when test="contains($l,' og ')">
    <xsl:call-template name="nameList">
     <xsl:with-param name="l" select="substring-before($l,' og ')"/>
    </xsl:call-template>
    <name><xsl:value-of select="substring-after($l,' og ')"/></name>
   </xsl:when>
   <xsl:otherwise>
    <xsl:choose>
     <xsl:when test="contains($l,',')">
      <name><xsl:value-of select="substring-before($l,',')"/></name>
      <xsl:call-template name="nameList">
       <xsl:with-param name="l" select="normalize-space(substring-after($l,','))"/>
      </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
      <name><xsl:value-of select="$l"/></name>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- Document, specs 3.11 -->
 <xsl:template match="kn1">
  <TEI version="5">
   <xsl:apply-templates/>
  </TEI>
 </xsl:template>

 <xsl:template match="/">
  <xsl:apply-templates select="(//vulg|//stang|//rod)[1]" mode="schema"/>  
  <xsl:apply-templates/>
 </xsl:template>


 <xsl:template match="comment()">
  <xsl:copy><xsl:apply-templates select="node()"/></xsl:copy>
 </xsl:template>

 <xsl:template match="*"> <!--for elements unintentionally not handled above-->
  <xsl:element name="kn1:{local-name()}" namespace="http://sks.dk/kn1/"><xsl:apply-templates select="@*|node()"/></xsl:element>
 </xsl:template>
 
 <xsl:template match="@*"> <!--for attributes unintentionally not handled above-->
  <xsl:attribute name="kn1:{local-name()}" namespace="http://sks.dk/kn1/">
   <xsl:value-of select="concat('kn1:',.)"/>
  </xsl:attribute>
  <!--<xsl:text>!!!LOST attr!!!</xsl:text><xsl:value-of select="local-name()"/>=<xsl:value-of select="."/>-->
 </xsl:template>
 
 <xsl:template match="text()[contains(.,'ϕ')]">
  <xsl:value-of select="translate(.,'ϕ','φ')"/>
 </xsl:template>
 
</xsl:stylesheet>
