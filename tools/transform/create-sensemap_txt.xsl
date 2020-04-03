<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<xsl:strip-space elements="*" />
	<xsl:output method="text" indent="yes" />

	<xsl:variable name='debug' select='false()' />

	<xsl:template match="/">
		<xsl:text># senseid sensekey sensekey31 (dc:identifier)&#xa;</xsl:text>
		<xsl:apply-templates select="//Sense" />
	</xsl:template>

	<xsl:template match="Sense">
		<xsl:variable name="id" select="./@id" />
		<xsl:variable name="sensekey" select="./@sensekey" />
		<xsl:variable name="sensekey31" select="./@dc:identifier" />
		<xsl:if test="$debug = true() and $sensekey != $sensekey31">
			<xsl:message>
				<xsl:text>&#xa; </xsl:text>
				<xsl:text>diff </xsl:text>
				<xsl:value-of select="$sensekey" />
				<xsl:text> </xsl:text>
				<xsl:value-of select="$sensekey31" />
			</xsl:message>
		</xsl:if>
		<xsl:value-of select="$id" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="$sensekey" />
		<xsl:text> </xsl:text>
		<xsl:value-of select="$sensekey31" />
		<xsl:text>&#xa;</xsl:text>
	</xsl:template>

</xsl:transform>
