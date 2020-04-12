<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<xsl:template name="diff">
		<xsl:param name="arg1" />
		<xsl:param name="arg2" />
		<xsl:param name="diff1" />
		<xsl:param name="diff2" />
		<xsl:text>@@@ </xsl:text>
		<xsl:value-of select="position()" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="@id" />
		<xsl:text> [</xsl:text>
		<xsl:value-of select="$diff1" />
		<xsl:text>] -&gt; [</xsl:text>
		<xsl:value-of select="$diff2" />
		<xsl:text>]&#xa;</xsl:text>

		<xsl:text>---</xsl:text>
		<xsl:value-of select="$arg1" />
		<xsl:text>&#xa;</xsl:text>
		<xsl:text>+++</xsl:text>
		<xsl:value-of select="$arg2" />
		<xsl:text>&#xa;&#xa;</xsl:text>
	</xsl:template>

</xsl:transform>
