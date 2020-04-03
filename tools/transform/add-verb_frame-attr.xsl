<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:strip-space elements="*" />

	<xsl:output omit-xml-declaration="no" standalone="no" method="xml" version="1.1" encoding="UTF-8" indent="yes" />

	<xsl:strip-space elements="*" />

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
			xmlns:dc="http://purl.org/dc/elements/1.1/">
			<xsl:apply-templates select="./*" />
		</LexicalResource>
	</xsl:template>

	<xsl:template match="Sense">
		<xsl:variable name='senseid' select="@id" />

		<xsl:variable name='sb'>
			<xsl:for-each select="../SyntacticBehaviourRef">
				<xsl:variable name='senses' select="@senses" />
				<xsl:if test="contains($senses,$senseid)">
					<xsl:value-of select="@idref" />
					<xsl:text> </xsl:text>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name='sb_normalized'>
			<xsl:value-of select="normalize-space($sb)" />
		</xsl:variable>

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:value-of select="$senseid" />
				<xsl:value-of select="concat(': ',$sb)" />
				<xsl:text>&#xa;</xsl:text>
			</xsl:message>
		</xsl:if>

		<xsl:copy>
			<xsl:if test="$sb_normalized != ''">
				<xsl:attribute name="verbFrames">
					<xsl:value-of select="$sb_normalized" />
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
