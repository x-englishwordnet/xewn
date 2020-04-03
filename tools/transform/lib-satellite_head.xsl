<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<!-- not necessary imported as global by caller -->
	<!-- <xsl:import href='lib-lexid.xsl' /> -->

	<xsl:variable name='debug' select='false()' />

	<!-- S A T E L L I T E - H E A D - F A C T O R Y -->

	<xsl:template name="make-satellite-head">
		<xsl:param name="sensenode" />
		<xsl:param name="pos" />
		<xsl:param name="method" />

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[D] CALLED make-satellite-head(sensenode_id=</xsl:text>
				<xsl:value-of select="$sensenode/@id" />
				<xsl:text>, pos=</xsl:text>
				<xsl:value-of select="$pos" />
				<xsl:text>)</xsl:text>
			</xsl:message>
		</xsl:if>

		<!-- SATELLITE HEAD -->
		<xsl:choose>
			<xsl:when test="$pos != 's'">
				<xsl:message>
					<xsl:text>[D]   not a satellite</xsl:text>
					<xsl:text>&#xa;</xsl:text>
				</xsl:message>
				<xsl:value-of select="':'" />
			</xsl:when>

			<xsl:otherwise>
				<xsl:variable name="synset_id" select="$sensenode[1]/@synset" />
				<xsl:variable name="synset" select="id($synset_id)" />
				<xsl:variable name="head_synset_id" select="$synset[1]/SynsetRelation[@relType='similar']/@target" />
				<xsl:variable name="head_senses" select="//Sense[@synset=$head_synset_id]" />
				<xsl:variable name="lemma" select="$head_senses[1]/../Lemma/@writtenForm" />
				<!-- HEAD WORD : "the lemma of the first word of the satellite's head synset" /> -->
				<xsl:variable name="headword" select="translate($lemma,' ','_')" />

				<xsl:if test='$debug = true()'>
					<xsl:message>
						<xsl:text>[D]   synset_id </xsl:text>
						<xsl:value-of select="$synset_id" />
						<xsl:text>&#xa;[D]   its fetched synset </xsl:text>
						<xsl:value-of select="$synset" />
						<xsl:text>&#xa;[D]   its fetched synset count() </xsl:text>
						<xsl:value-of select="count($synset)" />
						<xsl:text>&#xa;[D]   its fetched synset/@id </xsl:text>
						<xsl:value-of select="$synset/@id" />
						<xsl:text>&#xa;[D]   head_synset_id </xsl:text>
						<xsl:value-of select="$head_synset_id" />
						<xsl:text>&#xa;[D]   head_senses[1].@id </xsl:text>
						<xsl:value-of select="$head_senses[1]/@id" />
						<xsl:text>&#xa;[D]   lemma </xsl:text>
						<xsl:value-of select="$lemma" />
						<xsl:text>&#xa;[D]   headword=</xsl:text>
						<xsl:value-of select="$headword" />
					</xsl:message>
				</xsl:if>

				<!-- HEAD LEXID : "a two digit decimal integer that, when appended onto head_word, uniquely identifies the sense of head_word within a lexicographer file, as 
					described for lex_id" /> -->
				<xsl:variable name="headid">
					<xsl:call-template name="make-lexid">
						<xsl:with-param name="sensenode" select="$head_senses[1]" />
						<xsl:with-param name="method" select="$method" />
					</xsl:call-template>
				</xsl:variable>

				<!-- Value -->
				<xsl:if test='$debug = true()'>
					<xsl:message>
						<xsl:text>[D]   headid=</xsl:text>
						<xsl:value-of select="$headid" />
						<xsl:text>&#xa;</xsl:text>
					</xsl:message>
				</xsl:if>
				<xsl:value-of select="concat($headword,':',format-number($headid,'00'))" />
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

</xsl:transform>
