# Appendix

## Removed Methods

### Removed in NSX 6.3.0

vCloud Networking and Security methods removed:
* PUT /api/2.0/si/service/service-ID/servicedeploymentspec/deploymentscope
* GET /api/2.0/si/service/service-ID/servicedeploymentspec
* all /api/3.0/edges/ methods

All ISIS methods removed from NSX Edge routing.
* GET /4.0/edges/{edge-id}/routing/config/isis
* PUT /4.0/edges/{edge-id}/routing/config/isis
* DELETE /4.0/edges/{edge-id}/routing/config/isis

## Error Message Schema

This schema details error messages.

```
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified">
  <xs:element name="Errors">
   	<xs:complexType>
      <xs:sequence>
        <xs:element maxOccurs="unbounded" name="Error" type="ErrorType"/>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:complexType name="ErrorType">
    <xs:sequence>
      <xs:element name="code" type="xs:unsignedInt"/>
      <xs:element name="description" type="xs:string"/>
      <xs:element minOccurs="0" name="detailedDescription" type="xs:string"/>
      <xs:element minOccurs="0" name="index" type="xs:int"/>
      <xs:element minOccurs="0" name="resource" type="xs:NMTOKEN"/>
      <xs:element minOccurs="0" name="requestId" type="xs:NMTOKEN"/>
      <xs:element minOccurs="0" name="module" type="xs:NMTOKEN"/>
    </xs:sequence>
  </xs:complexType>
</xs:schema>
```

If a REST API call results in an error, the HTTP reply contains the following information:
* An XML error document as the response body
* Content-Type: application/xml
* An appropriate 2xx, 4xx, or 5xx HTTP status code

**Error Message Status Codes**

Code | Description
-----|------------
200 | OK The request was valid and has been completed. Generally, this response is accompanied by a body document (XML).
201 | Created The request was completed and new resource was created. The Location header of the response contains the URI of newly created resource. 
204 | No Content Same as 200 OK, but the response body is empty (No XML).
400 | Bad Request The request body contains an invalid representation or the representation of the entity is missing information. The response is accompanied by Error Object (XML). 
401 | Unauthorized An authorization header was expected. Request with invalid or no NSX Manager Token.
403 | Forbidden The user does not have enough privileges to access the resource.
404 | Not Found The resource was not found. The response is accompanied by Error Object (XML). 
500 | Internal Server Error Unexpected error with the server. The response is accompanied by Error Object (XML). 
503 | Service Unavailable Cannot proceed with the request, because some of the services are unavailable. Example: NSX Edge is Unreachable. The response is accompanied by Error Object (XML). 

