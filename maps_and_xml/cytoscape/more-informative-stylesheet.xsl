<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    
    <xsl:output method="text"/>
    <xsl:template match="TEI">
        <xsl:apply-templates select="//person"/>
    </xsl:template>
    <xsl:template match="person">
        <xsl:apply-templates select="floruit/location"/>
    </xsl:template>        
    <xsl:template match="location">
        <xsl:choose>
            <xsl:when test="./@corresp">
            <xsl:value-of
                select="concat(ancestor::person/persName, ';', ancestor::person/nationality/@key, ';', parent::floruit/@period, ';',
                following::place[@xml:id = current()/substring(@corresp, 2)]/location/placeName[@type='short'], ';', following::place[@xml:id = current()/substring(@corresp, 2)]/@type , '&#x0a;')"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of
                select="concat(ancestor::person/persName,';', ancestor::person/nationality/@key, ';', parent::floruit/@period, ';',
                placeName, ';', @type,'&#x0a;')"
            />
        </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    <xsl:template match="place"/>
</xsl:stylesheet>
