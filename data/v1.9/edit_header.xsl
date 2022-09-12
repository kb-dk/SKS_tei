<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns="http://www.tei-c.org/ns/1.0"
               xmlns:t="http://www.tei-c.org/ns/1.0"
               xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               exclude-result-prefixes="t xsl"
               version="1.0">

  <xsl:output encoding="UTF-8"/>

  <xsl:param name="published_date" select="''"/>
  
  <xsl:template match="t:fileDesc/t:sourceDesc">
    <sourceDesc>
      <xsl:apply-templates select="@*"/>
      <bibl>
        <xsl:attribute name="xml:id">
          <xsl:value-of select="concat('source',generate-id(.))"/>
        </xsl:attribute>
        <xsl:apply-templates mode="bib" select="//t:fileDesc/t:titleStmt"/>
        <xsl:if test="$published_date">
          <date>
            <xsl:attribute name="when">
              <xsl:value-of select="$published_date"/>
            </xsl:attribute>
             <xsl:attribute name="xml:id">
               <xsl:value-of select="concat('date',generate-id(.))"/>
             </xsl:attribute>
            <xsl:choose>
              <xsl:when test="contains($published_date,'-')">
                <xsl:value-of select="substring-before($published_date,'-')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$published_date"/>
              </xsl:otherwise>
            </xsl:choose>
          </date>
        </xsl:if>
      </bibl>
      <xsl:apply-templates select="node()"/>
    </sourceDesc>
  </xsl:template>
  
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template mode="bib" match="@xml:id">
    <xsl:attribute name="xml:id">
      <xsl:value-of select="concat('source',generate-id(.))"/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template mode="bib" match="@*">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template mode="bib" match="t:fileDesc/t:titleStmt">
    <xsl:apply-templates mode="bib" select="t:title"/> 
    <xsl:apply-templates mode="bib" select="t:author"/> 
  </xsl:template>

  <xsl:template mode="bib" match="t:title">
    <title>
      <xsl:apply-templates mode="bib" select="@*"/>
      <xsl:apply-templates mode="bib"/>
    </title>
  </xsl:template>

  <xsl:template mode="bib" match="t:name">
    <name>
      <xsl:apply-templates mode="bib" select="@*"/>
      <xsl:apply-templates mode="bib"/>
    </name>
  </xsl:template>
  
  <xsl:template mode="bib" match="t:author">
    <author>
      <xsl:apply-templates mode="bib" select="@*"/>
      <xsl:apply-templates mode="bib"/>
    </author>
  </xsl:template>

  
</xsl:transform>


  
