<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.opengis.net/kml/2.2"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="TEI">
        <kml>
            <Document>
                <name>Trial</name>
                <Style id="BlackLine">
                    <LineStyle>
                        <color>87000000</color>
                        <width>6</width>
                    </LineStyle>
                </Style>
                <Style id="GreyLine">
                    <LineStyle>
                        <color>50BEBEBE</color>
                        <width>4</width>
                    </LineStyle>
                </Style>
                <xsl:apply-templates select="text"/>
            </Document>
        </kml>
    </xsl:template>
    <!--    <xsl:variable name="corresp">
        <xsl:text>#</xsl:text>
        <xsl:value-of select="back/ab/listPlace/place/string(@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="ID">
        <xsl:value-of
            select="substring-after((body/listPerson/person/floruit/location/string(@corresp)), '#')"
        />
    </xsl:variable>
    <xsl:variable name="floruitGeo">
        <xsl:for-each select="location[string(@corresp) = $corresp]">
            <xsl:value-of select="back/ab/listPlace/place[@xml:id = $ID]/location/geo"/>
        </xsl:for-each>
    </xsl:variable>-->

    <xsl:template match="person">
        <xsl:variable name="floruitGeo">
            <xsl:value-of
                select="//back//place[@xml:id = current()/floruit/location/@corresp/substring(.,2)]//geo"
            />
        </xsl:variable>
        <Placemark>
            <name>
                <xsl:value-of select="persName"/>
            </name>
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
            <xsl:choose>
                <xsl:when test="floruit/location[@cert='low']">
                    <styleUrl>#GreyLine</styleUrl>
                </xsl:when>
                <xsl:otherwise>
                    <styleUrl>#BlackLine</styleUrl>
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
        </Placemark>
    </xsl:template>

    <xsl:template match="place">
        <Placemark>
            <name>
                <xsl:value-of select="location/placeName[@type='short']"/>
            </name>
            <description>
                <xsl:value-of select="location/placeName[@type='full']"/>
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

    <xsl:template match="floruit">
        <Placemark>
            <name>
                <xsl:value-of select="location/placeName"/>
            </name>
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
