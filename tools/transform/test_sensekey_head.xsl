<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:import href='lib-lexid.xsl' />
	<xsl:import href='lib-satellite_head.xsl' />
	<xsl:import href='lib-satellite_head_word.xsl' />

	<xsl:output method="text" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/">

		<xsl:call-template name="fetch">
			<xsl:with-param name="s" select="//Sense[@id='gA1']" />
		</xsl:call-template>
		<xsl:call-template name="fetch">
			<xsl:with-param name="s" select="//Sense[@id='hA1']" />
		</xsl:call-template>
		<xsl:call-template name="fetch">
			<xsl:with-param name="s" select="//Sense[@id='iA2']" />
		</xsl:call-template>
		<xsl:call-template name="fetch">
			<xsl:with-param name="s" select="//Sense[@id='jA2']" />
		</xsl:call-template>
		<xsl:call-template name="fetch">
			<xsl:with-param name="s" select="//Sense[@id='kB1']" />
		</xsl:call-template>
		<xsl:call-template name="fetch">
			<xsl:with-param name="s" select="//Sense[@id='lB1']" />
		</xsl:call-template>
		<xsl:call-template name="fetch">
			<xsl:with-param name="s" select="//Sense[@id='mB2']" />
		</xsl:call-template>
		<xsl:call-template name="fetch">
			<xsl:with-param name="s" select="//Sense[@id='nB2']" />
		</xsl:call-template>
		<xsl:call-template name="fetch">
			<xsl:with-param name="s" select="//Sense[@id='aA']" />
		</xsl:call-template>
		<xsl:call-template name="fetch">
			<xsl:with-param name="s" select="//Sense[@id='dB']" />
		</xsl:call-template>

	</xsl:template>

	<xsl:template name="fetch">

		<xsl:param name="s" />

		<xsl:message>
			<xsl:text>INPUT </xsl:text>
			<xsl:value-of select="$s/@id" />
		</xsl:message>

		<xsl:variable name="head">
			<xsl:call-template name="make-satellite-head">
				<xsl:with-param name="sensenode" select="$s" />
				<xsl:with-param name="pos" select="$s/../Lemma/@partOfSpeech" />
				<xsl:with-param name="method" select="'idx'" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="headword">
			<xsl:call-template name="make-satellite-head-word">
				<xsl:with-param name="sensenode" select="$s" />
				<xsl:with-param name="pos" select="$s/../Lemma/@partOfSpeech" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:text>&#xa;</xsl:text>
		<xsl:value-of select='$s/@id' />
		<xsl:text> has sk head </xsl:text>
		<xsl:value-of select="$head" />
		<xsl:text> with headword </xsl:text>
		<xsl:value-of select="$headword" />

	</xsl:template>

</xsl:transform>
