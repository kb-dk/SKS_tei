<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	       xmlns:t="http://www.tei-c.org/ns/1.0"
	       xmlns="http://www.tei-c.org/ns/1.0"
	       version="1.0">

  <!-- identity transform -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="t:ptr">
    <xsl:element name="ptr">
      <xsl:copy-of select="@*"/>
      <xsl:if test="contains(@target,'ekom.xml')">
        <xsl:attribute name="target">
          <xsl:value-of select="concat('#',substring-after(@target,'ekom.xml#'))"/>
        </xsl:attribute>
      </xsl:if>
    </xsl:element>
  </xsl:template>
  
</xsl:transform>
