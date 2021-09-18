<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2020. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="https://globalwordnet.github.io/schemas/dc/">

	<xsl:import href='lib-lexid.xsl' />
	<xsl:import href='lib-satellite_head.xsl' />
	<xsl:import href='lib-satellite_head_word.xsl' />

	<xsl:output omit-xml-declaration="no" standalone="no" method="xml" version="1.1" encoding="UTF-8" indent="yes" />
	<xsl:strip-space elements="*" />

	<xsl:variable name="lexid_method" select="'idx'" />

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

	<xsl:template match="Sense[../Lemma/@partOfSpeech = 's']">

		<xsl:variable name="head">
			<xsl:call-template name='make-satellite-head-word'>
				<xsl:with-param name='sensenode' select='.' />
				<xsl:with-param name='pos' select="'s'" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:copy>
			<xsl:if test="$head != ''">
				<xsl:attribute name="adjHead">
					<xsl:value-of select="$head" />
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="Sense[../Lemma/@partOfSpeech = 'a']">
		<xsl:variable name="is-head">
			<xsl:call-template name='is-satellite-head'>
				<xsl:with-param name='sensenode' select='.' />
			</xsl:call-template>
		</xsl:variable>

		<xsl:copy>
			<xsl:if test='$is-head'>
				<xsl:attribute name="adjIsHead">
					<xsl:value-of select="'true'" />
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
