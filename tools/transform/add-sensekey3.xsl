<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="https://globalwordnet.github.io/schemas/dc/">

	<xsl:import href='lib-lexid.xsl' />
	<xsl:import href='lib-sensekey.xsl' />

	<xsl:output omit-xml-declaration="no" standalone="no" method="xml" version="1.1" encoding="UTF-8" indent="yes" />
	<xsl:strip-space elements="*" />

	<xsl:variable name="lexid_method" select="'idx'" />

	<xsl:template match="/">
		<xsl:message>
			<xsl:text>&#xa;</xsl:text>
		</xsl:message>
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

		<xsl:variable name="idx">
			<xsl:number />
		</xsl:variable>

		<xsl:variable name="lexid">
			<xsl:call-template name='make-lexid'>
				<xsl:with-param name='sensenode' select='.' />
				<xsl:with-param name='method' select='$lexid_method' />
			</xsl:call-template>
		</xsl:variable>

		<xsl:variable name="sensekey">
			<xsl:call-template name="make-sensekey">
				<xsl:with-param name="sensenode" select="." />
				<xsl:with-param name="method" select="$lexid_method" />
			</xsl:call-template>
		</xsl:variable>

		<xsl:copy>
			<xsl:attribute name="senseidx">
					<xsl:value-of select="format-number($idx - 1,'#0')" />
			</xsl:attribute>

			<xsl:attribute name="lexid">
					<xsl:value-of select="format-number($lexid,'#0')" />
			</xsl:attribute>

			<xsl:attribute name="sensekey">
					<xsl:value-of select="$sensekey" />
			</xsl:attribute>

			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

</xsl:transform>
