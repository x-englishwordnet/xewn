<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0" xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="dc">

	<xsl:output omit-xml-declaration="no" standalone="no" method="xml" version="1.1" encoding="UTF-8" indent="yes" />
	<xsl:strip-space elements="*" />

	<xsl:variable name='debug' select='false()' />

	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="LexicalResource">
		<LexicalResource xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation=". https://x-englishwordnet.github.io/schemas/1.1/changes.xsd">
			<Lexicon id = "ewn-change-senses-tagCnt" label="English WordNet - Changes to Sense/@tagCnt">
				<Changes>
					<xsl:apply-templates select="//Sense[@tagCnt != '']"/>
				</Changes>
			</Lexicon>
		</LexicalResource>
	</xsl:template>

	<xsl:template match="Sense">

		<xsl:if test="$debug=true()">
			<xsl:message>
				<xsl:text>adding </xsl:text>
				<xsl:value-of select="@tagCnt" />
				<xsl:text> to =</xsl:text>
				<xsl:value-of select="@id" />
			</xsl:message>

		</xsl:if>

		<xsl:copy copy-namespaces="no">
			<xsl:attribute name="id">
			<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="tagCnt">
			<xsl:value-of select="@tagCnt" />
			</xsl:attribute>
		</xsl:copy>
	</xsl:template>

</xsl:transform>
