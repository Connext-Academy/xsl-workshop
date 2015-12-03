<?xml version='1.0' encoding='UTF-8'?>
<!--
    Created on : 2015-12-02
    Author     : Niels Nijens <niels@connectholland.nl>
-->
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

    <!--
    Output HTML. Duh!
    -->
    <xsl:output method='html'/>

    <!--
    Default page layout.
    -->
    <xsl:template match='/page'>
        <html>
            <head>
                <title><xsl:value-of select='title'/> - <xsl:value-of select='organization'/></title>
                <meta name='viewport' content='width=device-width, initial-scale=1'/>
                <!-- Bootstrap core CSS -->
                <link href='/css/bootstrap.min.css' rel='stylesheet'/>
                <!-- Custom styles for this template -->
                <link href='/css/jumbotron-narrow.css' rel='stylesheet'/>
                <link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.0.0/styles/default.min.css'/>
                <script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.0.0/highlight.min.js'></script>
                <script>hljs.initHighlightingOnLoad();</script>
            </head>
            <body>
                <div class='container'>
                    <xsl:apply-templates select='self::node()' mode='header'/>

                    <xsl:apply-templates select='jumbotron'/>
                    <xsl:apply-templates select='row'/>

                    <xsl:apply-templates select='self::node()' mode='footer'/>
                </div>
            </body>
        </html>
    </xsl:template>

    <!--
    Add page header.
    -->
    <xsl:template match='page' mode='header'>
        <div class='header clearfix'>
            <h3 class='text-muted'><img src='/images/logo.png' width='200' alt='{organization}'/></h3>
        </div>
    </xsl:template>

    <!--
    Add page footer.
    -->
    <xsl:template match='page' mode='footer'>
        <footer class='footer'>
            <p>&#169; 2015 <xsl:value-of select='organization'/>.</p>
        </footer>
    </xsl:template>

    <!--
    Add the jumbotron.
    -->
    <xsl:template match='jumbotron'>
        <div class='jumbotron'>
            <xsl:apply-templates select='self::node()' mode='background'/>
            <h1><xsl:value-of select='title'/></h1>
            <p class='lead'><xsl:value-of select='subtitle'/></p>
        </div>
    </xsl:template>

    <!--
    Add the jumbotron background when available.
    -->
    <xsl:template match='jumbotron' mode='background'/>
    <xsl:template match='jumbotron[@background]' mode='background'>
        <xsl:attribute name='style'>background-image: url(<xsl:value-of select='@background'/>);</xsl:attribute>
    </xsl:template>

    <!--
    Add a page row.
    -->
    <xsl:template match='row'>
        <div class='row marketing'>
            <h2><xsl:value-of select='title'/></h2>
            <xsl:apply-templates select='text | table'/>
            <xsl:apply-templates select='column[1]'/>
            <xsl:apply-templates select='column[2]'/>
        </div>
    </xsl:template>

    <!--
    Add a table.
    -->
    <xsl:template match='table'>
        <div class='panel panel-default'>
            <table class='table'>
                <thead>
                    <xsl:apply-templates select='row' mode='tableHeader'/>
                </thead>
                <tbody>
                    <xsl:apply-templates select='row'/>
                </tbody>
            </table>
        </div>
    </xsl:template>

    <!--
    Add a table header.
    -->
    <xsl:template match='table/row[1]' mode='tableHeader'>
        <tr>
            <th>#</th>
            <xsl:apply-templates select='@*' mode='tableHeader'/>
        </tr>
    </xsl:template>

    <!--
    Add a table header column.
    -->
    <xsl:template match='table/row/@*' mode='tableHeader'>
        <th><xsl:value-of select='local-name()'/></th>
    </xsl:template>

    <!--
    Add a table row.
    -->
    <xsl:template match='table/row'>
        <tr>
            <xsl:apply-templates select='self::node()' mode='classAttribute'/>
            <th scope='row'><xsl:value-of select='position()'/></th>
            <xsl:apply-templates select='@*'/>
        </tr>
    </xsl:template>

    <!--
    Add a table row class attribute.
    -->
    <xsl:template match='table/row' mode='classAttribute'>
        <xsl:attribute name='class'>
            <xsl:apply-templates select='self::node()' mode='classAttributeValue'/>
        </xsl:attribute>
    </xsl:template>

    <!--
    Add a table row class attribute value.
    -->
    <xsl:template match='table/row' mode='classAttributeValue'>
        <xsl:text>odd</xsl:text>
    </xsl:template>

    <!--
    Add a table row class attribute value.
    -->
    <xsl:template match='table/row[position() mod 2 = 0]' mode='classAttributeValue'>
        <xsl:text>even</xsl:text>
    </xsl:template>

    <!--
    Add a table row cell.
    -->
    <xsl:template match='table/row/@*'>
        <td><xsl:value-of select='.'/></td>
    </xsl:template>

    <!--
    Add a page row text.
    -->
    <xsl:template match='row/text'>
        <p><xsl:copy-of select='self::node()'/></p>
    </xsl:template>

    <!--
    Add a page row column.
    -->
    <xsl:template match='row/column'>
        <div class='col-lg-6'>
            <xsl:apply-templates select='item'/>
        </div>
    </xsl:template>

    <!--
    Add a page row column item.
    -->
    <xsl:template match='row/column/item'>
        <h4><xsl:value-of select='title'/></h4>
        <p><xsl:copy-of select='text'/></p>
    </xsl:template>

</xsl:stylesheet>
