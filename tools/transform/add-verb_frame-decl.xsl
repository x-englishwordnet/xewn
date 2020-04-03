<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

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

	<xsl:template match="Lexicon">
		<xsl:copy>
			<xsl:apply-templates select="@*" />

			<xsl:variable name="vfs" select="document('verbframes.xml')/SyntacticBehaviours/SyntacticBehaviour"/>
			<xsl:copy-of select="$vfs"/>
			<!--
			<xsl:for-each select="$vfs">
				<xsl:sort select="substring(@id,8)" data-type="number"/>
				<xsl:copy-of select="."/>
			</xsl:for-each>
			-->

			<xsl:apply-templates select="SyntacticBehaviour" />
			<xsl:apply-templates select="LexicalEntry" />
			<xsl:apply-templates select="Synset" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

</xsl:transform>
