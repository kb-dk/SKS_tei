<?xml version="1.0"?>
<!DOCTYPE stylesheet [
 <!ENTITY o- "&#xF8;">
 <!ENTITY cpunkt "&#183;">
 <!ENTITY blank "&#160;">
 <!ENTITY hjem '<img class="barbut" height="11" width="20" src="../vignet/home.gif"/>'>
 <!ENTITY hakbeg "&#x25b6;">
 <!ENTITY hakslut "&#x25c0;">
]>

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 version="1.0">

 <xsl:import href="../kn1/sksbasis.xsl"/>

 <xsl:template match="dok">
  <xsl:comment>

   Transformed from Kierkegaard Normalformat (1) XML by style sheet sksdok.xsl
   (c) by Karsten Kynde, Soren Kierkegaard Forskningscenteret, Copenhagen
   Version 1.8 KK 2013-02-05

  </xsl:comment>
  <div class="{name()}">
  <div class="kapw">
   <div id="Her-rulles" class="drop"><xsl:text/></div>
   <div id="sktp" class="drop"><xsl:text/></div>
   <div class="fix">
   <xsl:call-template name="vis"><xsl:with-param name="end" select="'top'"/></xsl:call-template>
   <xsl:variable name="bar">
     <a title="Home" href="../forside/indhold.asp" onclick="return blank('SKStop',this.href)">&hjem;</a>
     <b>
      &blank; Dok &blank;
     </b>
     <input type="text" id="curnr" class="inptxt" value="(nr)" onchange="goshowtxt(this.value)" onfocus="this.value=''" size="3" title="Entry no."/>
     <input type="submit" value="" class="gotopage"/>
     &blank;
   </xsl:variable>
   <div class="bar">
     <xsl:copy-of select="$bar"/>
   </div>
   </div>
   <h1><xsl:value-of select="/kn1/kolofon/titel"/></h1>
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
   <div id="xspace"></div>
   <br/>
   <xsl:call-template name="kolofon">
    <xsl:with-param name="vis" select="'yes'"/>
   </xsl:call-template>
   <br/>
   <xsl:copy-of select="$copyright"/>
  </div>
  </div>
 </xsl:template>

  <xsl:template name="vis">
    <xsl:param name="end"/>
    <div class="vis">
       <b>Vis nr. i </b>
       B&amp;A<input id="korBA{$end}" type="checkbox" onclick="showhiderefx(8)"/>
    </div>
  </xsl:template>

  <xsl:template match="kor[@kil='BA']">
    <a class="kor{@kil}" name="dum" title="B&amp;A"><xsl:value-of select="@id"/></a>
  </xsl:template>

 <xsl:template match="opt">
  <xsl:variable name="cur" select="concat('k',@nr)"/>
  <div id="{$cur}" class="navigat">
   <div class="navhead" title="Show/hide text of this entry"
    onclick="showhidetxt('{$cur}')">
    <b>
      <xsl:value-of select="@tit"/>
      &blank;
      <xsl:value-of select="@nr"/>
    </b>
    <xsl:choose>
     <xsl:when test="string-length(@nr)=1">
      <xsl:text>&#x2002;&#x2002;</xsl:text>
     </xsl:when>
     <xsl:when test="string-length(@nr)=2">
      <xsl:text>&#x2002;</xsl:text>
     </xsl:when>
    </xsl:choose>
    <xsl:text> </xsl:text>
    <xsl:value-of select="substring(@dat,1,4)"/>
    <xsl:if test="@senest and substring(@dat,1,4)!=substring(@senest,1,4)">-<xsl:value-of select="substring(@senest,1,4)"/></xsl:if>
    <xsl:text> </xsl:text>
    <xsl:value-of select="hs[1]/lin[1]//text()"/>

     <xsl:call-template name="kapside">
      <xsl:with-param name="kil" select="'BA'"/>
      <xsl:with-param name="bubble">B&amp;A</xsl:with-param>
    </xsl:call-template>

    <xsl:text> </xsl:text>

    <span id="{$cur}txp">
     <xsl:text>&gt;</xsl:text>
    </span>
   </div>
  </div>
   <div id="{$cur}tx" class="kaptxt">
<!--
     <xsl:if test="@tving and @nr&gt;1">
       <hr class="fuldklum"/>
     </xsl:if>
-->
     <xsl:apply-templates select="@tving[.='nyBfort']"/>
     <xsl:for-each select="hs">
      <xsl:choose>
        <xsl:when test="@klum='fuld'">
          <div class="fuldklum">
            <xsl:call-template name="optdek"/>
            <xsl:apply-templates/>
          </div>
        </xsl:when>
        <xsl:when test="@klum='bred' and @ms='tom'">
          <div class="bredklum">
            <xsl:call-template name="optdek"/>
            <xsl:apply-templates/>
          </div>
        </xsl:when>
        <xsl:when test="@klum='tvaers'">
           <div class="fuldklum">
             <xsl:if test="position()=1">
               <xsl:call-template name="optdek"/>
               <xsl:apply-templates select="preceding-sibling::*[1][name()='ms']" mode="tvaers"/>
               <br/>
             </xsl:if>
             <xsl:apply-templates/>
             <br/>
             <xsl:apply-templates select="following-sibling::*[1][name()='ms']" mode="tvaers"/>
           </div>
        </xsl:when>
        <xsl:when test="not(following-sibling::*[1][name()='ms'])">
          <div class="hs">
            <xsl:call-template name="optdek"/>
            <xsl:apply-templates/>
          </div>
        </xsl:when>
        <xsl:otherwise>
         <table>
          <tr>
           <td valign="top">
            <div class="hs">
              <xsl:call-template name="optdek"/>
              <xsl:apply-templates/>
            </div>
           </td>
           <td valign="top">
            <xsl:apply-templates select="following-sibling::*[1][name()='ms']"/>
           </td>
          </tr>
         </table>
        </xsl:otherwise>
      </xsl:choose>
     </xsl:for-each>
     <xsl:call-template name="tntemp"/>
   </div>
 </xsl:template>

  <xsl:template name="optdek">
    <xsl:if test="position()=1 and ../@dek!='blank'">
      <p class="dek">
        <xsl:for-each select=".."><!--with-->
          <xsl:call-template name="dekora"/>
        </xsl:for-each>
        <br/><br/>
      </p>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>

