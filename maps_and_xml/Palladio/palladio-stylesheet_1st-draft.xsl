<?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        exclude-result-prefixes="xs"
        version="2.0">        
        <xsl:output method="text"/>
        
        <xsl:template match="TEI">
            <xsl:apply-templates select="text/body/listPerson"/>     
        </xsl:template>
        
        <xsl:template match="person">
            <xsl:variable name="floruitGeo">
                <xsl:value-of
                    select="//back//place[@xml:id = current()/floruit/location[1]/substring(@corresp, 2)]//geo"/>
            </xsl:variable>
            <xsl:value-of select="persName"/>
            <xsl:text>;</xsl:text>
        <xsl:value-of select="birth/location[1]/geo"/>
        <xsl:text>;</xsl:text>
        <xsl:choose>
            <xsl:when test="floruit/location/geo">
                <xsl:value-of select="floruit/location[1]/geo"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$floruitGeo"/>
            </xsl:otherwise>
        </xsl:choose>
            <xsl:text>;</xsl:text>
            <xsl:value-of select="floruit/@from"/>
            <xsl:text>;</xsl:text>
            <xsl:value-of select="floruit/@to"/>
        </xsl:template>
</xsl:stylesheet>