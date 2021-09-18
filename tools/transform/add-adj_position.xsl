<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="https://globalwordnet.github.io/schemas/dc/">

	<xsl:output omit-xml-declaration="no" standalone="no" method="xml" version="1.1" encoding="UTF-8" indent="yes" />
	<xsl:strip-space elements="*" />

	<xsl:param name="updateFileName" select="'data-adjpositions.xml'" />
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
		<xsl:variable name="senseid" select="@id" />
		<xsl:variable name="lemma" select="translate(../Lemma/@writtenForm,' ','_')" />
		<xsl:variable name="synsetid" select="substring-before(substring-after(@synset,'ewn-'),'-')" />
		<xsl:variable name="pos" select="../Lemma/@partOfSpeech" />
		<xsl:variable name="row" select="$updates/adjpositions/adjposition[starts-with($senseid,senseid)]" />
		<xsl:variable name="adjposition" select="$row/position" />

		<xsl:if test="$debug=true()">
			<xsl:if test="$adjposition">
				<xsl:message>
					<xsl:text> senseid=</xsl:text>
					<xsl:value-of select="$senseid" />
					<xsl:text> lemma=</xsl:text>
					<xsl:value-of select="$lemma" />
					<xsl:text> synsetid=</xsl:text>
					<xsl:value-of select="$synsetid" />
					<xsl:text> pos=</xsl:text>
					<xsl:value-of select="$pos" />
					<xsl:text> - position=</xsl:text>
					<xsl:value-of select="$adjposition" />
				</xsl:message>
			</xsl:if>
		</xsl:if>

		<xsl:copy>
			<xsl:if test="$adjposition">
				<xsl:attribute name="adjPosition">
					<xsl:value-of select="$adjposition" />
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
