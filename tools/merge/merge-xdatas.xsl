<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2020. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:output method="xml" indent="yes" />

	<xsl:param name="dir" as="xs:string" required="yes" />

	<xsl:variable name="path">
		<xsl:value-of select="concat($dir,'?select=*.xml;recurse=no;on-error=warning')" />
	</xsl:variable>
	<xsl:variable name="docs" select="collection($path)" />

	<xsl:variable name='debug' select='false()' />
	<xsl:variable name='fromtag' select='true()' />

	<xsl:template match="/">
		<xsl:message>
			<xsl:text>dir: </xsl:text>
			<xsl:value-of select="$dir" />
			<xsl:text>&#xa;</xsl:text>
			<xsl:text>docs:</xsl:text>
			<xsl:value-of select="count($docs)" />
			<xsl:text> files &#xa;</xsl:text>
			<xsl:for-each select="$docs">
				<xsl:value-of select="base-uri(.)" />
				<xsl:text>&#xa;</xsl:text>
			</xsl:for-each>
		</xsl:message>

		<LexicalResource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation=". https://x-englishwordnet.github.io/schemas/1.10/xEWN-LMF-1.10-changes.xsd">
			<Lexicon id = "oewn-change-senses" label="English WordNet - All Changes to Sense">
				<Changes>
					<xsl:merge>
						<xsl:merge-source for-each-item="$docs" sort-before-merge="true" select="//Sense">
							<xsl:merge-key select="@id" order="ascending" />
						</xsl:merge-source>
						<xsl:merge-action>
							<xsl:copy>
								<xsl:for-each select="current-merge-group()">
									<xsl:apply-templates select="./@*" />
								</xsl:for-each>
							</xsl:copy>
						</xsl:merge-action>
					</xsl:merge>
				</Changes>
			</Lexicon>
		</LexicalResource>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

</xsl:transform>
