<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<xsl:output method="xml" indent="yes" />
	<xsl:strip-space elements="*" />

	<xsl:variable name='debug' select='false()' />

	<xsl:template match="/">
		<xsl:element name="sensemap">
			<xsl:apply-templates select="//Sense" />
		</xsl:element>
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
		<xsl:element name="sense">
			<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			<xsl:attribute name="sensekey"><xsl:value-of select="$sensekey" /></xsl:attribute>
			<xsl:attribute name="sensekey31"><xsl:value-of select="$sensekey31" /></xsl:attribute>
		</xsl:element>
	</xsl:template>

</xsl:transform>
