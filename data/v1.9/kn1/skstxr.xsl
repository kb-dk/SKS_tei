<?xml version="1.0"?>
<!DOCTYPE stylesheet [
 <!ENTITY o- "&#xF8;">
 <!ENTITY cpunkt "&#183;">
 <!ENTITY hpil "&#x2192;">
 <!ENTITY blank "&#160;">
 <!ENTITY hjem '<img class="barbut" height="11" width="20" src="../vignet/home.gif"/>'>
]>

<xsl:stylesheet
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 version="1.0">

 <xsl:import href="../kn1/sksbasis.xsl"/>

 <xsl:template match="kap0">
    <xsl:comment>

      Transformed from Kierkegaard Normalformat (1) XML by style sheet skstxr.xsl
      (c) by Karsten Kynde, Soren Kierkegaard Forskningscenteret, Copenhagen
      Version 1.6 KK 20130221

    </xsl:comment>
  <div class="{../@kat}">
  <div class="kapw">
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
     <xsl:apply-templates select="../@txt"/>
     <xsl:apply-templates select="//kolofon/intro"/>
     <xsl:apply-templates select="../@txr"/>
     <xsl:apply-templates select="../@kom"/>
   </div>
   <h1><xsl:value-of select="//kolofon/titel"/></h1>
   <h2 class="SKS-E-txt"><xsl:apply-templates select="//kap0/rub//text()"/></h2>
   <div id="al" class="kom">
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

  <xsl:template match="kap1">
    <A name="{@id}" id="{@id}">
      &blank;
    </A>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="kap0/rub">
    <!--Done initially-->
  </xsl:template>

  <xsl:template match="kap1/rub">
    <h2><i><xsl:apply-templates/></i></h2>
  </xsl:template>

  <xsl:template match="kap2/rub">
    <h3><i><xsl:apply-templates/></i></h3>
  </xsl:template>

  <xsl:template match="kap3/rub">
    <h4><i><xsl:apply-templates/></i></h4>
  </xsl:template>

  <xsl:template match="indhold">
    <P><xsl:apply-templates/></P>
  </xsl:template>

  <xsl:template match="irub">
    <a>
     <xsl:attribute name="href">#<xsl:value-of select="refs/@id"/></xsl:attribute>
     <xsl:apply-templates/>
    </a>
    <br/>
  </xsl:template>

  <xsl:template match="lin[not(@ryk)]">
    <p style="margin-top:1em">
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="not/lin">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="blok[@ryk='tab']">
    <TABLE>
      <xsl:apply-templates/>
    </TABLE>
  </xsl:template>

  <xsl:template match="blok[@ryk='tab']/lin">
    <TR>
      <xsl:apply-templates/>
    </TR>
  </xsl:template>

  <xsl:template match="blok[@ryk='lyrik']">
    <BLOCKQUOTE style="font-size:90%">
      <xsl:apply-templates/>
    </BLOCKQUOTE>
  </xsl:template>

  <xsl:template match="tab">
    <TD valign="top" style="padding-right:1em">
      <xsl:if test="@ryk[.='cen']">
        <xsl:attribute name="align">center</xsl:attribute>
      </xsl:if>
      <xsl:if test="@klumspan">
        <xsl:attribute name="colspan">
          <xsl:value-of select="@klumspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test="@linspan">
        <xsl:attribute name="rowspan">
          <xsl:value-of select="@linspan"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </TD>
  </xsl:template>

  <xsl:template match="mstx/lin">
    <P style="margin:0">
      <xsl:apply-templates/>
    </P>
  </xsl:template>

  <xsl:template match="cit">
    <BLOCKQUOTE>
      <xsl:apply-templates/>
    </BLOCKQUOTE>
  </xsl:template>

  <xsl:template match="lis">
    <TABLE>
      <xsl:apply-templates/>
    </TABLE>
  </xsl:template>

  <xsl:template match="l">
    <TR valign="top">
      <xsl:if test="not(lid)">
        <TD>&#x2022;</TD>
      </xsl:if>
      <xsl:apply-templates/>
    </TR>
  </xsl:template>

  <xsl:template match="lid">
    <TD><xsl:apply-templates/>. </TD>
  </xsl:template>

  <xsl:template match="ltx">
    <TD><xsl:apply-templates/></TD>
  </xsl:template>

  <xsl:template match="mslis">
    <TABLE style="margin-top: 1em ; margin-bottom: 1em">
      <xsl:apply-templates/>
    </TABLE>
  </xsl:template>

  <xsl:template match="msl">
    <TR valign="top">
      <xsl:apply-templates/>
    </TR>
  </xsl:template>

  <xsl:template match="msid"> <!--1. nivo-->
    <TD>
      <xsl:apply-templates/>. &blank;
    </TD>
  </xsl:template>

  <xsl:template match="mstx//msid"> <!--2. nivo-->
    <TD>
      <xsl:apply-templates/>. &blank;
    </TD>
  </xsl:template>

  <xsl:template match="mstx"> <!--1. nivo-->
    <TD>
      <xsl:apply-templates/>
      <BR/>
    </TD>
  </xsl:template>

  <xsl:template match="mstx//mstx"> <!--2. nivo-->
    <TD>
      <xsl:apply-templates/>
    </TD>
  </xsl:template>

  <xsl:template match='refs'/>

  <xsl:template match='ref'>
    <span class="hoj"><xsl:number level="any" from="kor|txr"/></span>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="not">
     <table class="txrnote">
      <tr valign="top">
       <td><span class="hoj"><xsl:number level="any" from="kor|txr"/></span>)</td>
       <td>
          <xsl:apply-templates/>
       </td>
      </tr>
     </table>
  </xsl:template>

  <!--xsl:template match="refkx">
    <span color="red">&lt;refkx&gt; should not be used, replace with &lt;refx&gt;</span>
  </xsl:template-->

  <xsl:template match="refi"/>

  <xsl:template match="meta">
    &#32;[<span style="font-style:italic;background-color:#008bbc;color:white"><xsl:apply-templates/></span>]&#32;
  </xsl:template>

  <xsl:template match="slet">
    <s><xsl:apply-templates/></s>
  </xsl:template>

  <xsl:template match="kor">
    <a name="ss{@id}" id="ss{@id}"/>
  </xsl:template>

  <xsl:template match="a">
    <xsl:copy>
      <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
      <xsl:attribute name="onclick"><xsl:value-of select="@onclick"/></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
