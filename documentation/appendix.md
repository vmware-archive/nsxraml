# Appendix

## Status Codes

Code | Description
---|---
200 OK | The request was valid and has been completed. Generally, this response is accompanied by a body document (XML).
201 Created | The request was completed and new resource was created. The Location header of the response contains the URI of newly created resource. 
204 No Content | Same as 200 OK, but the response body is empty (No XML).
400 Bad Request | The request body contains an invalid representation or the representation of the entity is missing information. The response is accompanied by Error Object (XML).
401 Unauthorized | An authorization header was expected. Request with invalid or missing NSX Manager Token.
403 Forbidden | The user does not have enough privileges to access the resource.
404 Not Found | The resource was not found. The response is accompanied by Error Object (XML).
415 Unsupported Media Type | The required **Accept** or **Content-type** header is missing or incorrect.
500 Internal Server Error | Unexpected error with the server. The response is accompanied by Error Object (XML).
503 Service Unavailable | Cannot proceed with the request, because some of the services are unavailable. Example: NSX Edge is Unreachable. The response is accompanied by Error Object (XML).

## Error Messages

There are three type of errors returned by NSX Manager:

### Error With Single Message

    <error>
      <details>[Routing] Default Originate cannot be enabled on BGP from edge version 6.3.0 onwards.</details>
      <errorCode>13100</errorCode>
      <moduleName>vShield Edge</moduleName>
    </error>

### Error With Multiple Error Messages

    <errors>
      <error>
        <details>[Routing] Default Originate cannot be enabled on BGP from edge version 6.3.0 onwards.</details>
        <errorCode>13100</errorCode>
        <moduleName>vShield Edge</moduleName>
      </error>
    </errors>

### Error With Message and Error Data

    <error>
      <details>Invalid IP Address input 44.4-44.5 for field ipPools.ipPools[0].ipRange.</details>
      <errorCode>15012</errorCode>
      <moduleName>vShield Edge</moduleName>
      <errorData>
        <data>
          <key>leafNode</key>
          <value><autoConfigureDNS>true</autoConfigureDNS><ipRange>44.4-44.5</ipRange></value>
        </data>
      </errorData>
    </error>
    
## API Removals

This section lists resources that have been removed from the API. See **Method
history** information throughout the *NSX API Guide* for changes. 

### Removed in NSX 6.2.3

ISIS removed from NSX Edge routing.  
`GET, PUT, DELETE /api/4.0/edges/{edge-id}/routing/config/isis`  
`GET, PUT /api/4.0/edges/{edge-id}/routing/config`

`PUT /api/1.0/appliance-management/certificatemanager/csr/nsx` removed.  
Replaced with `POST /api/1.0/appliance-management/certificatemanager/csr/nsx`.

### Removed in 6.3.0

SSL VPN web access removed.  
`GET, POST, DELETE /api/4.0/edges/{edgeId}/sslvpn/config/webresources`  
`GET, PUT, DELETE /api/4.0/edges/{edgeId}/sslvpn/config/webresources/{id}`
