<?xml version="1.0"?>
<!DOCTYPE stylesheet [
 <!ENTITY o- "&#xF8;">
 <!ENTITY cpunkt "&#183;">
 <!ENTITY hark "&#125;" >
 <!ENTITY blank "&#160;">
 <!ENTITY hjem '<img class="barbut" height="11" width="20" src="../vignet/home.gif"/>'>
 <!ENTITY vark "&#123;" >
]>

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 version="1.0">

 <xsl:import href="../kn1/sksbasis.xsl"/>

 <xsl:template match="ts|uts">
  <xsl:comment>

   Transformed from Kierkegaard Normalformat (1) XML by style sheet sksts.xsl
   (c) by Karsten Kynde, Soren Kierkegaard Forskningscenteret, Copenhagen
   Version 1.7 KK 2012-03-27

  </xsl:comment>
  <div class="{name()}">
  <xsl:if test="@bagkant='fast'">
    <xsl:attribute name="style">text-align:justify</xsl:attribute>
  </xsl:if>
  <div class="kapw">
   <div id="Her-rulles" class="drop"><xsl:text/></div>
   <div id="sktp" class="drop"><xsl:text/></div>
   <div class="fix">
   <xsl:call-template name="vis"><xsl:with-param name="end" select="'top'"/></xsl:call-template>
   <xsl:variable name="bar">
     <a title="Home" href="../forside/indhold.asp" onclick="return blank('SKStop',this.href)">&hjem;</a>
     <b>&blank;<xsl:value-of select="//kolofon/korttit"/>&blank;</b>
     <input type="hidden" id="curnr" value="0"/>
   </xsl:variable>
   <div class="bar">
     <xsl:copy-of select="$bar"/>
     <a class="korSK" name="dum">
      <input type="text" class="inptxt" value="(side)" size="4" onchange="goshowpage('s',this.value)" onfocus="this.value=''" title="Base text page"/>
      <input type="submit" value="" class="gotopage"/> <!--blurs input element by return-->
     </a>
     &blank;
     <a class="korSKS" name="dum">
      <input type="text" class="inptxt" value="(side)" size="4" onchange="goshowpage('ss',this.value)" onfocus="this.value=''" title="SKS page"/>
     </a>
     &blank;&blank;&blank;&blank;&blank;&blank;&blank;
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
<!--
   <xsl:call-template name="vis"><xsl:with-param name="end" select="'bottom'"/></xsl:call-template>
-->
   <xsl:copy-of select="$copyright"/>
  </div>
  </div>
 </xsl:template>

  <xsl:template name="vis">
    <xsl:param name="end"/>
    <div class="vis">
       <b>Vis sidetal: </b>
       <xsl:choose>
       <xsl:when test="//ts or //uts[@bagkant='fast']">
        <xsl:text>A</xsl:text>
       </xsl:when>
       <xsl:otherwise>
        <xsl:text>Ms.</xsl:text>
       </xsl:otherwise>
       </xsl:choose>
       <input type="checkbox" onclick="showhiderefx(0)">
        <xsl:attribute name="id">korSK<xsl:value-of select="$end"/></xsl:attribute>
       </input>
       SKS<input type="checkbox" onclick="showhiderefx(1)">
        <xsl:attribute name="id">korSKS<xsl:value-of select="$end"/></xsl:attribute>
       </input>
       <xsl:if test="//kor[@kil='SV3']">
        SV3<input type="checkbox" onclick="showhiderefx(2)">
         <xsl:attribute name="id">korSV3<xsl:value-of select="$end"/></xsl:attribute>
        </input>
       </xsl:if>
       <xsl:if test="//kor[@kil='Pap']">
        Pap.<input id="korPap{$end}" type="checkbox" onclick="showhiderefx(6)"/>
       </xsl:if>
     &blank;&cpunkt;&blank;
     <b>Henvisninger til:</b>
     Kommentarer<input type="checkbox" onclick="showhiderefx(3)">
      <xsl:attribute name="id">k<xsl:value-of select="$end"/></xsl:attribute>
     </input>
     Tekstkritik<input type="checkbox" onclick="showhiderefx(4)">
      <xsl:attribute name="id">tn<xsl:value-of select="$end"/></xsl:attribute>
     </input>
    </div>
  </xsl:template>

 <xsl:template match="kap">
  <xsl:variable name="cur"
   select="concat('k',
                  count(ancestor-or-self::kap) +
                  count(ancestor-or-self::kap/preceding-sibling::kap/descendant-or-self::kap)
                 )"/>
  <div class="navigat">
   <xsl:if test="kap">
     <div class="plusnav" 
          id="{$cur}p"
          onclick="showhide('{$cur}','{$cur}p')"
          title="Fold/unfold this chapter">
      <xsl:text>+</xsl:text>
     </div>
   </xsl:if>
   <div class="navhead" title="Show/hide text of this chapter"
   onclick="showhidetxt('{$cur}')">
    <xsl:if test="@vklum">
     <span class="capi"><xsl:value-of select="@vklum"/></span>
     <xsl:text> - </xsl:text>
    </xsl:if>
    <xsl:for-each select="rub//lin">
     <xsl:text>&#32;</xsl:text>
     <xsl:for-each select=".//text()[not(ancestor::sub or ancestor::ill)]">
       <xsl:value-of select="."/>
     </xsl:for-each>
    </xsl:for-each>
    <xsl:if test="not(rub//lin)">
     <span class="SKS-E-txt kur"><xsl:value-of select="@klum"/></span>
     <xsl:if test="not(@klum)">
      <xsl:text>&#32;</xsl:text>
      <xsl:value-of select="concat(substring(.//lin[.//text()],1,20),substring-before(concat(substring(.//lin[.//text()],21),' '),' '))"/> ...
     </xsl:if>
    </xsl:if>

    <xsl:call-template name="kapside">
      <xsl:with-param name="kil" select="'#SK#supp'"/>
      <xsl:with-param name="korclass" select="'SK'"/>
      <xsl:with-param name="bubble" select="'Base text'"/>
    </xsl:call-template>

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
      <xsl:with-param name="kil" select="'SV3'"/>
    </xsl:call-template>

    <span id="{$cur}txp">
     <xsl:text>&gt;</xsl:text>
    </span>
   </div>
  </div>
  <div id="{$cur}" class="kapv">
   <xsl:if test="@sp='2'">
     <xsl:attribute name="class">kapv sp2</xsl:attribute>
   </xsl:if>
   <xsl:choose>
    <xsl:when test="kap">
     <div id="{$cur}tx" class="kaptxt">
      <xsl:apply-templates select="rub|blok|lin"/>
     </div>
     <xsl:apply-templates select="kap"/>
    </xsl:when>
    <xsl:otherwise>
     <div id="{$cur}tx" class="kaptxt">
      <xsl:apply-templates/>
     </div>
    </xsl:otherwise>
   </xsl:choose>
  </div>
 </xsl:template>

  <xsl:template match="rub">
   <div class="rub{@niv}"><xsl:apply-templates/></div>
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
        <xsl:for-each select="/kn1/*/not[@id=$refid]/*">
          <xsl:apply-templates select="."/>
        </xsl:for-each>
        <br/>
       </td>
      </tr>
     </table>
  </xsl:template>

  <xsl:template match="text()[preceding-sibling::node()[1][name()='ref' and @type='sk']]">
   <span style="text-indent:0"> 
    <xsl:value-of select="substring-after(.,' ')"/>
   </span>
  </xsl:template>

 <xsl:template match="not[@type='sk']"/>

  <xsl:template match="kor[@kil='SV3']">
    <a class="korSV3" name="dum" title="SV3 page">|<span class="kor"><xsl:value-of select="@id"/></span></a>
  </xsl:template>

</xsl:stylesheet>

