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
    
## API Removals and Behavior Changes

This section lists API removals and behavior changes. See **Method
history** information throughout the *NSX API Guide* for details of
other changes, such as parameter additions.

### Deprecations in NSX 6.4.2

The following item is deprecated, and might be removed in a future release.
* GET/POST/DELETE /api/2.0/vdn/controller/{controllerId}/syslog. Use 
  GET/PUT /api/2.0/vdn/controller/cluster/syslog instead.
  
The following API to retrieve the edge health status is deprecated.
* GET  api/4.0/edges/{edge-id}/status. Use GET /api/4.0/edges/{edgeId}/healthsummary instead.

### Behavior changes in NSX 6.4.1

When you create a new IP pool with `POST /api/2.0/services/ipam/pools/scope/globalroot-0`, or modify an existing IP pool with `PUT /api/2.0/services/ipam/pools/`, and the pool has multiple IP ranges defined, validation is done to ensure that the ranges do not overlap. This validation was not previously done.

### Deprecations in NSX 6.4.0

The following items are deprecated, and might be removed in a future release.

* The *systemStatus* parameter in `GET /api/4.0/edges/edgeID/status` is deprecated. 
* `GET /api/2.0/services/policy/serviceprovider/firewall/` is deprecated. Use
  `GET /api/2.0/services/policy/serviceprovider/firewall/info` instead.
* Setting the *tcpStrict* in the global configuration section of Distributed
  Firewall is deprecated. Starting in NSX 6.4.0, *tcpStrict* is defined at 
  the section level.   
  **Note:** If you upgrade to NSX 6.4.0 or later, the global configuration setting for
  **tcpStrict** is used to configure **tcpStrict** in each existing layer 3
  section. **tcpStrict** is set to *false* in layer 2 sections and layer 3
  redirect sections. See "Working with Distributed Firewall Configuration" for
  more information.

### Behavior Changes in NSX 6.4.0

NSX 6.4.0 introduces these changes in error handling:

* Previously `POST /api/2.0/vdn/controller` responded with *201 Created* to
  indicate the controller creation job is created. However, the creation of the
  controller might still fail. Starting in NSX 6.4.0 the response is *202 Accepted*.
* Previously if you sent an API request which is not allowed in transit or
  standalone mode, the response status was *400 Bad Request*. Starting in 6.4.0
  the response status is *403 Forbidden*.

### Behavior Changes in NSX 6.3.5

NSX 6.3.5 introduces these changes in error handling:

* If an API request results in a database exception on the NSX Manager, the
  response is *500 Internal server* error. In previous releases, NSX Manager
  responded with *200 OK*, even though the request failed.
* If you send an API request with an empty body when a request body is expected,
  the response is *400 Bad request*. In previous releases NSX Manager responded
  with *500 Internal server error*.
* If you specify an incorrect security group in this API, `GET
  /api/2.0/services/policy/securitygroup/{ID}/securitypolicies`, the response is
  *404 Not found*. In previous releases NSX Manager responded with *200 OK*.

### Behavior Changes in NSX 6.3.3

Starting in 6.3.3, the defaults for two backup and restore parameters have
changed to match the defaults in the UI. Previously passiveMode and useEPSV
defaulted to false, now they default to true. This affects the following APIs:

* `PUT /api/1.0/appliance-management/backuprestore/backupsettings`
* `PUT /api/1.0/appliance-management/backuprestore/backupsettings/ftpsettings`

### Removed in NSX 6.3.0

SSL VPN web access removed.  
`GET, POST, DELETE /api/4.0/edges/{edgeId}/sslvpn/config/webresources`  
`GET, PUT, DELETE /api/4.0/edges/{edgeId}/sslvpn/config/webresources/{id}`

### Removed in NSX 6.2.3

ISIS removed from NSX Edge routing.  
`GET, PUT, DELETE /api/4.0/edges/{edge-id}/routing/config/isis`  
`GET, PUT /api/4.0/edges/{edge-id}/routing/config`

`PUT /api/1.0/appliance-management/certificatemanager/csr/nsx` removed.  
Replaced with `POST /api/1.0/appliance-management/certificatemanager/csr/nsx`.

### Removed in NSX 6.0

Removed API | Alternative API
------------|-----------------
/api/2.0/global/heartbeat | /api/1.0/appliance-management/global/info 
/api/2.0/global/config | /api/2.0/services/vcconfig <br>/api/2.0/services/ssoconfig <br>/api/1.0/appliance-management/system/network/dns <br>/api/1.0/appliance-management/system/timesettings
/api/2.0/global/vcInfo | /api/2.0/services/vcconfig 
/api/2.0/global/techsupportlogs | /api/1.0/appliance-management/techsupportlogs/NSX 
/api/2.0/vdn/map/cluster/clusterId |
/api/2.0/services/usermgmt/securityprofile  |