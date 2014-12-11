<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/2000/svg"
    version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all">
    <xsl:output indent="yes"/>


    <xsl:variable name="barWidth" select="40"/>
    <xsl:variable name="barInterval" select="$barWidth + 10"/>
    <xsl:variable name="barHeight" select="300"/>
    <xsl:variable name="barShift" select="22"/>
    <xsl:template match="/">
        <svg height="400">
            <g transform="translate(30, 330)">
                <!--
                    The height of the y axis is hard-coded
                    The length of the x axis is calculated according to the number of states
                    There's a dashed line at 50% on the y axis
                -->
                <line x1="20" x2="20" y1="0" y2="-320" stroke="black" stroke-width="1"/>
                <line x1="20" x2="{count(//period)*$barInterval + 20}" y1="0" y2="0" stroke="black"
                    stroke-width="1"/>
                <line x1="{20}" x2="{count(//period)*$barInterval + 20}" y1="-{$barHeight div 2}"
                    y2="-{$barHeight div 2}" stroke="black" opacity="0.5" stroke-dasharray="8 4"
                    stroke-width="1"/>
                <text x="10" y="5" text-anchor="end" fill="white">0%</text>
                <text x="10" y="{5 - $barHeight div 2}" text-anchor="end" fill="white">50%</text>
                <text x="10" y="{5 - $barHeight}" text-anchor="end" fill="white">100%</text>
                <xsl:apply-templates select="//period"/>
            </g>
        </svg>
    </xsl:template>
    <xsl:template match="period">
        <xsl:variable name="pronPos" select="position()-1"/>
        <xsl:variable name="xPosition" select="$pronPos*$barInterval"/>
        <xsl:variable name="totalPron" select="sum(pronoun[@type='total'])"/>
        <xsl:variable name="archVotes" select="sum(pronoun[@type='archaic'])"/>
        <xsl:variable name="archPer" select="$archVotes div $totalPron"/>
        <xsl:variable name="modVotes" select="sum(pronoun[@type='modern'])"/>
        <xsl:variable name="modPer" select="$modVotes div $totalPron"/>
        <xsl:variable name="type" select="@type"/>
        <rect x="{$xPosition + $barShift}" y="-{$barHeight}" stroke="black" stroke-width=".5"
            fill="#D45710" width="{$barWidth}" height="{$barHeight}"/>
        <rect x="{$xPosition + $barShift}" y="-{$archPer * $barHeight}" stroke="black"
            stroke-width=".5" fill="#FFED67" width="{$barWidth}" height="{$archPer*$barHeight}"/>
        <text x="{$xPosition+ $barShift + 20}" y="-{($archPer * $barHeight)-20}"
            text-anchor="middle">
            <xsl:value-of select='format-number(($archPer), "#%")'/>
        </text>
        <text x="{$xPosition + $barShift +20}" y="-{$barHeight - 20}" text-anchor="middle">
            <xsl:value-of select='format-number(($modPer), "#%")'/>
        </text>
        <xsl:choose>
            <xsl:when test="position() = last()">
                <text x="{$xPosition - position()}" y="{35 * position()}" text-anchor="middle"
                    transform="rotate(-40 20,40)" fill="white"><xsl:value-of select="@num"/>
                </text>
            </xsl:when>
            <xsl:otherwise>
                <text x="{$xPosition - (position()* 8)}" y="{35 * position()}" text-anchor="start"
                    transform="rotate(-40 20,40)" fill="white">Period <xsl:value-of select="@num"/>
                </text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
