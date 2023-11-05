<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:dm="http://azure.workflow.datamapper" xmlns:ef="http://azure.workflow.datamapper.extensions" exclude-result-prefixes="xsl xs math dm ef" version="3.0" expand-text="yes">
  <xsl:output indent="yes" media-type="text/xml" method="xml" />
  <xsl:template match="/">
    <xsl:variable name="xmlinput" select="json-to-xml(/)" />
    <xsl:apply-templates select="$xmlinput" mode="azure.workflow.datamapper" />
  </xsl:template>
  <xsl:template match="/" mode="azure.workflow.datamapper">
    <SupplierOrderSubmission>
      <Order>
        <OrderID>{/*/*[@key='orderId']}</OrderID>
        <CompanyName>{/*/*[@key='recipient_company']}</CompanyName>
        <CompanyContactPerson>{/*/*[@key='recipient_contact_person']}</CompanyContactPerson>
        <EmailAddress>{/*/*[@key='recipient_email']}</EmailAddress>
        <Phone>{/*/*[@key='recipient_phone']}</Phone>
        <Address>{/*/*[@key='recipient_address']}</Address>
        <City>{/*/*[@key='recipient_city']}</City>
        <PostalCode>{/*/*[@key='recipient_post_code']}</PostalCode>
        <Country>{/*/*[@key='recipient_country']}</Country>
        <RequestorName>{concat(/*/*[@key='requestor_firstName'], ' ', /*/*[@key='requestor_lasteName'])}</RequestorName>
        <ShippmentCenter>{dm:if_then_else((/*/*[@key='recipient_country']) = ('United States'), 'US', 'EU')}</ShippmentCenter>
        <tems>
          <xsl:for-each select="/*/*[@key='products']/*">
            <Item>
              <ProductCode>{*[@key='productCode']}</ProductCode>
              <Qty>{*[@key='qty']}</Qty>
            </Item>
          </xsl:for-each>
        </tems>
      </Order>
    </SupplierOrderSubmission>
  </xsl:template>
  <xsl:function name="dm:if_then_else" as="xs:string">
    <xsl:param name="condition" as="xs:boolean" />
    <xsl:param name="thenResult" as="xs:anyAtomicType" />
    <xsl:param name="elseResult" as="xs:anyAtomicType" />
    <xsl:choose>
      <xsl:when test="$condition">
        <xsl:value-of select="$thenResult" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$elseResult" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>
</xsl:stylesheet>