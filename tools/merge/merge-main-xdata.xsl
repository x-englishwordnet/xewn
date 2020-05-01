<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2020. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" />

	<xsl:param name="xdata" as="xs:string" required="yes" />

	<xsl:variable name="xdatadoc" select="document($xdata)" />
	<xsl:variable name="maindoc" select="/" />

	<xsl:variable name='debug' select='false()' />

	<xsl:template match="/">
		<xsl:message>
			<xsl:text>main: </xsl:text>
			<xsl:value-of select="base-uri($maindoc)" />
			<xsl:text>&#xa;</xsl:text>
			<xsl:text>xdata: </xsl:text>
			<xsl:value-of select="base-uri($xdatadoc)" />
			<xsl:text>&#xa;</xsl:text>
		</xsl:message>

		<xsl:apply-templates select="*"></xsl:apply-templates>
	</xsl:template>

	<xsl:template match="Sense">
		<xsl:variable name="senseid" select="@id" />

		<xsl:merge>
			<xsl:merge-source select="." name="master">
				<xsl:merge-key select="@id" />
			</xsl:merge-source>
			<xsl:merge-source select="$xdatadoc//Sense[@id = $senseid]" name="xdata">
				<xsl:merge-key select="@id" />
			</xsl:merge-source>
			<xsl:merge-action>
				<xsl:copy>
					<xsl:apply-templates select="current-merge-group('master')/@*" />
					<xsl:if test="not(empty(current-merge-group('xdata')))">
						<xsl:apply-templates select="current-merge-group('xdata')/@*" />
					</xsl:if>
				</xsl:copy>
				<xsl:apply-templates select="*" />
			</xsl:merge-action>
		</xsl:merge>

	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

</xsl:transform>
