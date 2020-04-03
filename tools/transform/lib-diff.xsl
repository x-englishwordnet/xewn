<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<xsl:template name="sense-node-diff">
		<xsl:param name="var1" />
		<xsl:param name="var2" />
		<xsl:text>@@@ </xsl:text>
		<xsl:value-of select="position()" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="@id" />
		<xsl:text> [</xsl:text>
		<xsl:value-of select="$var1" />
		<xsl:text>] -&gt; [</xsl:text>
		<xsl:value-of select="$var2" />
		<xsl:text>]&#xa;</xsl:text>
		<xsl:text>---</xsl:text>
		<xsl:value-of select="@dc:identifier" />
		<xsl:text>&#xa;</xsl:text>
		<xsl:text>+++</xsl:text>
		<xsl:value-of select="@sensekey" />
		<xsl:text>&#xa;&#xa;</xsl:text>
	</xsl:template>

</xsl:transform>
