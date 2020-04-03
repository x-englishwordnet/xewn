<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2019. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<!-- not necessary imported as global by caller -->
	<!-- <xsl:import href='lib-lexid.xsl' /> -->
	<xsl:import href='lib-satellite_head.xsl' />

	<xsl:variable name='debug' select='false()' />

	<!-- S E N S E K E Y - F A C T O R Y -->

	<xsl:template name="make-sensekey">
		<xsl:param name="sensenode" />
		<xsl:param name="method" />

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[D] CALLED make-sensekey(sensenode_id=</xsl:text>
				<xsl:value-of select="$sensenode/@id" />
				<xsl:text>, method=</xsl:text>
				<xsl:value-of select="$method" />
				<xsl:text>)</xsl:text>
			</xsl:message>
		</xsl:if>

		<xsl:variable name="pos" select="$sensenode[1]/../Lemma/@partOfSpeech" />
		<xsl:variable name="lexfile" select="id($sensenode[1]/@synset)/@dc:subject" />

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[D]   pos </xsl:text>
				<xsl:value-of select="$pos" />
				<xsl:text>&#xa;[D]   lexfile </xsl:text>
				<xsl:value-of select="$lexfile" />
			</xsl:message>
		</xsl:if>

		<!-- LEMMA -->
		<!-- <xsl:variable name="lemma" select="translate($sensenode/../Lemma/@writtenForm,': ABCDEFGHIJKLMNOPQRSTUVWXYZ','#_abcdefghijklmnopqrstuvwxyz')" /> -->
		<xsl:variable name="lemma" select="translate($sensenode/../Lemma/@writtenForm,': ','#_')" />

		<!-- LEX_SENSE -->

		<!-- LEX_SENSE.SSTYPE, assumed stable : we do not jump over the part-of-speech boundary, can be computed from $pos /> -->
		<xsl:variable name="sstype">
			<xsl:choose>
				<xsl:when test="$pos = 'n'">
					<xsl:value-of select="1" />
				</xsl:when>
				<xsl:when test="$pos = 'v'">
					<xsl:value-of select="2" />
				</xsl:when>
				<xsl:when test="$pos = 'a'">
					<xsl:value-of select="3" />
				</xsl:when>
				<xsl:when test="$pos = 'r'">
					<xsl:value-of select="4" />
				</xsl:when>
				<xsl:when test="$pos = 's'">
					<xsl:value-of select="5" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$pos" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- LEX_SENSE.LEXFILE_NUM, assumed stable relative to wn31 : we do not jump over the lexicographer file boundary , can be computed from dc:subject /> -->
		<xsl:variable name="lexfilenum">
			<xsl:choose>
				<xsl:when test="$lexfile = 'adj.all' ">
					<xsl:value-of select="00" />
				</xsl:when>
				<xsl:when test="$lexfile = 'adj.pert' ">
					<xsl:value-of select="01" />
				</xsl:when>
				<xsl:when test="$lexfile = 'adv.all' ">
					<xsl:value-of select="02" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.Tops' ">
					<xsl:value-of select="03" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.act' ">
					<xsl:value-of select="04" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.animal' ">
					<xsl:value-of select="05" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.artifact' ">
					<xsl:value-of select="06" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.attribute' ">
					<xsl:value-of select="07" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.body' ">
					<xsl:value-of select="08" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.cognition' ">
					<xsl:value-of select="09" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.communication' ">
					<xsl:value-of select="10" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.event' ">
					<xsl:value-of select="11" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.feeling' ">
					<xsl:value-of select="12" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.food' ">
					<xsl:value-of select="13" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.group' ">
					<xsl:value-of select="14" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.location' ">
					<xsl:value-of select="15" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.motive' ">
					<xsl:value-of select="16" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.object' ">
					<xsl:value-of select="17" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.person' ">
					<xsl:value-of select="18" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.phenomenon' ">
					<xsl:value-of select="19" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.plant' ">
					<xsl:value-of select="20" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.possession' ">
					<xsl:value-of select="21" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.process' ">
					<xsl:value-of select="22" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.quantity' ">
					<xsl:value-of select="23" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.relation' ">
					<xsl:value-of select="24" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.shape' ">
					<xsl:value-of select="25" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.state' ">
					<xsl:value-of select="26" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.substance' ">
					<xsl:value-of select="27" />
				</xsl:when>
				<xsl:when test="$lexfile = 'noun.time' ">
					<xsl:value-of select="28" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.body' ">
					<xsl:value-of select="29" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.change' ">
					<xsl:value-of select="30" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.cognition' ">
					<xsl:value-of select="31" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.communication' ">
					<xsl:value-of select="32" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.competition' ">
					<xsl:value-of select="33" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.consumption' ">
					<xsl:value-of select="34" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.contact' ">
					<xsl:value-of select="35" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.creation' ">
					<xsl:value-of select="36" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.emotion' ">
					<xsl:value-of select="37" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.motion' ">
					<xsl:value-of select="38" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.perception' ">
					<xsl:value-of select="39" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.possession' ">
					<xsl:value-of select="40" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.social' ">
					<xsl:value-of select="41" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.stative' ">
					<xsl:value-of select="42" />
				</xsl:when>
				<xsl:when test="$lexfile = 'verb.weather' ">
					<xsl:value-of select="43" />
				</xsl:when>
				<xsl:when test="$lexfile = 'adj.ppl' ">
					<xsl:value-of select="44" />
				</xsl:when>
				<xsl:when test="$lexfile = 'contrib.colloq' ">
					<xsl:value-of select="50" />
				</xsl:when>
				<xsl:when test="$lexfile = 'contrib.plwn' ">
					<xsl:value-of select="51" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="concat('???',$lexfile)" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- LEX_SENSE.LEXID, assume: volatile /> -->
		<xsl:variable name="lexid">
			<xsl:call-template name='make-lexid'>
				<xsl:with-param name='sensenode' select='$sensenode' />
				<xsl:with-param name='method' select='$method' />
			</xsl:call-template>
		</xsl:variable>

		<xsl:if test='$debug = true()'>
			<xsl:message>
				<xsl:text>[D]   lexid </xsl:text>
				<xsl:value-of select="$lexid" />
			</xsl:message>
		</xsl:if>

		<!-- LEX_SENSE.SS_TYPE:LEXFILENUM:LEXID /> -->
		<xsl:value-of select="concat($lemma,'%',$sstype,':',format-number($lexfilenum,'00'),':',format-number($lexid,'00'))" />

		<!-- SATELLITE HEAD -->
		<xsl:choose>
			<xsl:when test="$pos != 's'">
				<xsl:value-of select="'::'" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="head">
					<xsl:call-template name="make-satellite-head">
						<xsl:with-param name="sensenode" select="." />
						<xsl:with-param name="pos" select="$pos" />
						<xsl:with-param name="method" select="$method" />
					</xsl:call-template>
				</xsl:variable>
				<xsl:value-of select="concat(':',$head)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:transform>
