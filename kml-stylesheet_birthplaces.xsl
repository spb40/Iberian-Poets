<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.opengis.net/kml/2.2"
    exclude-result-prefixes="xs"
    version="2.0">    
    <xsl:output method="xml"/>  
    <xsl:template match="TEI">
        <kml>
<Document>
  <name>If this doesn't work I'll go nuts</name>  
            
        <xsl:apply-templates select="text/body/listPerson"/>
</Document>
        </kml>
    </xsl:template>
    <xsl:template match="person">
<Placemark>
    <name>
        <xsl:value-of select="persName"/>        
    </name>
    <description>
        <xsl:value-of select="birth/location/placeName"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="persName"/>
        <xsl:text>'s place of birth</xsl:text>
    </description>
    <Point>
        <coordinates>
            <xsl:value-of select="birth/location/geo"></xsl:value-of>
        </coordinates>
    </Point>
</Placemark>
    </xsl:template>
    <xsl:template match="person[@sameAs]"/>
    <xsl:template match="person[birth/location[@cert='unknown']]"/>
</xsl:stylesheet>