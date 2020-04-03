<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:strip-space elements="*" />

	<xsl:output omit-xml-declaration="no" standalone="no" method="xml" version="1.1" encoding="UTF-8" indent="yes" />

	<xsl:strip-space elements="*" />

	<xsl:variable name='debug' select='false()' />

	<xsl:key name='find-syntactic_behaviour-by-frame' match='/LexicalResource/Lexicon/SyntacticBehaviour' use='normalize-space(@subcategorizationFrame)'></xsl:key>

	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="LexicalResource">
		<LexicalResource 
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation=". https://x-englishwordnet.github.io/schemas/1.10/xEWN-LMF-1.10-relax_idrefs.xsd" 
			xmlns:dc="http://purl.org/dc/elements/1.1/">
			<xsl:apply-templates select="./*" />
		</LexicalResource>
	</xsl:template>

	<xsl:template match="/LexicalResource/Lexicon/LexicalEntry/SyntacticBehaviour">
		<xsl:variable name="frame" select="normalize-space(@subcategorizationFrame)" />
		<xsl:variable name="sb" select="key('find-syntactic_behaviour-by-frame', normalize-space($frame))" />
		<xsl:variable name="sbid">
			<xsl:for-each select="$sb">
				<xsl:value-of select="./@id" />
				<xsl:text> </xsl:text>
			</xsl:for-each>
		</xsl:variable>

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>frame </xsl:text>
				<xsl:value-of select="normalize-space($frame)" />
				<xsl:text>&#xa;</xsl:text>
				<xsl:text>sb length </xsl:text>
				<xsl:value-of select="count($sb)" />
				<xsl:text>&#xa;</xsl:text>
				<xsl:text>sbid </xsl:text>
				<xsl:value-of select="$sbid" />
				<xsl:text>&#xa;</xsl:text>
			</xsl:message>
		</xsl:if>

		<xsl:element name="SyntacticBehaviourRef">
			<xsl:attribute name="idref"><xsl:value-of select="normalize-space($sbid)" /></xsl:attribute>
			<xsl:attribute name="senses"><xsl:value-of select="./@senses" /></xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

</xsl:transform>
