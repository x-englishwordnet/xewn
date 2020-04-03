<xsl:transform version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:my="https://1313ou.github.io/ewn-transform3">
	<!--  Author: Bernard Bou, Copyright (c) 2020: Bernard Bou, License: GPL3-->

	<xsl:output
		omit-xml-declaration="no"
		method="xml"
		version="1.0"
		encoding="UTF-8"
		indent="yes"
		doctype-system="http://globalwordnet.github.io/schemas/WN-LMF-relaxed-1.0.dtd" />
	<xsl:strip-space elements="*" />

	<!--  Turn to false() if the dbug section below is not to be printed to stdderr -->
	<xsl:variable name="debug" select="false()" />

	<!--  Strip lexentry ids of garbage that originates from adj position -->
	<xsl:function name="my:strip" as="xs:string">
		<xsl:param name="str" as="xs:string" />
		<xsl:sequence select="replace(replace($str,'--a$','-a'),'(-a-|-ip-|-p-|--)([sa])$', '-$2')" />
	</xsl:function>

	<!--  The group of elements that share the (stripped) id -->
	<xsl:key name="get-group" match="*[@id]" use="my:strip(@id)" />

	<!--  Start -->
	<xsl:template match="/">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<!--  Copy all except lex entries that have their own template -->
	<xsl:template match="node() | @*">
		<xsl:copy>
			<xsl:apply-templates select="node() | @*" />
		</xsl:copy>
	</xsl:template>

	<!--  Processing lexentries ... -->
	<xsl:template match="LexicalEntry">
		<!--  Stripped down id, an artifact, call it group id ... -->
		<xsl:variable name="myGID" select="my:strip(@id)" />
		<!--  Group of elements that map to the same group id ... -->
		<xsl:variable name="myGroup" select="key('get-group', $myGID)" />
		<!--  Generated id for current node ... -->
		<xsl:variable name="id1" select="generate-id()" />
		<!--  Generated id for first element in the group ... -->
		<xsl:variable name="id2" select="generate-id($myGroup[1])" />
		<!--  If id1 = id2 then the current node is the first element in the group ... -->

		<xsl:if test="$debug">
			<xsl:message>
				<xsl:text>ele=</xsl:text>
				<xsl:value-of select="./@id" />
				<xsl:text>&#xa;</xsl:text>

				<xsl:text>gid=</xsl:text>
				<xsl:value-of select="$myGID" />
				<xsl:text>&#xa;</xsl:text>

				<xsl:text>count=</xsl:text>
				<xsl:value-of select="count($myGroup)" />
				<xsl:text> group=</xsl:text>
				<xsl:for-each select="$myGroup">
					<xsl:value-of select="./@id" />
					<xsl:text> </xsl:text>
				</xsl:for-each>
				<xsl:text>&#xa;</xsl:text>
				<!-- <xsl:text>id1=</xsl:text> -->
				<!-- <xsl:value-of select="$id1" /> -->
				<!-- <xsl:text>&#xa;</xsl:text> -->
				<!-- <xsl:text>id2=</xsl:text> -->
				<!-- <xsl:value-of select="$id2" /> -->
				<!-- <xsl:text>&#xa;</xsl:text> -->
				<xsl:text>is first in group=</xsl:text>
				<xsl:value-of select="$id1 = $id2" />

				<xsl:text>&#xa;</xsl:text>
			</xsl:message>
		</xsl:if>

		<!-- If the current lexentry element is first in the group -->
		<xsl:if test="$id1 = $id2">
			<!-- Merge all elements in the group -->
			<xsl:copy>
				<!-- The group id replaces the current element id ... -->
				<xsl:attribute name="id" select="$myGID" />
				<!-- Copy unique subelements from the current node -->
				<xsl:copy-of select="./Lemma" />
				<xsl:copy-of select="./Form" />
				<!-- Copy subelements originating from the lex entries elements in the group -->
				<xsl:apply-templates select="$myGroup/Sense" />
				<xsl:apply-templates select="$myGroup/SyntacticRelation" />
			</xsl:copy>
		</xsl:if>
	</xsl:template>
</xsl:transform>
