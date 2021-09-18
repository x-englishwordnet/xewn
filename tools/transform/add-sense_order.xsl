<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0" xmlns:dc="https://globalwordnet.github.io/schemas/dc/">

	<xsl:output omit-xml-declaration="no" standalone="no" method="xml" version="1.1" encoding="UTF-8" indent="yes" />
	<xsl:strip-space elements="*" />
	<xsl:variable name='debug' select='false()' />

	<!-- This is to avoid dependency on reading schema -->
	<xsl:key name='find-synset-by-id' match='//Synset' use='@id'></xsl:key>

	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="LexicalResource">
		<LexicalResource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation=". https://x-englishwordnet.github.io/schemas/1.10/xEWN-LMF-1.10-relax_idrefs.xsd" xmlns:dc="https://globalwordnet.github.io/schemas/dc/">
			<xsl:apply-templates select="./*" />
		</LexicalResource>
	</xsl:template>

	<xsl:template match="Sense">
		<xsl:variable name="entryid" select="../@id" />
		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[LexicalEntry  ] </xsl:text>
				<xsl:value-of select="$entryid" />
			</xsl:message>
		</xsl:if>

		<xsl:variable name="synsetid" select="@synset" />
		<xsl:variable name="members" select="key('find-synset-by-id',$synsetid)/@members" />
		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[Synset Members] </xsl:text>
				<xsl:value-of select="$members" />
			</xsl:message>

			<xsl:message>
				<xsl:for-each select="tokenize($members)">
					<xsl:text>[m] </xsl:text>
					<xsl:value-of select="." />
					<xsl:text>&#xa;</xsl:text>
				</xsl:for-each>
			</xsl:message>

			<xsl:message>
				<xsl:for-each select="tokenize($members)">
					<xsl:if test='$entryid = .'>
						<xsl:value-of select="position() - 1" />
					</xsl:if>
				</xsl:for-each>
			</xsl:message>

		</xsl:if>

		<xsl:variable name="order">
			<xsl:for-each select="tokenize($members)">
				<xsl:if test='$entryid = .'>
					<xsl:value-of select="position() - 1" />
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>

		<xsl:copy>
			<xsl:attribute name="order">
				<xsl:value-of select="$order" />
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
