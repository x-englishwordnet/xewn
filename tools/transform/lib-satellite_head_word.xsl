<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2020. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<!-- not necessary if imported as global by caller -->
	<!-- <xsl:import href='lib-satellite_head.xsl' /> -->

	<xsl:variable name='debug' select='false()' />
	<xsl:variable name='error' select='true()' />

	<!-- This is to avoid dependency on reading schema -->
	<xsl:key name='find-sense-by-id' match='//Sense' use='@id'></xsl:key>

	<!-- S A T E L L I T E - H E A D - W O R D F A C T O R Y -->

	<xsl:template name="make-satellite-head-word">
		<xsl:param name="sensenode" />
		<xsl:param name="pos" />

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[D] CALLED make-satellite-head-word(sensenode_id=</xsl:text>
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
				</xsl:message>
				<xsl:value-of select="''" />
			</xsl:when>

			<xsl:otherwise>

				<!-- HEAD SENSE : "the head sense of the satellite's head synset" /> -->
				<xsl:variable name="headsenseid">
					<xsl:call-template name='make-satellite-head-sense'>
						<xsl:with-param name='sensenode' select='$sensenode' />
						<xsl:with-param name='pos' select="$pos" />
					</xsl:call-template>
				</xsl:variable>
				<!-- xsl:variable name="headsense" select='id($headsenseid)' /> -->
				<xsl:variable name="headsense" select='id($headsenseid)' />

				<xsl:if test='$debug = true()'>
					<xsl:message>
						<xsl:text>[D]   headsenseid=</xsl:text>
						<xsl:value-of select="$headsenseid" />
					</xsl:message>
				</xsl:if>

				<!-- HEAD WORD : "the lemma of the first word of the satellite's head synset" /> -->
				<xsl:variable name="lemma" select="$headsense/../Lemma/@writtenForm" />
				<xsl:variable name="headword" select="translate($lemma,' ','_')" />

				<xsl:if test='$debug = true()'>
					<xsl:message>
						<xsl:text>[D]   headword=</xsl:text>
						<xsl:value-of select="$headword" />
					</xsl:message>
				</xsl:if>
				<xsl:value-of select="$headword" />

			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<!-- I S - S A T E L L I T E - H E A D T E S T -->

	<xsl:template name="is-satellite-head">
		<xsl:param name="sensenode" />

		<xsl:variable name="is_a" select="$sensenode[1]/../Lemma/@partOfSpeech='a'" />
		<xsl:variable name="antonym_relation" select="$sensenode/SenseRelation[@relType='antonym']" />
		<xsl:variable name="is_head" select="$antonym_relation/@target != '' and $is_a" />

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[D] CALLED is-satellite-head(sensenode_id=</xsl:text>
				<xsl:value-of select="$sensenode/@id" />
				<xsl:text>)</xsl:text>
				<xsl:text>&#xa;[D]   antonym_relation </xsl:text>
				<xsl:value-of select="$antonym_relation/@target" />
				<xsl:text>&#xa;[T]   is a '</xsl:text>
				<xsl:value-of select="$is_a" />
				<xsl:text>'</xsl:text>
				<xsl:text>&#xa;[T]   is head '</xsl:text>
				<xsl:value-of select="$is_head" />
				<xsl:text>'</xsl:text>
			</xsl:message>
		</xsl:if>

		<xsl:value-of select="$is_head" />
	</xsl:template>

</xsl:transform>
