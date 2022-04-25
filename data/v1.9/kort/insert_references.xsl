<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform version="1.0"
	       xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:t="http://www.tei-c.org/ns/1.0"
               xmlns="http://www.tei-c.org/ns/1.0"
	       exclude-result-prefixes="t">

  <xsl:template match="t:div[t:figure]">
    <div>
      <xsl:copy-of select="@*"/>
      <figure>
        <head>
          <xsl:choose>
            <xsl:when test="contains(@xml:id,'kbh_')">Kaart over Kjöbenhavn 1839 / Sterms Topographie over Danmark, [København]: Sterm, [1839], KBK K-0-1839/2, 1911-15690, IDnr. x531925845. Målestok [ca. 1:7 000]</xsl:when>
            <xsl:when test="contains(@xml:id,'kbhf_') or contains(@xml:id,'kbhfsv_')">Kjöbenhavn med Forstæder (Med Stadens Inddeling i Qvarterer paa de colorerede Kaart) / C. Henckels lith: Inst: ; grav: af A. Bull, [København]: B. A. Meyers Forlag, [1840?]. KBK K-0-1840/3A 1977-354/533, IDnr. x233518613. Målestok [ca. 1:10 000]</xsl:when>
            <xsl:when test="contains(@xml:id,'kbho_')">Kjøbenhavns Omegn i VI Blade, Østre Blad IV / stukket af F.C. Holm. Maalt 1851 &amp; 52, [København]: Generalstaben 1854. KBK K-0-1857/1a-1f 1958-939/1-6, IDnr. x531926132. Målestok 1:20 000 [ca. 1:25 200]</xsl:when>
            <xsl:when test="contains(@xml:id,'nos_') or contains(@xml:id,'mols_') or contains(@xml:id,'ns_')">Den nordöstlige Deel af Sjælland 1837, Jernbanen mellem Kjöbenh. og Roeskilde er tilföiet 1846. KBK 1111,25-0-1837/2a-d x-2003/86-88, x-2003/119. Målestok 1:160 000 [ca. 1:202 000]</xsl:when>
            <xsl:when test="contains(@xml:id,'dk_') or contains(@xml:id,'ring_') or contains(@xml:id,'vib_')">[Danmarkskort, omgivet af en ramme med prospekter, historiske billeder og historisk tekst (bortklippet)] / komponeret af Harald Jensen ifölge J. C. la Cour's Forslag ; Den kartografiske Text af C. Bågø. Graveret i Harald Jensen's lithografiske Atelier ; Kortet gr. af N. Engel. Kjøbenhavn : Forlagt af N.C. Rom, [1889], KBK 1111-14-1889/1 x-1967/77, IDnr. x531812900. Målestok: [ca. 1:1 127 000]</xsl:when>
            <xsl:when test="contains(@xml:id,'ber_')">Grundriss von Berlin, Aufgenommen und gezeichnet mit Genehmigung der Königl. Akademie der Wissenschaften von Johann Christian Selter. Verlag von Simon Schropp. 1843. Format: 101 x 75 cm. Målestok: [ca. 1:11 300]</xsl:when>
          </xsl:choose>
        </head>
        <xsl:copy-of select="t:figure/t:graphic"/>
      </figure>
    </div>
  </xsl:template>
  
   <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
