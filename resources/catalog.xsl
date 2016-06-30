<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:interface="http://zero-install.sourceforge.net/2004/injector/interface"
    xmlns:catalog="http://0install.de/schema/injector/catalog"
    version="1.0">
  <xsl:output method="xml" encoding="utf-8"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"/>
  <xsl:template match="/catalog:catalog">
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="Content-Language" content="en" />
        <title>Zero Install - Software catalogue</title>
        <link rel="stylesheet" href="@REPOSITORY_BASE_URL@/resources/catalog.css" type="text/css" />
        <script src="//cdnjs.cloudflare.com/ajax/libs/list.js/1.1.1/list.min.js"></script>
      </head>

      <body>
        <div id="main">
          <h1>Zero Install - Software catalogue</h1>
          <input class="search" placeholder="Search" />
          <div class="list">
            <xsl:for-each select="interface:interface">
              <div class="app">
                <a class="subtle" href="{@uri}">
                  <xsl:variable name="icon" select="interface:icon[@type='image/png']/@href"/>
                  <xsl:if test="$icon">
                    <img class="icon" src="{$icon}"/>
                  </xsl:if>
                  <xsl:if test="not($icon)">
                    <img class="icon" src="http://0install.net/tango/applications-system.png"/>
                  </xsl:if>
                </a>
                <div class="info">
                  <h2 class="name">
                    <a class="subtle" href="{@uri}">
                      <xsl:value-of select="interface:name"/>
                    </a>
                  </h2>
                  <p class="summary">
                    <xsl:if test="interface:summary[@xml:lang='en']">
                      <xsl:value-of select="interface:summary[@xml:lang='en']"/>
                    </xsl:if>
                    <xsl:if test="not(interface:summary[@xml:lang='en'])">
                      <xsl:value-of select="interface:summary"/>
                    </xsl:if>
                  </p>
                </div>
                <div class="actions">
                  <form action="http://0install.de/bootstrap/" method="get">
                    <input type="hidden" name="name" value="{interface:name}"/>
                    <input type="hidden" name="uri" value="{@uri}"/>
                    <input type="hidden" name="mode" value="run"/>
                    <input type="submit" value="Run"/>
                  </form>
                  <form action="http://0install.de/bootstrap/" method="get">
                    <input type="hidden" name="name" value="{interface:name}"/>
                    <input type="hidden" name="uri" value="{@uri}"/>
                    <input type="hidden" name="mode" value="integrate"/>
                    <input type="submit" value="Integrate"/>
                  </form>
                </div>
              </div>
            </xsl:for-each>
          </div>
        </div>
        <script>new List('main', {valueNames: ['name']});</script>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
