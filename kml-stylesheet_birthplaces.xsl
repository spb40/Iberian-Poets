<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.opengis.net/kml/2.2"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml"/>
    <xsl:template match="TEI">
        <kml>
            <Document>
                <name>Trial</name>
                <Style id="thickBlackLine">
                <LineStyle>
                    <color>87000000</color>
                    <width>10</width>
                </LineStyle>
                </Style>
                <xsl:apply-templates select="text"/>
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
            <Style>
                <IconStyle>
                    <Icon><href>http://maps.google.com/mapfiles/kml/paddle/purple-stars.png</href></Icon>
                </IconStyle>
            </Style>
            <Point>
                <coordinates>                    
                    <xsl:value-of select="birth/location/geo"/>
                </coordinates>
            </Point>
        </Placemark>
        <Placemark>
            <styleUrl></styleUrl>     
            <LineString>          
                <tessellate>0</tessellate>
                <coordinates>
                    <xsl:value-of select="birth/location/geo"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="floruit/location/geo"/>
                </coordinates>
            </LineString>
        </Placemark>  
    </xsl:template>
    
    <xsl:template match="place">
        <Placemark>
            <name>
                <xsl:value-of select="location/placeName"/>
            </name>
            <description>Place of Activity</description>
            <Style>
                <IconStyle>
                    <Icon><href>http://maps.google.com/mapfiles/kml/paddle/red-circle.png</href></Icon>
                </IconStyle>
            </Style>
            <Point>
                <coordinates>
                    <xsl:value-of select="location/geo"/>
                </coordinates>
            </Point>
        </Placemark>
    </xsl:template>
</xsl:stylesheet>
