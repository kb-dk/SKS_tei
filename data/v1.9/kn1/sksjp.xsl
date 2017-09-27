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

 <xsl:template match="jp|uts">
  <xsl:comment>

   Transformed from Kierkegaard Normalformat (1) XML by style sheet sksjp.xsl
   (c) by Karsten Kynde, Soren Kierkegaard Forskningscenteret, Copenhagen
   Version 1.8 KK 2012-09-10

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
      &blank;
      <xsl:value-of select="(/kn1/jp/opt/@tit)[1]"/>
      <xsl:choose>
        <xsl:when test="(/kn1/jp/opt/@tit)[1]!='Papir'">:</xsl:when>
        <xsl:otherwise>&blank;</xsl:otherwise>
      </xsl:choose>
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
     <xsl:apply-templates select="@txr"/>
     <xsl:apply-templates select="@kom"/>
     <xsl:apply-templates select="@ekom"/>
     <xsl:call-template name="vejl">
      <xsl:with-param name="kat" select="'txt'"/>
     </xsl:call-template>
     &blank;&blank;&blank;
   </div>
   </div>
   <h1><xsl:value-of select="/kn1/kolofon/titel"/></h1>
   <xsl:if test="starts-with(/kn1/kolofon/korttit,'P')"> <!--Papir--> <!--OBS og hvis B-fort. findes, !='x' , ex Jordrystelsen-->
     <h4>
      <span class="kur">B-fort.</span>
      <xsl:text> </xsl:text>
      <xsl:value-of select="substring-before(concat(.//kor[@kil='Bfort'][1]/@id,'.'),'.')"/>
      <xsl:for-each select="opt[@tving='nyBfort']">
        <xsl:text>, </xsl:text>
        <xsl:value-of select=".//kor[@kil='Bfort'][1]/@id"/>
      </xsl:for-each>
      <!--xsl:apply-templates select="//kor[@kil='Bfort']/@id"/-->
     </h4>
   </xsl:if>
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
       <b>Vis sidetal mv:</b>
       Ms.<input id="korSK{$end}" type="checkbox" onclick="showhiderefx(0)"/>
       SKS<input id="korSKS{$end}" type="checkbox" onclick="showhiderefx(1)"/>
       Pap.<input id="korPap{$end}" type="checkbox" onclick="showhiderefx(6)"/>
     &blank;&cpunkt;&blank;
     <b>Henvisninger til:</b>
     <xsl:if test="//kom">
       Kommentarer<input id="k{$end}" type="checkbox" onclick="showhiderefx(3)"/>
     </xsl:if>
     Tekstkritik<input id="tn{$end}" type="checkbox" onclick="showhiderefx(4)"/>
    </div>
  </xsl:template>

 <xsl:template match="opt">
  <xsl:variable name="cur" select="concat('k',@nr)"/>
  <div id="{$cur}" class="navigat">
   <div class="navhead" title="Show/hide text of this entry"
    onclick="showhidetxt('{$cur}')">
    <b>
      <xsl:value-of select="@tit"/>
      <xsl:choose>
        <xsl:when test="@tit!='Papir'">:</xsl:when>
        <xsl:otherwise>&blank;</xsl:otherwise>
      </xsl:choose>
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
    <xsl:variable name="hdg0"><xsl:apply-templates select="hs[1]/*[1]//text()[not(ancestor::sub or ancestor::ill)]"/></xsl:variable>
    <xsl:variable name="hdg" select="normalize-space($hdg0)"/>
    <xsl:value-of select="concat(substring($hdg,1,20),substring-before(concat(substring($hdg,21),' '),' '))"/>
    <xsl:if test="substring-after(substring($hdg,21),' ')"><xsl:text> ...</xsl:text></xsl:if>

    <xsl:call-template name="kapside">
      <xsl:with-param name="kil" select="'#SK#supp'"/>
      <xsl:with-param name="korclass" select="'SK'"/>
      <xsl:with-param name="bubble" select="'Base text page'"/>
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

    <xsl:text> </xsl:text>
    <a name="dum" class="korPap" title="Pap entry">
     <xsl:value-of select=".//kor[@kil='Pap']/@id"/>
    </a>

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

  <xsl:template match="@tving[.='nyBfort']">
    <span class="nyBfort" onmouseover="dropkor(this,'B-fort. {..//kor[@kil='Bfort']/@id}')"
       onmouseout="dropkor(this)"
       title="H.P. Barfod's catalogue">
      &#x25b7;
    </span>
  </xsl:template>

  <xsl:template match="ms">
    <xsl:apply-templates select="not[@type='mn']|not[@type='mu']"/><!--first level notes-->
  </xsl:template>

  <xsl:template match="ms" mode="tvaers">
    <xsl:apply-templates select="not[@type='mn']|not[@type='mu']" mode="tvaers"/><!--first level notes-->
  </xsl:template>
  
  <xsl:template match="not"> <!--type="sn"-->
    <div id="{@id}" class="note">
      <br/>
      <xsl:apply-templates select="lin"/>
    </div>
  </xsl:template>

  <xsl:template match="ms/not">
    <div id="{@id}" class="margen">
      <xsl:apply-templates select="lin|blok"/><!--dont select indv which is done as part of lin-->
      <xsl:for-each select="*//ref"><!--second level notes-->
        <xsl:variable name="mmid"><xsl:value-of select="@id"/></xsl:variable>
        <xsl:apply-templates select="//ms/not[@id=$mmid]"/>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="ms/not[@type='mm']">
    <div id="{@id}" class="mmargen">
      <xsl:apply-templates select="lin|blok"/>
      <xsl:for-each select="*/ref"><!--third... level notes-->
        <xsl:variable name="mmid"><xsl:value-of select="@id"/></xsl:variable>
        <xsl:apply-templates select="//ms/not[@id=$mmid]"/>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="ms/not" mode="tvaers">
    <div id="{@id}" class="tvmargen">
      <xsl:apply-templates select="lin|blok"/>
      <xsl:for-each select="*//ref"><!--second level notes-->
        <xsl:variable name="mmid"><xsl:value-of select="@id"/></xsl:variable>
        <xsl:apply-templates select="//ms/not[@id=$mmid]" mode="tvaers"/>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="ms/not[@type='mm']" mode="tvaers">
    <div id="{@id}" class="tvmmargen">
      <xsl:apply-templates select="lin|blok"/>
      <xsl:for-each select="*/ref"><!--third... level notes-->
        <xsl:variable name="mmid"><xsl:value-of select="@id"/></xsl:variable>
        <xsl:apply-templates select="//ms/not[@id=$mmid]" mode="tvaers"/>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="not[@type='mu']/indv|not[@type='su']/indv">
    <sup class="indv kur" title="Not referenced in main column by SK"><xsl:apply-templates/></sup>
  </xsl:template>

  <xsl:template match="indv">
    <sup class="indv"><xsl:apply-templates/></sup>
  </xsl:template>

  <xsl:template match="ref"> <!--type="sn" or-->
    <a id="R{@id}" href="#{@id}">
        <xsl:if test="not(indv)"> <!--type="su"-->
          <sup class="indv">
            <xsl:attribute name="onmouseover">this.innerHTML=' [ <xsl:value-of select="substring-after(@id,'.')"/> ] '</xsl:attribute>
            <xsl:attribute name="onmouseout">this.innerHTML=' [ ] '</xsl:attribute>
          [ ]
          </sup>
        </xsl:if>
      <xsl:apply-templates/>
    </a>
  </xsl:template>

  <xsl:template match="ref[@type='mn']|ref[@type='mu']|ref[@type='mm']">
    <xsl:variable name="refid"><xsl:value-of select="@id"/></xsl:variable>
      <a id="R{@id}" name="R{@id}" href="#{@id}" class="ref">
<!-- type="mu", deleted in v 1.5
        <xsl:if test="not(indv)">
          <sup class="indv">
            <xsl:attribute name="onmouseover">this.innerHTML=' [ <xsl:value-of select="substring-after(@id,'.')"/> ] '</xsl:attribute>
            <xsl:attribute name="onmouseout">this.innerHTML=' [ ] '</xsl:attribute>
          [ ]
          </sup>
        </xsl:if>
-->
        <!--else-->
          <xsl:apply-templates/>
      </a>
  </xsl:template>

<!--
  <xsl:template match="kor[@kil='Bfort']/@id">
    <xsl:if test=".!='x' and .!='-'">
      <xsl:value-of select="."/><xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
    </xsl:if>
  </xsl:template>
-->

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

  <xsl:template match="altbeg[@spec='hakhak']">
    <span>
      <!--empty-->
    </span><!--no text node here--><a name="dum" class="tnx" onClick="that=this" href="javascript:tnx(that)" title="Secondary source">&hakbeg;&hakbeg;</a><!--no text node here--><span class="tnote">
    <xsl:call-template name="sigel">
      <xsl:with-param name="s">
        <xsl:value-of select="@kil"/>
      </xsl:with-param>
    </xsl:call-template>
    <span class="udg">
      <xsl:value-of select="@n"/>
    </span>
    <xsl:if test="@msifB">
      <span class="udg">
        (ms. s. <xsl:value-of select="@msifB"/> if. B-fort.)
      </span>
    </xsl:if>
    <xsl:apply-templates select="udg[@spec='fri']" mode="in-tn"/>
    <xsl:for-each select="sub"><span class="udg">,</span>
      <xsl:apply-templates select="." mode="in-tn"/>
    </xsl:for-each>
    </span>
  </xsl:template>

  <xsl:template match="altslut[@spec='hak' or @spec='hakbag']">
    <span/><a name="dum" class="tnx">&hakslut;</a><span/>
  </xsl:template>

  <xsl:template match="altslut[@spec='hakhak']">
    <span/><a name="dum" class="tnx">&hakslut;&hakslut;</a><span/>
  </xsl:template>

  <xsl:template match="blok[@ryk='etiket']">
    <div class="etiket">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="barfod">
    <span class="grad-1">
      [<xsl:value-of select="@kom"/><xsl:apply-templates/>]
    </span>
  </xsl:template>

</xsl:stylesheet>

