<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="https://globalwordnet.github.io/schemas/dc/">

	<xsl:import href='lib-diff.xsl' />

	<xsl:output method="text" indent="no" />
	<xsl:strip-space elements="*" />

	<!-- <xsl:variable name="what" select="'wordlower'" /> -->
	<xsl:variable name="what" select="'wordlower'" />

	<xsl:template match="/">
		<xsl:message>
			<xsl:choose>
				<xsl:when test="$what = 'word'">
					<xsl:text>word</xsl:text>
				</xsl:when>
				<xsl:when test="$what = 'wordlower'">
					<xsl:text>lower-cased word</xsl:text>
				</xsl:when>
				<xsl:when test="$what = 'head'">
					<xsl:text>head</xsl:text>
				</xsl:when>
				<xsl:when test="$what = 'headword'">
					<xsl:text>headword</xsl:text>
				</xsl:when>
				<xsl:when test="$what = 'headid'">
					<xsl:text>headid</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>whole</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:message>

		<xsl:variable name="diffs" select="//Sense[@dc:identifier != @sensekey]" />
		<xsl:apply-templates select="$diffs" />

		<xsl:text>&#xa;</xsl:text>
		<xsl:value-of select="count($diffs)" />
		<xsl:text> diffs</xsl:text>
	</xsl:template>

	<xsl:template match="Sense">
		<xsl:variable name="var1">
			<xsl:choose>
				<xsl:when test="$what = 'word'">
					<xsl:value-of select="substring-before(@dc:identifier,'%')" />
				</xsl:when>
				<xsl:when test="$what = 'wordlower'">
					<xsl:value-of select="translate(substring-before(@dc:identifier,'%'),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')" />
				</xsl:when>
				<xsl:when test="$what = 'head'">
					<xsl:value-of
						select="substring-after(substring-after(substring-after(substring-after(@dc:identifier,'%'),':'),':'),':')" />
				</xsl:when>
				<xsl:when test="$what = 'headword'">
					<xsl:value-of
						select="substring-before(substring-after(substring-after(substring-after(substring-after(@dc:identifier,'%'),':'),':'),':'),':')" />
				</xsl:when>
				<xsl:when test="$what = 'headid'">
					<xsl:value-of select="substring-after(substring-after(substring-after(substring-after(substring-after(@dc:identifier,'%'),':'),':'),':'),':')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@dc:identifier" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="var2">
			<xsl:choose>
				<xsl:when test="$what = 'word'">
					<xsl:value-of select="substring-before(@sensekey,'%')" />
				</xsl:when>
				<xsl:when test="$what = 'wordlower'">
					<xsl:value-of select="translate(substring-before(@sensekey,'%'),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')" />
				</xsl:when>
				<xsl:when test="$what = 'head'">
					<xsl:value-of select="substring-after(substring-after(substring-after(substring-after(@sensekey,'%'),':'),':'),':')" />
				</xsl:when>
				<xsl:when test="$what = 'headword'">
					<xsl:value-of select="substring-before(substring-after(substring-after(substring-after(substring-after(@sensekey,'%'),':'),':'),':'),':')" />
				</xsl:when>
				<xsl:when test="$what = 'headid'">
					<xsl:value-of select="substring-after(substring-after(substring-after(substring-after(substring-after(@sensekey,'%'),':'),':'),':'),':')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@sensekey" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="$var1 != $var2">
			<xsl:call-template name="diff">
				<xsl:with-param name="arg1" select="@dc:identifier" />
				<xsl:with-param name="arg2" select="@sensekey" />
				<xsl:with-param name="diff1" select="$var1" />
				<xsl:with-param name="diff2" select="$var2" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

</xsl:transform>
