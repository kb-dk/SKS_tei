<?xml version="1.0"?>
<!DOCTYPE stylesheet [
 <!ENTITY cpunkt "&#183;">
 <!ENTITY blank "&#160;">
 <!ENTITY hjem '<img class="barbut" height="11" width="20" src="../vignet/home.gif"/>'>
 <!ENTITY hakbeg "&#x25b6;">
 <!ENTITY hakslut "&#x25c0;">
 <!ENTITY vfod "&#x230a;">
 <!ENTITY hfod "&#x230b;">
]>

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 version="1.0">

  <xsl:import href="../kn1/sksbasis.xsl"/>

 <xsl:template match="bd">
  <xsl:comment>

   Transformed from Kierkegaard Normalformat (1) XML by style sheet sksbd.xsl
   (c) by Karsten Kynde, Soren Kierkegaard Forskningscenteret, Copenhagen
   Version 1.8 KK 2012-12-13

  </xsl:comment>
  <div class="bd">
  <div class="kapw">
   <div id="Her-rulles" class="drop"><xsl:text/></div>
   <div id="sktp" class="drop"><xsl:text/></div>
   <div class="fix">
   <xsl:call-template name="vis"><xsl:with-param name="end" select="'top'"/></xsl:call-template>
   <xsl:variable name="bar">
     <a title="Home" href="../forside/indhold.asp" onclick="return blank('SKStop',this.href)">&hjem;</a>
     <b>
      &blank;
      <xsl:choose>
        <xsl:when test="starts-with(//kolofon/korttit,'B')"><xsl:text>Brev</xsl:text></xsl:when>
        <xsl:otherwise><xsl:value-of select="//kolofon/korttit"/></xsl:otherwise>
      </xsl:choose>
      &blank;
     </b>
     <input type="text" id="curnr" class="inptxt" value="(nr)" onchange="goshowtxt(this.value)" onfocus="this.value=''" size="3" title="Entry no."/>
     <input type="submit" value="" class="gotopage"/>
     &blank;
     <a class="korSKS" name="dum">
      <input type="text" class="inptxt" value="(side)" size="4" onchange="goshowpage('ss',this.value)" onfocus="this.value=''" title="SKS page" tabindex="2"/>
     </a>
     &blank;
   </xsl:variable>
   <div class="bar">
     <xsl:copy-of select="$bar"/>
     &blank;&blank;&blank;&blank;&blank;&blank;&blank;
     <xsl:apply-templates select="//kolofon/intro"/>
     <xsl:apply-templates select="@txr"/>
     <xsl:apply-templates select="@kom"/>
     <xsl:apply-templates select="@ekom"/>
     <xsl:call-template name="vejl">
      <xsl:with-param name="kat" select="'txt'"/>
     </xsl:call-template>
     &blank;&blank;&blank;
   </div>
   </div>
   <h1><xsl:value-of select="//kolofon/titel"/></h1>
   <div>
    <div class="plusnav" id="alp" onclick="showhideall('al')" title="Fold/unfold all">
     <xsl:text>+</xsl:text>
    </div>
    <a title="Show/hide all text"
     onclick="showhidealltxt('al')">
     <span id="altxp">
      &blank;Vis al tekst
      &gt;
     </span>
    </a>
   </div>
   <div id="al">
    <xsl:apply-templates/>
    <xsl:call-template name="tntemp"/>
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

 <xsl:template match="korrespondance|brev|skr|ded">
  <xsl:variable name="cur">
    <xsl:choose>
      <xsl:when test="@nr and @nr!='-'">k<xsl:value-of select="@nr"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <div class="navigat">
   <xsl:if test="brev|ded">
     <div class="plusnav" 
          id="{$cur}p"
          onclick="showhide('{$cur}','{$cur}p')"
          title="Fold/unfold this section">
      <xsl:text>+</xsl:text>
     </div>
   </xsl:if>
   <div class="navhead" title="Show/hide text of this section"
   onclick="showhidetxt('{$cur}')">
    <xsl:choose>
      <xsl:when test="name()='korrespondance'">
        <xsl:value-of select="@med"/>
      </xsl:when>
      <xsl:when test="name()='brev'">
        <b>Brev <xsl:value-of select="@nr"/></b>
        <xsl:text> &blank; </xsl:text>
        <xsl:value-of select="@txt"/>
      </xsl:when>
      <xsl:when test="name()='skr'">
        <xsl:value-of select="@txt"/>
      </xsl:when>
      <xsl:when test="name()='ded'">
        <b>Ded <xsl:value-of select="@nr"/></b>
        <xsl:text> &blank; </xsl:text>
        <xsl:value-of select="@til"/>
      </xsl:when>
    </xsl:choose>
    <xsl:call-template name="kapside">
      <xsl:with-param name="kil" select="'SKS'"/>
      <xsl:with-param name="sigel">
        <span class="kur">SKS</span>
        <xsl:text> </xsl:text>
        <xsl:value-of select="/kn1/kolofon/bind"/>
        <xsl:text>, </xsl:text>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="kapside">
      <!--xsl:with-param name="sigel"><span class="kur grad-2">B&amp;A</span>&#32;</xsl:with-param-->
      <xsl:with-param name="kil" select="'BA'"/>
      <xsl:with-param name="bubble">B&amp;A</xsl:with-param>
    </xsl:call-template>
    <xsl:if test="name()='brev' or name()='ded'">
      <span id="{$cur}txp">
        <xsl:text> &gt;</xsl:text>
      </span>
    </xsl:if>
   </div>
  </div>
  <div id="{$cur}" class="kapv">
   <xsl:choose>
    <xsl:when test="brev|ded">
     <div id="{$cur}tx"/><!--  class="kaptxt" -->
     <xsl:apply-templates select="brev|ded"/>
    </xsl:when>
    <xsl:otherwise>
     <div id="{$cur}tx" class="kaptxt">
      <xsl:choose>
        <xsl:when test="contains(@fri,'se Brev')">
          <a href="txt.xml#k{substring-after(@fri,'se Brev ')}" onclick="blank('txt',this.href);location.reload(true);return true">
            <xsl:text>Se Brev</xsl:text>
            <xsl:value-of select="substring-after(@fri,'se Brev')"/>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
     </div>
    </xsl:otherwise>
   </xsl:choose>
  </div>
 </xsl:template>

  <xsl:template name="name-form">
    <xsl:param name="name"/>
    <xsl:param name="kil"/>
    <xsl:if test="$kil">
      <xsl:text>[</xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="contains($name,',')">
        <xsl:value-of select="substring-after($name,',')"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="substring-before($name,',')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$name"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="$kil">
      <xsl:text>]</xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="datering|tiltale|txt|efterskrift|hilsen|endtit">
   <div class="box{@ryk}">
    <xsl:apply-templates/>
   </div>
   <div style="clear:both;height:0"></div>
  </xsl:template>

  <xsl:template match="udskrift">
   <div class="udskriftbox">
     <xsl:apply-templates/>
    <div style="clear:both;height:0"></div>
   </div>
  </xsl:template>

  <xsl:template match="altbeg[@spec='hak' or @spec='hakbag']">
    <span>
      <!--empty-->
    </span><!--no text node here--><a name="dum" class="tnx" onClick="that=this" href="javascript:tnx(that)" title="Secondary source">&hakbeg;</a><!--no text node here--><span class="tnote">
      <xsl:if test="@kil">
        <xsl:call-template name="sigel">
          <xsl:with-param name="s">
            <xsl:value-of select="@kil"/>
          </xsl:with-param>
          <xsl:with-param name="skil"><xsl:if test="@paa">komma</xsl:if></xsl:with-param>
        </xsl:call-template>
        <xsl:if test="@n">
          <xsl:choose>
            <xsl:when test="@kil='Bafskr'"/>
            <xsl:when test="@kil='Hafskr'"/>
            <xsl:when test="@kil='Bfort' or @kil='Lfort'">
              <span class="udg">
                <xsl:value-of select="@n"/>
              </span>
            </xsl:when>
            <xsl:otherwise> <!--EP-->
              <span class="udg">
                s. <xsl:value-of select="@n"/>
              </span>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </xsl:if>
      <xsl:if test="@paa">
        <xsl:call-template name="sigel">
          <xsl:with-param name="s"><xsl:value-of select="@paa"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="@msifB">
        <span class="udg">
          (ms. s. <xsl:value-of select="@msifB"/> if. B-fort.)
        </span>
      </xsl:if>
      <xsl:apply-templates select="udg[@spec='fri']" mode="in-tn"/>
    </span>
  </xsl:template>

  <xsl:template match="altslut[@spec='hak' or @spec='hakbag']">
    <span/><a name="dum" class="tnx">&hakslut;</a><span/>
  </xsl:template>

  <xsl:template match="barfod">
    <span class="grad-1">
      [<xsl:value-of select="@kom"/><xsl:apply-templates/>]
    </span>
  </xsl:template>

  <xsl:template name="vis">
    <xsl:param name="end"/>
    <div class="vis">
       <b>Vis sidetal mv:</b>
       Ms.<input id="korSK{$end}" type="checkbox" onclick="showhiderefx(0)"/>
       SKS<input id="korSKS{$end}" type="checkbox" onclick="showhiderefx(1)"/>
       B&amp;A<input id="korBA{$end}" type="checkbox" onclick="showhiderefx(8)"/>
     &blank;&cpunkt;&blank;
     <b>Henvisninger til:</b>
     Kommentarer<input id="k{$end}" type="checkbox" onclick="showhiderefx(3)"/>
     Tekstkritik<input id="tn{$end}" type="checkbox" onclick="showhiderefx(4)"/>
    </div>
  </xsl:template>

  <xsl:template match="kor[@kil='BA']">
    <a class="kor{@kil}" name="dum" title="B&amp;A"><xsl:value-of select="@id"/></a>
  </xsl:template>

<!-- fra sksjp.xsl -->

  <xsl:template match="not"> <!--type="sn"-->
    <div id="{@id}" class="note">
      <br/>
      <xsl:apply-templates select="lin"/>
    </div>
  </xsl:template>

  <xsl:template match="indv">
    <sup class="indv"><xsl:apply-templates/></sup>
  </xsl:template>

</xsl:stylesheet>
