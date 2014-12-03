<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output indent="yes" method="xhtml"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:template match="TEI">
        <html>
            <head>
                <title>Lyrics - Medieval Galician-Portuguese Poetry</title>
                <link href="index.css" rel="stylesheet" type="text/css"/>
            </head>
            <body>
                <h2>First Period</h2>
                <ul>
                    <xsl:apply-templates select="//head[name/affiliation[@corresp='1']]" mode="toc">
                        <xsl:sort select="name/persName"/>
                    </xsl:apply-templates>
                </ul>
                <h2>Second Period</h2>
                <ul>
                    <xsl:apply-templates select="//head[name/affiliation[@corresp='2']]" mode="toc">
                        <xsl:sort select="name/persName"/>
                    </xsl:apply-templates>
                </ul>
                <h2>Third Period</h2>
                <ul>
                    <xsl:apply-templates select="//head[name/affiliation[@corresp='3']]" mode="toc">
                        <xsl:sort select="name/persName"/>
                    </xsl:apply-templates>
                </ul>
                <h2>Fourth Period</h2>
                <ul>
                    <xsl:apply-templates select="//head[name/affiliation[@corresp='4']]" mode="toc">
                        <xsl:sort select="name/persName"/>
                    </xsl:apply-templates>
                </ul>
                <h2>Fifth Period</h2>
                <ul>
                    <xsl:apply-templates select="//head[name/affiliation[@corresp='5']]" mode="toc">
                        <xsl:sort select="name/persName"/>
                    </xsl:apply-templates>
                </ul>
                <xsl:apply-templates select="//div"/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="head" mode="toc">
        <li>
            <a id="{generate-id(title)}" href="#{generate-id(title)}_toc">
                <xsl:value-of select="title"/>
            </a>
            <xsl:text> by </xsl:text>
            <xsl:value-of select="name/persName"/>
        </li>
    </xsl:template>
    <xsl:template match="div">
        <h3>
            <a id="{generate-id(head/title)}_toc" href="#{generate-id(head/title)}">
                <xsl:value-of select="head/title"/>
            </a>
        </h3>
        <h4>by</h4>
        <h3>
            <xsl:value-of select="head/name/persName"/>
        </h3>
        <p>
            <xsl:apply-templates select="lg"/>
        </p>
    </xsl:template>
    <xsl:template match="lg[@type]">
        <span class="{@type}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="l">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="w">
        <xsl:if
            test="current()[substring(@ana,2) = /TEI/text/back/ab//fs[tokenize(@feats/string(),'\s') = '#modern']/@xml:id]">
            <span class="modern">
                <xsl:apply-templates/>
            </span>
        </xsl:if>
        <xsl:if
            test="current()[substring(@ana,2) = /TEI/text/back/ab//fs[tokenize(@feats/string(),'\s') = '#archaic']/@xml:id]">
            <span class="archaic">
                <xsl:apply-templates/>
            </span>
        </xsl:if>        
    </xsl:template>
</xsl:stylesheet>
