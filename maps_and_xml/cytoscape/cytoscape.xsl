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
    <xsl:template match="person[@xml:id]">
        <xsl:value-of select="string-join((@xml:id, nationality/@key, floruit/@period, occupation/@key, floruit/location[1]/@corresp), ';')"/>
        <xsl:text>
        </xsl:text>
        <xsl:value-of select="current()[count(floruit/location) gt 1]/string-join((@xml:id, nationality/@key, floruit/@period, occupation/@key, floruit/location[2]/@corresp), ';')"/>
        <xsl:text>            
        </xsl:text>
        <xsl:value-of select="current()[count(floruit/location) gt 2]/string-join((@xml:id, nationality/@key, floruit/@period, occupation/@key, floruit/location[3]/@corresp), ';')"/>
        <xsl:text>            
        </xsl:text>
        <xsl:value-of select="current()[count(floruit/location) gt 3]/string-join((@xml:id, nationality/@key, floruit/@period, occupation/@key, floruit/location[4]/@corresp), ';')"/>
    </xsl:template>
    <xsl:template match="person[@sameAs]"/>
</xsl:stylesheet>