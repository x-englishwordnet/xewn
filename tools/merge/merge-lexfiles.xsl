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

		<LexicalResource 
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
			xsi:schemaLocation=". https://x-englishwordnet.github.io/schemas/1.10/xEWN-LMF-1.10.xsd"
			xmlns:dc="http://purl.org/dc/elements/1.1/">
			<Lexicon 
				id="ewn" 
				label="English WordNet" 
				version="2019" 
				language="en" 
				email="john@mccr.ae" 
				license="https://wordnet.princeton.edu/license-and-commercial-use"
				url="https://github.com/globalwordnet/english-wordnet" 
				confidenceScore="1.0">

				<!-- S Y N T A T I C B E H A V I O U R -->
				<xsl:merge>
					<xsl:merge-source for-each-item="$docs" sort-before-merge="true" select="/LexicalResource/Lexicon/SyntacticBehaviour">
						<xsl:merge-key select="@id" order="ascending" />
					</xsl:merge-source>
					<xsl:merge-action>
						<xsl:sequence select="current-merge-group()[1]" />
					</xsl:merge-action>
				</xsl:merge>

				<!-- L E X I C A L E N T R Y -->
				<!-- use /LexicalResource/Lexicon/LexicalEntry[@id='ewn-abandon-v'] for a simple example -->
				<!-- this is to yield: -->
				<!-- from wn-verb.possession: -->
				<!-- <Sense id="ewn-abandon-v-02232523-01" n="1" synset="ewn-02232523-v" dc:identifier="abandon%2:40:01::" /> 2 give up with the intent of never claiming again -->
				<!-- <Sense id="ewn-abandon-v-02232813-01" n="0" synset="ewn-02232813-v" dc:identifier="abandon%2:40:00::" /> 1 forsake, leave behind -->
				<!-- from wn-verb.motion: -->
				<!-- <Sense id="ewn-abandon-v-02080923-03" n="2" synset="ewn-02080923-v" dc:identifier="abandon%2:38:00::" /> 3 leave behind empty; ... -->
				<!-- from wn-verb.cognition: -->
				<!-- <Sense id="ewn-abandon-v-00614907-01" n="3" synset="ewn-00614907-v" dc:identifier="abandon%2:31:01::" /> 4 stop maintaining or insisting on; ... -->
				<!-- <Sense id="ewn-abandon-v-00615748-01" n="4" synset="ewn-00615748-v" dc:identifier="abandon%2:31:00::" /> 5 leave someone who needs or counts on you; ... -->

				<xsl:merge>
					<xsl:merge-source for-each-item="$docs" sort-before-merge="true" select="/LexicalResource/Lexicon/LexicalEntry">
						<xsl:merge-key select="@id" order="ascending" />
					</xsl:merge-source>
					<xsl:merge-action>
						<xsl:variable name="group" select="current-merge-group()" />
						<xsl:variable name="first" select="current-merge-group()[1]" />
						<xsl:choose>

							<xsl:when test="count($group) = 1">
								<xsl:if test='$debug = true()'>
									<xsl:message>
										<xsl:text>Singly defined </xsl:text>
										<xsl:value-of select="current-merge-key()" />
									</xsl:message>
								</xsl:if>

								<xsl:choose>
									<xsl:when test='$fromtag = true()'>
										<xsl:element name="LexicalEntry">
											<xsl:attribute name="id"><xsl:value-of select="current-merge-key()" /></xsl:attribute>
											<xsl:copy-of select="$first/Lemma" />
											<xsl:copy-of select="$first/Form" />
											<xsl:for-each select="$group/Sense">
												<xsl:sort select="./@n" />
												<xsl:copy select=".">
													<xsl:attribute name="lexfile">
														<xsl:value-of select="substring-after(substring-before(replace(base-uri(.), '.*/', '') , '.xml'),'wn-')" />
													</xsl:attribute>
													<xsl:copy-of select="./@*" />
													<xsl:copy-of select="./*" />
												</xsl:copy>
											</xsl:for-each>
										</xsl:element>
									</xsl:when>
									<xsl:otherwise>
										<xsl:copy-of select="$first" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:when>

							<xsl:otherwise>
								<xsl:if test='$debug = true()'>
									<xsl:message>
										<xsl:text>Multiply defined </xsl:text>
										<xsl:value-of select="current-merge-key()" />
										<xsl:text> (</xsl:text>
										<xsl:value-of select="count($group)" />
										<xsl:text> sources:</xsl:text>
										<xsl:for-each select="$group">
											<xsl:text> </xsl:text>
											<xsl:value-of select="substring-after(substring-before(replace(base-uri(.), '.*/', '') , '.xml'),'wn-')" />
										</xsl:for-each>
										<xsl:text>)</xsl:text>
									</xsl:message>
								</xsl:if>

								<xsl:element name="LexicalEntry">
									<xsl:attribute name="id"><xsl:value-of select="current-merge-key()" /></xsl:attribute>
									<xsl:copy-of select="$first/Lemma" />
									<xsl:copy-of select="$first/Form" />
									<xsl:choose>
										<xsl:when test='$fromtag = true()'>
											<xsl:for-each select="$group/Sense">
											    <xsl:sort select="./@n" />
												<xsl:copy select=".">
													<xsl:attribute name="lexfile">
														<xsl:value-of select="substring-after(substring-before(replace(base-uri(.), '.*/', '') , '.xml'),'wn-')" />
													</xsl:attribute>
													<xsl:copy-of select="./@*" />
													<xsl:copy-of select="./*" />
												</xsl:copy>
											</xsl:for-each>
										</xsl:when>
										<xsl:otherwise>
											<xsl:sequence select="$group/Sense" />
										</xsl:otherwise>
									</xsl:choose>
								</xsl:element>
							</xsl:otherwise>

						</xsl:choose>
					</xsl:merge-action>
				</xsl:merge>

				<!-- S Y N S E T -->
				<xsl:merge>
					<xsl:merge-source for-each-item="$docs" sort-before-merge="true" select="/LexicalResource/Lexicon/Synset">
						<xsl:merge-key select="@id" order="ascending" />
					</xsl:merge-source>
					<xsl:merge-action>
						<xsl:variable name="group" select="current-merge-group()" />
						<xsl:variable name="first" select="current-merge-group()[1]" />
						<xsl:choose>
							<xsl:when test="count($group) = 1">
								<xsl:sequence select="$first" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:message>
									<xsl:text>Multiple definition of synset </xsl:text>
									<xsl:value-of select="current-merge-key()" />
								</xsl:message>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:merge-action>
				</xsl:merge>

			</Lexicon>
		</LexicalResource>
	</xsl:template>

</xsl:transform>
