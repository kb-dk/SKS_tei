<?xml version="1.0"?>
<!DOCTYPE stylesheet [
 <!ENTITY o- "&#xF8;">
 <!ENTITY hpil "&#x2192;">
 <!ENTITY blank "&#160;">
 <!ENTITY hjem '<img class="barbut" height="11" width="20" src="../vignet/home.gif"/>'>
]>

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 version="1.0">

 <xsl:import href="../kn1/sksbasis.xsl"/>

 <xsl:template match="kommentar">
  <xsl:comment>

   Transformed from Kierkegaard Normalformat (1) XML by style sheet skskom.xsl
   (c) by Karsten Kynde, Soren Kierkegaard Forskningscenteret, Copenhagen
   Version 1.6 KK 20110906

  </xsl:comment>
  <div class="{@kat}">
    <xsl:if test="not(@kat)"><xsl:attribute name="class">jp</xsl:attribute></xsl:if>
  <div class="kapw">
  <div id="Her-rulles" class="drop"><xsl:text/></div>
   <xsl:variable name="bar">
     <a title="Home" href="../forside/indhold.asp" onclick="return blank('SKStop',this.href)">&hjem;</a>
     <b>
      &blank;
      <xsl:choose>
        <xsl:when test="starts-with(//kolofon/korttit,'P') and @kat='jp'">Papir</xsl:when>
        <xsl:otherwise><xsl:value-of select="//kolofon/korttit"/></xsl:otherwise>
      </xsl:choose>
     </b>
     <input type="hidden" id="curnr" value="0"/>
   </xsl:variable>
   <div class="kbar">
     <xsl:copy-of select="$bar"/>
     &blank;&blank;&blank;&blank;&blank;&blank;&blank;
     <xsl:apply-templates select="@txt"/>
     <xsl:apply-templates select="@txr"/>
     <xsl:apply-templates select="//kolofon/intro"/>
     <xsl:apply-templates select="@kom"/>
     <xsl:apply-templates select="@ekom"/>
     <xsl:call-template name="vejl">
      <xsl:with-param name="kat" select="'kom'"/>
     </xsl:call-template>

     &blank;&blank;&blank;
   </div>
   <h1><xsl:value-of select="//kolofon/titel"/></h1>
   <h2 class="SKS-E-txt">
    Kommentarer<xsl:if test="//k[@x='e']">, <i>SKS-E</i></xsl:if>
   </h2>
   <div>
    <a title="Show/hide all text"
     onclick="showhidealltxt('al')">
     <span id="altxp">
      &blank;&blank;Vis al tekst
      &gt;
     </span>
    </a>
   </div>
   <div id="al">
    <xsl:apply-templates/> 
   </div>
   <br/>
   <xsl:call-template name="kolofon">
    <xsl:with-param name="vis" select="'yes'"/>
   </xsl:call-template>
   <br/>
   <xsl:copy-of select="$copyright"/>
  </div>
  </div>
 </xsl:template>

 <xsl:template match="k">
  <xsl:variable name="cur" select="concat('k',substring-after(@id,'-'))"/>
  <div class="navigat">
   <div class="navhead" title="Show/hide this note"
    onclick="showhidetxt('{$cur}')">
    <xsl:value-of select="lemma"/>
    <span id="{$cur}txp">
     <xsl:text>&gt;</xsl:text>
    </span>
   </div>
  </div>
  <div id="{$cur}" class="kapv">
     <div id="{$cur}tx" class="kaptxt">
      <a class="komid"
         onclick="return blank('txt',this.href,625)"
         href="txt.xml#r{substring-before(concat(substring-after(@id,'-'),'-e'),'-e')}">
        <xsl:if test="@x='e'">
          <xsl:attribute name="class">ekomid</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="/kn1/kolofon/bind"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="@side"/>
        <xsl:text>,</xsl:text>
        <span class="kur grad-1"><xsl:value-of select="@linie"/></span>
      </a>
      <xsl:apply-templates/>
     </div>
  </div>
 </xsl:template>

  <xsl:template match='lemma'>
    <span class="lemma"><xsl:apply-templates/>]</span>
  </xsl:template>

  <xsl:template match="klin">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="refk"> <!--Lokal ref.-->
    <a class="komid" 
       href="#k{substring-after(@id,'-')}txp"
       onclick="showtxt('k{substring-after(@id,'-')}tx')"
       title="See note">
      <xsl:text>&hpil; </xsl:text>
      <xsl:value-of select="@side"/>
      <xsl:text>,</xsl:text>
      <span class="kur grad-1"><xsl:value-of select="@linie"/></span>
    </a>
  </xsl:template>

  <xsl:template match="refk[ancestor::k/@x='e']"> <!--Lokal ref.-->
    <a class="ekomid"
       href="#k{substring-after(@id,'-')}txp"
       onclick="showtxt('k{substring-after(@id,'-')}tx')"
       title="See SKS-E-note">
      <xsl:text>&hpil; </xsl:text>
      <xsl:value-of select="@side"/>
      <xsl:text>,</xsl:text>
      <span class="kur grad-1"><xsl:value-of select="@linie"/></span>
    </a>
  </xsl:template>

  <xsl:template match="refkx"> <!--Xref. fra E til B eller B til B-->
    <xsl:variable name="tit">
      <xsl:choose>
        <xsl:when test="@tit"><xsl:value-of select="@tit"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="/kn1/kolofon/korttit/text()"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <a class="komid"
       href="../{$tit}/kom.xml#k{substring-after(@id,'-')}"
       title="See external note">
      <xsl:text>&hpil; </xsl:text>
      <xsl:if test="not(/kn1/kommentar/@kat='jp' and starts-with(@tit,'P'))"><i><xsl:value-of select="@tit"/></i></xsl:if>
      <xsl:text> </xsl:text>
      <xsl:value-of select="@side"/>
      <xsl:text>,</xsl:text>
      <span class="kur grad-1"><xsl:value-of select="@linie"/></span>
    </a>
  </xsl:template>

  <xsl:template match="refkx[@x='e']"> <!--Xref. fra B til E-->
    <a class="ekomid"
       href="ekom.xml#k{substring-after(@id,'-')}"
       title="See SKS-E-note">
      <xsl:text>&hpil; </xsl:text>
      <i>SKS-E</i>
      <xsl:text> </xsl:text>
      <xsl:value-of select="@side"/>
      <xsl:text>,</xsl:text>
      <span class="kur grad-1"><xsl:value-of select="@linie"/></span>
    </a>
  </xsl:template>

  <xsl:template match="refi"/>

</xsl:stylesheet>

