<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<xsl:variable name='debug' select='false()' />
	<xsl:variable name='debug2' select='false()' />

	<!-- L E X I D F A C T O R Y -->

	<!-- Make lexid, dispatch as per one of three methods {legacy, nbased, idx} -->
	<!-- Dispatcher -->

	<xsl:template name="make-lexid">
		<xsl:param name="sensenode" />
		<xsl:param name="method" />
		<xsl:choose>
			<xsl:when test="$method = 'legacy'">
				<xsl:if test='$debug2 = true()'>
					<!-- 1x values -->
					<xsl:value-of select="1" />
				</xsl:if>
				<xsl:call-template name='make-lexid-from-legacy'>
					<xsl:with-param name='sensenode' select='$sensenode' />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$method = 'nbased'">
				<xsl:if test='$debug2 = true()'>
					<!-- 2x values -->
					<xsl:value-of select="2" />
				</xsl:if>
				<xsl:call-template name='make-lexid-from-n'>
					<xsl:with-param name='sensenode' select='$sensenode' />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$method = 'idx'">
				<xsl:if test='$debug2 = true()'>
					<!-- 3x values -->
					<xsl:value-of select="3" />
				</xsl:if>
				<xsl:call-template name='make-lexid-from-idx'>
					<xsl:with-param name='sensenode' select='$sensenode' />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<message terminate='yes'>
					<xsl:text>&#xa;[E] Unknown or unspecified lexid method '</xsl:text>
					<xsl:value-of select="$method" />
					<xsl:text>'</xsl:text>
				</message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Make lexid -->
	<!-- based on extraction of lexid from legacy sensekey (dc:identifier) formatted as ss_type:lex_filenum:lex_id -->

	<xsl:template name="make-lexid-from-legacy">
		<xsl:param name="sensenode" />

		<xsl:variable name="legacy_sensekey" select="./@dc:identifier" />
		<xsl:variable name="legacy_lexid"
			select="number(substring-before(substring-after(substring-after(substring-after(./@dc:identifier,'%'),':'),':'),':'))" />

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[D] CALLED make-lexid-from-legacy(sensenode_id=</xsl:text>
				<xsl:value-of select="$sensenode/@identifier" />
				<xsl:text>)</xsl:text>
				<xsl:text>&#xa;[D]   sensekey </xsl:text>
				<xsl:value-of select="$legacy_sensekey" />
				<xsl:text>&#xa;[D]   sensekey </xsl:text>
				<xsl:value-of select="$legacy_lexid" />
			</xsl:message>
		</xsl:if>

		<xsl:value-of select="$legacy_lexid" />
	</xsl:template>

	<!-- Make lexid -->
	<!-- based on ordering of 'n' attribute, floored to min value of n in lexicographer file -->

	<xsl:template name="make-lexid-from-n">
		<xsl:param name="sensenode" />

		<xsl:variable name="numsenses" select="count($sensenode/parent::LexicalEntry/Sense)" />

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[D] CALLED make-lexid-from-n(sensenode_id=</xsl:text>
				<xsl:value-of select="$sensenode/@id" />
				<xsl:text>)</xsl:text>
				<xsl:text>&#xa;[D]   num senses </xsl:text>
				<xsl:value-of select="$numsenses" />
			</xsl:message>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="$numsenses &gt; 1">
				<xsl:variable name="minn">
					<xsl:for-each select="$sensenode/parent::LexicalEntry/Sense/@n">
						<xsl:sort select="." data-type="number" order="ascending" />
						<xsl:if test="position() = 1">
							<xsl:value-of select="number(.)" />
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<xsl:value-of select="$sensenode/@n - $minn" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="0" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Make lexid -->
	<!-- based on ordering of senses: 0 if there is a single sense, otherwise 1-based index of sense: 1, 2, .. -->

	<xsl:template name="make-lexid-from-idx">
		<xsl:param name="sensenode" />

		<xsl:variable name="senseid" select="$sensenode/@id" />
		<xsl:variable name="allsenses" select="$sensenode/parent::LexicalEntry/Sense" />
		<xsl:variable name="numsenses" select="count($allsenses)" />

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[D] CALLED make-lexid-from-idx(sensenode_id=</xsl:text>
				<xsl:value-of select="$senseid" />
				<xsl:text>)</xsl:text>
				<xsl:text>&#xa;[D]   num co-senses </xsl:text>
				<xsl:value-of select="$numsenses" />
				<xsl:for-each select="$allsenses">
					<xsl:text>&#xa;[D]   sense </xsl:text>
					<xsl:value-of select="concat('#',position(), ' id=', ./@id, ' synset=', ./@synset)" />
					<xsl:if test='./@id = $senseid'>
						<xsl:text> SELECT this sense with position </xsl:text>
						<xsl:value-of select="position()" />
					</xsl:if>
				</xsl:for-each>
			</xsl:message>
		</xsl:if>

		<xsl:choose>
			<xsl:when test='$numsenses &gt; 1'>
				<xsl:variable name='senseidx'>
					<xsl:for-each select="$allsenses">
						<xsl:if test='./@id = $senseid'>
							<xsl:value-of select="position()" />
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
				<xsl:value-of select="$senseidx" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select='0' />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:transform>
