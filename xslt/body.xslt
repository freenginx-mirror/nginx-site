<?xml version="1.0" encoding="utf-8"?>
<!--
  Copyright (C) Igor Sysoev
  Copyright (C) Nginx, Inc.
  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template name="body"><xsl:param name="lang"/>

    <body>

    <div id="main">
    <div id="menu">
        <h1>
            <a href="/">
                <img src="/nginx.png" alt="free nginx"/>
            </a>
        </h1>
        <div>
        <xsl:apply-templates select="document(concat($XML, '/menu.xml'))
                        /menus/menu[@lang = $lang]/item"/>
        </div>
    </div>

    <div id="content">
        <h2>
        <xsl:value-of select="@name"/> <xsl:if test="$YEAR"> <xsl:text>: </xsl:text> <xsl:value-of select="$YEAR"/> </xsl:if>
        </h2>

        <xsl:if test="$ORIGIN and document(concat($XML, '/', $ORIGIN))/*/@rev and
              (not(@rev) or
              @rev != document(concat($XML, '/', $ORIGIN))/*/@rev)">
            <span>

            <blockquote class="note">

            <xsl:choose><xsl:when test="document(concat($XML, '/i18n.xml'))
                           /i18n/text[@lang = $lang]/item[@id='outdated']">
                <xsl:apply-templates select="document(concat($XML, '/i18n.xml'))
                             /i18n/text[@lang = $lang]/item[@id='outdated']"/>
            </xsl:when><xsl:otherwise>
                <xsl:apply-templates select="document(concat($XML, '/i18n.xml'))
                             /i18n/text[@lang = 'en']/item[@id='outdated']"/>
            </xsl:otherwise></xsl:choose>

            </blockquote>
            </span>
        </xsl:if>

        <xsl:if test="@toc = 'yes' and section[@id and @name]">
            <table width="100%"><tr><td>
            <xsl:for-each select="section[@id and @name]">
                <a href="#{@id}"> <xsl:value-of select="@name"/> </a><br/>
                <xsl:for-each select="section[@id and @name]">
                    <xsl:text>&#160;&#160;&#160;&#160;&#160;</xsl:text>
                    <a href="#{@id}"> <xsl:value-of select="@name"/> </a><br/>
                </xsl:for-each>
                <xsl:if test="@id = 'directives'">
                    <xsl:for-each select="directive[@name]">
                        <xsl:text>&#160;&#160;&#160;&#160;&#160;</xsl:text>
                        <a href="#{@name}"> <xsl:value-of select="@name"/> </a><br/>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="@id = 'endpoints'">
                    <xsl:for-each select="para/list/tag-name[@name]">
                        <xsl:text>&#160;&#160;&#160;&#160;&#160;</xsl:text>
                        <a href="#{@id}"> <xsl:value-of select="@name"/> </a><br/>
                    </xsl:for-each>
                </xsl:if>

            </xsl:for-each>
            </td></tr></table>
        </xsl:if>

        <xsl:apply-templates/>

        <xsl:if test="@author or @editor or @translator">
            <table width="100%"><tr><td align="right">

            <xsl:if test="@author">
                <xsl:value-of select="document(concat($XML, '/i18n.xml'))
                           /i18n/text[@lang = $lang]/item[@id='author']"/>
                <xsl:text> </xsl:text> <xsl:value-of select="@author"/> <br/>
            </xsl:if>

            <xsl:if test="@editor">
                <xsl:value-of select="document(concat($XML, '/i18n.xml'))
                           /i18n/text[@lang = $lang]/item[@id='editor']"/>
                <xsl:text> </xsl:text> <xsl:value-of select="@editor"/> <br/>
            </xsl:if>

            <xsl:if test="@translator">
                <xsl:value-of select="document(concat($XML, '/i18n.xml'))
                           /i18n/text[@lang = $lang]/item[@id='translator']"/>
                <xsl:text> </xsl:text> <xsl:value-of select="@translator"/> <br/>
            </xsl:if>

            </td></tr></table>
        </xsl:if>
    </div>
    </div>
    </body>

</xsl:template>

</xsl:stylesheet>
