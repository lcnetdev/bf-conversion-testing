<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:marc="http://www.loc.gov/MARC21/slim" 
    exclude-result-prefixes="xs"
    version="1.0">
 
    <xsl:output encoding="UTF-8" indent="yes" method="text"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="//marc:collection">
                    <xsl:for-each select="//marc:collection/marc:record">
                            <xsl:call-template name="marcRecord"/>
                    </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select="//marc:record">
                    <xsl:call-template name="marcRecord"/>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="marcRecord">
        <xsl:apply-templates select="marc:leader" />
        <xsl:apply-templates select="marc:controlfield" />
        <xsl:apply-templates select="marc:datafield" />
    </xsl:template>
    
    <xsl:template match="marc:leader">
        <xsl:value-of select="."/><xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="marc:controlfield">
        <xsl:value-of select="@tag"/><xsl:text>    </xsl:text><xsl:value-of select="."/><xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="marc:datafield">
        <xsl:value-of select="@tag"/><xsl:text> </xsl:text>
        <xsl:value-of select="@ind1"/><xsl:value-of select="@ind2"/><xsl:text> </xsl:text>
        <xsl:for-each select="marc:subfield">$<xsl:value-of select="@code"/><xsl:value-of select="."/></xsl:for-each>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
</xsl:stylesheet>