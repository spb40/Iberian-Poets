<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" 
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="2.0">
    <xsl:output indent="yes" method="xhtml"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:template match="TEI">
        <html>
            <head>
                <title>Lyrics - Medieval Galician-Portuguese Poetry</title>
                <link href="index.css" rel="stylesheet" type="text/css" />
            </head>
            <body>
                <h2>First Period</h2>
                <ul>
                    <xsl:apply-templates select="//head[name/affiliation[@corresp='1']]" mode="toc">
                        <xsl:sort select="title"></xsl:sort>
                    </xsl:apply-templates>
                    
                </ul>
                <h2>Second Period</h2>
                <ul>
                    <xsl:apply-templates select="//head[name/affiliation[@corresp='2']]" mode="toc">
                        <xsl:sort select="title"></xsl:sort>
                    </xsl:apply-templates>
                    
                </ul>
                <h2>Third Period</h2>
                <ul>
                    <xsl:apply-templates select="//head[name/affiliation[@corresp='3']]" mode="toc">
                        <xsl:sort select="title"></xsl:sort>
                    </xsl:apply-templates>
                    
                </ul>
                <h2>Fourth Period</h2>
                <ul>
                    <xsl:apply-templates select="//head[name/affiliation[@corresp='4']]" mode="toc">
                        <xsl:sort select="title"></xsl:sort>
                    </xsl:apply-templates>
                    
                </ul>
                <h2>Fifth Period</h2>
                <ul>
                    <xsl:apply-templates select="//head[name/affiliation[@corresp='5']]" mode="toc">
                        <xsl:sort select="title"></xsl:sort>
                    </xsl:apply-templates>
                    
                </ul>
                <xsl:apply-templates select="//div[head/name/affiliation[@corresp='1']]"/>
                <xsl:apply-templates select="//div[head/name/affiliation[@corresp='2']]"/>
                <xsl:apply-templates select="//div[head/name/affiliation[@corresp='3']]"/>
                <xsl:apply-templates select="//div[head/name/affiliation[@corresp='4']]"/>
                <xsl:apply-templates select="//div[head/name/affiliation[@corresp='5']]"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="head" mode="toc">
        <xsl:variable name="title" select="replace(title, ' ', '_')"/>        
        <li>
            <a id="{$title}" href="#{$title}_toc">
            <xsl:value-of select="title"/>
            <xsl:text> by </xsl:text>
            <xsl:value-of select="name/persName"/>
            </a>
        </li>
    </xsl:template>
    <xsl:template match="div">
        <xsl:variable name="title" select="replace(head/title, ' ', '_')"/>
        <h3><a id="{$title}_toc" href="#{$title}"><xsl:value-of select="head/title"/></a></h3>
        <p><xsl:apply-templates select="lg"/></p>
    </xsl:template>
    <xsl:template match="l">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
</xsl:stylesheet>