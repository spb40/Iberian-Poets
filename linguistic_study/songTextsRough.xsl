<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="2.0">
    <xsl:output indent="yes" method="xhtml"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Medieval Galician-Portuguese Poetry</title>
            </head>
            <body>
                <h1>Medieval Galician-Portuguese Poetry</h1>
                <h2>Period 1</h2>
                <ul>
                    <xsl:apply-templates select="//*:head" mode="toc"/>
                </ul>
                <hr/>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="*:affiliation[@corresp='1']" mode="toc">
        <li>
            <xsl:apply-templates select="*:affiliation[@corresp='1']/ancestor::*:title"/>
            <xsl:text> by </xsl:text>
            <xsl:apply-templates select="*:affiliation[@corresp='1']/preceding-sibling::*:persName" mode="toc"/>
            <xsl:text>: </xsl:text>
            <xsl:apply-templates select="*:affiliation"/>
        </li>
    </xsl:template>
    <xsl:template match="*:head">
        <h2><xsl:apply-templates select="*:title"/></h2>
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="*:l" mode="toc">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="*:l">
        <xsl:apply-templates/>
        <xsl:if test="following-sibling::*:l">
            <br/>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>