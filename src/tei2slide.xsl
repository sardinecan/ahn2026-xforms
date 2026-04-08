<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:file="http://expath.org/ns/file"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="xs tei eg"
    version="3.0">
    
    <xsl:output method="xml" indent="yes" omit-xml-declaration="true"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="tei:TEI" mode="form"/>
        <xsl:apply-templates select="descendant::tei:div[@type='slide']"/>
    </xsl:template>
    
    <xsl:variable name="title" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
    
    <xsl:template match="tei:TEI" mode="form">
        <xsl:result-document href="index.xhtml">
            <xsl:processing-instruction name="xml-stylesheet" >href="../assets/xsltforms/xsltforms.xsl" type="text/xsl"</xsl:processing-instruction>
            <html
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xf:bogus="fix/Firefox/namespace/issue"
                xmlns:ev="http://www.w3.org/2001/xml-events"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xs:bogus="fix/Firefox/namespace/issue"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xlink:bogus="fix/Firefox/namespace/issue"
                xmlns:etp="http://ethap2025/ns/1.0"
                etp:bogus="fix/Firefox/namespace/issue"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                tei:bogus="fix/Firefox/namespace/issue"
                xmlns:x="http://www.w3.org/1999/xhtml"
                lang="fr">
                <head>
                    <meta name="viewport" content="initial-scale=1, width=device-width, viewport-fit=cover" charset="utf8"/>
                    <title><xsl:apply-templates select="$title"></xsl:apply-templates></title>
                    <link rel="stylesheet" href="../assets/css/main.css" type="text/css"/>
                    <model xmlns="http://www.w3.org/2002/xforms">
                        <instance id="tutorial">
                            <tutorial>
                                <xsl:for-each select="descendant::tei:div[@type='slide']">
                                    <entry>
                                        <title><xsl:value-of select="./tei:head"/></title>
                                        <file>slide<xsl:value-of select="position()"/>.xhtml</file>
                                    </entry>
                                </xsl:for-each>
                            </tutorial>
                        </instance>
                        <instance id="nav">
                            <nav xmlns="">
                                <base></base>
                                <file/>
                                <url/>
                            </nav>
                        </instance>
                        <bind ref="instance('nav')/url" calculate="concat(../base, ../file)"/>
                        <submission id="save" ref="instance('nav')" resource="nav.xml" method="put" replace="none"/>
                        <submission id="restore" replace="instance" instance="nav" resource="nav.xml" method="get"
                            serialization="none"/>
                        <action ev:event="xforms-ready">
                            <setvalue ref="instance('nav')/file" value="instance('tutorial')/entry[1]/file"/>
                            <send submission="restore"/>
                        </action>
                    </model>
                </head>
                <body>
                    <group xmlns="http://www.w3.org/2002/xforms">
                        <!--<switch>
                <case id="hide">
                    <trigger class="block" appearance="minimal">
                        <label>▸ XForms Hands-On Tutorial</label>
                        <toggle case="show" ev:event="DOMActivate"/>
                    </trigger>
                </case>
                <case id="show">
                    <trigger appearance="minimal">
                        <label>▾ XForms Hands-On Tutorial</label>
                        <toggle case="hide" ev:event="DOMActivate"/>
                    </trigger>
                    <select1 class="block" ref="instance('nav')/file" appearance="full">
                        <itemset ref="instance('tutorial')/entry">
                            <label ref="title"/>
                            <value value="file"/>
                        </itemset>
                    </select1>
                </case>
            </switch>-->
                        <action ev:event="xforms-value-changed"> <!-- Only for the value of 'show' -->
                            <send submission="save"/> <!-- if it succeeds great; if it fails, too bad -->
                        </action>
                        <group>
                            <trigger ref="instance('tutorial')/entry[file=instance('nav')/file]/preceding-sibling::entry[1]">
                                <label>←<!--🡰--></label>
                                <hint>
                                    <output ref="title"/>
                                </hint>
                                <setvalue ref="instance('nav')/file"
                                    value="context()/file"
                                    ev:event="DOMActivate"/>
                            </trigger>
                            <select1 ref="instance('nav')/file" appearance="{{instance('nav')/appearance}}">
                                <itemset ref="instance('tutorial')/entry">
                                    <label ref="title"/>
                                    <value value="file"/>
                                </itemset>
                            </select1>
                            <trigger ref="instance('tutorial')/entry[file=instance('nav')/file]/following-sibling::entry">
                                <label>→<!--🡲--></label>
                                <hint>
                                    <output ref="title"/>
                                </hint>
                                <setvalue ref="instance('nav')/file"
                                    value="context()/file"
                                    ev:event="DOMActivate"/>
                            </trigger>
                        </group>
                        <h:iframe id="whyisthisneeded" src="{{instance('nav')/url}}"></h:iframe>
                    </group>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:TEI" mode="nav">
        
    </xsl:template>
    
    <xsl:template match="tei:div[@type='slide'][not(@subtype)]">
        <xsl:variable name="n">
            <xsl:number count="tei:div[@type='slide']" from="tei:body" level="any"/>
        </xsl:variable>
        <xsl:result-document href="slide{$n}.xhtml" method="xhtml" doctype-public="'-//W3C//DTD XHTML 1.0 Strict//EN'" doctype-system="'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'">
            <html xmlns="http://www.w3.org/1999/xhtml">
                <head>
                    <meta charset="utf-8"/>
                    <title><xsl:apply-templates select="$title"/></title>
                    <link rel="stylesheet" href="../assets/css/main.css" type="text/css"/>
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.0.1/styles/atom-one-dark-reasonable.min.css" integrity="sha512-RwXJS3k4Z0IK6TGoL3pgQlA9g2THFhKL7z9TYWdAI8u6xK0AUuMWieJuWgTRayywC9A94ifUj1RzjDa1NIlUIg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
                    <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js">/**/</script>
                </head>
                <body>
                    <main class="slide">
                        <xsl:apply-templates/>
                    </main>
                    <script>hljs.highlightAll();</script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='slide'][@subtype = 'xforms']">
        <xsl:variable name="n">
            <xsl:number count="tei:div[@type='slide']" from="tei:body" level="any"/>
        </xsl:variable>
        <xsl:result-document href="slide{$n}.xhtml">
            <xsl:processing-instruction name="xml-stylesheet" >href="../assets/xsltforms/xsltforms.xsl" type="text/xsl"</xsl:processing-instruction>
            <html
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xf="http://www.w3.org/2002/xforms"
                xf:bogus="fix/Firefox/namespace/issue"
                xmlns:ev="http://www.w3.org/2001/xml-events"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xs:bogus="fix/Firefox/namespace/issue"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xlink:bogus="fix/Firefox/namespace/issue"
                xmlns:etp="http://ethap2025/ns/1.0"
                etp:bogus="fix/Firefox/namespace/issue"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                tei:bogus="fix/Firefox/namespace/issue"
                xmlns:x="http://www.w3.org/1999/xhtml"
                lang="fr">
                <head>
                    <meta charset="utf-8"/>
                    <title><xsl:apply-templates select="$title"/></title>
                    <link rel="stylesheet" href="../assets/css/main.css" type="text/css"/>
                    <link rel="stylesheet" href="../assets/css/tei.css" type="text/css"/>
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.0.1/styles/atom-one-dark-reasonable.min.css" integrity="sha512-RwXJS3k4Z0IK6TGoL3pgQlA9g2THFhKL7z9TYWdAI8u6xK0AUuMWieJuWgTRayywC9A94ifUj1RzjDa1NIlUIg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
                    <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js">/**/</script>
                    <script src="../assets/js/generateid.js"/>
                    <xsl:apply-templates select="tei:div[@type='model']"/>
                </head>
                <body>
                    <main class="slide">
                        <xsl:apply-templates select="tei:div[@type='content']"/>
                    </main>
                    <script>hljs.highlightAll();</script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='model']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='content']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div>
            <xsl:if test="@type">
                <xsl:attribute name="class"><xsl:value-of select="@type"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="xf:*">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="eg:egXML">
        <pre>
            <code class="language-{./@rend}">
                <!--<xsl:copy-of select="node()"/>-->
                <xsl:value-of disable-output-escaping="no" select="./node()"/>
            </code>
        </pre>
    </xsl:template>
    
    <xsl:template match="tei:code">
        <code><xsl:apply-templates/></code>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="tei:emph">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rend = 'bold'">
                <strong><xsl:apply-templates/></strong>
            </xsl:when>
            <xsl:otherwise><span class="{@rend}"><xsl:apply-templates/></span></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <a href="{@target}"><xsl:apply-templates/></a>
    </xsl:template>
    
    <xsl:template match="tei:figure">
        <figure><xsl:apply-templates/></figure>
    </xsl:template>
    
    <xsl:template match="tei:graphic">
        <img src="{@url}"/>
    </xsl:template>
    
    <xsl:template match="tei:figDesc">
        <figcaption><xsl:apply-templates/></figcaption>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <xsl:choose>
            <xsl:when test="ancestor::tei:div[@subtype='xforms']">
                <xsl:variable name="level" select="count(ancestor::tei:div[not(descendant::tei:div[@type='content'])])"/>
                <xsl:element name="h{$level}"><xsl:apply-templates/></xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="level" select="count(ancestor::tei:div[not(descendant::tei:div[@type='slide'])])"/>
                <xsl:element name="h{$level}"><xsl:apply-templates/></xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    
</xsl:stylesheet>