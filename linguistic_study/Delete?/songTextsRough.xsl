<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="2.0">
    <xsl:output indent="yes" method="xhtml"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:template match="TEI">
        <html>
            <head>
                <title>Medieval Galician-Portuguese Poetry</title>
            </head>
            <body>
                <h1>Medieval Galician-Portuguese Poetry</h1>
                <h2>Song List</h2>
                
                <h3>Period 1</h3>
                <ul>
                    <xsl:apply-templates select="//*:name[@corresp='per1']" mode="toc"/>
                </ul>
                <xsl:apply-templates/>
                
                <h3>Period 2</h3>
                <ul>
                    <xsl:apply-templates select="//*:name[@corresp='per2']" mode="toc"/>
                </ul>
                <xsl:apply-templates/>
                
                <h3>Period 3</h3>
                <ul>
                    <xsl:apply-templates select="//*:name[@corresp='per3']" mode="toc"/>
                </ul>
                <xsl:apply-templates/>
                
                <h3>Period 4</h3>
                <ul>
                    <xsl:apply-templates select="//*:name[@corresp='per4']" mode="toc"/>
                </ul>
                <xsl:apply-templates/>
                
                <h3>Period 5</h3>
                <ul>
                    <xsl:apply-templates select="//*:name[@corresp='per5']" mode="toc"/>
                </ul>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <!--Here be the list items -->
    
    <xsl:template match="*:name[@corresp='per1']" mode="toc">
        <li>
            <xsl:apply-templates select="following-sibling::*:title"/>
            <xsl:text> by </xsl:text>
            <xsl:apply-templates select="*:persName" mode="toc"/>
        </li>
    </xsl:template>
    
    <xsl:template match="*:name[@corresp='per2']" mode="toc">
        <li>
            <xsl:apply-templates select="following-sibling::*:title"/>
            <xsl:text> by </xsl:text>
            <xsl:apply-templates select="*:persName" mode="toc"/>
        </li>
    </xsl:template>
    
    <xsl:template match="*:name[@corresp='per3']" mode="toc">
        <li>
            <xsl:apply-templates select="following-sibling::*:title"/>
            <xsl:text> by </xsl:text>
            <xsl:apply-templates select="*:persName" mode="toc"/>
        </li>
    </xsl:template>
    
    <xsl:template match="*:name[@corresp='per4']" mode="toc">
        <li>
            <xsl:apply-templates select="following-sibling::*:title"/>
            <xsl:text> by </xsl:text>
            <xsl:apply-templates select="*:persName" mode="toc"/>
        </li>
    </xsl:template>
    
    <xsl:template match="*:name[@corresp='per5']" mode="toc">
        <li>
            <xsl:apply-templates select="following-sibling::*:title"/>
            <xsl:text> by </xsl:text>
            <xsl:apply-templates select="*:persName" mode="toc"/>
        </li>
    </xsl:template>
    
</xsl:stylesheet>