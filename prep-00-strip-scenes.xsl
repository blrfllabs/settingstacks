<?xml version="1.0" encoding="UTF-8"?>

<!--
  Strip all <Scene> and <scenes> items

  Original source: http://stackoverflow.com/a/4781209/180674
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="scenes"/>
  <xsl:template match="Scene"/>

</xsl:stylesheet>
