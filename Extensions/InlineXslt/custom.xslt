<tems>
    <xsl:for-each select="/*/*[@key='products']/*">
      <Item>
        <OrderID>{/*/*[@key='orderId']}</OrderID>
        <ItemID>{$_a}</ItemID>
        <ProductCode>{*[@key='productCode']}</ProductCode>
        <Qty>{*[@key='qty']}</Qty>
      </Item>
    </xsl:for-each>
  </tems>