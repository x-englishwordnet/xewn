<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<xsl:strip-space elements="*" />
	<xsl:output method="text" indent="no" />

	<xsl:template match="/">
		<xsl:variable name="items" select="/LexicalResource/Lexicon/SyntacticBehaviour[@sentenceTemplate != '']" />
		<xsl:for-each select="$items">
			<xsl:sort select="substring(@id,8)" data-type="number" />
			<xsl:variable name="template_num" select="substring(@id,8)" />
			<xsl:variable name="template" select="@sentenceTemplate" />

			<xsl:value-of select="$template_num" />
			<xsl:text> </xsl:text>
			<xsl:value-of select="$template" />
			<xsl:text>&#xa;</xsl:text>
		</xsl:for-each>

		<xsl:message>
			<xsl:value-of select="count($items)" />
			<xsl:text> processed</xsl:text>
		</xsl:message>
	</xsl:template>

</xsl:transform>
