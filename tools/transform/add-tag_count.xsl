<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="https://globalwordnet.github.io/schemas/dc/">

	<xsl:output omit-xml-declaration="no" standalone="no" method="xml" version="1.1" encoding="UTF-8" indent="yes" />
	<xsl:strip-space elements="*" />

	<xsl:param name="updateFileName" select="'data-tagcount.xml'" />
	<xsl:param name="updates" select="document($updateFileName)" />

	<xsl:variable name='debug' select='false()' />

	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="LexicalResource">
		<LexicalResource 
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation=". https://x-englishwordnet.github.io/schemas/1.10/xEWN-LMF-1.10-relax_idrefs.xsd" 
			xmlns:dc="https://globalwordnet.github.io/schemas/dc/">
			<xsl:apply-templates select="./*" />
		</LexicalResource>
	</xsl:template>

	<xsl:template match="Sense">
		<!-- <xsl:variable name="sensekey" select="@sensekey" /> -->
		<xsl:variable name="sensekey31" select="@dc:identifier" />
		<xsl:variable name="map" select="$updates/maps/map[sensekey = $sensekey31]" />
		<xsl:variable name="tagcnt" select="$map/tagcnt" />

		<xsl:if test="$debug=true()">
			<!-- <xsl:message> -->
			<!-- <xsl:text>sensekey31=</xsl:text> -->
			<!-- <xsl:value-of select="$sensekey31" /> -->
			<!-- </xsl:message> -->
			<xsl:if test="$tagcnt != ''">
				<xsl:message>
					<xsl:text>adding </xsl:text>
					<xsl:value-of select="count($tagcnt)" />
					<xsl:text> tagcount to sensekey31=</xsl:text>
					<xsl:value-of select="$sensekey31" />
					<xsl:text> tagcnt=</xsl:text>
					<xsl:value-of select="$tagcnt" />
				</xsl:message>
			</xsl:if>
		</xsl:if>

		<xsl:copy>
			<xsl:if test="count($tagcnt) > 0">
				<xsl:attribute name="tagCnt">
				<xsl:value-of select="$tagcnt" />
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

</xsl:transform>
