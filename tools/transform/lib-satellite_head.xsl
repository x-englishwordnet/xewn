<?xml version="1.0" encoding="UTF-8"?>
<!-- ~ Copyright (c) 2020. Bernard Bou <1313ou@gmail.com>. -->

<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:dc="https://globalwordnet.github.io/schemas/dc/">

	<!-- not necessary if imported as global by caller -->
	<!-- <xsl:import href='lib-lexid.xsl' /> -->

	<xsl:variable name='debug' select='false()' />
	<xsl:variable name='warn' select='false()' />
	<xsl:variable name='error' select='true()' />

	<!-- This is to avoid dependency on reading schema -->
	<xsl:key name='find-synset-by-id' match='//Synset' use='@id'></xsl:key>
	<xsl:key name='find-sense-by-id' match='//Sense' use='@id'></xsl:key>

	<!-- S A T E L L I T E - H E A D - F A C T O R Y -->

	<xsl:template name="make-satellite-head-sense">
		<xsl:param name="sensenode" />
		<xsl:param name="pos" />

		<xsl:if test='$debug'>
			<xsl:message>
				<xsl:text>[D] CALLED make-satellite-head-sense(sensenode_id=</xsl:text>
				<xsl:value-of select="$sensenode/@id" />
				<xsl:text>, pos=</xsl:text>
				<xsl:value-of select="$pos" />
				<xsl:text>)</xsl:text>
			</xsl:message>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="$pos != 's'">
				<xsl:message>
					<xsl:text>[D]   not a satellite</xsl:text>
				</xsl:message>
				<xsl:value-of select="''" />
			</xsl:when>

			<xsl:otherwise>
				<xsl:variable name="synset_id" select="$sensenode/@synset" />
				<!-- <xsl:variable name="synset" select="id($synset_id)" /> -->
				<xsl:variable name="synset" select="key('find-synset-by-id',$synset_id)" />
				<xsl:variable name="head_synset_id" select="$synset/SynsetRelation[@relType='similar']/@target" />
				<xsl:variable name="head_senses" select="//Sense[@synset=$head_synset_id]" />

				<xsl:if test='$debug'>
					<xsl:message>
						<xsl:text>[D]   synset_id </xsl:text>
						<xsl:value-of select="$synset_id" />
						<xsl:text>&#xa;[D]   its fetched synset definition '</xsl:text>
						<xsl:value-of select="$synset" />
						<xsl:text>'</xsl:text>
						<xsl:text>&#xa;[D]   its fetched synset count() </xsl:text>
						<xsl:value-of select="count($synset)" />
						<xsl:text>&#xa;[D]   its fetched synset/@id </xsl:text>
						<xsl:value-of select="$synset/@id" />
						<xsl:text>&#xa;[D]   head_synset_id (through similar) </xsl:text>
						<xsl:value-of select="$head_synset_id" />
						<xsl:text>&#xa;[D]   head_senses </xsl:text>
						<xsl:value-of select="count($head_senses)" />
						<xsl:for-each select="$head_senses">
							<xsl:text>&#xa;[D]   -head_sense </xsl:text>
							<xsl:value-of select="./@id" />
						</xsl:for-each>
					</xsl:message>
				</xsl:if>

				<xsl:if test="count($head_senses) = 0 and $error">
					<xsl:message>
						<xsl:text>[E]   no head sense found for '</xsl:text>
						<xsl:value-of select="$sensenode/@id" />
						<xsl:text>' head synset is '</xsl:text>
						<xsl:value-of select="$head_synset_id" />
						<xsl:text>'</xsl:text>
					</xsl:message>
				</xsl:if>

				<!-- HEAD SENSE : "the sense which has an antonymy relation" /> -->
				<xsl:variable name="head_senses_with_antonym" select="$head_senses[SenseRelation/@relType = 'antonym']" />
				<xsl:if test="$debug">
					<xsl:message>
						<xsl:text>[D]   has antonym </xsl:text>
						<xsl:value-of select="count($head_senses_with_antonym)" />
						<xsl:text>: </xsl:text>
						<xsl:value-of select="$head_senses_with_antonym[1]/@id" />
					</xsl:message>
				</xsl:if>

				<xsl:choose>
					<xsl:when test="count($head_senses_with_antonym) = 1">
						<!-- return -->
						<xsl:value-of select="$head_senses_with_antonym/@id" />
					</xsl:when>
					<xsl:when test="count($head_senses_with_antonym) > 1">
						<xsl:if test="$warn">
							<xsl:message>
								<xsl:text>[W]   multiple antonyms found in head synset </xsl:text>
								<xsl:value-of select="$head_synset_id" />
								<xsl:text>, taking first of </xsl:text>
								<xsl:value-of select="count($head_senses_with_antonym)" />
								<xsl:text> members of head synset with antonyms </xsl:text>
							</xsl:message>
						</xsl:if>
						<!-- return first as sorted by @order-->
						<xsl:for-each select="$head_senses_with_antonym">
							<xsl:sort select="@order"/>
							<xsl:if test="$warn">
								<xsl:message>
									<xsl:text>      word </xsl:text>
									<xsl:value-of select="position()" />
									<xsl:text> </xsl:text>
									<xsl:value-of select="../Lemma/@writtenForm" />
									<xsl:text> </xsl:text>
									<xsl:value-of select="@id" />
									<xsl:if test='position() = 1'>
										<xsl:text> *</xsl:text>
									</xsl:if>
								</xsl:message>
							</xsl:if>
							<xsl:if test='position() = 1'>
								<xsl:value-of select="./@id" />
							</xsl:if>
					    </xsl:for-each>

					</xsl:when>
					<xsl:otherwise>
						<!-- HEAD WORD : "the lemma of the first word of the satellite's head synset" /> -->
						<xsl:if test="$warn">
							<xsl:message>
								<xsl:text>[W]   no antonym found in head synset </xsl:text>
								<xsl:value-of select="$head_synset_id" />
								<xsl:text>, taking first of </xsl:text>
								<xsl:value-of select="count($head_senses)" />
								<xsl:text> head synset member(s) </xsl:text>
							</xsl:message>
						</xsl:if>
						<!-- return -->
						<xsl:for-each select="$head_senses">
							<xsl:sort select="@order"/>
							<xsl:if test="$warn">
								<xsl:message>
									<xsl:text>      word </xsl:text>
									<xsl:value-of select="position()" />
									<xsl:text> </xsl:text>
									<xsl:value-of select="../Lemma/@writtenForm" />
									<xsl:text> </xsl:text>
									<xsl:value-of select="@id" />
									<xsl:if test='position() = 1'>
										<xsl:text> *</xsl:text>
									</xsl:if>
								</xsl:message>
							</xsl:if>
							<xsl:if test='position() = 1'>
								<xsl:value-of select="./@id" />
							</xsl:if>
					    </xsl:for-each>
					</xsl:otherwise>
				</xsl:choose>

			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template name="make-satellite-head">
		<xsl:param name="sensenode" />
		<xsl:param name="pos" />
		<xsl:param name="method" />

		<xsl:if test='$debug'>
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
				</xsl:message>
				<xsl:value-of select="':'" />
			</xsl:when>

			<xsl:otherwise>

				<!-- HEAD SENSE : "the head sense of the satellite's head synset" /> -->
				<xsl:variable name="headsenseid">
					<xsl:call-template name='make-satellite-head-sense'>
						<xsl:with-param name='sensenode' select='$sensenode' />
						<xsl:with-param name='pos' select="$pos" />
					</xsl:call-template>
				</xsl:variable>
				<!-- <xsl:variable name="headsense" select='id($headsenseid)' /> -->
				<xsl:variable name="headsense" select="key('find-sense-by-id',$headsenseid)" />

				<xsl:if test='$debug'>
					<xsl:message>
						<xsl:text>[D]   headsenseid=</xsl:text>
						<xsl:value-of select="$headsenseid" />
					</xsl:message>
				</xsl:if>

				<!-- HEAD WORD : "the lemma of the first word of the satellite's head synset" /> -->
				<xsl:variable name="lemma" select="$headsense/../Lemma/@writtenForm" />
				<xsl:variable name="headword" select="translate($lemma,' ','_')" />

				<xsl:if test='$debug'>
					<xsl:message>
						<xsl:text>[D]   headword=</xsl:text>
						<xsl:value-of select="$headword" />
					</xsl:message>
				</xsl:if>

				<!-- HEAD LEXID : "a two digit decimal integer that, when appended onto head_word, uniquely identifies the sense of head_word within a lexicographer file, as
					described for lex_id" /> -->
				<xsl:variable name="headid">
					<xsl:call-template name="make-lexid">
						<xsl:with-param name="sensenode" select="$headsense" />
						<xsl:with-param name="method" select="$method" />
					</xsl:call-template>
				</xsl:variable>

				<!-- Value -->
				<xsl:if test='$debug'>
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
