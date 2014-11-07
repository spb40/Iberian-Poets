<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.opengis.net/kml/2.2"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="TEI">
        <kml>
            <Document>
                <name>Mapping the Medieval Galician-Portuguese Poetry</name>
                <TimeSpan>
                    <begin>1165-01-01</begin>
                    <end>1485-01-01</end>
                </TimeSpan>
                <Style id="WhiteLine">
                    <LineStyle>
                        <color>50FFFFFF</color>
                        <width>3</width>
                    </LineStyle>
                </Style>
                <Style id="purpleLine">
                    <LineStyle>
                        <color>50FF78B4</color>
                        <width>3</width>
                    </LineStyle>
                </Style>
                <xsl:apply-templates select="text"/>
            </Document>
        </kml>
    </xsl:template>
    <xsl:template match="person">
        <xsl:variable name="floruitGeo">
            <xsl:value-of
                select="//back//place[@xml:id = current()/floruit/location/substring(@corresp, 2)]//geo"
            />
        </xsl:variable>
        <Placemark>
            <name>
                <xsl:value-of select="persName"/>
            </name>
            <TimeSpan>
                <begin>
                    <xsl:value-of select="floruit/@from"/>
                    <xsl:text>-01-01</xsl:text>
                </begin>
                <end>
                    <xsl:value-of select="floruit/@to"/>
                    <xsl:text>-01-01</xsl:text>
                </end>
            </TimeSpan>
            <description>
                <xsl:choose>
                    <xsl:when test="birth/location/not(placeName)">
                        <xsl:text>Place of birth unknown</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="birth/location/placeName"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="persName"/>
                        <xsl:text>'s place of birth</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </description>
            <Style>
                <IconStyle>
                    <xsl:choose>
                        <xsl:when test="birth[@cert='low']">
                            <Icon>
                                <href>http://maps.google.com/mapfiles/kml/paddle/ltblu-blank.png</href>
                            </Icon>
                        </xsl:when>
                        <xsl:when
                            test="birth/location[@cert='unknown'] | birth/location[@cert='low']">
                            <Icon>
                                <href>http://maps.google.com/mapfiles/kml/paddle/ltblu-blank.png</href>
                            </Icon>
                        </xsl:when>
                        <xsl:otherwise>
                            <Icon>
                                <href>http://maps.google.com/mapfiles/kml/paddle/purple-stars.png</href>
                            </Icon>
                        </xsl:otherwise>
                    </xsl:choose>
                </IconStyle>
            </Style>
            <Point>
                <coordinates>
                    <xsl:value-of select="birth/location/geo"/>
                </coordinates>
            </Point>
        </Placemark>
        <Placemark>
            <TimeSpan>
                <begin>
                    <xsl:value-of select="floruit/@from"/>
                    <xsl:text>-01-01</xsl:text>
                </begin>
                <end>
                    <xsl:value-of select="floruit/@to"/>
                    <xsl:text>-01-01</xsl:text>
                </end>
            </TimeSpan>
            <description>
                <xsl:value-of select="persName"/>
                <xsl:text>'s journey</xsl:text>
            </description>
            <xsl:choose>
                <xsl:when test="floruit/location[@cert='low']">
                    <styleUrl>#purpleLine</styleUrl>
                </xsl:when>
                <xsl:otherwise>
                    <styleUrl>#WhiteLine</styleUrl>
                </xsl:otherwise>
            </xsl:choose>
            <LineString>
                <tessellate>0</tessellate>
                <coordinates>
                    <xsl:value-of select="birth/location/geo"/>
                    <xsl:text> </xsl:text>
                    <xsl:choose>
                        <xsl:when test="floruit/location/geo">
                            <xsl:value-of select="floruit/location/geo"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$floruitGeo"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </coordinates>
            </LineString>
            <xsl:if test="floruit[not(location/@corresp)]">
                <xsl:apply-templates select="floruit[not(location/@corresp)]"/>
            </xsl:if>
        </Placemark>        
    </xsl:template>
    <xsl:template
        match="place">
        <Placemark>
            <name>
                <xsl:value-of select="location/placeName[@type='short']"/>
            </name>
            <TimeSpan>
                <begin>
                    <xsl:text>-01-01</xsl:text>
                </begin>
                <end>
                    <xsl:text>-01-01</xsl:text>
                </end>
            </TimeSpan>
            <description>
                <xsl:value-of select="location/placeName[@type='full']"/>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="current()/@type"/>
                <xsl:text> court)</xsl:text>
            </description>
            <Style>
                <IconStyle>
                    <Icon>
                        <href>http://maps.google.com/mapfiles/kml/paddle/red-circle.png</href>
                    </Icon>
                </IconStyle>
            </Style>
            <Point>
                <coordinates>
                    <xsl:value-of select="location/geo"/>
                </coordinates>
            </Point>
        </Placemark>
    </xsl:template>

    <xsl:template match="floruit[not(location/@corresp)]">
        <Placemark>
            <name>
                <xsl:value-of select="location/placeName"/>
            </name>
            <TimeSpan>
                <begin>
                   <xsl:text>-01-01</xsl:text>
                </begin>
                <end>
                    <xsl:text>-01-01</xsl:text>
                </end>
            </TimeSpan>
            <description>
                <xsl:value-of select="location/placeName"/>
            </description>
            <Style>
                <IconStyle>
                    <xsl:choose>
                        <xsl:when test="location[@cert='unknown']">
                            <Icon>
                                <href>http://maps.google.com/mapfiles/kml/paddle/pink-blank.png</href>
                            </Icon>
                        </xsl:when>
                        <xsl:otherwise>
                            <Icon>
                                <href>http://maps.google.com/mapfiles/kml/paddle/red-circle.png</href>
                            </Icon>
                        </xsl:otherwise>
                    </xsl:choose>
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
