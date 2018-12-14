# VMware NSX Data Center for vSphere API documentation version 6.4
https://{nsxmanager}/api

### Introduction
This manual, the *NSX API Guide*, describes how to install, configure, monitor, and maintain the
VMware NSX® Data Center for vSphere® system by using REST API requests.

**Important**: NSX for vSphere is now known as NSX Data Center for vSphere.

## Intended Audience

This manual is intended for anyone who wants to use the REST API to
programmatically control an NSX Data Center for vSphere environment. The information
in this manual is written for experienced developers who are familiar with
virtual machine technology, virtualized datacenter operations, and REST APIs.
This manual also assumes familiarity with NSX Data Center for vSphere.

## VMware Technical Publications Glossary

VMware Technical Publications provides a glossary of terms that might be
unfamiliar to you. For definitions of terms as they are used in VMware
technical documentation go to http://www.vmware.com/support/pubs.

## Technical Documentation and Product Updates

You can find the most up-to-date technical documentation on the VMware Web site at:
http://www.vmware.com/support/.

The VMware Web site also provides the latest product updates.

If you have comments about this documentation, submit your feedback to:
&lt;docfeedback@vmware.com&gt;.

## Using the NSX REST API

To use the NSX REST API, you must configure a REST client, verify the required
ports are open between your REST client and the NSX Manager, and understand
the general RESTful workflow.

### Ports Required for the NSX REST API

The NSX Manager requires port 443/TCP for REST API requests.

### Configuring REST Clients for the NSX REST API

Some common REST clients include Postman, RESTClient (a Firefox add-on), and
curl (a command-line tool). The details of REST client configuration will vary
from client to client, but this general information should help you configure
your REST client correctly.

* **The NSX REST API can use basic authentication or JSON Web Token authentication.**   
You can authenticate using basic authentication or JSON Web Tokens. See "Working
with API Tokens" for information on creating and using JSON Web Tokens. You must
configure your REST client to send the NSX Manager authentication credentials.
See the documentation for your REST client for details. 

* **You must use https to send API requests to the NSX Manager.**   
You might need to import the certificate from the NSX Manager to your REST
client to allow it to connect to the NSX Manager.

* **When you submit an API request with a request body, you must include the 
appropriate `Content-Type` header.**   
Starting in NSX 6.4, both XML and JSON are supported. This guide documents XML
examples. Set the **Content-Type** header to *application/xml* or *application/json* as needed.  
Some requests require additional headers, for example, firewall configuration
changes require the **If-Match** header. This is noted on each method
description.
* **To ensure you always receive the correct response bodies, set the `Accept` header**   
Starting in NSX 6.4, both XML and JSON are supported. This guide documents XML
examples. Set the **Accept** header to *application/xml* or *application/json* as
needed.  
**Note:** Some methods, for example, the central CLI method, `POST /1.0/nsx/cli`, might require a different Accept header.

The following API method will return a response on a newly deployed NSX
Manager appliance, even if you have not made any configuration changes. You
can use this as a test to verify that your REST client is configured correctly
to communicate with the NSX Manager API.

```
GET /api/2.0/services/usermgmt/user/admin
```

### URI and Query Parameters

Some methods have URI or query parameters. URI parameters are values that you
include in the request URL. You use a question mark (**?**) to join the request
URL and the query parameters. Multiple query parameters can be combined by
using ampersands (**&**).

For example, you can use this method to get a list of logical switches on a transport zone: 

```
GET /api/2.0/vdn/scopes/{scopeId}/virtualwires
```

**scopeId** is a URI parameter that represents a transport zone.

The **startindex** and **pagesize** query parameters control how this
information is displayed. **startindex** determines which logical switch to
begin the list with, and **pagesize** determines how many logical switches to
list.  

To view the first 20 logical switches on transport zone vdnscope-1, use the following parameters:

* **scopeId** URI parameter set to *vdnscope-1*.  
* **startindex** query parameter set to *0*.   
* **pagesize** query parameter set to *20*.   

These parameters are combined to create this request:

```
GET https://192.168.110.42/api/2.0/vdn/scopes/vdnscope-1/virtualwires?
startindex=0&pagesize=20
```

### RESTful Workflow Patterns

All RESTful workflows fall into a pattern that includes only two fundamental
operations, which you repeat in this order for as long as necessary.

* **Make an HTTP request (GET, PUT, POST, or DELETE).**   
The target of this request is either a well-known URL (such as NSX Manager) or
a link obtained from the response to a previous request. For example, a GET
request to an Org URL returns links to vDC objects contained by the Org.
* **Examine the response, which can be an XML document or an HTTP response code.**   
If the response is an XML document, it might contain links or other
information about the state of an object. If the response is an HTTP response
code, it indicates whether the request succeeded or failed, and might be
accompanied by a URL that points to a location from which additional
information can be retrieved.

### Revision Numbers

Some API objects include a configuration version number. In some cases, this
revision number is used to prevent concurrent changes to an object. As a best
practice, before you change the configuration of an object, retrieve the latest
configuration using GET. Modify the response body as needed and use it as your
PUT request body. If the object has been modified since your GET operation, you
might see an error message.

## Finding vCenter Object IDs

Many API methods reference vCenter object IDs in URI parameters, query
parameters, request bodies, and response bodies. You can find vCenter object
IDs via the vCenter Managed Object Browser.

### Find Datacenter MOID

1. In a web browser, enter the vCenter Managed Object Browser URL:
   `http://vCenter-IP-Address/mob`.
2. Click **content**.
3. Find **rootFolder** in the Name column, and click the corresponding link in
   the Value column. For example, *group-d1*.
4. Find the **childEntity** in the Name column, and the corresponding
  Value column entry is the datacenter MOID. For example, *datacenter-21*.

### Find Cluster or Host MOID

1. In a web browser, enter the vCenter Managed Object Browser URL:
   `http://vCenter-IP-Address/mob`.
2. Click **content**.
3. Find **rootFolder** in the Name column, and click the corresponding link in
   the Value column. For example, *group-d1*.
4. Find **childEntity** in the Name column, and click the corresponding
   link in the Value column. For example, *datacenter-21*.
4. Find **hostFolder** in the Name column, and click the corresponding
   link in the Value column. For example, *group-h23*.
4. Find **childEntity** in the Name column. The corresponding Value column
   lists the host clusters. For example, *domain-c33*.
4. To find the MOID of a host in a cluster, click the appropriate host cluster
   link located in the previous step. 
4. Find *host* in the Name column. The corresponding Value column
   lists the hosts in that cluster by vCenter MOID and hostname. For example,
   *host-32 (esx-02a.corp.local)*.

### Find Portgroup MOID

1. In a web browser, enter the vCenter Managed Object Browser URL:
   `http://vCenter-IP-Address/mob`.
2. Click **content**.
3. Find **rootFolder** in the Name column, and click the corresponding link in
   the Value column. For example, *group-d1*.
4. Find **childEntity** in the Name column, and click the corresponding
   link in the Value column. For example, *datacenter-21*.
4. Find **hostFolder** in the Name column, and click the corresponding
   link in the Value column. For example, *group-h23*.
4. Find **childEntity** in the Name column. The corresponding Value column
   contains links to host clusters. Click the appropriate host cluster link.
   For example, *domain-c33*.
4. Find **host** in the Name column. The corresponding Value column lists the
   hosts in that cluster by vCenter MOID and hostname. Click the appropriate
   host link, For example, host-32.
5. Find **network** in the Name column. The corresponding Value column lists
   the port groups on that host, For example, *dvportgroup-388*.

### Find VM MOID or VM Instance UUID

1. In a web browser, enter the vCenter Managed Object Browser URL:
   `http://vCenter-IP-Address/mob`.
2. Click **content**.
3. Find **rootFolder** in the Name column, and click the corresponding link in
   the Value column. For example, *group-d1*.
4. Find **childEntity** in the Name column, and click the corresponding
   link in the Value column. For example, *datacenter-21*.
4. Find **hostFolder** in the Name column, and click the corresponding
   link in the Value column. For example, *group-h23*.
4. Find **childEntity** in the Name column. The corresponding Value column
   contains links to host clusters. Click the appropriate host cluster link.
   For example, *domain-c33*.
4. Find **host** in the Name column. The corresponding Value column lists the
   hosts in that cluster by vCenter MOID and hostname. Click the appropriate
   host link, For example, *host-32*.
5. Find **vm** in the Name column. The corresponding Value column lists the
   virtual machines by vCenter MOID and hostname. For example, *vm-216 (web-01a)*.
6. To find the instance UUID of a VM, click the VM MOID link located in the
   previous step. Click the config link in the Value column.
6. Find **instanceUuid** in the Name column. The corresponding Value column
   lists the VM instance UUID. For example,
   *502e71fa-1a00-759b-e40f-ce778e915f16*.

### update-number
Update 8

### update-date
Modified DEC 2018

---

## vdsManage
Working With vSphere Distributed Switches
===========

### /2.0/vdn/switches

* **post** *(secured)*: Prepare a vSphere Distributed Switch.

The MTU is the maximum amount of data that can be transmitted in one
packet before it is divided into smaller packets. VXLAN frames are slightly
larger in size because of the traffic encapsulation, so the MTU required
is higher than the standard MTU. You must set the MTU for each switch to
1602 or higher.

* **get** *(secured)*: Retrieve information about all vSphere Distributed Switches.

### /2.0/vdn/switches/datacenter/{datacenterID}
Working With vSphere Distributed Switches in a Datacenter
------

* **get** *(secured)*: Retrieve information about all vSphere Distributed Switches in the specified datacenter.

### /2.0/vdn/switches/{vdsId}
Working With a Specific vSphere Distributed Switch
------

* **get** *(secured)*: Retrieve information about the specified vSphere Distributed Switch.

* **delete** *(secured)*: Delete the specified vSphere Distributed Switch.

## vdnConfig
Working With Segment ID Pools and Multicast Ranges
========

### /2.0/vdn/config/segments
Working With Segment ID Pools
-------------
Segment ID pools (also called segment ID ranges) provide virtual network
identifiers (VNIs) to logical switches.

You must configure a segment ID pool for each NSX Manager. You can have
more than one segment ID pool. The segment ID pool includes the beginning
and ending IDs.

You should not configure more than 10,000 VNIs in a single vCenter
server because vCenter limits the number of dvPortgroups to 10,000.

If any of your transport zones will use multicast or hybrid replication
mode, you must also configure a multicast address range.

* **post** *(secured)*: Add a segment ID pool.

* **name** - Required property.
* **desc** - Optional property.
* **begin** - Required property. Minimum value is *5000*
* **end** - Required property. Maximum value is *16777216*

* **get** *(secured)*: Retrieve information about all segment ID pools.

### /2.0/vdn/config/segments/{segmentPoolId}
Working With a Specific Segment ID Pool
------

* **get** *(secured)*: Retrieve information about the specified segment ID pool.

* **put** *(secured)*: Update the specified segment ID pool.

If the segment ID pool is universal you must send the API request to
the primary NSX Manager.

* **delete** *(secured)*: Delete the specified segment ID pool.

If the segment ID pool is universal you must send the API request to
the primary NSX Manager.

### /2.0/vdn/config/multicasts
Working With Multicast Address Ranges
------
If any of your transport zones will use multicast or hybrid replication
mode, you must add a multicast address range (also called a multicast
address pool). Specifying a multicast address range helps in spreading
traffic across your network to avoid overloading a single multicast
address.

* **post** *(secured)*: Add a multicast address range for logical switches.

The address range includes the beginning and ending addresses.

* **get** *(secured)*: Retrieve information about all configured multicast address ranges.

Universal multicast address ranges have the property isUniversal
set to *true*.

### /2.0/vdn/config/multicasts/{multicastAddresssRangeId}
Working With a Specific Multicast Address Range
--------

* **get** *(secured)*: Retrieve information about the specified multicast address range.

* **put** *(secured)*: Update the specified multicast address range.

If the multicast address range is universal you must send the API
request to the primary NSX Manager.

* **delete** *(secured)*: Delete the specified multicast address range.

If the multicast address range is universal you must send the API
request to the primary NSX Manager.

### /2.0/vdn/config/vxlan/udp/port
Working With the VXLAN Port Configuration
----------

* **get** *(secured)*: Retrieve the UDP port configured for VXLAN traffic.

### /2.0/vdn/config/vxlan/udp/port/{portNumber}
Update the VXLAN Port Configuration
-------

* **put** *(secured)*: Update the VXLAN port configuration to use port *portNumber*.

This method changes the VXLAN port in a three phrase process, avoiding
disruption of VXLAN traffic. In a cross-vCenter NSX environment,
change the VXLAN port on the primary NSX Manager to propagate this
change on all NSX Managers and hosts in the cross-vCenter NSX
environment.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. Port change is now non-disruptive, and propagates to secondary NSX Managers if performed on the primary NSX Manager. Force parameter added.

### /2.0/vdn/config/vxlan/udp/port/taskStatus
VXLAN Port Configuration Update Status
----

* **get** *(secured)*: Retrieve the status of the VXLAN port configuration update.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/config/vxlan/udp/port/resume
Resume VXLAN Port Configuration Update
----

* **post** *(secured)*: If you update the VXLAN port using the **Change** button on
the **Installation > Logical Network Preparation** page in the vSphere
Web Client, or using `PUT
/api/2.0/vdn/config/vxlan/udp/port/{portNumber}` without the **force**
parameter, and the port update does not complete, you can try resuming
the port config change.

You can check the progress of the VXLAN port update with 
`GET /api/2.0/vdn/config/vxlan/udp/port/taskStatus`.

Only try resuming the port update if it has failed to complete. You
should not need to resume the port update under normal circumstances.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/config/resources/allocated
Working With Allocated Resources
------

* **get** *(secured)*: Retrieve information about allocated segment IDs or multicast
addresses.

### /2.0/vdn/config/host/{hostId}/vxlan/vteps
Resolving Missing VXLAN VMKernel Adapters
----

* **post** *(secured)*: Resolve missing VXLAN VMKernel adapters.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

## CdoMode
Working With Controller Disconnected Operation (CDO) Mode
====================================
You can enable CDO mode on secondary NSX Manager to avoid connectivity issues with the primary site.

CDO mode state has the following values:
  * ENABLED: CDO mode has been successfully enabled on NSX Manager.
  * DISABLED: CDO mode has been successfully disabled on NSX Manager.
  * UNKNOWN: CDO mode has not been set on NSX Manager.

CDO mode operation status has the following values:
  * FAILED: NSX Manager failed to set CDO state.
  * SUCCESSFUL: NSX Manager is successful to set CDO state.
  * IN_PROGRESS: Setting of CDO state in-progress.
  * UNKNOWN: Unknown state.
  

### /2.0/vdn/cdo

* **get** *(secured)*: Retrieves the status of CDO mode.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **post** *(secured)*: 
Modify the status of CDO mode.
This method can be used to perform the following tasks: 
* Update the CDO mode: POST /api/2.0/vdn/cdo?action=update
* Resync the CDO mode: POST /api/2.0/vdn/cdo?action=resync
* Enable the CDO mode: POST /api/2.0/vdn/cdo?action=enable
* Disable the CDO mode: POST /api/2.0/vdn/cdo?action=disable

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

## vdnScopes
Working With Transport Zones
==============

### /2.0/vdn/scopes

* **get** *(secured)*: Retrieve information about all transport zones (also known as network
scopes).

**CDO mode state parameters (read-only)**

The CDO mode state shows the most recent CDO operation, and the status of that operation. The status can be:
*UNKNOWN*, *PENDING*, *IN_PROGRESS*, *COMPLETED*, or *FAILED*.

Operation Type | Description 
----|----
*ENABLE* | Enable CDO mode on all distributed switches in the transport zone.
*DISABLE* | Disable CDO mode on all distributed switches in the transport zone.
*EXPAND* | Enable CDO mode on newly joined distributed swithes.
*SHRINK* | Disable CDO mode on removed distributed switches.
*CLEAN_UP* | Transport zone removed, clean up the CDO mode configuration from all distributed switches in the transport zone.
*SYNC_ENABLE* | Repush CDO mode configuration data to all distributed switches in the scope
*SYNC_DISABLE* | Remove CDO mode configuration from all distributed switches in the transport zone.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method updated. Output includes information about CDO mode. See *Working With Transport Zone CDO Mode* for more information.

* **post** *(secured)*: Create a transport zone.

Request body parameters:

  * **name** - Required. The name of the transport zone.
  * **description** - Optional. Description of the transport zone.
  * **objectId** - Required. The cluster object ID from vSphere. One or more are
    required.
  * **controlPlaneMode** - Optional. The control plane mode. It can be
    one of the following:
      * *UNICAST_MODE*
      * *HYBRID_MODE*
      * *MULTICAST_MODE*

### /2.0/vdn/scopes/{scopeId}
Working With a Specific Transport Zone
---------

* **get** *(secured)*: Retrieve information about the specified transport zone.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method updated. Output includes information about CDO mode. See *Working With Transport Zone CDO Mode* for more information.

* **post** *(secured)*: Update the specified transport zone.

You can add a cluster to or delete a cluster from a transport zone.

You can also repair missing port groups. For every logical switch
created, NSX creates a corresponding port group in vCenter. If the
port group is lost for any reason, the logical switch will stop
functioning. The repair action recreates any missing port groups.

* **delete** *(secured)*: Delete the specified transport zone.

### /2.0/vdn/scopes/{scopeId}/attributes
Working With Transport Zone Attributes
----

* **put** *(secured)*: Update the attributes of a transport zone.

For example, you can update the name, description, or control plane
mode. You must include the cluster object IDs for the transport zone
in the request body.

### /2.0/vdn/scopes/{scopeId}/cdo
Working With Transport Zone CDO Mode
-----

* **post** *(secured)*: **Note**: From 6.4.0, CDO feature is supported at NSX Manager level and not at Transport Zone level.
For more details, refer to *Working with Controller Disconnected Operation (CDO) Mode* section.

Enable or disable CDO mode for the specified transport zone.

Controller Disconnected Operation (CDO) mode ensures that the data
plane connectivity is unaffected when host lose connectivity with the
controller. 

If you want to enable CDO mode on the universal transport zone in a
cross-vCenter NSX environment, you must do this from the primary NSX
Manager. The universal synchronization service will propagate the CDO
configuration to the secondary NSX Managers.

**Method history:**

Release | Modification
--------|-------------
6.3.2 | Method introduced. (Tech preview in 6.3.0).

### /2.0/vdn/scopes/{scopeId}/conn-check/multicast
Testing Multicast Group Connectivity
-------

* **post** *(secured)*: Test multicast group connectivity.

Test multicast group connectivity between two hosts connected to the
specified transport zone.

Parameter **packetSizeMode** has one of the following values:
* *0* - VXLAN standard packet size
* *1* - minimum packet size
* *2* - customized packet size.
If you set **packetSizeMode** to *2*, you must specify the size using
the **packetSize** parameter.

## logicalSwitches
Working With Logical Switches in a Specific Transport Zone
==================

### /2.0/vdn/scopes/{scopeId}/virtualwires

* **get** *(secured)*: Retrieve information about all logical switches in the specified
transport zone (network scope).

* **post** *(secured)*: Create a logical switch.

To create a universal logical switch use *universalvdnscope* as the
scopeId in the URI and send the request to the primary NSX Manager.
Request body parameters:
  * **name** - Optional. The name of the logical switch.
  * **description** - Optional. Description of the logical switch.
  * **tenantId** - Required.
  * **controlPlaneMode** - Optional. The control plane mode. If not
    specified, the **controlPlaneMode** of the transport zone is used. It
    can be one of the following:
      * *UNICAST_MODE*
      * *HYBRID_MODE*
      * *MULTICAST_MODE*
  * **guestVlanAllowed** - Optional. Default is *false*.

## traceflows
Working With Traceflow
================
For Traceflow to work as expected, make sure that the controller cluster is
connected and in healthy state. The Traceflow operation requires active
communication between vCenter, NSX Manager, controller cluster, and netcpa
User World Agents (UWA) on the host. Traceflow observes marked packet as it
traverses overlay network. Each packet is delivered to host VM and
monitored as it crosses overlay network until it reaches the destination
VM. The packet is never delivered to the destination guest VM. This means
that Traceflow packet delivery is successful even when the guest VM is
powered down. Unknown L2 Packets are always be sent to the bridge.
Typically, the bridge forwards these packets to a VLAN and reports the
Traceflow packet as delivered. The packet which is reported as delivered
need not necessarily mean that the trace packet was delivered to the
destination specified. You should conclude only after validating the
observations.vdl2 serves ARP proxy for ARP packets coming from VMs.
However, Traceflow bypasses this process, hence vdl2 may broadcast the
Traceflow packet out.

### /2.0/vdn/traceflow

* **post** *(secured)*: Create a traceflow.

### /2.0/vdn/traceflow/{traceflowId}
Working With a Specific Traceflow
---------

* **get** *(secured)*: Query a specific Traceflow by *tracflowId* which is the value returned
after executing the create Traceflow API call.

### /2.0/vdn/traceflow/{traceflowId}/observations
Traceflow Observations
-----

* **get** *(secured)*: Retrieve traceflow observations.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. New parameter **replicateType** added.

## logicalSwitchesGlobal
Working With Logical Switches in All Transport Zones
===========

### /2.0/vdn/virtualwires

* **get** *(secured)*: Retrieve information about all logical switches in all transport zones.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. Added *name* query parameter.

### /2.0/vdn/virtualwires/vm/vnic
Working Virtual Machine Connections to Logical Switches
-----

* **post** *(secured)*: Attach a VM vNIC to, or detach a VM vNIC from a logical switch.

Specify the logical switch ID in the **portgroupId** parameter. To
detach a VM vNIC from a logical switch, leave the **portgroupId** parameter
empty.

To find the ID of a VM vNIC, do the following:
1. In the vSphere MOB, navigate to the VM you want to connect or disconnect.
2. Click **config** and take note of the **instanceUuid**.
3. Click **hardware** and take note of the last three digits of the
appropriate network interface device.

Use these two values to form the VM vNIC ID.  For example, if the
**instanceUuid** is *502e71fa-1a00-759b-e40f-ce778e915f16* and the
appropriate **device** value is *device[4000]*, the **objectId** and
**vnicUuid** are both *502e71fa-1a00-759b-e40f-ce778e915f16.000*.

### /2.0/vdn/virtualwires/{virtualWireID}
Working With a Specific Logical Switch
----

* **get** *(secured)*: Retrieve information about the specified logical switch.

If the switch is a universal logical switch the **isUniversal**
parameter is set to true in the response body.

* **put** *(secured)*: Update the specified logical switch.

For example, you can update the name, description, or control plane
mode.

* **delete** *(secured)*: Delete the specified logical switch.

### /2.0/vdn/virtualwires/{virtualWireID}/backing
Resolving Missing Port Groups for a Logical Switch
----

* **post** *(secured)*: For every logical switch created, NSX creates a corresponding port
group in vCenter. If the port group is missing, the logical switch
will stop functioning.

If the port group backing a logical switch is deleted, you can
recreate a new backing port group for the logical switch.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/virtualwires/{virtualWireID}/conn-check/multicast
Testing Host Connectivity
-----

* **post** *(secured)*: Test multicast group connectivity.

Test multicast group connectivity between two hosts connected to the
specified logical switch.

Parameter **packetSizeMode** has one of the following values:
* *0* - VXLAN standard packet size
* *1* - minimum packet size
* *2* - customized packet size.
If you set **packetSizeMode** to *2*, you must specify the size using
the **packetSize** parameter.

### /2.0/vdn/virtualwires/{virtualWireID}/conn-check/p2p
Testing Point-to-Point Connectivity
----

* **post** *(secured)*: Test point-to-point connectivity.

Test point-to-point connectivity between two hosts connected to the
specified logical switch.

Parameter **packetSizeMode** has one of the following values:
* *0* - VXLAN standard packet size
* *1* - minimum packet size
* *2* - customized packet size.
If you set **packetSizeMode** to *2*, you must specify the size using
the **packetSize** parameter.

### /2.0/vdn/virtualwires/{virtualWireID}/hardwaregateways
Working With Hardware Gateway Bindings for a Specific Logical Switch
-----

* **get** *(secured)*: Retrieve hardware gateway bindings for the specified logical switch.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/virtualwires/{virtualWireID}/hardwaregateways/{hardwareGatewayBindingId}
Working With Connections Between Hardware Gateways and Logical Switches
-------

* **post** *(secured)*: Manage the connection between a hardware gateway and a logical switch.

### Attach a hardware gateway to a logical switch and create a new binding with the information provided

`POST /api/2.0/vdn/virtualwires/{virtualwireid}/hardwaregateways`

```
<hardwareGatewayBinding>
  <hardwareGatewayId>hardwarewgateway1</hardwareGatewayId>
  <vlan>v1</vlan>
  <switchName>s1</switchName>
  <portName>s1</portName>
</hardwareGatewayBinding> 
```

### Attach a hardware gateway to a logical switch, specifying an existing binding by ID

`POST /api/2.0/vdn/virtualwires/<virtualwireId>/hardwaregateways/{bindingId}?action=attach`

```
<virtualWire>
  ...
  <hardwareGatewayBindings>
    <hardwareGatewayBinding>
      <id>binding id</id>
    </hardwareGatewayBinding>
  </hardwareGatewayBindings>
</virtualWire>
```

### Detach a hardware gateway from a logical switch

`POST /api/2.0/vdn/virtualwires/<virtualwireId>/hardwaregateways/{bindingId}?action=detach`

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

## arpMAC
Working With IP Discovery and MAC Learning for Logical Switches
==============
You can enable IP discovery (ARP suppression) and MAC learning for logical
switches or dvPortGroup. Enabling MAC learning builds a VLAN - MAC
pair learning table on each vNic.

This table is stored as part of the dvfilter data. During vMotion,
dvfilter saves/restores the table at the new location. The switch then
issues RARPs for all the VLAN - MAC entries in the table.

Enabling this feature avoids possible traffic loss during vMotion in the
following cases:

* the vNic is in VLAN trunk mode
* the VM is using more  than one unicast MAC address. Since Etherswitch
supports only one unicast MAC per vNic, RARP is not processed.

When a logical switch is created using the API, IP discovery is enabled,
and MAC learning is disabled.

In cross-vCenter NSX, the following applies:
* The MAC learning setting for a universal logical switch is managed
on the primary NSX Manager. Any changes are synchronized to all secondary
NSX Managers.
* The IP discovery setting for a universal logical switch is managed
separately on each NSX Manager.

**Note:** In NSX 6.2.2 and earlier you cannot disable IP discovery for
universal logical switches on secondary NSX Managers.

### /2.0/xvs/networks/{ID}/features

* **get** *(secured)*: Retrieve IP discovery and MAC learning information.
* **put** *(secured)*: Enable or disable IP discovery and MAC learning.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. IP discovery can be disabled on secondary NSX Managers.

## nsxControllers
Working With NSX Controllers
==============
For the unicast or hybrid control plane mode,
you must add an NSX controller to manage overlay transport and provide
East-West routing. The controller optimizes virtual machine broadcast (ARP
only) traffic, and the learning is stored on the host and the controller.

### /2.0/vdn/controller

* **post** *(secured)*: Add a new NSX Controller on the specified cluster. The *hostId*
parameter is optional. The *resourcePoolId* can be either the
*clusterId* or *resourcePoolId*.

The IP address of the controller node will be allocated
from the specified IP pool. 

**Note:** Controller nodes are deployed with 4 GB of memory regardless of 
which **deployType** value is provided.

**Method history:**

Release | Modification
--------|-------------
6.3.3 | Method updated. **deployType** is no longer required.

* **get** *(secured)*: Retrieves details and runtime status for all controllers.  Runtime status
can be one of the following:

  * **Deploying** - controller is being deployed and the procedure has not
  completed yet.
  * **Removing** - controller is being removed and the procedure has not
  completed yet.
  * **Running** - controller has been deployed and can respond to API
  invocation.
  * **Unknown** - controller has been deployed but fails to respond to API
  invocation.

### /2.0/vdn/controller/upgrade-available
Working With Controller Upgrade Availability
----

* **get** *(secured)*: Retrieve controller upgrade availability.

### /2.0/vdn/controller/progress/{jobId}
Working With of Controller Job Status
-----

* **get** *(secured)*: Retrieves status of controller creation or removal. The progress gives
a percentage indication of current deploy / remove procedure.

### /2.0/vdn/controller/{controllerId}
Working With a Specific Controller
-----

* **delete** *(secured)*: Delete the NSX controller.

* **post** *(secured)*: If you power off or delete a controller from vCenter, NSX Manager
detects the change in controller status. You can remediate the
controller, which will power on a powered off controller, or remove the
controller from the NSX Manager database if the controller is deleted.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **put** *(secured)*: Update the name of the controller. The name must not contain spaces 
or underscores.

When you update the controller name, the following changes are made:

* the name displayed in the Networking & Security UI is changed to *newName*
* the VM name is vSphere is changed to *newName-NSX-&lt;controller_id&gt;*
* the VM's hostname is changed to *newName-NSX-&lt;controller_id&gt;* 

**Note**: The VM hostname is used in controller log entries. If you
change the controller hostname, the log entries display the new
hostname. 

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /2.0/vdn/controller/{controllerId}/systemStats
Working With NSX Controller System Statistics
----

* **get** *(secured)*: Retrieve NSX Controller system statistics.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/controller/{controllerId}/techsupportlogs
Working With Controller Tech Support Logs
-----

* **get** *(secured)*: Retrieve controller logs. Response content type is
application/octet-stream and response header is filename. This
streams a fairly large bundle back (possibly hundreds of MB).

### /2.0/vdn/controller/{controllerId}/syslog
Working With Controller Syslog Configuration
-----

* **post** *(secured)*: Add controller syslog exporter on the controller.

**Deprecated**: Starting in 6.4.2, `POST/DELETE
/api/2.0/vdn/controller/{controllerId}/syslog` are deprecated.

Use `GET/PUT /api/2.0/vdn/controller/cluster/syslog` instead.

Using both these methods is not supported and might result in an
inconsistent state on the controller nodes.

* **get** *(secured)*: Retrieve details about the syslog exporter on the controller.

**Deprecated**: Starting in 6.4.2, `POST/DELETE
/api/2.0/vdn/controller/{controllerId}/syslog` are deprecated.

Use `GET/PUT /api/2.0/vdn/controller/cluster/syslog` instead.

Using both these methods is not supported and might result in an
inconsistent state on the controller nodes.

* **delete** *(secured)*: Deletes syslog exporter on the specified controller node.

**Deprecated**: Starting in 6.4.2, `POST/DELETE
/api/2.0/vdn/controller/{controllerId}/syslog` are deprecated.

Use `GET/PUT /api/2.0/vdn/controller/cluster/syslog` instead.

Using both these methods is not supported and might result in an
inconsistent state on the controller nodes.

### /2.0/vdn/controller/{controllerId}/snapshot
Working With Controller Cluster Snapshots
-----

* **get** *(secured)*: Take a snapshot of the control cluster from the specified controller
node.

### /2.0/vdn/controller/cluster
Working With the NSX Controller Cluster Configuration
----

* **get** *(secured)*: Retrieve cluster wide configuration information for controller.

* **put** *(secured)*: Modify cluster wide configuration information for controller.

### /2.0/vdn/controller/cluster/ntp
Working With Controller Cluster NTP Settings
-----
You can configure up to five NTP servers on the NSX Controller cluster. 
You can specify NTP servers by IPv4 address or FQDN. If an FQDN is used, 
DNS settings must also be configured. The same 
NTP settings are applied to all controller nodes in the cluster.

* **get** *(secured)*: Retrieve NTP configuration for the NSX Controller cluster.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **put** *(secured)*: Update NTP configuration for the NSX Controller cluster.

If the settings fail to apply to one or more controller nodes,
an error message is returned. Check the controller node status, and retry 
the request.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /2.0/vdn/controller/cluster/dns
Working With Controller Cluster DNS Settings 
-----
  
When you configure DNS on the NSX Controller cluster, the same 
settings are applied to all nodes in the cluster.

Controller cluster DNS settings override any DNS settings 
configured on the controller IP pool.

**DNS Parameters**

Parameter |  Description | Comments
---|---|---
**dnsServer** | DNS server IP address | Required. Specify up to 3. Valid input: IPv4 addresses.
**dnsSuffix** | DNS suffix for search order | Optional. Specify up to 3. Valid input: domain name suffix. At least one **dnsServer** must be configured.

* **get** *(secured)*: Retrieve DNS settings for the NSX Controller cluster.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

* **put** *(secured)*: Update DNS settings for all nodes in the NSX Controller cluster.

**Note:** If the settings fail to apply to one or more controller nodes,
an error message is returned. Check the controller node status, and retry 
the request.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

### /2.0/vdn/controller/cluster/syslog
Working With Controller Cluster Syslog Configuration
-----
  
When you configure syslog on the NSX Controller cluster, the same 
settings are applied to all nodes in the cluster.

**Syslog Parameters**

Parameter |  Description | Comments
---|---|---
**syslogServer** | Syslog server address | Required. Specify up to 10. Valid input: IPv4 addresses or FQDN. If FQDN is used, DNS must also be configured.
**port** | Syslog exporter port | Optional. Default is *6514*. Valid ports: *1-65535*. 
**level** | Syslog logging level | Optional. Default is *INFO*. Valid values: *INFO*, *ERROR*, *WARN*. 
**protocol** | Syslog protocol | Optional. Default is *TLS*. Valid values: *TLS*, *UDP*, *TCP*.
**certificate** | Certificate | Required if **protocol** is set to *TLS*. Valid value: X.509 PEM encoded certificate.

* **get** *(secured)*: Retrieve syslog settings for the NSX Controller cluster.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

* **put** *(secured)*: Update syslog settings for all nodes in the NSX Controller cluster.

If the settings fail to apply to one or more controller nodes,
an error message is returned. Check the controller node status, and retry 
the request.

**Important**: You can also configure syslog on an individual
controller node with the deprecated API `POST/DELETE
/api/2.0/vdn/controller/{controllerId}/syslog`. Using both these
methods is not supported and might result in an inconsistent state on
the controller nodes.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

### /2.0/vdn/controller/credential
Working With the NSX Controller Password
------

* **put** *(secured)*: Change the NSX controller password.

### /2.0/vdn/controller/synchronize
Working With Controller Synchronization
-------
You can resynchronize the NSX Controller cluster with NSX Manager. You
might want to do this if you notice that the controller cluster has extra,
stale, or missing configuration items.

* **put** *(secured)*: Synchronize the controller cluster with the NSX Manager database.

### /2.0/vdn/controller/synchronize/status
Working with Controller Synchronization Status
----
Retrieve the status of the controller synchronization.

* **get** *(secured)*: Get the status of the controller synchronization.

If the sync is in progress, the response includes the status
*JOB_IN_PROGRESS*, and the jobId.
If the sync has finished, the response includes the status *NOT_RUNNING*.

## hostsHealth
Working With Hypervisor Tunnel Health Status Using BFD
==============
Provides overall information about tunnel health of hypervisor. Tunnel, pNIC, control plane, and management plane statuses are displayed.

### /2.0/vdn/host/status
Working with overall information about tunnel health of a hypervisor
----

* **get** *(secured)*: Retrieve  overall information about tunnel health of a hypervisor.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /2.0/vdn/host/{hostId}/status
Working with tunnel health status for a specific host
----

* **get** *(secured)*: Retrieve information about tunnel health status for a specific host.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /2.0/vdn/host/{hostId}/tunnel
Working with tunnel connections for a specific host
----

* **get** *(secured)*: Retrieve tunnel connections for a specific host.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /2.0/vdn/host/{hostId}/remote-host-status
Working with remote host status 
----

* **get** *(secured)*: Retrieve status of all remote hosts with tunnel connections to the given host.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

## bfdConfig
Working With BFD Configuration Information
==============
Provides information about BFD configured on the interface.
You can enable or disable BFD to monitor tunnel health of a hypervisor. By default, BFD is disabled.

**BFD Parameters**

Parameter |  Description | Comments
---|---|---
  **enabled**      |Enable or disable BFD to monitor tunnel health of a hypervisor.|Required. Options are *True* or *False*. Default is *False*.
  **pollingIntervalSecondsForHost**     |Configure the BFD polling interval.|Required. Value should be greater than *30*. Default value is *180*.
  **bfdIntervalMillSecondsForHost**     |Configure the interval of BFD session.|Required. Value should be greater than *30*. Default value is *120000*.
  

### /2.0/vdn/bfd/configuration/global

* **get** *(secured)*: Retrieve the BFD global configuration.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **put** *(secured)*: Update the BFD global configuration.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

## pnicCheckConfig
Working With pNIC Configuration Information 
==============
Provides the status information about physical NIC (pNIC) global configuration.
You can enable or disable pNIC to monitor tunnel health of a hypervisor. By default, pNIC is disabled.
    
**pNIC Parameters**

Parameter |  Description | Comments
---|---|---
  **enabled**      |Enable or disable pNIC to monitor tunnel health of a hypervisor.|Required. Options are *True* or *False*. Default is *False*.
  **pollingIntervalSecondsForHost**     |Configure the pNIC polling interval for the host.|Required. Value should be greater than *30*. Default value is *180*.

### /2.0/vdn/pnic-check/configuration/global

* **get** *(secured)*: Get pNIC status information. 

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **put** *(secured)*: Update the global configuration for pNIC status check.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

## servicesApps
Working With Services Grouping Objects
=============

### /2.0/services/application/scope/{scopeId}
Retrieve Services from a Specific Scope
----

* **get** *(secured)*: Retrieve services that have been created on the specified scope.

### /2.0/services/application/{scopeId}
Create a Service on a Specific Scope
------

* **post** *(secured)*: Create a new service on the specified scope.

### /2.0/services/application/{applicationId}
Working With a Specified Service
-------

* **get** *(secured)*: Retrieve details about the specified service. 

* **put** *(secured)*: Modify the name, description, applicationProtocol, or port value of a
service.

* **delete** *(secured)*: Delete the specified service.

## applicationgroup
Working With Service Groups Grouping Objects
============

### /2.0/services/applicationgroup/{scopeId}
Creating Service Groups on a Specific Scope
-------

* **post** *(secured)*: Create a new service group on the specified scope.

### /2.0/services/applicationgroup/scope/{scopeId}
Working With Service Groups on a Specific Scope
-------

* **get** *(secured)*: Retrieve a list of service groups that have been created on the scope.

### /2.0/services/applicationgroup/{applicationgroupId}
Working With a Specific Service Group
----

* **get** *(secured)*: Retrieve details about the specified service group.
* **put** *(secured)*: Modify the name, description, applicationProtocol, or port value of
the specified service group.

* **delete** *(secured)*: Delete the specified service group (application group) from a scope.

### /2.0/services/applicationgroup/{applicationgroupId}/members/{moref}
Working With a Specific Service Group Member
-----

* **put** *(secured)*: Add a member to the service group.
* **delete** *(secured)*: Delete a member from the service group.

### /2.0/services/applicationgroup/scope/{scopeId}/members
Working With Service Group Members on a Specific Scope
------

* **get** *(secured)*: Get a list of member elements that can be added to the service groups
created on a particular scope.

## ipPoolsObjects
Working With IP Pool Grouping Objects
========

### /2.0/services/ipam/pools/scope/{scopeId}
Working With IP Pools on a Specific Scope
-----

* **get** *(secured)*: Retrieves all IP pools on the specified scope where the **scopeId** is the
reference to the desired scope. An example of the **scopeID** is
*globalroot-0*.

* **post** *(secured)*: Create a pool of IP addresses. For **scopeId** use *globalroot-0* or
the *datacenterId* in upgrade use cases.

### /2.0/services/ipam/pools/{poolId}
Working With a Specific IP Pool
------

* **get** *(secured)*: Retrieve details about a specific IP pool.
* **put** *(secured)*: To modify an IP pool, query the IP pool first. Then modify the output and
send it back as the request body.

* **delete** *(secured)*: Delete an IP pool.

### /2.0/services/ipam/pools/{poolId}/ipaddresses
Working With IP Pool Address Allocations
------

* **get** *(secured)*: Retrieves all allocated IP addresses from the specified pool.

* **post** *(secured)*: Allocate an IP address from the pool. 

To allocate the next available IP, set **allocationMode** to *ALLOCATE*  

```
<ipAddressRequest>
  <allocationMode>ALLOCATE</allocationMode>
</ipAddressRequest>
```

To allocate a specific IP, set **allocationMode** to *RESERVE* and pass
the IP to reserve in the **ipAddress** parameter.

```
<ipAddressRequest>
  <allocationMode>RESERVE</allocationMode>
  <ipAddress>192.168.1.2</ipAddress>
</ipAddressRequest>
```

### /2.0/services/ipam/pools/{poolId}/ipaddresses/{ipAddress}
Working With Specific IPs Allocated to an IP Pool
----

* **delete** *(secured)*: Release an IP address allocation in the pool.

## nsxLicensing
Working With Licensing 
============
The licensing capacity usage API command reports usage of CPUs, VMs and
concurrent users for the distributed firewall and VXLAN. The licensing
status API command displays details about the assigned license.

### /2.0/services/licensing/capacityusage
Working With Licensing Capacity
---------------
The licensing capacity usage API command reports usage of CPUs, VMs and
concurrent users for the distributed firewall and VXLAN. 

* **get** *(secured)*: Retrieve capacity usage information on the usage of CPUs, VMs and concurrent
users for the distributed firewall and VXLAN.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/services/licensing/status
Working With Licensing Status
-----------
The licensing status API command displays details about the assigned license.

* **get** *(secured)*: Retrieve details about the assigned license.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

## securitytags
Working With Security Tags
=====

You can manage security tags and their virtual machine assignments. For
example, you can create a user defined security tag, assign tags to a
virtual machine, view tags assigned to virtual machines, and view virtual
machines that have a specific tag assigned.

### /2.0/services/securitytags/tag
Managing Security Tags
-----

* **post** *(secured)*: Create a new security tag.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method updated. **isUniversal** parameter can be set to create a universal security tag.

* **get** *(secured)*: Retrieve all security tags.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method updated. Added **isUniversal** query parameter to filter universal security tags.
6.3.3 | Method updated. Output is now paginated. **startIndex**, **pageSize**, **sortOrderAscending**, **sortBy**, **filterBy**, and **filterValue** query parameters added.

### /2.0/services/securitytags/tag/{tagId}
Delete a Security Tag
----

* **delete** *(secured)*: Delete the specified security tag.

### /2.0/services/securitytags/tag/{tagId}/vm
Working With Virtual Machines on a Specific Security Tag
----

* **get** *(secured)*: Retrieve the list of VMs that have the specified tag attached to
them.

* **post** *(secured)*: Attach or detach a security tag to a virtual machine.

This operation does not check that the virtual machine exists in
the local inventory. This allows you to attach a universal
security tag to a virtual machine that is connected to a secondary
NSX Manager (and therefore is not connected to the primary NSX
Manager where the call is sent).

Possible keys for the tagParameter are:
* instance_uuid
* bios_uuid
* vmname

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

### /2.0/services/securitytags/tag/{tagId}/vm/{vmId}
Manage a Security Tag on a Virtual Machine
----

* **put** *(secured)*: Apply a security tag to the specified virtual machine.

**Note:** this method can attach a universal security tag to a
virtual machine. However, this method checks that the VM exists
on the NSX Manager to which the API call is sent. In a
cross-vCenter active active environment, the VM might exist on
a secondary NSX Manager, and so the call would fail. 

You can instead use the `POST
/api/2.0/services/securitytags/tag/{tagId}/vm?action=attach`
method to attach universal security tags to a VM that is not
local to the primary NSX Manager. This method does not check
that the VM is local to the NSX Manager.

* **delete** *(secured)*: Detach a security tag from the specified virtual machine.

### /2.0/services/securitytags/tag/{tagId}/vmDetail
Working With Virtual Machine Details for a Specific Security Tag
-----

* **get** *(secured)*: Retrieve details about the VMs that are attached to the
specified security tag.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

### /2.0/services/securitytags/vm/{vmId}
Working With Security Tags on a Specific Virtual Machine
-----

* **get** *(secured)*: Retrieve all security tags associated with the specified virtual
machine.

* **post** *(secured)*: Update security tags associated with the specified virtual machine.

You can assign multiple tags at a time to the specified VM, or clear
all assigned tags from the specified VM.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

### /2.0/services/securitytags/selection-criteria
Working With Security Tags Unique ID Selection Criteria
-------
In NSX versions before 6.3.0, security tags are local to a NSX Manager,
and are mapped to VMs using the VM's managed object ID.

In NSX 6.3.0 and later, you can create universal security tags to use in
all NSX Managers in a cross-vCenter NSX environment.

In an active standby environment, the managed object ID for a given VM
might not be the same in the active and standby datacenters. NSX 6.3.x
introduces a Unique ID Selection Criteria on the primary NSX Manager to
use to identify VMs when attaching them to universal security tags only.
You can use them singly or in combination. The VM instance UUID is the
recommended selection criteria. See the descriptions for more
information.

The default value for the selection criteria is null and must be set
before assigning a universal security tag to a VM. The selection
criteria can be set only on the primary NSX manager and is read-only on
secondary NSX Managers.

Security Tag Assignment<br>Metadata Parameter | Description
------|-------
instance_uuid | The VM instance UUID is generally unique within a vCenter domain, however there are exceptions such as when deployments are made through snapshots. If the VM instance UUID is not unique, you can use the VM BIOS UUID in combination with the VM name.
bios_uuid | The BIOS UUID is not guaranteed to be unique within a vCenter domain, but it is always preserved in case of disaster. Use BIOS UUID in combination with VM name to reduce the chance of a duplicate ID.
vmname | If all of the VM names in an environment are unique, then VM name can be used to identify a VM across vCenters. Use VM name in combination with VM BIOS UUID to reduce the chance of a duplicate ID.

* **get** *(secured)*: Retrieve unique ID section criteria configuration.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

* **put** *(secured)*: Configure the unique ID section criteria configuration.

If you set the selection criteria and assign security tags to VMs, you
must remove all security tags from VMs before you can change the
selection criteria.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

## ssoConfig
Working With NSX Manager SSO Registration
============

### /2.0/services/ssoconfig

* **get** *(secured)*: Retrieve SSO Configuration.
* **post** *(secured)*: Register NSX Manager to SSO Services.
* **delete** *(secured)*: Deletes the NSX Manager SSO Configuration.

### /2.0/services/ssoconfig/status
Working With SSO Configuration Status
-----

* **get** *(secured)*: Retrieve the SSO configuration status of NSX Manager.

## userMgmt
Working With User Management
==========

### /2.0/services/usermgmt/user/{userId}
Manage Users on NSX Manager
-----

* **get** *(secured)*: Get information about a user.
* **delete** *(secured)*: Remove the NSX role for a vCenter user.

### /2.0/services/usermgmt/user/{userId}/enablestate/{value}
Working With User Account State
-----

* **put** *(secured)*: You can disable or enable a user account, either local user or vCenter
user. When a user account is created, the account is enabled by default.

### /2.0/services/usermgmt/role/{userId}
Manage NSX Roles for Users
-----
Possible roles are:
* *super_user* - built-in admin user
* *vshield_admin* - NSX Administrator
* *enterprise_admin* - Enterprise Administrator
* *security_admin* - Security Administrator
* *auditor* - Auditor

Two additional roles are introduced in NSX 6.4.2.
* *security_engineer* - Security Engineer
* *network_engineer* - Network Engineer

* **get** *(secured)*: Retrieve a user's role. 

* **post** *(secured)*: Add role and resources for a user.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method updated. Two roles, *security_engineer* and *network_engineer* added.

* **put** *(secured)*: Change a user's role.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method updated. Two roles, *security_engineer* and *network_engineer* added.

* **delete** *(secured)*: Delete the role assignment for specified vCenter user. Once this role
is deleted, the user is removed from NSX Manager. You cannot delete the
role for a local user.

### /2.0/services/usermgmt/users/vsm
Working With NSX Manager Role Assignment
----

* **get** *(secured)*: Get information about users who have been assigned a NSX Manager role
(local users as well as vCenter users with NSX Manager role).

### /2.0/services/usermgmt/roles
Working With Available NSX Manager Roles
----

* **get** *(secured)*: Read all possible roles in NSX Manager

### /2.0/services/usermgmt/scopingobjects
Working With Scoping Objects
----

* **get** *(secured)*: Retrieve a list of objects that can be used to define a user's access
scope.

## servicesAuth
Working with API Authentication
==========

### /2.0/services/auth/basic
Working with Basic Authentication
---------------

* **put** *(secured)*: Update whether basic authentication is enabled. 

Authentication headers are ignored, and the credentials used 
in the request body are used instead. This request works whether 
or not basic authenication is enabled.

All NSX Manager systems in a cross-vCenter NSX environment must 
have the same enabled/disabled status for basic authentication. If you
disable basic authentication on one NSX Manager in a cross-vCenter 
NSX environment, you must disable it on all NSX Manager systems in the 
environment.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

* **get** *(secured)*: Retrieve basic authentication configuration.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

### /2.0/services/auth/token
Working with API Tokens
--------
You can create a JSON Web Token and use it to authenticate with the 
NSX Manager appliance in subsequent API requests.

* **post** *(secured)*: Create a new authentication token.

You can use this token in your REST client to access the API. Send the
token in the Authorization header with the AUTHTOKEN keyword. See the
documentation for your REST client for more information.

**Example Authorization header:**
```
Authorization: AUTHTOKEN eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTUyMDU1NTU0NH0.bXPVyHp6uR4HmCmyIMcgJQIS-E1xeb6MLz_3BDk7Lzw
```

By default, this token is created with the default expiry value. You 
can also set a custom expiration using the *expiresInMinutes* query 
parameter.

If a user authenticates with a token, and the user is deleted or their
NSX access is disabled, their token will remain valid until the token
expires.

To create a token when basic authentication is disabled, see 
`POST /api/3.0/services/auth/token`.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced. 

### /2.0/services/auth/tokenexpiration
Working With API Token Expiration
---------
You can configure the default expiry time of API tokens. New tokens are
created with this expiry time.

* **put** *(secured)*: Update the default token expiry time.

The default expiry time is 90 minutes. The maximum expiry time is 24 hours.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced. 

* **get** *(secured)*: Retrieve the default token expiry time.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced. 

### /2.0/services/auth/tokeninvalidation
Working With Token Invalidation
----

* **post** *(secured)*: Invalidate tokens created by the specified user.

**Method history:**

Release | Modification
--------|-------------
6.4.1 | Method introduced. 

## 3AuthToken
Working with API Authentication
======

### /3.0/services/auth/token

* **post** *(secured)*: Create a new authentication token.

Authentication headers are ignored, and the credentials used 
in the request body are used instead. This request works whether 
or not Basic Authenication is enabled.
  
You can use this token in your REST client to access the API. Send the
token in the Authorization header with the AUTHTOKEN keyword. See the
documentation for your REST client for more information.

**Example Authorization header:**
```
Authorization: AUTHTOKEN eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTUyMDU1NTU0NH0.bXPVyHp6uR4HmCmyIMcgJQIS-E1xeb6MLz_3BDk7Lzw
```

By default, this token is created with the default expiry value
(see `GET/PUT /api/2.0/services/auth/tokenexpiration`). You 
can also set a custom expiration using the *expiresInMinutes* query 
parameter.

If a user authenticates with a token, and the user is deleted or their
NSX access is disabled, their token will remain valid until the token
expires.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

## secGroup
Working With Security Group Grouping Objects
===========
A security group is a collection of assets or grouping objects from your
vSphere inventory.

### /2.0/services/securitygroup/bulk/{scopeId}
Creating New Security Groups With Members
----

* **post** *(secured)*: Create a new security group on a global scope or universal scope with
membership information.

Universal security groups are read-only when querying a secondary NSX
manager.

When you create a universal security group (on scope
*universalroot-0*) by default **localMembersOnly** is set to *false*
which indicates that the universal security group will contain members
across the cross-vCenter NSX environment.  This is the case in an
active active environment. You can add the following
objects to a universal security group with *localMembersOnly=false*
(active active):
* IP Address Set
* MAC Address Set
* Universal Security Groups with *localMembersOnly=false*

When you create a universal security group (on scope
*universalroot-0*) you can set the extendedAttribute
**localMembersOnly** to *true* to indicate that the universal security
group will contain members local to that NSX Manager only.  This is
the case in an active standby environment, because only one NSX
environment is active at a time, and the same VMs are present in each
NSX environment. You can add the following objects to a universal
security group with *localMembersOnly=true* (active standby):
* Universal Security Tag
* IP Address Set
* MAC Address Set
* Universal Security Groups with *localMembersOnly=true*
* Dynamic criteria using VM name

You can set the **localMembersOnly** attribute only when the universal
security group is created, it cannot be modified afterwards.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Extended attribute **localMembersOnly** introduced.

### /2.0/services/securitygroup/{scopeId}
Creating New Security Groups Without Members
-----

* **post** *(secured)*: Create a new security group, with no membership information specified.
You can add members later with `PUT
/2.0/services/securitygroup/bulk/{objectId}`

When you create a universal security group (on scope
*universalroot-0*) by default **localMembersOnly** is set to *false*
which indicates that the universal security group will contain members
across the cross-vCenter NSX environment.  This is the case in an
active active environment. You can add the following
objects to a universal security group with *localMembersOnly=false*
(active active):
* IP Address Set
* MAC Address Set
* Universal Security Groups with *localMembersOnly=false*

When you create a universal security group (on scope
*universalroot-0*) you can set the extendedAttribute
**localMembersOnly** to *true* to indicate that the universal security
group will contain members local to that NSX Manager only.  This is
the case in an active standby environment, because only one NSX
environment is active at a time, and the same VMs are present in each
NSX environment. You can add the following objects to a universal
security group with *localMembersOnly=true* (active standby):
* Universal Security Tag
* IP Address Set
* MAC Address Set
* Universal Security Groups with *localMembersOnly=true*
* Dynamic criteria using VM name

You can set the **localMembersOnly** attribute only when the universal
security group is created, it cannot be modified afterwards.
 
**Method history:**

Release | Modification
--------|-------------
6.3.0 | Extended attribute **localMembersOnly** introduced.

### /2.0/services/securitygroup/bulk/{objectId}
Updating a Specific Security Group Including Membership
----

* **put** *(secured)*: Update configuration for the specified security group, including
membership information.

### /2.0/services/securitygroup/{objectId}
Working With a Specific Security Group
----

* **get** *(secured)*: Retrieve all members of the specified security group.
* **put** *(secured)*: Update configuration for the specified security group. Members are not
updated. You must use `PUT
/2.0/services/securitygroup/bulk/{objectId}` to update a security
group membership.

* **delete** *(secured)*: Delete an existing security group.

If *force=true* is specified, the object is deleted even if used in
other configurations, such as firewall rules. If *force=true* is not
specified, the object is deleted only if it is not used by other
configuration; otherwise the delete fails.

### /2.0/services/securitygroup/{objectId}/members/{memberId}
Working With Members of a Specific Security Group
----

* **put** *(secured)*: Add a new member to the specified security group.

* **delete** *(secured)*: Delete member from the specified security group.

### /2.0/services/securitygroup/{objectId}/translation/virtualmachines
Working With Virtual Machines in a Security Group
----

* **get** *(secured)*: Retrieve effective membership of a security group in terms of virtual
machines. The effective membership is calculated using all the three
membership components of a security group - static include, static
exclude, and dynamic using the following formula:
  
Effective membership virtual machines = [ (VMs resulting from static include
component + VMs resulting from dynamic component) - (VMs resulting from static
exclude component) ]

### /2.0/services/securitygroup/{objectId}/translation/ipaddresses
Working With IP Addresses in a Security Group
-----

* **get** *(secured)*: Retrieve list of IP addresses that belong to a specific security
group.

### /2.0/services/securitygroup/{objectId}/translation/macaddresses
Working With MAC Addresses in a Security Group
-----

* **get** *(secured)*: Retrieve list of MAC addresses that belong to a specific security
group.

### /2.0/services/securitygroup/{objectId}/translation/vnics
Working With vNICs in a Security Group
-----

* **get** *(secured)*: Retrieve list of vNICs that belong to a specific security group.

### /2.0/services/securitygroup/lookup/virtualmachine/{virtualMachineId}
Working With Virtual Machine Security Group Membership
------

* **get** *(secured)*: Retrieves the collection of security groups to which a virtual machine
is a direct or indirect member. Indirect membership involves nesting of
security groups.

### /2.0/services/securitygroup/lookup/ipaddress/{ipAddress}
Working With IP Address in a Security Group
------

* **get** *(secured)*: Retrieve all the security groups that contain the specified IP address.

### /2.0/services/securitygroup/internal/scope/{scopeId}
Working With Internal Security Groups
----

* **get** *(secured)*: Retrieve all internal security groups on the NSX Manager. These are used
 internally by the system and should not be created or modified by end
users.

### /2.0/services/securitygroup/scope/{scopeId}
Working With Security Groups on a Specific Scope
----

* **get** *(secured)*: List all the security groups created on a specific scope.

### /2.0/services/securitygroup/scope/{scopeId}/memberTypes
Working With Security Group Member Types
----

* **get** *(secured)*: Retrieve a list of valid elements that can be added to a security
group.

### /2.0/services/securitygroup/scope/{scopeId}/members/{memberType}
Working With a Specific Security Group Member Type
----

* **get** *(secured)*: Retrieve members of a specific type in the specified scope.

## ipsets
Working With IP Set Grouping Objects
=======

### /2.0/services/ipset/scope/{scopeMoref}
Working With IP Sets on a Specific Scope
----

* **get** *(secured)*: Retrieve all configured IPSets

### /2.0/services/ipset/{scopeMoref}
Creating New IP Sets
-----

* **post** *(secured)*: Create a new IP set.

### /2.0/services/ipset/{ipsetId}
Working With a Specific IP Set
----

* **get** *(secured)*: Retrieve an individual IP set.
* **put** *(secured)*: Modify an existing IP set.
* **delete** *(secured)*: Delete an IP set.

## vCenterConfig
Configuring NSX Manager with vCenter Server
=========
You can synchronize NSX Manager with a vCenter Server, which enables the
Networking and Security tab in the vCenter Web Client to display your VMware
Infrastructure inventory.

**vCenter Config Parameters**

Parameter | Comments
----|----
**ipAddress** | FQDN or IP address of vCenter server.
**userName** | Required.
**password** | Required.
**certificateThumbprint** | Required. Must be colon (:) delimited hexadecimal.
**assignRoleToUser** | Optional. *true* or *false*.
**pluginDownloadServer** | Optional.
**pluginDownloadPort** | Optional.

### /2.0/services/vcconfig

* **get** *(secured)*: Get vCenter Server configuration details on NSX Manager.
* **put** *(secured)*: Synchronize NSX Manager with vCenter server.

### /2.0/services/vcconfig/status
Connection Status for vCenter Server
-----

* **get** *(secured)*: Get default vCenter Server connection status.

### /2.0/services/vcconfig/connectionstatus
Working with vCenter Server Connection 
-----
 Validates the vCenter connection by actually trying connection to vCenter Server with the available credentials instead of the cached state. Returns *true* if vCenter connectivity is successful and *false* if fails. If the vCenter connectivity has issues, then it disconnects the default connection. 

Note: If previously connected, this API tries to re-connect to the vCenter Server which may take time to respond. If vCenter Server is non-responsive, then the API may result in timeout error.

**Method history:**
  
Release | Modification
  --------|-------------
6.4.0 | Method introduced. 

* **post** *(secured)*: Update the vCenter Server connection status.

## IndexMaintenanceConfig
Configuring Index Maintainance 
=========
If you have few tables in the database that is taking up most of the space, you can configure your index maintenance activities. 
You can reindex the tables, and tables with index bloat size greater than 75% are reindexed.

### /2.0/services/housekeeping/management/index_maintenance

* **get** *(secured)*: Retrieve the default settings for the index maintenance activities.

**Method history:**

Release | Modification
--------|-------------
6.3.3 | Method introduced.

* **put** *(secured)*: Update the index maintenance default settings. You can enable or disable the settings and change the CRON configuration. To make the changes effective, you must restart the NSX Manager. To change the CRON expression, 
make sure the new CRON expression is correct using any CRON evaluators. Note that incorrect CRON expression will not run the reindexing task at the expected frequency.

**CRON expression guidelines**: 
  
  CRON expression pattern is a list of six single space-separated fields,representing second, minute, hour, day, month, weekday. Month and weekday can be given as first three letters of the English names.
  You can refer to the following Web sites for details:
    
  *  https://docs.spring.io/spring/docs/current/javadoc-api/org/springframework/scheduling/support/CronSequenceGenerator.html
  *  http://www.manpagez.com/man/5/crontab/

**Method history:**
  
Release | Modification
  --------|-------------
6.3.3 | Method introduced. 

* **post** *(secured)*: Trigger the reindexing task on demand. Tables with index bloat size greater than 75% are reindexed.

**Method history:**
  
Release | Modification
  --------|-------------
6.3.3 | Method introduced. 

## CPUConfiguration
Configuring the High CPU Usage Reporting Tool 
=========
You can configure the monitoring of high CPU usage for a defined time period using the High CPU Usage Reporting tool.  The CPU Usage Monitoring Tool uses this configuration to monitor CPU utilization of the NSX Manager. 
You can configure the parameter values to monitor the CPU utilization. 

**CPU Configuration Parameters**

  Parameter | Comments
  ----|----
  **delay** | Time between two monitoring sessions in milliseconds.
  **intervals** | The number of monitoring sessions. This is a positive integer value.   
  **highcputhreshold** | Enter threshold value for high CPU usage. Threshold value is a percentage value ranging from 1 to 100.
  **mediumcputhreshold** | Enter threshold value for medium CPU usage. Threshold value is a percentage value ranging from 1 to 100.
  **monitoringfeatureenabled** | Enter *true* to enable CPU usage monitoring feature. Enter *false* to disable CPU usage monitoring feature.

  **Method history:**
  
  Release | Modification
  --------|-------------
  6.4.0 | Method introduced.

### /2.0/services/configuration

* **get** *(secured)*: Get the configuration details for the High CPU Usage Reporting Tool.
* **put** *(secured)*: Update the configuration for the High CPU Usage Reporting Tool.

## CPUUsage
Working with the CPU Usage Monitoring Tool 
=========
Monitoring tool monitors CPU usage of the NSX Manager. The configurations for the CPU usage are defined in the High CPU Usage Reporting Tool. 
Monitoring tool displays values for CPU utilization as High, Medium, and Low.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /2.0/system-monitor/cpuusage/indicator
Working With CPU Usage Indicator
----

* **get** *(secured)*: Retrieve the CPU utilization status and the CPU usage percentage.

### /2.0/system-monitor/cpuusage/details
Working With CPU Usage Details
-------------        

* **get** *(secured)*: Retrieve the details of the module which is causing high CPU utilization for the NSX Manager.

## universalSync
Working With Universal Sync Configuration in Cross-vCenter NSX
======

### /2.0/universalsync/configuration/role
Working With Universal Sync Configuration Roles
----
You can set the role of an NSX Manager to primary, secondary, or
standalone. If you set an NSX Manager’s role to primary, then use it to
create universal objects, and then set the role to standalone, the role
will be set as transit. In the transit role, the universal objects will
still exist, but cannot be modified, other than being deleted.

* **post** *(secured)*: Set the universal sync configuration role.
* **get** *(secured)*: Retrieve the universal sync configuration role.

### /2.0/universalsync/configuration/nsxmanagers
Working With Universal Sync Configuration of NSX Managers
-----

* **post** *(secured)*: Add a secondary NSX manager.

Run this method on the primary NSX Manager, providing details of the
secondary NSX Manager.

Retrieve the certificate thumbprint of the secondary NSX Manager
using the `GET
/api/1.0/appliance-management/certificatemanager/certificates/nsx`
method. The **sha1Hash** parameter contains the thumbprint.

* **get** *(secured)*: If run on a primary NSX Manager, it will list secondary NSX Managers
configured on the primary NSX Manager.

If run on a secondary NSX Manager, it will list information about
the secondary NSX Manager and the primary NSX Manager it is
associated with.

* **delete** *(secured)*: Delete secondary NSX manager configuration.

### /2.0/universalsync/configuration/nsxmanagers/{nsxManagerID}
Universal Sync Configuration of a Specific NSX Manager
----

* **get** *(secured)*: Retrieve information about the specified secondary NSX Manager.

* **delete** *(secured)*: Delete the specified secondary NSX Manager.
* **put** *(secured)*: Update the the specified secondary NSX manager IP or thumbprint in
the universal sync configuration.

### /2.0/universalsync/sync
NSX Manager Synchronization
----

* **post** *(secured)*: Sync all objects on the NSX Manager.

### /2.0/universalsync/entitystatus
Working With Universal Sync Entities
----

* **get** *(secured)*: Retrieve the status of a universal sync entity.

### /2.0/universalsync/status
Working With Universal Sync Status
-----

* **get** *(secured)*: Retrieve the universal sync status.

## applianceManager
Working With the Appliance Manager
========

With the appliance management tool, you can manage:
* System configurations like network configuration, syslog, time settings,
  and certificate management etc.
* Components of appliance such as NSX Manager, Postgres, SSH component,
  RabbitMQ service.
* Overall support related features such as tech support logs, backup
  restore, status, and summary reports of appliance health.

### /1.0/appliance-management/global/info
Global Information for NSX Manager
----

* **get** *(secured)*: Retrieve global information containing version information as well as
current logged in user.

### /1.0/appliance-management/summary/system
Summary Information for NSX Manager
----

* **get** *(secured)*: Retrieve system summary info such as address, DNS name, version, CPU,
memory and storage.

### /1.0/appliance-management/summary/components
Component Information for NSX Manager
----

* **get** *(secured)*: Retrieve summary of all available components and their status info.

### /1.0/appliance-management/system/restart
Reboot NSX Manager
-----

* **post** *(secured)*: Reboot the NSX Manager appliance.

### /1.0/appliance-management/system/cpuinfo
NSX Manager Appliance CPU Information
-----

* **get** *(secured)*: Retrieve NSX Manager Appliance CPU information.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. Added **cpuUsageIndicator** parameter.

### /1.0/appliance-management/system/cpuinfo/details
NSX Manager Appliance CPU Details
-----

* **get** *(secured)*: Retrieve details about CPU utilization for the NSX Manager Appliance.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /1.0/appliance-management/system/uptime
NSX Manager Appliance Uptime Information
----

* **get** *(secured)*: Retrieve NSX Manager uptime information.

**Example response:**
```
25 days, 22 hours, 11 minutes
```

### /1.0/appliance-management/system/meminfo
NSX Manager Appliance Memory Information
-----

* **get** *(secured)*: Retrieve NSX Manager memory information.

### /1.0/appliance-management/system/storageinfo
NSX Manager Appliance Storage Information
----

* **get** *(secured)*: Retrieve NSX Manager storage information.

### /1.0/appliance-management/system/network
NSX Manager Appliance Network Settings
----

* **get** *(secured)*: Retrieve network information for the NSX Manager appliance. i.e. host name, IP address, DNS settings.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. New parameter *dynamicIPAddress* added. The parameter tells whether the IP address of the NSX Appliance Manager is dynamically allocated or not. If *dynamicIPAddress* parameter is *true*, then the Unconfigure ipv4/ipv6 button on the UI is disabled.

* **put** *(secured)*: Update network information for the NSX Manager appliance.

### /1.0/appliance-management/system/network/dns
Working With DNS Configuration
-----

* **put** *(secured)*: Configure DNS.
* **delete** *(secured)*: Delete DNS server configuration.

### /1.0/appliance-management/system/securitysettings
Working With Security Settings
----

* **get** *(secured)*: Retrieve the NSX Manager FIPS and TLS settings.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

* **post** *(secured)*: Update the NSX Manager security settings, including FIPS and TLS.

Do not enable FIPS until you have upgraded all NSX components to NSX
6.3.0 or later. Enable FIPS on NSX Edges before enabling it on the NSX
Manager.

Changing the FIPS mode will reboot the NSX Manager appliance.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

### /1.0/appliance-management/system/tlssettings
Working With TLS Settings
----

* **get** *(secured)*: Retrieve TLS settings.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **post** *(secured)*: Update TLS settings.

Include a comma separated list of the TLS versions you want to enable,
for both server and client.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /1.0/appliance-management/system/timesettings
Working With Time Settings
------
You can either configure time or specify the NTP server to be used for
time synchronization.

* **get** *(secured)*: Retrieve time settings, like timezone or current date and time with
NTP server, if configured.

* **put** *(secured)*: Configure time or specify the NTP server to use for time
synchronization.

### /1.0/appliance-management/system/timesettings/ntp
Working With NTP Settings
----

* **delete** *(secured)*: Delete NTP server.

### /1.0/appliance-management/system/locale
Configure System Locale
----

* **get** *(secured)*: Retrieve locale info.
* **put** *(secured)*: Configure locale.

### /1.0/appliance-management/system/syslogserver
Working With Syslog Server
-----

* **get** *(secured)*: Retrieves only the first syslog server among the servers configured.
* **put** *(secured)*: Configures one syslog server. If there are syslog server(s) already configured, this API replaces the first one in the list.
* **delete** *(secured)*: Deletes all the syslog servers.

### /1.0/appliance-management/system/syslogservers
Working With Multiple Syslog Servers
-----

* **get** *(secured)*: Retrieves all syslog servers configured on the NSX Manager.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **put** *(secured)*: Configure one or more syslog servers. Unconfigures all servers that were previously configured, and configures the one provided in the request body for this API. Duplicates are ignored. 

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **delete** *(secured)*: Deletes all the syslog servers. Same as *DELETE /system/syslogserver* API.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /1.0/appliance-management/components
Working With Components
----

The NSX Manager appliance has the following components.

Component | Description |
------|--------
NSX | NSX Manager
NSXREPLICATOR | Universal Synchronization Service
RABBITMQ | RabbitMQ - Messaging service
SSH | SSH Service
VPOSTGRES | vPostgres - Database service

* **get** *(secured)*: Retrieve all appliance manager components.

### /1.0/appliance-management/components/component/{componentID}
Working With a Specific Component
----

* **get** *(secured)*: Retrieve details for the specified component.

### /1.0/appliance-management/components/component/{componentID}/dependencies
Working With Component Dependencies
----

* **get** *(secured)*: Retrieve dependency details for the specified component.

### /1.0/appliance-management/components/component/{componentID}/dependents
Working With Component Dependents
----

* **get** *(secured)*: Retrieve dependents for the specified component.

### /1.0/appliance-management/components/component/{componentID}/status
Working With Component Status
----

* **get** *(secured)*: Retrieve current status for the specified component.

### /1.0/appliance-management/components/component/{componentID}/toggleStatus/{command}
Toggle Component Status
-----

* **post** *(secured)*: Start or stop a component.

### /1.0/appliance-management/components/component/APPMGMT/restart
Working With the Appliance Management Web Application
-----

* **post** *(secured)*: Restart the appliance management web application.

### /1.0/appliance-management/backuprestore/backupsettings
NSX Manager Appliance Backup Settings
-----
You can back up and restore your NSX Manager data, which can include
system configuration, events, and audit log tables. Configuration tables
are included in every backup. Backups are saved to a remote location that
must be accessible by the NSX Manager.

**FTP parameters for backup and restore**

Parameter | Description | Comments
---|---|---
**transferProtocol** | Transfer protocol. | Required. *SFTP* or *FTP*.
**hostNameIPAddress** | Backup server hostname or IP address. | Required. 
**port** | Transfer protocol port. | Required. Determined by backup server configuration, standard ports are *22* for *SFTP*, *21* for *FTP*.
**userName** | User name to log in to backup server. | Required.
**password**| Password for user on backup server. | Required.
**backupDirectory** | Directory location to save backup files on backup server. |  Required.
**fileNamePrefix** | Prefix for backup files. | Required. 
**passPhrase** | Passphrase to encrypt and decrypt backups. | Required.
**passiveMode** | Use passive mode. | Optional. Default is *true*.
**useEPRT** | Use EPRT. | Optional. Default is *false*.
**useEPSV** | Use EPSV. | Optional. Default is *true*.

**Backup frequency parameters**

Parameter | Description | Comments
---|---|---
**frequency** | Frequency to run backups | *WEEKLY*, *DAILY*, or *HOURLY*.
**dayOfWeek** | Day of week to run backups. | Required for *WEEKLY* backups. *SUNDAY, MONDAY, ..., SATURDAY*.
**hourOfDay** | Hour of day to run backups. | Required for *WEEKLY* and *DAILY* backups. [*0-23*].
**minuteOfHour** | Minute of hour to run backups. | Required for *WEEKLY*, *DAILY*, and *HOURLY* backups. [*0-59*].
**excludeTable** | Table to exclude from backups. | Optional if **excludeTables** section is omitted. Specify *AUDIT_LOG*, *SYSTEM_EVENTS*, or *FLOW_RECORDS*. You can provide multiple **excludeTable** parameters.

* **get** *(secured)*: Retrieve backup settings.
* **put** *(secured)*: Configure backups on the appliance manager.

You must set a **passPhrase** for the backups. The passphrase is used
to encrypt and decrypt backup files. If you do not set a passphrase, backups
will fail. If you forget the passphrase set on a backup file, you cannot
restore that backup file.

**Method history:**

Release | Modification
--------|-------------
6.3.3 | Method updated. Parameters **passiveMode** and **useEPSV** previously defaulted to *false*, now default to *true*.

* **delete** *(secured)*: Delete appliance manager backup configuration.

### /1.0/appliance-management/backuprestore/backupsettings/ftpsettings
NSX Manager Appliance Backup FTP Settings
---
See *NSX Manager Appliance Backup Settings* for details.

* **put** *(secured)*: Configure FTP settings.

**Method history:**

Release | Modification
--------|-------------
6.3.3 | Method updated. Parameters **passiveMode** and **useEPSV** previously defaulted to *false*, now default to *true*.

### /1.0/appliance-management/backuprestore/backupsettings/excludedata
NSX Manager Appliance Backup Exclusion Settings
---
See *NSX Manager Appliance Backup Settings* for details.

* **put** *(secured)*: Specify tables that need not be backed up.

### /1.0/appliance-management/backuprestore/backupsettings/schedule
NSX Manager Appliance Backup Schedule Settings
---
See *NSX Manager Appliance Backup Settings* for details.

* **put** *(secured)*: Set backup schedule.
* **delete** *(secured)*: Delete backup schedule.

### /1.0/appliance-management/backuprestore/backup
NSX Manager Appliance On-Demand Backup
----

* **post** *(secured)*: Start an on-demand NSX Manager backup.

You must set the **Content-Type** header to *application/xml* for the
backup to run successfully.

### /1.0/appliance-management/backuprestore/backups
Working With NSX Manager Appliance Backup Files
-----

* **get** *(secured)*: Retrieve list of all backups available at configured backup location.

### /1.0/appliance-management/backuprestore/restore
Restoring Data from an NSX Manager Appliance Backup File
------

* **post** *(secured)*: Restore data from a backup file.

Retrieve a list of restore files using `GET /api/1.0/appliance-management/backuprestore/backups`.

Restore the backup to a newly deployed, unconfigured NSX Manager
appliance. Restoring to an NSX Manager which is in use might result in
inconsistent behavior.

**Method history:**

Release | Modification
--------|-------------
6.4.1 | Method updated. Query parameter *forceRestore* added.

### /1.0/appliance-management/techsupportlogs/{componentID}
Working With Tech Support Logs by Component
----

* **post** *(secured)*: Generate tech support logs. The location response header contains the
location of the created tech support file. 

### /1.0/appliance-management/techsupportlogs/{filename}
Working With Tech Support Log Files
-----

* **get** *(secured)*: Download tech support logs.

### /1.0/appliance-management/notifications
Working With Support Notifications
----

* **get** *(secured)*: Retrieve all system generated notifications.
* **delete** *(secured)*: Delete all notifications.

### /1.0/appliance-management/notifications/{ID}/acknowledge
Acknowledge Notifications
----

* **post** *(secured)*: Acknowledge a notification. The notification is then deleted from
the system.

### /1.0/appliance-management/upgrade
Upgrading NSX Manager Appliance
----
  
To upgrade NSX Manager, you must do the following:
  * upload an upgrade bundle   
    `POST /api/1.0/appliance-management/upgrade/uploadbundle/{componentID}`
  * retrieve the upgrade information   
    `GET /api/1.0/appliance-management/upgrade/information/{componentID}`
  * edit the **preUpgradeQuestionsAnswers** section of the upgrade
    information response to include answers
  * start the upgrade, providing the edited **preUpgradeQuestionsAnswers**
    section as the request body   
    `POST /api/1.0/appliance-management/upgrade/start/{componentID}`

### /1.0/appliance-management/upgrade/uploadbundle/{componentID}
Upload an NSX Manager Upgrade Bundle
----
You must upload the upgrade bundle using the form-data content-type.
Consult the documentation for your REST client for instructions. 

Do not set other Content-type headers in your request, for
example, *Content-type: application/xml*.

When you upload a file as form-data, you must provide a **key**
and a **value** for the file. The **key** is *file*, and the **value**
is the location of the upgrade bundle file.

**Example using curl**
```
/usr/bin/curl -v -k -i -F file=@/tmp/VMware-NSX-Manager-upgrade-bundle-6.2.7-5343628.tar.gz -H 'Authorization: Basic YWRtaW46ZGXXXXXXXX==' 
https://192.168.110.42/api/1.0/appliance-management/upgrade/uploadbundle/NSX
```

* **post** *(secured)*: Upload upgrade bundle.

### /1.0/appliance-management/upgrade/uploadbundlefromurl
Upload an NSX Manager Upgrade Bundle from URL
----
You can upload the upgrade bundle using the URL. Supported protocols are HTTP, HTTPS, and FTP.  

You must provide the URL of the upgrade bundle file. 
  **For example**: 
  * NSX?fileurl=http://www.vmware.com/build/mts/release/final-5934867/publish/VMware-NSX-Manager-upgrade-bundle-6.4.0-5934867.tar.gz
  * NSX?fileurl=ftp://10.112.11.53/backup/VMware-NSX-Manager-upgrade-bundle-6.4.0-6864920.tar.gz

* **post** *(secured)*: Upload upgrade bundle from URL.

**Method history:**

Release | Modification
--------|-------------
6.3.3 | Method introduced.
6.4.0 | Method updated. FTP protocol support added.

### /1.0/appliance-management/upgrade/information/{componentID}
Prepare for NSX Manager Upgrade
---

* **get** *(secured)*: Once you have uploaded an upgrade bundle, you must retrieve
information about the upgrade. This request contains pre-upgrade
validation warnings and error messages, along with pre-upgrade
questions. 

You use the **preUpgradeQuestionsAnswers** section with the addition of
your answers to create the request body for the `POST
/api/1.0/appliance-management/upgrade/start/{componentID}` request to
start the backup.  See *Start the NSX Manager Upgrade* for more
information.

### /1.0/appliance-management/upgrade/start/{componentID}
Start the NSX Manager Upgrade
----

* **post** *(secured)*: Start upgrade process.

If you want to enable SSH or join the VMware CEIP program, you must
specify *Yes* (not *YES*) for the **answer** parameter.

### /1.0/appliance-management/upgrade/status/{componentID}
NSX Manager Upgrade Status
----

* **get** *(secured)*: Query upgrade status.

### /1.0/appliance-management/certificatemanager
Working With Certificates on the NSX Manager Appliance
-------

### /1.0/appliance-management/certificatemanager/pkcs12keystore/nsx
Working With Keystore Files
------------
You must upload a key store file by using the *form-data* content-type in the request body. 
See the documentation of your REST client for instructions.

To upload a file with form-data as the content-type, specify a **key** and a **value** for the file. 
The **key** is *file* with type as *File*, and the **value** is the keystore file that you want to upload.

**Example using curl**
```
/usr/bin/curl -v -k -i -F file=@/tmp/cert.p12 -H 'Authorization: Basic YWRtaW46ZGXXXXXXXX==' 
https://192.168.110.42/api/1.0/appliance-management/certificatemanager/pkcs12keystore/nsx?password=password
```

* **post** *(secured)*: Upload keystore file.

Input is PKCS#12 formatted NSX file with form-data.

### /1.0/appliance-management/certificatemanager/certificates/nsx
NSX Manager Certificate Manager
--------

* **get** *(secured)*: Retrieve certificate information from the NSX Manager.

**Method history:**

Release | Modification
--------|-------------
6.4.4 | Method updated. PEM encoding of the certificate is added in the response body.

### /1.0/appliance-management/certificatemanager/csr/nsx
Working With Certificate Signing Requests
------

* **post** *(secured)*: Create a certificate signing request (CSR) for NSX Manager.

The response header contains the created file location.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced. Replaces `PUT /api/1.0/appliance-management/certificatemanager/csr/nsx`.

* **get** *(secured)*: Retrieve generated certificate signing request (CSR).

### /1.0/appliance-management/certificatemanager/uploadchain/nsx
Working With Certificate Chains
-----
You must upload a certificate chain file by using the *form-data* content-type in the request body. 
See the documentation of your REST client for instructions.

To upload a file with form-data as the content-type, specify a **key** and a **value** for the file. 
The **key** is *file* with type as *File*, and the **value** is the certificate chain file that you want to upload.

**Example using curl**
```
/usr/bin/curl -v -k -i -F file=@/tmp/cert.pem -H 'Authorization: Basic YWRtaW46ZGXXXXXXXX=='
https://192.168.110.42/api/1.0/appliance-management/certificatemanager/uploadchain/nsx
```

* **post** *(secured)*: Upload certificate chain.

Input is certificate chain file which is a PEM encoded chain of
certificates received from the certification authority after signing a CSR.

## threaddump
Working with NSX Manager Debug APIs
=========

You can use the NSX Manager debug APIs to troubleshoot problems on the NSX Manager.

### /1.0/services/debug/threaddump

* **get** *(secured)*: Generates the thread dump of the NSX Manager and captures the output of the **top** command. 
The **top** output helps you to monitor the processes and the usage of the system resources on the NSX Manager.
The combined output (**top** output + thread dump) is saved in a separate **threaddump_top** log file. 
To view the files, download the NSX Manager tech support bundle. The files are available inside *Bundle_Name*\logs\threaddump.

## systemEvents
Working With NSX Manager System Events
==========

### /2.0/systemevent

* **get** *(secured)*: Get NSX Manager system events 

**Method history:**

Release | Modification
--------|-------------
6.4.0 |  Method updated. New parameters **eventSourceId**, **eventSourceType**, **eventSourceIP** added under **eventSourceInfo**.

## hostevents
Working with Host Event Notifications
==========

You can enable host event notifications on the NSX Manager as a security feature to detect potential denial-of-service (DoS) attack on hosts. 
By default, host event notifications are enabled. 
To view host event notifications in the vSphere Web Client, navigate to **Networking & Security > System > Events > Monitor > System Events**.
These notifications are also displayed as alarms in the vSphere Web Client.

### /2.0/hostevents

* **get** *(secured)*: Retrieve configuration of host event notifications.
  
**Method history:**
  
Release | Modification
  --------|-------------
6.4.0 |  Method added.

* **post** *(secured)*: Add configuration of host event notifications on the NSX Manager and host.

**Method history:**
  
Release | Modification
  --------|-------------
6.4.0 |  Method added.

Request body parameters:

  * **enabled** - Required. Enable or disable host event notifications. Options are True or False.
  * **notificationInterval** - Required. Time interval in seconds at which the NSX Manager receives host event notifications from each host. Valid range is 300 to 3600.

## auditLogs
Working With NSX Manager Audit Logs
==========

You can retrieve NSX Manager audit logs. The following table translates the
names used for modules in the API and the vSphere Web Client UI.

Navigate to **Networking & Security > NSX Managers > *NSX Manager* >
Monitor > Audit Logs** to view the logs in the vSphere Web Client UI.

### Module Names for Audit Logs in API and UI

API Names for Audit Log Modules | UI Names for Audit Log Modules
---|---
UNKNOWN | Unknown
ZONES_FIREWALL | App Firewall
EDGE_FIREWALL | Edge Firewall
EDGE | Edge
EDGE_NAT | Edge NAT
EDGE_SNAT | Edge SNAT
EDGE_DNAT | Edge DNAT
EDGE_DHCP | Edge DHCP
EDGE_VPN | Edge VPN
EDGE_LB | Edge Load Balancer
EDGE_SYSLOG | Edge Syslog
EDGE_STATIC_ROUTING | Edge Static Routing
EDGE_TRAFFICSTATS | Edge Traffic Stats
EDGE_SUPPORT | Edge Support
EDGE_CERTIFICATE | Edge Certificate
EPSEC | Guest Introspection
NETWORK_ISOLATION | Port Group Isolation
INVENTORY | Inventory
SDD | Data Security
SHIELD | vShield
SYSTEM | System
UPGRADE | Upgrade
ACCESS_CONTROL | Access Control
DLP | Data Recovery
APPLICATION | Application
IP_SET | IP Addresses
MAC_SET | MAC Addresses
SECURITY_GROUP | Security Group
SPOOFGUARD | SpoofGuard
APP_FAIL_SAFE | App Fail Safe Config
APP_EXCLUDE_LIST | App Exclude List
SYSLOG_SERVER_CONFIG | Syslog Server Config
TRUST_STORE | Trust Store
PASSWORD_CHANGE | Password Change
SSO_CONFIG | SSO Config
BACKUP_RESTORE | Backup Restore
SSL_CERTIFICATE | SSL Certificate
APPLICATION_GROUP | Application Group
NAMESPACE | Namespace
DYNAMIC_SET | Dynamic set
DYNAMIC_CRITERIA | Dynamic criteria
NamespaceService | Namespace Service
SECURITY_POLICY | Security Policy
SECURITY_TAG | Security Tag

### /2.0/auditlog

* **get** *(secured)*: Get NSX Manager audit logs.

## telemetry
Working With the VMware Customer Experience Improvement Program
=====

NSX Data Center for vSphere participates in VMware’s Customer Experience Improvement Program (CEIP).

See "Customer Experience Improvement Program" in the *NSX Administration
Guide* for more information.

### /1.0/telemetry/config
Working With the VMware CEIP Configuration
----
You can join or leave the CEIP at any time. You can also define the
frequency and the days the information is collected.

**CEIP Parameters**

Parameter | Description | Comments
---|---|---
**enabled** | Enable status of data collection | *true* or *false*.
**frequency** | Frequency of data collection | *daily*, *weekly*, or *monthly*.
**dayOfWeek** | Day to collect data | *SUNDAY*, *MONDAY*, ... *SATURDAY*.
**hourOfDay** | Hour to collect data | *0-23*.
**minutes** | Minute to collect data | *0-59*.
**lastCollectionTime** | Time of last collection. | Timestamp in milliseconds. Read only.

* **get** *(secured)*: Retrieve the CEIP configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced. 

* **put** *(secured)*: Update the CEIP configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced. 
6.3.3 | Method updated. *minutes* parameter is configurable.

### /1.0/telemetry/proxy
Working With Proxy Setting for VMware CEIP 
-----
  
If your NSX Manager appliance does not have a direct connection to the 
internet, you can configure a proxy server for the purpose of sending
information collected by CEIP to VMware.

**CEIP Proxy Parameters**

Parameter | Description | Comments
---|---|---
**enabled** | Enabled status of proxy | Required. Default is *AUTO*.<br>*OFF*: use direct connection<br>*MANUAL*: use settings defined here<br>*AUTO*: use proxy auto-discovery.
**scheme** | Proxy scheme. | Required if **enabled** is set to *MANUAL*. Valid value: *http*. Default is *http*.
**hostname** | Hostname of proxy server | Required if **enabled** is set to *MANUAL*.
**port** | Port used for proxy server | Required if **enabled** is set to *MANUAL*. Default is *0*.
**username** | Proxy server username | Optional.
**password** | Proxy server password | Optional. Not included in GET response.

* **get** *(secured)*: Retrieve the NSX Manager proxy settings for CEIP.

**Method history:**

Release | Modification
--------|-------------
6.3.3 | Method introduced. 

* **put** *(secured)*: Retrieve the NSX Manager proxy settings for CEIP.

**Method history:**

Release | Modification
--------|-------------
6.3.3 | Method introduced. 

## nwfabric
Working With Network Fabric Configuration
=====

### /2.0/nwfabric/configure
Working With Network Virtualization Components and VXLAN
---
Cluster preparation can be broken down into the following:
  * Install VIB and non-VIB related action: Before any per-host config
  a VIB must be installed on the host. The feature can use this time to
  perform other bootstrapping tasks which do not depend on
  VIB-installation. e.g. VXLAN creates the vmknic-pg and sets up some
  opaque data.
  * Post-VIB install: Prepare each host for the feature. In the case of
  VXLAN, create vmknics.

* **post** *(secured)*: Install network fabric or VXLAN.

This method can be used to perform the following tasks: 
* Install Network Virtualization Components
* Configure VXLAN
* Configure VXLAN with LACPv2
* Reset Communication Between NSX Manager and a Host or Cluster

**Parameter Information**

| Name | Comments |
|------|----------|
|**resourceId** | vCenter MOB ID of cluster. For example, *domain-c7*. A host can be specified when resetting communication. For example, *host-24*. |
|**featureId** | Feature to act upon. Omit for network virtualization components operations. Use *com.vmware.vshield.vsm.vxlan* for VXLAN operations, *com.vmware.vshield.vsm.messagingInfra* for message bus operations.|
|**ipPoolId** | Used for VXLAN installation. If not specified, DHCP is used for VTEP address assignment.|
|**teaming** | Used for VXLAN installation. Options are *FAILOVER_ORDER*, *ETHER_CHANNEL*, *LACP_ACTIVE*, *LACP_PASSIVE*, *LOADBALANCE_LOADBASED*, *LOADBALANCE_SRCID*, *LOADBALANCE_SRCMAC*, *LACP_V2*|
|**uplinkPortName** | The *uplinkPortName* as specified in vCenter.|

### Install Network Virtualization Components

`POST /api/2.0/nwfabric/configure`

```
<nwFabricFeatureConfig>
  <resourceConfig>
    <resourceId>CLUSTER MOID</resourceId>
  </resourceConfig>
</nwFabricFeatureConfig>
```

### Configure VXLAN

`POST /api/2.0/nwfabric/configure`

```
<nwFabricFeatureConfig>
  <featureId>com.vmware.vshield.vsm.vxlan</featureId>
  <resourceConfig>
    <resourceId>CLUSTER MOID</resourceId>
    <configSpec class="clusterMappingSpec">
      <switch>
        <objectId>DVS MOID</objectId></switch>
        <vlanId>0</vlanId>
        <vmknicCount>1</vmknicCount>
        <ipPoolId>IPADDRESSPOOL ID</ipPoolId>
    </configSpec>
  </resourceConfig>
  <resourceConfig>
    <resourceId>DVS MOID</resourceId>
    <configSpec class="vdsContext">
      <switch>
          <objectId>DVS MOID</objectId>
      </switch>
      <mtu>1600</mtu>
      <teaming>ETHER_CHANNEL</teaming>
    </configSpec>
  </resourceConfig>
</nwFabricFeatureConfig>
```

### Configure VXLAN with LACPv2

`POST /api/2.0/nwfabric/configure`

```
<nwFabricFeatureConfig>
  <featureId>com.vmware.vshield.nsxmgr.vxlan</featureId>
  <resourceConfig>
    <resourceId>CLUSTER MOID</resourceId>
    <configSpec class="clusterMappingSpec">
      <switch>
        <objectId>DVS MOID</objectId>
      </switch>
      <vlanId>0</vlanId>
      <vmknicCount>1</vmknicCount>
    </configSpec>
  </resourceConfig>
  <resourceConfig>
    <resourceId>DVS MOID</resourceId>
    <configSpec class="vdsContext">
      <switch>
        <objectId>DVS MOID</objectId>
      </switch>
      <mtu>1600</mtu>
      <teaming>LACP_V2</teaming>
      <uplinkPortName>LAG NAME</uplinkPortName>
    </configSpec>
  </resourceConfig>
</nwFabricFeatureConfig>
```

### Reset Communication Between NSX Manager and a Host or Cluster

`POST /api/2.0/nwfabric/configure?action=synchronize`

``` 
<nwFabricFeatureConfig>
  <featureId>com.vmware.vshield.vsm.messagingInfra</featureId>
  <resourceConfig>
    <resourceId>resourceId</resourceId>
  </resourceConfig>
</nwFabricFeatureConfig> 
```

* **put** *(secured)*: Upgrade Network virtualization components.

This API call can be used to upgrade network virtualization components.
After NSX Manager is upgraded, previously prepared clusters must have
the 6.x network virtualization components installed.

* **delete** *(secured)*: Remove VXLAN or network virtualization components.

Removing network virtualization components removes previously
installed VIBs, tears down NSX Manager to ESXi messaging, and removes
any other network fabric dependent features such as logical switches.
If a feature such as logical switches is being used in your
environment, this call fails.

Removing VXLAN does not remove the network virtualization components
from the cluster.

| Name | Comments |
|------|----------|
|**resourceId** | vCenter MOB ID of cluster. For example, domain-c7.|
|**featureId** | Feature to act upon. Omit for network virtualization components operations. Use *com.vmware.vshield.vsm.vxlan* for VXLAN operations.|

### Remove Network Virtualization Components

```
<nwFabricFeatureConfig>
  <resourceConfig>
    <resourceId>CLUSTER MOID</resourceId>
  </resourceConfig>
</nwFabricFeatureConfig>
```

### Remove VXLAN

```
<nwFabricFeatureConfig>
  <featureId>com.vmware.vshield.vsm.vxlan</featureId>
  <resourceConfig>
    <resourceId>CLUSTER MOID</resourceId>
   </resourceConfig>
</nwFabricFeatureConfig>
```

### Remove VXLAN with vDS context

```
<nwFabricFeatureConfig>
  <featureId>com.vmware.vshield.vsm.vxlan</featureId>
  <resourceConfig>
    <resourceId>CLUSTER MOID</resourceId>
    <configSpec class="map">
      <entry>
        <keyclass="java.lang.String">vxlan</key>
        <valueclass="java.lang.String">cascadeDeleteVdsContext</value>
      </entry>
    </configSpec>
  </resourceConfig>
</nwFabricFeatureConfig>
```

### /2.0/nwfabric/resolveIssues/{clusterID}
Resolving Host Preparation Issues
---

* **post** *(secured)*: Resolve all issues associated with host preparation (VIB installation). You can
resolve issues only at the cluster level.

### /2.0/nwfabric/features
Working With Network Fabric Features
---

* **get** *(secured)*: Retrieves all network fabric features available on the cluster. Multiple
**featureInfo** sections may be returned.

### /2.0/nwfabric/status
Working With Network Fabric Status
----

* **get** *(secured)*: Retrieve the network fabric status of the specified resource.

### /2.0/nwfabric/status/child/{parentResourceID}
Working With Network Fabric Status of Child Resources
----

* **get** *(secured)*: Retrieve the network fabric status of child resources of the specified resource.

### /2.0/nwfabric/status/alleligible/{resourceType}
Working With Status of Resources by Criterion
----

* **get** *(secured)*: Retrieve status of resources by criterion.

### /2.0/nwfabric/clusters/{clusterID}
Working With Locale ID Configuration For Clusters
---

* **get** *(secured)*: Retrieve the locale ID for the specified cluster.
* **put** *(secured)*: Update the locale ID for the specified cluster.
* **delete** *(secured)*: Delete locale ID for the specified cluster.

### /2.0/nwfabric/hosts/{hostID}
Working With Locale ID Configuration for Hosts
----

* **get** *(secured)*: Retrieve the locale ID for the specified host.
* **put** *(secured)*: Update the locale ID for the specified host.
* **delete** *(secured)*: Delete the locale ID for the specified host.

## securityFabric
Working With Security Fabric and Security Services
======
The security fabric simplifies and automates deployment of security
services and provide a platform for configuration of the elements that are
required to provide security to workloads. These elements include:

Internal components:
* Guest Introspection Universal Service Virtual Machine
* Guest Introspection Mux
* Logical Firewall

External components:
* Partner OVFs / VIBs
* Partner vendor policy templates

For partner services, the overall workflow begins with registration of
services by partner consoles, followed by deployment of the services by
the administrator.

Subsequent workflow is as follows:
1. Select the clusters on which to deploy the security fabric (Mux,
Traffic filter, USVM).
2. Specify an IP pool to be used with the SVMs (available only if the
partner registration indicates requirement of static IPs)
3. Select portgroup (DVPG) to be used for each cluster (a default is
pre-populated for the user).
4. Select datastore to be used for each cluster (a default is
pre-populated for the user).
5. NSX Manager deploys the components on all hosts of the selected
clusters.

Once you deploy the security fabric, an agency defines the configuration
needed to deploy agents (host components and appliances). An agency is
created per cluster per deployment spec associated with services.  Agents
are deployed on the selected clusters, and events / hooks for all the
relevant actions are generated.

**Request parameters**

Parameter | Description 
-------|---------
dataStore |Needs to be specified only in POST call. In PUT call, it should be left empty. 
dvPortGroup |Optional. If not specified, then user will set the Agent using vCenter Server. 
ipPool |Optional. If not specified, IP address is assigned through DHCP. 

### /2.0/si/deploy

* **post** *(secured)*: Deploy security fabric.

* **put** *(secured)*: Upgrade service to recent version.

The datastore, dvPortGroup, and ipPool variables should either not be
specified or have same value as provided at time of deployment.

### /2.0/si/deploy/service/{serviceID}
Working With a Specified Service
----

* **get** *(secured)*: Retrieve all clusters on which the service is installed.
* **delete** *(secured)*: Uninstall specified service from specified clusters.

### /2.0/si/deploy/service/{serviceID}/dependsOn
Working With Service Dependencies
----
Services installed through the security fabric may be dependent on
other services. When an internal service is registered, a dependencyMap
is maintained with the service-id and implementation type of the
internal service.

When partner registers a new service, the security fabric looks up its
implementation type in the dependencyMap to identify the service it
depends on, if any. Accordingly, a new field in Service object called
dependsOn-service-id is populated.

* **get** *(secured)*: Retrieve service on which the specified service depends.

### /2.0/si/deploy/cluster/{clusterID}
Working With Installed Services on a Cluster
---

* **get** *(secured)*: Retrieve all services deployed along with their status.
* **delete** *(secured)*: Uninstall a service. Fails if you try to remove a service that another
service depends on.

In order to uninstall services in any order, set parameter ignoreDependency to true.

### /2.0/si/deploy/cluster/{clusterID}/service/{serviceID}
Working With a Specific Service on a Cluster
-----

* **get** *(secured)*: Retrieve detailed information about the service.

## eventControl
Working With Data Collection for Activity Monitoring
===========
Activity Monitoring provides visibility into your virtual network to
ensure that security policies at your organization are being enforced
correctly.

A Security policy may mandate who is allowed access to what applications.
The Cloud administrator can generate Activity Monitoring reports to see if
the IP based firewall rule that they set is doing the intended work. By
providing user and application level detail, Activity Monitoring
translates high level security policies to low level IP address and
network based implementation.

Once you enable data collection for Activity Monitoring, you can run
reports to view inbound traffic (such as virtual machines being accessed
by users) as well as outbound traffic (resource utilization, interaction
between inventory containers, and AD groups that accessed a server).

You must enable data collection for one or more virtual machines on a
vCenter Server before running an Activity Monitoring report. Before
running a report, ensure that the enabled virtual machines are active and
are generating network traffic.

You should also register NSX Manager with the AD Domain Controller. See
"Working With Domains".

Note that only active connections are tracked by Activity Monitoring.
Virtual machine traffic blocked by firewall rules at the vNIC level is not
reflected in reports.

In case of an emergency such as a network overload, you can turn off data
collection at a global level. This overrides all other data collection
settings.

Some API calls may require the VMID, which is the MOID of the guest
virtual machine. You can retrieve this by queuing the vCenter mob
structure (https:VC-IP-Address/mob). The VMID is listed under host
structure.

### /1.0/eventcontrol/vm/{vmID}/request
Working With Data Collection on a Specific Virtual Machine
----
You must enable data collection at least five minutes before running an
Activity Monitoring report.

* **post** *(secured)*: Enable or disable data collection on a virtual machine

Set **value** to *enabled* or *disabled*.

### /1.0/eventcontrol/eventcontrol-root/request
Override Data Collection
----

* **post** *(secured)*: Turn data collection on or off at the global level.

In case of an emergency such as a network overload, you can turn off
data collection at a global level (kill switch). This overrides all
other data collection settings.

Set **value** to *enabled* or *disabled*.

### /1.0/eventcontrol/config/vm/{vmID}
Retrieve Data Collection Configuration for a Specific Virtual Machine
-----
When reporting per virtual machine configuration, current kill switch
status is also reported too. The effective configuration of a virtual
machine is determined by both kill switch config and per virtual machine
configuration. If kill switch is on, event collection is effectively
disabled regardless of what its per virtual machine configuration is; if
kill switch is off, per virtual machine configuration determines whether
event collection should be performed for this virtual machine.

* **get** *(secured)*: Retrieve per VM configuration for data collection.

## activityMonitoring
Working With Activity Monitoring
======

### /3.0/ai/records
Working With Aggregated User Activity
--------------
Get aggregated user activity (action records) using parameters. Requires
that Guest Introspection is configured, NSX Manager must be
registered with Active Directory, and data collection is enabled on one
or more VMs.

* **get** *(secured)*: ### View Outbound Activity

You can view what applications are being run by a security group or
desktop pool and then drill down into the report to find out which
client applications are making outbound connections by a particular
group of users. You can also discover all user groups and users who are
accessing a particular application, which can help you determine if you
need to adjust identity firewall in your environment.

* query=*resource*
* param=&lt;param-name&gt;:&lt;param-type&gt;:&lt;comma-separated-values&gt;:&lt;operator&gt;, where:
  * &lt;param-name&gt; is one of:
    * *src* (required)
    * *dest* (required)
    * *app*
  * &lt;param-type&gt; is one of:
    * for src: *SECURITY_GROUP*, *DIRECTORY_GROUP*, *DESKTOP_POOL*
    * for dest: *VIRTUAL_MACHINE*
    * for app: *SRC_APP*
  * &lt;comma-separated-values&gt; is a comma-separated numbers (optional). If none specified then no filter is applied.
  * &lt;operator&gt; is one of *INCLUDE*, *EXCLUDE* (default is *INCLUDE*).

**Example:** View user activities to VM ID 1 originating from application
ID 1  
```
GET /api/3.0/ai/records?query=resource&interval=60m&
param=src:DIRECTORY_GROUP&param=dest:VIRTUAL_MACHINE:1&param=app:SRC_APP:1
```

### View Inbound Activity

You can view all inbound activity to a server by desktop pool, security
group, or AD group.

* query=*sam*
* param=&lt;param-name&gt;:&lt;param-type&gt;:&lt;comma-separated-values&gt;:&lt;operator&gt;, where:
  * &lt;param-name&gt; is one of:
    * *src* (required)
    * *dest* (required)
    * *app*
  * &lt;param-type&gt; is one of:
    * for src: *SECURITY_GROUP*, *DIRECTORY_GROUP*, *DESKTOP_POOL*
    * for dest: *VIRTUAL_MACHINE*
    * for app: *DEST_APP*
  * &lt;comma-separated-values&gt; is a comma-separated numbers (optional). If none specified then no filter is applied.
  * &lt;operator&gt; is one of *INCLUDE*, *EXCLUDE*, *NOT* (default is *INCLUDE*).

**Example:** View user activities to VM ID 1 originating from
application ID 1  
```
GET /api/3.0/ai/records?query=containers&interval=60m&
param=dest:SECURITY_GROUP:1:EXCLUDE &param=src:SECURITY_GROUP:1
```

### View Interaction between Inventory Containers
You can view the traffic passing between defined containers such as AD
groups, security groups and/or desktop pools. This can help you identify
and configure access to shared services and to resolve misconfigured
relationships between Inventory container definitions, desktop pools and
AD groups.

* query=*containers*
* param=&lt;param-name&gt;:&lt;param-type&gt;:&lt;comma-separated-values&gt;:&lt;operator&gt;, where:
  * &lt;param-name&gt; is one of:
    * *src* (required)
    * *dest* (required)
  * &lt;param-type&gt; is one of:
    * for src: *SECURITY_GROUP*, *DIRECTORY_GROUP*, *DESKTOP_POOL*
    * for dest: *SECURITY_GROUP*, * *DESKTOP_POOL* 
  * &lt;comma-separated-values&gt; is a comma-separated numbers (optional). If none specified then no filter is applied.
  * &lt;operator&gt; is one of *INCLUDE*, *EXCLUDE*, or *NOT* (default * is *INCLUDE*).

**Example:** View interaction between inventory containers  
```
GET /api/3.0/ai/records?query=containers&interval=60m&
param=dest:SECURITY_GROUP:1:EXCLUDE&param=src:SECURITY_GROUP:1
```

### View Outbound AD Group Activity

You can view the traffic between members of defined Active Directory
groups and can use this data to fine tune your firewall rules.

* query=*adg*
* param=&lt;param-name&gt;:&lt;param-type&gt;:&lt;comma-separated-values&gt;:&lt;operator&gt;, where:
  * &lt;param-name&gt; is one of:
    * *src* (required)
    * *adg*
  * &lt;param-type&gt; is one of:
    * for src: *SECURITY_GROUP*, *DESKTOP_POOL*
    * for adg: *USER*
  * &lt;comma-separated-values&gt; is a comma-separated numbers (optional). If none specified then no filter is applied.
  * &lt;operator&gt; is one of *INCLUDE*, *EXCLUDE* (default * is *INCLUDE*).

**Example:** View outbound AD group activity    
```
GET /api/3.0/ai/records?query=adg&interval=24h&
param=adg:USER:1:INCLUDE&param=src:SECURITY_GROUP:1:EXCLUDE
```

### /3.0/ai/userdetails
Working With User Details
---------

* **get** *(secured)*: ### View Outbound Activity
You can view what applications are being run by a security group or
desktop pool and then drill down into the report to find out which
client applications are making outbound connections by a particular
group of users. You can also discover all user groups and users who
are accessing a particular application, which can help you determine
if you need to adjust identity firewall in your environment.

* query=*resource*
* param=&lt;param-name&gt;&lt;param-type&gt;&lt;comma-separated-values&gt;&lt;operator&gt;, where:
  * &lt;param-name&gt; is one of:
    * *src* (required)
    * *dest* (required)
    * *app*
  * &lt;param-type&gt; is one of:
    * for src: *SECURITY_GROUP*, *DIRECTORY_GROUP*, *DESKTOP_POOL*
    * for dest: *IP* - a valid IP address in dot notation, xx.xx.xx.xx
    * for app: *SRC_APP*
  * &lt;comma-separated-values&gt; is a comma-separated numbers (optional). If none specified then no filter is applied.
  * &lt;operator&gt; is one of *INCLUDE*, *EXCLUDE* (default is *INCLUDE*).

**Example:** View user activities to VM ID 1 originating from application ID 1  
```
GET /api/3.0/ai/userdetails?query=resource&stime=2012-10-15T00:00:00&etime=2012-10-20T00:00:00&
param=src:DIRECTORY_GROUP:2&param=app:SRC_APP:16&param=dest:IP:172.16.4.52
```

### View Inbound Activity

You can view all inbound activity to a server by desktop pool, security
group, or AD group.

* query=*sam*
* param=&lt;param-name&gt;&lt;param-type&gt;&lt;comma-separated-values&gt;&lt;operator&gt;, where:
  * &lt;param-name&gt; is one of:
    * *src* (required)
    * *dest* (required)
    * *app* (required)
  * &lt;param-type&gt; is one of:
    * for src: *SECURITY_GROUP*, *DIRECTORY_GROUP*, *DESKTOP_POOL*
    * for dest: *VIRTUAL_MACHINE*
    * for app: *DEST_APP*
  * &lt;comma-separated-values&gt; is a comma-separated numbers (optional). If none specified then no filter is applied.
  * &lt;operator&gt; is one of *INCLUDE*, *EXCLUDE*, *NOT* (default is *INCLUDE*).

**Example:** View user activities to VM ID 1 originating from
application ID 1  
```
GET /api/3.0/userdetails?query=sam&interval=60m&param=app:DEST_APP:1:EXCLUDE
&param=dest:IP:1:EXCLUDE&param=src:SECURITY_GROUP:1:EXCLUDE
```

### View Interaction between Inventory Containers
You can view the traffic passing between defined containers such as AD
groups, security groups and/or desktop pools. This can help you identify
and configure access to shared services and to resolve misconfigured
relationships between Inventory container definitions, desktop pools and
AD groups.

* query=*containers*
* param=&lt;param-name&gt;&lt;param-type&gt;&lt;comma-separated-values&gt;&lt;operator&gt;, where:
  * &lt;param-name&gt; is one of:
    * *src* (required)
    * *dest* (required)
  * &lt;param-type&gt; is one of:
    * for src: *SECURITY_GROUP*, *DIRECTORY_GROUP*, *DESKTOP_POOL*
    * for dest: *SECURITY_GROUP*, * *DESKTOP_POOL* 
  * &lt;comma-separated-values&gt; is a comma-separated numbers (optional). If none specified then no filter is applied.
  * &lt;operator&gt; is one of *INCLUDE*, *EXCLUDE*, or *NOT* (default * is *INCLUDE*).

**Example:** View interaction between inventory containers  
```
GET /api/3.0/ai/userdetails?query=containers&interval=60m&
param=dest:SECURITY_GROUP:1:EXCLUDE&param=src:SECURITY_GROUP:1
```

### View Outbound AD Group Activity

You can view the traffic between members of defined Active Directory
groups and can use this data to fine tune your firewall rules.

* query=*adg*
* param=&lt;param-name&gt;&lt;param-type&gt;&lt;comma-separated-values&gt;&lt;operator&gt;, where:
  * &lt;param-name&gt; is one of:
    * *src* (required)
    * *adg*
  * &lt;param-type&gt; is one of:
    * for src: *SECURITY_GROUP*, *DESKTOP_POOL*
    * for adg: *USER*
  * &lt;comma-separated-values&gt; is a comma-separated numbers (optional). If none specified then no filter is applied.
  * &lt;operator&gt; is one of *INCLUDE*, *EXCLUDE* (default is *INCLUDE*).

**Example:** View outbound AD group activity
```
GET /api/3.0/ai/userdetails?query=adg&interval=24h&param=adg:USER:1:INCLUDE
&param=src:SECURITY_GROUP:1:EXCLUDE
```

### View Virtual Machine Activity Report

* query=*vma*
* param=&lt;param-name&gt;&lt;param-type&gt;&lt;comma-separated-values&gt;&lt;operator&gt;, where:
  * &lt;param-name&gt; is one of:
    * *src*
    * *dst*
    * *app*
    * If no parameters are passed, then this would show all SAM
    activities
  * &lt;param-type&gt; is one of:
    * for src: *SECURITY_GROUP*, *DESKTOP_POOL*
    * for dst: *VIRTUAL_MACHINE*, *VM_UUID*
    * for app - *SRC_APP* or *DEST_APP*
  * &lt;comma-separated-values&gt; is a comma-separated numbers (optional). If none specified then no filter is applied.
  * &lt;operator&gt; is one of *INCLUDE*, *EXCLUDE* (default is *INCLUDE*).

**Example:** View outbound AD group activity
```
GET /api/3.0/ai/userdetails?query=vma&interval=60m&param=dest:VIRTUAL_MACHINE:1&
param=app:DEST_APP:16
```

### /3.0/ai/user/{userID}
Working With a Specific User
----

* **get** *(secured)*: Retrieve details for a specific user.

### /3.0/ai/app
Working With Applications
----

* **get** *(secured)*: Retrieve app details.

### /3.0/ai/app/{appID}
Working With a Specific Application
----

* **get** *(secured)*: Retrieve details for specific app.

### /3.0/ai/host
Working With Discovered Hosts
----

* **get** *(secured)*: Retrieve list of all discovered hosts (both by agent introspection and
LDAP Sync) and their detail.

### /3.0/ai/host/{hostID}
Working With a Specific Discovered Host
----

* **get** *(secured)*: Get host details.

### /3.0/ai/desktoppool
Working With Desktop Pools
-----

* **get** *(secured)*: Retrieve list of all discovered desktop pools by agent introspection.

### /3.0/ai/desktoppool/{desktoppoolID}
Working With a Specific Desktop Pool
----

* **get** *(secured)*: Retrieve specific desktop pool details.

### /3.0/ai/vm
Working With Virtual Machines
----

* **get** *(secured)*: Retrieve list of all discovered VMs.

### /3.0/ai/vm/{vmID}
Working With a Specific Virtual Machine
----

* **get** *(secured)*: Retrieve details about a specific virtual machine.

### /3.0/ai/directorygroup
Working With LDAP Directory Groups
----

* **get** *(secured)*: Retrieve list of all discovered (and configured) LDAP directory
groups.

### /3.0/ai/directorygroup/{directorygroupID}
Working With a Specific LDAP Directory Group
----

* **get** *(secured)*: Retrieve details about a specific directory group.

### /3.0/ai/directorygroup/user/{userID}
Working With a Specific User's Active Directory Groups
-----

* **get** *(secured)*: Retrieve Active Directory groups that user belongs to.

### /3.0/ai/securitygroup
Working With Security Groups
-----

* **get** *(secured)*: Retrieve list of all observed security groups.

Observed entities are the ones that are reported by the agents. For
example, if a host activity is reported by an agent and if that host
belongs to a security group then that security group would reported as
observed in SAM database.

### /3.0/ai/securitygroup/{secgroupID}
Working With a Specific Security Group
----

* **get** *(secured)*: Retrieve details about specific security group.

## domain
Working With Domains
===========
After you create a domain, you can apply a security policy to it and run
queries to view the applications and virtual machines being accessed by
the users of a domain.

### /1.0/directory/updateDomain
Registering Domains
---------------
You can a register one or more Windows domains with an NSX Manager and
associated vCenter server.  NSX Manager gets group and user information
as well as the relationship between them from each domain that it is
registered with. NSX Manager also retrieves Active Directory
credentials.  You can apply security policies on an Active Directory
domain and run queries to get information on virtual machines and
applications accessed by users within an Active Directory domain.

**Parameter Values for Registering or Updating a Domain**

Parameter Name | Description | Required? 
----------------|-------------|------------
**ID** |  Domain id.  If you want to create a new domain, do not provide this value.  Otherwise, the system will find an existing domain object by this ID and update it. | Required if updating existing domain 
**name** |  Domain name.  This should be the domain's fully qualified name. If it's agent discovered, this will be the NetBIOS name, so you need to update it to FQN in order to support LDAP sync and event log reader. | Required if creating a new domain. 
**description** | Domain description | Optional. 
**type** | Domain type. Valid values include: AGENT_DISCOVERED, ACTIVE_DIRECTORY, SPECIAL (Do NOT modify SPECIAL domain). For LDAP sync and event log reader work, this need to be set to ACTIVE_DIRECTORY. | Optional. Default is ACTIVE_DIRECTORY.
**netbiosName** |  NetBIOS name of domain. This is the domain's NetBIOS name. Normally Agent reported domain name is the NetBIOS name. Confirm from Windows domain settings. | Optional. 
**baseDn** | Domain's Base DN (for LDAP sync).  Base DN is required for LDAP Sync. If you have a domain like: w2k3.vshield.vmware.com, the base DN is very likely to be: DC=w2k3,DC=vshield,DC=vmware,DC=com. Another example is: domain name is: vs4.net, the base DN should be: DC=vs4,DC=net. You can use a LDAP client and connect to domain controller to find the domain's base DN. |  Optional. Required for LDAP sync.
**rootDn** | LDAP Sync root DN.  Specify where should LDAP sync start from LDAP tree. This could be an absolute path, for example: OU=Engineer,DC=vs4,DC=net, or a relative path (relative to Base DN), for example: OU=Engineer. |  Optional.
**rootDnItem** | Root DN item. Use instead of **rootDn** if the domain has multiple rootDn values. | Optional.
**securityId** | Domain's Security ID (SID). This should be filled by LDAP sync process, and should not need to be modified. |  Optional. 
**username** |  Domain's User name (Used for LDAP Sync and/or Event Log reader) | Optional. 
**password** | User password | Optional.
**eventLogUsername** | Domain's event log reader username (will use above username if this is NULL) | Optional.
**eventLogPassword** | Domain's event log reader password | Optional.

* **post** *(secured)*: Register or update a domain with NSX Manager

**Example: Domain with one root DN**
  
    <DirectoryDomain>
      <name>example.com</name>
      <netbiosName>Example</netbiosName>
      <baseDn>DC=example,DC=com</baseDn>
      <rootDn>OU=prod,DC=example,DC=com</rootDn>
      <username>Administrator</username>
      <password>xxx</password>
    </DirectoryDomain>

**Example: Domain with multiple root DN**

    <DirectoryDomain>
      <name>example.com</name>
      <netbiosName>Example</netbiosName>
      <baseDn>DC=example,DC=com</baseDn>
      <rootDnItem>OU=prod,DC=example,DC=com</rootDnItem>
      <rootDnItem>OU=test,DC=example,DC=com</rootDnItem>
      <username>Administrator</username>
      <password>xxx</password>
    </DirectoryDomain>
    
**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **rootDnItem** parameter added.

### /1.0/directory/listDomains
Retrieve LDAP Domains
-----

* **get** *(secured)*: Retrieve all agent discovered (or configured) LDAP domains.

### /1.0/directory/deleteDomain/{ID}
Delete a Specific Domain
----

* **delete** *(secured)*: Delete domain.

### /1.0/directory/verifyRootDn
Working with Root Distinguished Names
---------------
Retrieve the list of individual root distinguished names under which each domain sub-tree synchronization is executed.

* **post** *(secured)*: Verify that the rootDNs in the rootDNList are independent to each other.
Verify that the rootDNs in the rootDNList exist in Active Director server.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /1.0/directory/deleteDomainRootDN/{domainID}
Delete DomainRootDN
-------

* **delete** *(secured)*: Delete individual root distinguished name under which each domain sub-tree synchronization is not to be executed.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /1.0/directory/updateLdapServer
Create LDAP Server
------------

* **post** *(secured)*: Create LDAP server.

### /1.0/directory/listLdapServersForDomain/{domainID}
Query LDAP Servers for a Domain
----

* **get** *(secured)*: Query LDAP servers for a domain.

### /1.0/directory/ldapSyncSettings
Update AD Sync Settings
----
  Update AD sync settings (both delta sync and full sync).
  Change delta sync interval, and enable or disable full sync, as well as full sync frequency.

* **post** *(secured)*: LDAP full sync settings

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /1.0/directory/fullSync/{domainID}
Start LDAP Full Sync
----

* **put** *(secured)*: Start LDAP full sync.

### /1.0/directory/deltaSync/{domainID}
Start LDAP Delta Sync
-----

* **put** *(secured)*: Start LDAP delta sync.

### /1.0/directory/deleteLdapServer/{serverID}
Delete LDAP Server
----

* **delete** *(secured)*: Delete LDAP server.

### /1.0/directory/updateEventLogServer
EventLog Server
------

* **post** *(secured)*: Create EventLog server.

### /1.0/directory/listEventLogServersForDomain/{domainID}
Working With EventLog Servers for a Domain
----

* **get** *(secured)*: Query EventLog servers for a domain.

### /1.0/directory/deleteEventLogServer/{serverID}
Delete EventLog Server
-----

* **delete** *(secured)*: Delete EventLog server.

## mappingLists
Working With Mapping Lists
=========

### /1.0/identity/userIpMapping
Working With User to IP Mappings
---

* **get** *(secured)*: Query user-to-ip mapping list from database.

### /1.0/identity/hostIpMapping
Working With Host to IP Mappings
---

* **get** *(secured)*: Query host-to-ip mapping list from database.

### /1.0/identity/ipToUserMapping
Working With IP to User Mappings
----

* **get** *(secured)*: Retrieve set of users associated with a given set of IP addresses during
a specified time period. Since more than one user can be associated
with a single IP address during the specified time period, each IP
address can be associated with zero or more (i.e a SET of) users.

### /1.0/identity/directoryGroupsForUser
Working With User Domain Groups
----

* **get** *(secured)*: Query set of Windows Domain Groups (AD Groups) to which the specified
user belongs.

### /1.0/identity/staticUserMapping/{userID}/{IP}
Working With a Specific Static User Mapping
----

* **post** *(secured)*: Create static user IP mapping.

### /1.0/identity/staticUserMappings
Working With Static User Mappings
----

* **get** *(secured)*: Query static user IP mapping list.

### /1.0/identity/staticUserMappingsbyUser/{userID}
Working With Static User IP Mappings for a Specific User
----

* **get** *(secured)*: Query static user IP mapping for specified user.
* **delete** *(secured)*: Delete static user IP mapping for specified user.

### /1.0/identity/staticUserMappingsbyIP/{IP}
Working With Static User IP Mappings for a Specific IP
----

* **get** *(secured)*: Query static user IP mapping for specified IP.
* **delete** *(secured)*: Delete static user IP mapping for specified IP.

## activityMonitoringSyslog
Working With Activity Monitoring Syslog Support
==========

### /1.0/sam/syslog/enable
Enable Syslog Support
----

* **post** *(secured)*: Enable syslog support.

### /1.0/sam/syslog/disable
Disable Syslog Support
----

* **post** *(secured)*: Disable syslog support.

## solutionIntegration
Working With Solution Integrations
=========

### /2.0/si/host/{hostID}/agents
Working With Agents on a Specific Host
----

* **get** *(secured)*: Retrieves all agents on the specified host. The response body contains
agent IDs for each agent, which you can use to retrieve details about
that agent.

### /2.0/si/agent/{agentID}
Working With a Specific Agent
----

* **get** *(secured)*: Retrieve agent (host components and appliances) details.

### /2.0/si/deployment/{deploymentunitID}/agents
Working With Agents on a Specific Deployment
----

* **get** *(secured)*: Retrieve all agents for the specified deployment.

### /2.0/si/fabric/sync/conflicts
Working With Conflicting Agencies
----
When the NSX Manager database backup is restored to an older point in
time, it is possible that deployment units for some EAM Agencies are
missing. These methods help the administrator identify such EAM Agencies
and take appropriate action.

* **get** *(secured)*: Retrieve conflicting deployment units and EAM agencies, if any, and the
allowed operations on them.

* **put** *(secured)*: Create deployment units for conflicting EAM Agencies, delete
conflicting EAM agencies, or delete deployment units for conflicting
EAM agencies.

### Create deployment units for conflicting EAM agencies

```
<conflictResolverInfo>
  <agencyAction>RESTORE</agencyAction>
</conflictResolverInfo>
```

### Delete conflicting EAM agencies

```
<conflictResolverInfo>
  <agencyAction>DELETE</agencyAction>
</conflictResolverInfo>
```

### Delete deployment units for conflicting EAM agencies

```
<conflictResolverInfo>
  <deploymentUnitAction>DELETE</deploymentUnitAction>
</conflictResolverInfo>
```

## macsets
Working With MAC Address Set Grouping Objects
=============
You can create a MAC address set on the specified scope. On success, the API
returns a string identifier for the new MAC address set.

### /2.0/services/macset/{macsetId}
Working With a Specific MAC Address Set
---------

* **get** *(secured)*: Retrieve details about a MAC address set.
* **put** *(secured)*: Modify an existing MAC address set.
* **delete** *(secured)*: Delete a MAC address set.

### /2.0/services/macset/scope/{scopeId}
Working With MAC Address Sets on a Specific Scope
----

* **post** *(secured)*: Create a MAC address set on the specified scope.

The value parameter can include a single MAC identifier or a comma separated
set of MAC identifiers. Universal MAC address sets are read-only from
secondary managers.

* **get** *(secured)*: List MAC address sets on the specified scope.

## eam
Working With ESX Agent Manager
========
vSphere ESX Agent Manager (EAM) automates the process of deploying and
managing NSX Data Center for vSphere networking and security services.

### /2.0/eam/status
Working With EAM Status
--------

* **get** *(secured)*: Retrieve EAM status from vCenter.

You can verify the status is UP before proceeding with an NSX Data Center 
for vSphere install or upgrade.

**Method history:**

Release | Modification
--------|-------------
6.3.5 | Method introduced.

## servicesSystemAlarms
Working With Alarms
========

Alarms are notifications that are activated in response to an event, a set
of conditions, or the state of an object. Alarms, along with other alerts,
are displayed on the Dashboard and other screens on the vSphere Web
Client UI.

See "Alarms" in the *NSX Logging and System Events Guide* for more information.

Generally, an alarm gets automatically deleted by the system when the error
condition is rectified.  Some alarms are not automatically cleared on a
configuration update. Once the issue is resolved, you have to clear the
alarms manually.   

**Alarm Parameters**

Paramter | Description | Comments
----|-----|------
**resolutionAttempted** | Was resolution of the alarm was attempted? | *true* or *false*. 
**resolvable** | Can the alarm be resolved? | *true* or *false*
**alarmId** | ID of the alarm. | For example, *79965*.
**alarmCode** | Event code which uniquely identifies the system event. | For example, *130027*. 
**alarmSource** | The domain object identifier of the source where you can resolve the reported alarm. | For example, *edge-3*.
**totalCount** | The total number of unresolved alarms. | 

### /2.0/services/systemalarms

* **get** *(secured)*: Retrieve all unresolved alarms on NSX Manager.

**Method history:**

Release | Modification
--------|-------------
6.3.3 | Method introduced.

### /2.0/services/systemalarms/{alarmId}
Working With a Specific System Alarm
-------
You can view and resolve alarms by alarm ID. 

* **get** *(secured)*: Retrieve information about the specified alarm. Both resolved and
unresolved alarms can be retrieved.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

* **post** *(secured)*: Resolve the specified alarm.

System alarms resolve automatically when the cause of the alarm is resolved.
For example, if an NSX Edge appliance is powered off, this triggers a
alarm. If you power the NSX Edge appliance back on, the alarm resolves.
If however, you delete the NSX Edge appliance, the alarm persists,
because the alarm cause was never resolved. In this case, you might want
to manually resolve the alarm. Resolving the alarm will clear it from
the NSX Dashboard.         

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

## servicesAlarmsSource
Working With Alarms from a Specific Source
=====

You can view and resolve alarms from a specific source.

### /2.0/services/alarms/{sourceId}

* **get** *(secured)*: Retrive all alarms from the specified source.

* **post** *(secured)*: Resolve all alarms for the specified source.

Alarms will resolve automatically when the cause of the alarm is
resolved.  For example, if an NSX Edge appliance is powered off, this
will trigger an alarm. If you power the NSX Edge appliance back on, the
alarm will resolve. If however, you delete the NSX Edge appliance, the
alarm will persist, because the alarm cause was never resolved. In this
case, you may want to manually resolve the alarm. Resolving the alarms
will clear them from the Dashboard.

Use `GET /api/2.0/services/alarms/{sourceId}` to retrieve the list of
alarms for the source. Use this response as the request body for the
`POST` call.

## CapacityParameter
Working With System Scale (Capacity Parameter) Dashboard
===================
The System Scale (Capacity Parameter) dashboard displays information about the current object count, maximum object supported 
by the system, and  percentage usage for each parameter.
The capacity parameter report collects information about the current system scale and the supported scale
parameters. It also allows you to view a warning threshold value  and percentage usage for each the parameter. 
It also allows you to view and configure a warning threshold value at the system level. If the current global threshold values
exceeds a specified threshold value, a warning indicator is displayed on the UI to alert that the maximum 
supported scale is approaching. 
This information is also logged and included in the support bundle.

### /2.0/capacity-parameters/report
System Scale (Capacity Parameter) Dashboard Report
----------------------------
Retrieves the current and supported scale configuration of the system.

* **get** *(secured)*: The output displays scale summary, current scale value, supported system scale value, 
threshold value, and the percentage usage for each parameter.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /2.0/capacity-parameters/thresholds
System Scale (Capacity Parameter) Dashboard Threshold
---------------------------------
You can find out and change the global threshold for the system, if required. 
 The default global threshold value for the system is set to *80*.

* **get** *(secured)*: Retrieves the global threshold for the system. The System Scale dashboard on UI displays warning when the 
threshold value is reached.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **put** *(secured)*: You can configure the scale threshold of the system. If you change the global threshold from 80 to 70,
it means the System Scale dashboard displays warning when the system threshold reaches at 70%.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

## widgetconfigurations
Working With Custom Dashboard Widget
=============================
You can add up to five custom widgets to the dashboard. You can also share widgets with other users by setting the **shared** parameter to *true* in the widget configuration. It is recommended to have total of maximum 10 widgets on your dashboard. 
The following two types of widgets are supported:
* Label Value, and
* Grid (or Table)

**Data Types**

Following data types are supported:
* Datasource
* GridConfiguration
* LabelValueConfiguration
* UrlAlias
* Label
* Icon
* WidgetConfigurationList
* WidgetQueryParameters

**Datasource**

Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------
display_name | Datasource Instance Name. Only NSX-API is supported as ‘default’ datasource. |  String    | Required
urls |    Array of relative urls and their aliases.  |     Array of *UrlAlias*   | Required

**GridConfiguration**

Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------
resource_type | Must be set to the value GridConfiguration.|  String |  Required <br> Read only<br> Enum: GridConfiguration, LabelValueConfiguration
datasources |    Array of Datasource Instances with their relative urls. <br> The 'datasources' represent the sources from which data is fetched.Currently, only NSX-API is supported as a 'default' datasource. An example of specifying 'default' datasource along with the urls to fetch data from is given at 'example_request' section of 'CreateWidgetConfiguration' API.|     Array of *Datasource*  | Minimum items: 1
description |    Description of this widget configuration.  |     String   | Maximum length: 1024 
category_id |    Category of this widget configuration. If *category_id* is not provided, system  generates a category ID.  |   String   | 
category_display_name |  Display name of the category. If category display name is not provided, then *category_id* is used as its display name.  |  String   | 
columns |    Columns describes the information about individual columns such as column heading or label, data type of the column and so on.  |     Array of *ColumnItem*   | Required        
shared |    Share  widget configuration with other users.  |     Boolean   | Default is False   
        
**GridConfiguration: Grid Column** - Represents column of the Grid

**ColumnItem**

Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------      
field |    Column Field. <br> Field from which values of the column are derived.|     String   | Required
label |    Label of the column.  |     Label   | Required
render_configuration |    Render configuration to be applied, if any.  |     Array of *RenderConfiguration*   | 
type |    Data type of the field.  |     String   | Required <br> Options are String, Number, Date. Default is String
  
  
**Label Value Configuration** 

Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------      
resource_type |    Label Value Configuration. Must be set to the value *LabelValueConfiguration*. |     String   | Required. Read only  
sub_type |    [Optional] Sub-type of the resource type. When the sub-type is omitted, then the parent type *LabelValueConfiguration* will be considered. <br>For  *LabelValueConfiguration* the available sub-type is  *aggregate_count*. |     String   | Read only
object_type |    [Optional] User defined type for identifying the widget’s data. Example: *HostConnStatuses*. |     String   |  
datasources |    Array of Datasource Instances with their relative URLs. |     Array of *Datasource*   | Required. Read only  
description |    Description of this widget configuration. |     String   | Maximum length:1024  
display_name |    Widget Title. |     String   | Required  
category_id |    Category of this widget configuration.<br> If *category_id* is not provided, system generates an ID for category. |     String   |  
category_display_name |    Display name of the category. <br> If category display name is not provided, then *category_id* is used as the display name. |     String   |   
properties |    Properties consisting of labels and values. |     Array of *PropertyItem*   | Required
shared |    Share the widget configuration with other users. |     Boolean   | Default is False
revision |    Revision of this widget configuration. It is auto-generated and auto-updated. |     Integer   | Read only

**PropertyItem** 

Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------      
field |    Field of the Property. |     String   | Required
label |    Label of the Property.  |     Label   | Required
render_configuration |    Render Configuration. |     Array of RenderConfiguration    | 
type |    Field data type. |     String   | Options are *String*, *Number*, and *Date*. Default is String.
drilldown id |    ID of the drill-down widget configuration. |     String   | 

**RenderConfiguration** 

Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------      
condition |    Expression for evaluating condition. |     String   | 
display_value |    Overridden value to display, if any. |     String   | 
icons |    Icons to be applied at dashboard for widgets and UI elements. |     Array of *Icon*  | Minimum item is 0

**UrlAlias** 

Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------      
alias |    Alias name for URL. |     String   | 
url |    URL. |     String   | Required

  **Label** 
  
Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------      
text |    Text to be displayed at the label. |     String   | Required <br> Maximum length is 255
url |    URL. |     String   | Required
  
**Icon** 

Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------      
type |    Icon is rendered based on its type. <br> For example, if ERROR is chosen, then icon representing error will be rendered. |     String   | Options are ERROR, WARNING, INFO, INPROGRESS, SUCCESS, DETAIL, NOT_AVAILABLE 

**WidgetConfigurationList** 

Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------      
widgetconfigurations |    Array of widget configurations.  |     Array of *widgetconfiguration*   | Required. Read only 
   
   
**WidgetQueryParameters** 

Parameter  | Description |   Type | Comments
----------|------------ | ----------|------------      
widget_ids |    Comma separated IDs of the WidgetConfiguration to be queried.  |     String   | Read only
  
  **Expressions**:
  --------------
  Expressions can be used in widget configurations. Expressions should be evaluable on their own without any “variable declaration”. 
  For example, you can give following expressions:
    * Arithmetic:
      (1 + 2)= evaluates to 3
      (12.0 - 5.2) = evaluates to 6.8
      (6 * 12 + 5 / 2.6) = evaluates to 73.923
      (12 % 2)= evaluates to 0
      (6 / 4 )= evaluates to 1.5
      (-12 + 77.2) = evaluates to 65.2
      (x * 1.1 + y) = Not allowed as x and y are not defined.
    * Calling methods:
      "(\"\").isEmpty()" = evaluates to boolean true.
    * Accessing properties:
      "(\"Some long string\").length == 16" = evaluates to boolean true. But you can not give expressions like:
        “V1 + 2” 
        “aString.length()” and so on because these expressions require the definition of “V1” and “aString” to be present in the context, and there is no place in widget configuration to define it. 
         * No Java statements are supported, only expressions are supported.

  **Anatomy of an Expression in Widget Configuration**
      * Expression
       * Basic form: #{<datasource>.<url-alias>.<jsonpath>}
       * Examples:
           * Expression:   #{default.si.versionInfo.majorVersion}       
           * API: api/1.0/appliance-management/summary/system             
      * Expression:   #{default.si.cpuInfoDto.totalNoOfCPUs}                             
           * API:  api/1.0/appliance-management/summary/system
           * Expression:  #{default.summary.preparedHostsTotalNumber}                           
           * API: api/2.0/vdn/inventory/hosts/status/summary
           * Function form: #{<datasource>.<url-alias>.<jsonpath>}.function()
           * Example:
      * Expression:  #{default.se.dataPage.data}.size()                    
           * API: api/2.0/systemevent

  **Anatomy of a Condition in Widget Configuration**
       * Condition
          * Evaluates to a boolean (true or false)
           * Form: expression == value
              * Examples: 
                  #{default.status.degraded_count} < 10
                  #{default.status.results}.size() < 10
                  #{default.status.status} == \"INSTALLED_DISABLED\"
                  #{default.config.allow_mirrored} == true
                  #{default.config.allow_mirrored}        //A boolean can be used directly in expression.

### /2.0/services/dashboard/ui-views/dashboard/widgetconfigurations

* **get** *(secured)*: Retrieves configuration details for all the widgets available on dashboard.
 
**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **post** *(secured)*: Creates a new Widget Configuration and adds it to the default Dashboard on UI. Supported resource_type are *LabelValueConfiguration* and *GridConfiguration*.

**Notes for Expressions in Widget Configuration**

Expressions should be given in a single line. If an expression spans multiple lines, then form the expression in a single line. 
Order of evaluation of expressions is as follows:<br>
* First, render configurations are evaluated in their order of appearance in the widget configuration. 
The *field* is evaluated at the end.
* Next, when render configuration is provided then the order of evaluation is as follows: 
  
    * If expressions provided in condition and display value are well-formed and free  of runtime errors such as null pointers 
    and evaluates to true; then the remaining render configurations are not evaluated, and the current render configurations 
    *display value* is taken as the final value.
    
    * If expression provided in condition of render configuration is false, then next render configuration is evaluated. 
    
    * Finally, field is evaluated only when every render configuration evaluates to false and no error occurs during steps mentioned above.
    
    If an error occurs during evaluation of render configuration, then an error message: "__ERROR__: See the Error_Messages field of 
    this report for details" is shown. The display value corresponding to that label is not shown and evaluation of the 
    remaining render configurations continues to collect and show all the error messages (marked with the Label for identification)
    as Error_Messages: {}. If during evaluation of expressions for any label-value pair an error occurs, 
    then it is marked with error. The errors are shown in the report, along with the label value pairs that are error-free.
    
**Important Note for text in condition, field and render configuration's display value**: 
For elements that take expressions, strings should be provided by escaping them with a back-slash. These elements are - condition, field and render_configuration's display_value.

**Notes for Drilldowns**:
Only *GridConfiguration* is supported as drilldown widget. To make a widget as a drilldown, its category_id should be set as *drilldown*. Drilldowns are supported for *aggregate_count* (subtype of *LabelValueConfiguration*) widgets only.  In other words, only 'aggregate_count' widgets can have drilldowns.

**Notes for Sharing the widget to other users**:
Use a valid vsphere user, who has an NSX role assigned that has sufficient permissions, to create the widget and it will get displayed on the UI when that vsphere user logs in. For other users to view the widget on the UI, the owner (user who owners that widget) needs to share the widget (set **shared** parameter to *true*).

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /2.0/services/dashboard/ui-views/dashboard/widgetconfigurations/{widgetconfigurationId}
Working With a Specific Widget
---------------------------------

* **get** *(secured)*: Retrieves the configuration details about a specific widget on the dashboard. 

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **put** *(secured)*: Updates the configuration about a specific widget on the dashboard. For example, *LabelValueConfiguration*, 
PUT https://<nsx-mgr>/api/2.0/services/dashboard/ui-views/dashboard/widgetconfigurations/
LabelValueConfiguration_497802b7-e0d9-48b3-abfd-479058540956.
        
**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.
    

* **delete** *(secured)*: Deletes a specific widget on the dashboard.            
            

## taskFramework
Working With the Task Framework
======
Working with filtering criteria and paging information for jobs on the task
framework.

### /2.0/services/taskservice/job

* **get** *(secured)*: Query job instances by criterion.

### /2.0/services/taskservice/job/{jobId}
Working With a Specific Job Instance
------

* **get** *(secured)*: Retrieve all job instances for the specified job ID.

## guestIntrospection
Working With Guest Introspection and Third-party Endpoint Protection (Anti-virus) Solutions
============

About Guest Introspection and Endpoint Protection Solutions
----------
VMware's Guest Introspection Service enables vendors to deliver an
introspection-based, endpoint protection (anti-virus) solution that uses
the hypervisor to scan guest virtual machines from the outside, with only
a thin agent on each guest virtual machine.

Version Compatibility
-----------

**Note:** The management APIs listed in this section are to be used only
with partner endpoint protection solutions that were developed with EPSec
Partner Program 3.0 or earlier (for vShield 5.5 or earlier).  These
partner solutions are also supported on NSX 6.0 and need the APIs listed
below.  These APIs should not be used with partner solutions developed
specifically for NSX 6.0 or later, as these newer solutions automate the
registration and deployment process by using the new features introduced
in NSX.  Using these with newer NSX 6.0 based solutions could result in
loss of features.

Register a Solution
----------

To register a third-party solution with Guest Introspection, clients can
use four REST calls to do the following:
1. Register the vendor.
2. Register one or more solutions.
3. Set the solution IP address and port (for all hosts).
4. Activate registered solutions per host.

**Note:** Steps 1 through 3 need to be performed once per solution. Step 4
needs to be performed for each host.

Unregister a Solution
----------

To unregister a solution, clients perform these steps in reverse:
1. Deactivate solutions per host.
2. Unset a solution’s IP address and port.
3. Unregister solutions.
4. Unregister the vendor.

Updating Registration Information
-----------

To update registration information for a vendor or solution, clients must:
1. Unregister the vendor or solution.
2. Reregister the vendor or solution.

### /2.0/endpointsecurity/registration
Register a Vendor and Solution with Guest Introspection
---

* **post** *(secured)*: Register the vendor of an endpoint protection solution. Specify the
following parameters in the request.

| Name            | Comments |
|-----------------|------------|
|**vendorId**     | VMware-assigned ID for the vendor. |
|**vendorTitle**  | Vendor-specified title. |
|**vendorDescription** | Vendor-specified description. |

### /2.0/endpointsecurity/registration/vendors
Working With Registered Guest Introspection Vendors
----

* **get** *(secured)*: Retrieve the list of all registered Guest Introspection vendors.

### /2.0/endpointsecurity/registration/{vendorID}
Working With Guest Introspection Vendors and Endpoint Protection Solutions
-----

* **post** *(secured)*: Register an endpoint protection solution. Specify the following parameters in the request.

| Name            | Comments |
|-----------------|------------|
|**solutionAltitude**     | VMware-assigned altitude for the solution. *Altitude* is a number that VMware assigns to uniquely identify the solution. The altitude describes the type of solution and the order in which the solution receives events relative to other solutions on the same host. |
|**solutionTitle**  | Vendor-specified title for the solution. |
|**solutionDescription** | Vendor-specified description of the solution. |

* **get** *(secured)*: Retrieve registration information for a Guest Introspection vendor.
* **delete** *(secured)*: Unregister a Guest Introspection vendor.

### /2.0/endpointsecurity/registration/{vendorID}/solutions
Information About Registered Endpoint Protection Solutions
----

* **get** *(secured)*: Get registration information for all endpoint protection solutions for a Guest Introspection vendor.

### /2.0/endpointsecurity/registration/{vendorID}/{altitude}
Endpoint Protection Solution Registration Information
----

* **get** *(secured)*: Get registration information for an endpoint protection solution.
* **delete** *(secured)*: Unregister an endpoint protection solution.

### /2.0/endpointsecurity/registration/{vendorID}/{altitude}/location
IP Address and Port For an Endpoint Protection Solution
-----
To change the location of an endpoint protection solution:
1. Deactivate all security virtual machines.
2. Change the location.
3. Reactivate all security virtual machines.

* **post** *(secured)*: Set the IP address and port on the vNIC host for an endpoint
protection solution.

* **get** *(secured)*: Get the IP address and port on the vNIC host for an endpoint
protection solution.

* **delete** *(secured)*: Unset the IP address and port for an endpoint protection
solution.

### /2.0/endpointsecurity/activation
Activate an Endpoint Protection Solution
-------
You can activate a solution that has been registered and located.

* **get** *(secured)*: Retrieve activation information for all activated security VMs on the
specified host.

### /2.0/endpointsecurity/activation/{vendorID}/{solutionID}
Activated Security Virtual Machines
---

* **get** *(secured)*: Retrieve a list of activated security VMs for an endpoint protection solution.

### /2.0/endpointsecurity/activation/{vendorID}/{altitude}
Activate a Registered Endpoint Protection Solution
-----

* **post** *(secured)*: Activate an endpoint protection solution that has been registered
and located. Specify the following parameter in the request body.

| Name            | Comments |
|-----------------|------------|
|**svmMoid**     | Managed object ID of the virtual machine of the activated endpoint protection solution. |

### /2.0/endpointsecurity/activation/{vendorID}/{altitude}/{moid}
Working With Solution Activation Status
----

* **get** *(secured)*: Retrieve the endpoint protection solution activation status, either true (activated) or false (not activated).
* **delete** *(secured)*: Deactivate an endpoint protection solution on a host.

### /2.0/endpointsecurity/usvmstats/usvmhealththresholds
Working With Guest Introspection SVM Health Thresholds 
============
System events are generated when the Guest Introspection service VM memory
and CPU usage reach the defined thresholds.

* **get** *(secured)*: Retrieve Guest Introspection service VM CPU and memory usage thresholds.

**Method history:**

Release | Modification
--------|-------------
6.3.5 | Method introduced.

* **put** *(secured)*: Update Guest Introspection service VM CPU and memory usage thresholds.

Valid values are *0-100*. The default value is *75*.

**Method history:**

Release | Modification
--------|-------------
6.3.5 | Method introduced.

## dfw
Working With Distributed Firewall
=================================

### /4.0/firewall/globalroot-0/defaultconfig
Default Firewall Configuration
-----

* **get** *(secured)*: Retrieve the default firewall configuration.

The output of this method can be used to restore the firewall config
back to default. For example, to replace the layer 2 or layer 3
default section, use the relevant default section from the `GET
/api/4.0/firewall/globalroot-0/defaultconfig` response body to create
the request body of `PUT
/api/4.0/firewall/globalroot-0/config/layer2sections|layer3sections/{sectionId}`.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

### /4.0/firewall/globalroot-0/config
Working with Distributed Firewall Configuration
---
The following table lists the elements that can be used in firewall
rules.

| Element | Keyword for API | Used in |
|---|---|---|
| All Edges | ALL_EDGES | appliedTo |
| application | Application | service |
| application group | ApplicationGroup | service |
| cluster | compute resource | ClusterComputeResource<br>appliedTo |
| datacenter | Datacenter | source/destination<br>appliedTo |
| distributed firewall | DISTRIBUTED_FIREWALL | appliedTo |
| distributed virtual port group | DistributedVirtualPortgroup | source/destination<br>appliedTo |
| Edge ID | Edge | appliedTo |
| global root | GlobalRoot | source/destination |
| host | HostSystem | appliedTo |
| IP set | IPSet | source/destination |
| IPv4 addresses | Ipv4Address | source/destination |
| IPv6 addresses | Ipv6Address | source/destination |
| logical switch | VirtualWire | source/destination<br>appliedTo |
| MAC address set | MACSet | source/destination |
| network | Network | for legacy portgroups, network can be used in source or destination instead of appliedTo |
| profile | ALL_PROFILE_BINDINGS | |
| resource pool | ResourcePool | source/destination |
| security group | SecurityGroup | source/destination |
| virtual app | VirtualApp | source/destination |
| virtual machine | VirtualMachine | source/destination<br>appliedTo |
| vNIC | Vnic | source/destination<br>appliedTo |

Starting in NSX 6.4.0, the following attributes can be configured at the section level.

Attribute | Description | Default for new sections
----|----
**tcpStrict** | If TCP strict is enabled on a rule and a packet matches that rule, the following check will be performed. If the packet does not belong to an existing session, the kernel will check to see if the SYN flag of the packet is set. If it is not, then it will drop the packet. | *false* for all section types.
**stateless** | If stateless is enabled on a rule, traffic is monitored statically, and the state of network connections will be ignored. | *true* for L2, *false* for L3 and L3 redirect.
**useSid** | If useSid is enabled on a rule, the source field of the rule must be an Active Directory Security Group.  | *false* for all section types.

**tcpStrict** was previously configured in the global firewall
configuration: `PUT /api/4.0/firewall/config/globalconfiguration`. If you
upgrade to NSX 6.4.0 or later, the global configuration setting
for **tcpStrict** is used to configure **tcpStrict** in each existing
layer 3 section. **tcpStrict** is set to *false* in layer 2 sections and
layer 3 redirect sections. **stateless** and **useSid** are new attributes
in NSX 6.4.0 and are set to the default values during upgrade.

Once all hosts are upgraded to NSX 6.4.0, the global **tcpStrict** parameter
is ignored.

* **get** *(secured)*: Retrieve distributed firewall rule configuration.

If no query parameters are used, all rule configuration is retrieved.
Use the query parameters to filter the rule configuration information.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

* **put** *(secured)*: Update the complete firewall configuration in all sections.

* Retrieve the configuration with `GET /api/4.0/firewall/globalroot-0/config`.
* Retrieve the Etag value from the response headers.
* Extract and modify the configuration from the response body as needed.
* Set the If-Match header to the Etag value, and submit the request.

Not all fields are required while sending the request. All the optional fields
are safe to be ignored while sending the configuration to server. For example,
if an IP set is referenced in the rule only IPSet and Type is needed in the
Source/Destination objects and not Name and isValid tags.

When updating the firewall configuration:
* IDs for new objects (rule/section) should be removed or set to zero.
* If new entities (sections/rules) have been sent in the request, the response
  will contain the system-generated IDs, which are assigned to these new
  entities.
* **appliedTo** can be any valid firewall rule element.
* **action** can be *ALLOW*, *BLOCK*, or *REJECT*. REJECT sends reject message for
  unaccepted packets; RST packets are sent for TCP connections and ICMP
  unreachable code packets are sent for UDP, ICMP, and other IP connections
* source and destination can have an exclude flag. For example, if you add an
  exclude tag for 1.1.1.1 in the source parameter, the rule looks for traffic
  originating from all IPs other than 1.1.1.1.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

* **delete** *(secured)*: Restores default configuration, which means one defaultLayer3 section
with three default allow rules and one defaultLayer2Section with one
default allow rule.

### /4.0/firewall/globalroot-0/config/layer3sections
Working With Layer 3 Sections in Distributed Firewall
-----

You can use sections in the firewall table to group logical rules based on
AppliedTo or for a tenant use case. A firewall section is the smallest unit of
configuration which can be updated independently. Section types are as
follows:
* Layer3Section contains layer3 rules
* Layer2Section contains layer2 rules
* Layer3RedirectSection contains traffic redirect rules.

When Distributed Firewall is used with Service Composer, firewall sections
created by Service Composer contain an additional attribute in the XML called
managedBy. You should not modify Service Composer firewall sections using
Distributed Firewall REST APIs.

* **get** *(secured)*: Retrieve rules from the layer 3 section specified by section **name**.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

* **post** *(secured)*: Create a layer 3 distributed firewall section.

By default, the section is created at the top of the firewall table.
You can specify a location for the section with the **operation**
and **anchorId** query parameters.

See "Working with Distributed Firewall Configuration" for information
about configuring **tcpStrict**, **stateless**, and **useSid** for a section.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

### /4.0/firewall/globalroot-0/config/layer3sections/{sectionId}
Working With a Specific Layer 3 Distributed Firewall Section
----

* **get** *(secured)*: Retrieve information about the specified layer 3 section.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

* **post** *(secured)*: Move the specified layer 3 section.

Use the **action**, **operation**, and optionally **achorId**
query parameters to specify the destination for the section.

`POST /api/4.0/firewall/globalroot-0/config/layer3sections/1007
?action=revise&operation=insert_before&anchorId=1006`

`If-Match: 1477989118875` 

```
<section id="1007" name="Web Section" generationNumber="1477989118875" timestamp="1477989118875" type="LAYER3">
  ...
</section>
```

* **put** *(secured)*: Update the specified layer 3 section in distributed firewall.

* Retrieve the configuration for the specified section.
* Retrieve the Etag value from the response headers.
* Extract and modify the configuration from the response body as needed.
* Set the If-Match header to the Etag value, and submit the request.

Not all fields are required while sending the request. All the optional fields
are safe to be ignored while sending the configuration to server. For example,
if an IP set is referenced in the rule only IPSet and Type is needed in the
Source/Destination objects and not Name and isValid tags.

When updating the firewall configuration:
* IDs for new objects (rule/section) should be removed or set to zero.
* If new entities (sections/rules) have been sent in the request, the response
  will contain the system-generated IDs, which are assigned to these new
  entities.
* **appliedTo** can be any valid firewall rule element.
* **action** can be *ALLOW*, *BLOCK*, or *REJECT*. REJECT sends reject message for
  unaccepted packets; RST packets are sent for TCP connections and ICMP
  unreachable code packets are sent for UDP, ICMP, and other IP connections
* source and destination can have an exclude flag. For example, if you add an
  exclude tag for 1.1.1.1 in the source parameter, the rule looks for traffic
  originating from all IPs other than 1.1.1.1.

When Distributed Firewall is used with Service Composer, firewall
sections created by Service Composer contain an additional attribute
in the XML called managedBy. You should not modify Service Composer
firewall sections using Distributed Firewall REST APIs. If you do, you
must synchronize firewall rules from Service Composer using the `GET
/api/2.0/services/policy/serviceprovider/firewall` API.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

* **delete** *(secured)*: Delete the specified layer 3 distributed firewall section.

If the default layer 3 firewall section is selected, the request is
rejected. See `GET /api/4.0/firewall/globalroot-0/defaultconfig`
for information on resetting the default firewall section.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method updated. When deleting the default firewall rule section, the method previously removed all rules except for the default rule. The method now returns status 400 and the message `Cannot delete default section <sectionId>`.

### /4.0/firewall/globalroot-0/config/layer3sections/{sectionId}/rules
Working With Distributed Firewall Rules in a Layer 3 Section
----

* **post** *(secured)*: Add rules to the specified layer 2 section in distributed firewall.

You add firewall rules at the global scope. You can then narrow down the scope
(datacenter, cluster, distributed virtual port group, network, virtual machine,
vNIC, or logical switch) at which you want to apply the rule. Firewall allows
you to add multiple objects at the source and destination levels for each rule,
which helps reduce the total number of firewall rules to be added.  To add a
identity based firewall rule, first create a security group based on Directory
Group objects. Then create a firewall rule with the security group as the
source or destination.  Rules that direct traffic to a third part service are
referred to as layer3 redirect rules, and are displayed in the layer3 redirect
tab.

When Distributed Firewall is used with Service Composer, firewall
rules created by Service Composer contain an additional attribute
in the XML called managedBy.

Follow this procedure to add a rule:

* Retrieve the configuration for the specified section.
* Retrieve the Etag value from the response headers.
  **Note**: Each section contains its own Etag, generationNumber, and
  timestamp. When adding a new rule, you must use the Etag value of the
  firewall section to which you wish to add the rule.
* Extract and modify the configuration from the response body as needed.
* Set the If-Match header to the section Etag value, and submit the request.

Not all fields are required while sending the request. All the optional fields
are safe to be ignored while sending the configuration to server. For example,
if an IP set is referenced in the rule only IPSet and Type is needed in the
Source/Destination objects and not Name and isValid tags.

When updating the firewall configuration:

* IDs for new rules should be removed or set to zero.
* If new rules have been sent in the request, the response
  will contain the system-generated IDs, which are assigned to these new
  entities.
* **appliedTo** can be any valid firewall rule element.
* **action** can be *ALLOW*, *BLOCK*, or *REJECT*. REJECT sends reject message for
  unaccepted packets; RST packets are sent for TCP connections and ICMP
  unreachable code packets are sent for UDP, ICMP, and other IP connections
* source and destination can have an exclude flag. For example, if you add an
  exclude tag for 1.1.1.1 in the source parameter, the rule looks for traffic
  originating from all IPs other than 1.1.1.1.

### /4.0/firewall/globalroot-0/config/layer3sections/{sectionId}/rules/{ruleId}
Working With a Specific Rule in a Specific Layer 3 Section
----

* **get** *(secured)*: Retrieve information about the specified distributed firewall rule.

* **put** *(secured)*: Update a distributed firewall rule in a layer 3 section.

* Retrieve the configuration for the section that contains the rule you want
  to modify.
* Retrieve the Etag value from the response headers.
  **Note**: This is the Etag value of the firewall section to which you want
  to add the rule. If you are keeping this rule in the same section, you must
  keep the same Etag number.
* Extract and modify the rule configuration from the response body as needed.
* Set the If-Match header to the section Etag value, and submit the request.

Not all fields are required while sending the request. All the optional fields
are safe to be ignored while sending the configuration to server. For example,
if an IP set is referenced in the rule only IPSet and Type is needed in the
Source/Destination objects and not Name and isValid tags.

* **delete** *(secured)*: Delete the specified distributed firewall rule.

### /4.0/firewall/globalroot-0/config/layer2sections
Working With Layer 2 Sections in Distributed Firewall
----

You can use sections in the firewall table to group logical rules based on
AppliedTo or for a tenant use case. A firewall section is the smallest unit of
configuration which can be updated independently. Section types are as
follows:
* Layer3Section contains layer3 rules
* Layer2Section contains layer2 rules
* Layer3RedirectSection contains traffic redirect rules.

When Distributed Firewall is used with Service Composer, firewall sections
created by Service Composer contain an additional attribute in the XML called
managedBy. You should not modify Service Composer firewall sections using
Distributed Firewall REST APIs.

* **get** *(secured)*: Retrieve rules from the layer 2 section specified by section **name**.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

* **post** *(secured)*: Create a layer 2 distributed firewall section.

By default, the section is created at the top of the firewall table.
You can specify a location for the section with the **operation**
and **anchorId** query parameters.

See "Working with Distributed Firewall Configuration" for information
about configuring **tcpStrict**, **stateless**, and **useSid** for a section.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

### /4.0/firewall/globalroot-0/config/layer2sections/{sectionId}
Working With a Specific Layer 2 Distributed Firewall Section
----

* **get** *(secured)*: Retrieve information about the specified layer 2 section.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

* **post** *(secured)*: Move the specified layer 2 section.

Use the **action**, **operation**, and optionally **anchorId**
query parameters to specify the destination for the section.

`POST /api/4.0/firewall/globalroot-0/config/layer2sections/1009
?action=revise&operation=insert_before&anchorId=1008`

`If-Match: 1478307787160`

```
<section id="1009" name="Test Section" generationNumber="1478307787160" timestamp="1478307787160" type="LAYER2">
  ...
</section>
```

* **put** *(secured)*: Update the specified layer 2 section in distributed firewall.

* Retrieve the configuration for the specified section.
* Retrieve the Etag value from the response headers.
* Extract and modify the configuration from the response body as needed.
* Set the If-Match header to the Etag value, and submit the request.

Not all fields are required while sending the request. All the optional fields
are safe to be ignored while sending the configuration to server. For example,
if an IP set is referenced in the rule only IPSet and Type is needed in the
Source/Destination objects and not Name and isValid tags.

When updating the firewall configuration:
* IDs for new objects (rule/section) should be removed or set to zero.
* If new entities (sections/rules) have been sent in the request, the response
  will contain the system-generated IDs, which are assigned to these new
  entities.
* **appliedTo** can be any valid firewall rule element.
* **action** can be *ALLOW*, *BLOCK*, or *REJECT*. REJECT sends reject message for
  unaccepted packets; RST packets are sent for TCP connections and ICMP
  unreachable code packets are sent for UDP, ICMP, and other IP connections
* source and destination can have an exclude flag. For example, if you add an
  exclude tag for 1.1.1.1 in the source parameter, the rule looks for traffic
  originating from all IPs other than 1.1.1.1.

When Distributed Firewall is used with Service Composer, firewall
sections created by Service Composer contain an additional attribute
in the XML called managedBy. You should not modify Service Composer
firewall sections using Distributed Firewall REST APIs. If you do, you
must synchronize firewall rules from Service Composer using the `GET
/api/2.0/services/policy/serviceprovider/firewall` API.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

* **delete** *(secured)*: Delete the specified layer 2 section and its contents.

If the default layer 2 firewall section is selected, the request is
rejected. See `GET /api/4.0/firewall/globalroot-0/defaultconfig`
for information on resetting the default firewall section.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method updated. When deleting the default firewall rule section, the method previously removed all rules except for the default rule. The method now returns status 400 and the message `Cannot delete default section <sectionId>`.

### /4.0/firewall/globalroot-0/config/layer2sections/{sectionId}/rules
Working With Distributed Firewall Rules in a Layer 2 Section
------

* **post** *(secured)*: Add rules to the specified layer 2 section in distributed firewall.

You add firewall rules at the global scope. You can then narrow down the scope
(datacenter, cluster, distributed virtual port group, network, virtual machine,
vNIC, or logical switch) at which you want to apply the rule. Firewall allows
you to add multiple objects at the source and destination levels for each rule,
which helps reduce the total number of firewall rules to be added.  To add a
identity based firewall rule, first create a security group based on Directory
Group objects. Then create a firewall rule with the security group as the
source or destination.  Rules that direct traffic to a third part service are
referred to as layer3 redirect rules, and are displayed in the layer3 redirect
tab.

When Distributed Firewall is used with Service Composer, firewall
rules created by Service Composer contain an additional attribute
in the XML called managedBy.

Follow this procedure to add a rule:

* Retrieve the configuration for the specified section.
* Retrieve the Etag value from the response headers.
  **Note**: Each section contains its own Etag, generationNumber, and
  timestamp. When adding a new rule, you must use the Etag value of the
  firewall section to which you wish to add the rule.
* Extract and modify the configuration from the response body as needed.
* Set the If-Match header to the section Etag value, and submit the request.

Not all fields are required while sending the request. All the optional fields
are safe to be ignored while sending the configuration to server. For example,
if an IP set is referenced in the rule only IPSet and Type is needed in the
Source/Destination objects and not Name and isValid tags.

When updating the firewall configuration:

* IDs for new rules should be removed or set to zero.
* If new rules have been sent in the request, the response
  will contain the system-generated IDs, which are assigned to these new
  entities.
* **appliedTo** can be any valid firewall rule element.
* **action** can be *ALLOW*, *BLOCK*, or *REJECT*. REJECT sends reject message for
  unaccepted packets; RST packets are sent for TCP connections and ICMP
  unreachable code packets are sent for UDP, ICMP, and other IP connections
* source and destination can have an exclude flag. For example, if you add an
  exclude tag for 1.1.1.1 in the source parameter, the rule looks for traffic
  originating from all IPs other than 1.1.1.1.

### /4.0/firewall/globalroot-0/config/layer2sections/{sectionId}/rules/{ruleId}
Working With a Specific Rule in a Specific Layer 2 Section
-----

* **get** *(secured)*: Retrieve the configuration of the specified rule.

* **put** *(secured)*: Update a distributed firewall rule in a layer 2 section.

* Retrieve the configuration for the section that contains the rule you want
  to modify.
* Retrieve the Etag value from the response headers.
  **Note**: This is the Etag value of the firewall section to which you want
  to add the rule. If you are keeping this rule in the same section, you must
  keep the same Etag number.
* Extract and modify the rule configuration from the response body as needed.
* Set the If-Match header to the section Etag value, and submit the request.

Not all fields are required while sending the request. All the optional fields
are safe to be ignored while sending the configuration to server. For example,
if an IP set is referenced in the rule only IPSet and Type is needed in the
Source/Destination objects and not Name and isValid tags.

* **delete** *(secured)*: Delete the specified distributed firewall rule.

### /4.0/firewall/globalroot-0/config/layer3redirectsections
Layer 3 Redirect Sections and Rules
----

* **post** *(secured)*: Add L3 redirect section

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

### /4.0/firewall/globalroot-0/config/layer3redirectsections/{section}
Layer 3 Redirect Section
----

* **get** *(secured)*: Get L3 redirect section configuration

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

* **put** *(secured)*: Modify layer 3 redirect section. You will need to get the Etag
value out of the GET first. Then pass the modified version of the
whole redirect section configuration in the GET body.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict**, **stateless**, and **useSid** added as **section** attributes.

* **delete** *(secured)*: Delete specified L3 redirect section

### /4.0/firewall/globalroot-0/config/layer3redirectsections/{section}/rules
Working With Layer 3 Redirect Rules for a Specific Section
----

* **post** *(secured)*: Add L3 redirect rule

### /4.0/firewall/globalroot-0/config/layer3redirectsections/{section}/rules/{ruleID}
Working With a Specific Layer 3 Redirect Rule for a Specific Section
----

* **get** *(secured)*: Get L3 redirect rule
* **put** *(secured)*: Modify L3 redirect rule. You will need Etag value from the
response header of GET call. Then, pass Etag value as the
if-match header in PUT call

* **delete** *(secured)*: Delete specified L3 redirect rule

### /4.0/firewall/globalroot-0/config/layer3redirect/profiles
Service Insertion Profiles and Layer 3 Redirect Rules
----

* **get** *(secured)*: Retrieve the Service Insertion profiles that can be applied to
layer3 redirect rules.

### /4.0/firewall/globalroot-0/state
Enable Distributed Firewall After Upgrade
-----
After upgrading NSX Manager, controllers, and network virtualization
components, check the status of distributed firewall. If it is ready to
enable, you can enable distributed firewall.

| State | Description |
|-------|-------------|
| backwardCompatible | This is the default state after an upgrade from vCloud Networking and Security to NSX, which means that vShield App is being used for protection instead of distributed firewall.|
| backwardCompatibleReadyForSwitch | Once the clusters are prepared with NSX binaries, this state is enabled. You can enable distributed firewall only after firewall is in this state. |
| switchingToForward | This is an intermediate state when you change firewall to distributed firewall. |
| forward | This is the default state for green field deployments or after you have switched from vShield App to distributed firewall. |
| switchFailed | This state is unlikely, but may be present if NSX Manager failed to switch to distributed firewall. |

* **get** *(secured)*: Retrieve current state of firewall functioning after NSX upgrade.

* **put** *(secured)*: Enable distributed firewall.

### /4.0/firewall/globalroot-0/status
Working With Distributed Firewall Status
----
Retrieve status of last publish action for each cluster in the NSX
environment.

The status output displays a generation number (**generationNumber**) for
each rule set, which can be used to verify whether a change in rule sets
has propagated to a host. In 6.2.4, a generation number for objects
(**generationNumberObjects**) has been added to the status API. This allows
you to verify whether a change in objects consumed in firewall rules has
propagated to a host. Note that the object generation number may change
frequently and will always be equal to or greater than the ruleset
generation number.

Starting in NSX 6.2.4, clusters (and hosts inside the cluster) are no
longer included in the firewall status output if distributed firewall is
disabled at the cluster level, or if the cluster is not prepared (NSX
VIBs are not installed). In earlier versions of NSX these clusters and
hosts are included in the output. However, because they are not
configured for firewall, after a firewall rule publish their status is
*inprogress*.

* **get** *(secured)*: Get firewall configuration status

**Method history:**

Release | Modification
--------|-------------
6.2.4 | Method updated. Parameter **generationNumberObjects** added. Clusters not configured for firewall are excluded from the status output.

### /4.0/firewall/globalroot-0/status/layer3sections/{sectionID}
Working With a Specific Layer 3 Section Status
----

* **get** *(secured)*: Retrieve status of the last publish action for the specified layer 3 section.

**Method history:**

Release | Modification
--------|-------------
6.2.4 | Method updated. Parameter **generationNumberObjects** added. Clusters not configured for firewall are excluded from the status output.

### /4.0/firewall/globalroot-0/status/layer2sections/{sectionID}
Working With a Specific Layer 2 Section Status
----

* **get** *(secured)*: Retrieve status of the last publish action for the specified layer 2 section.

**Method history:**

Release | Modification
--------|-------------
6.2.4 | Method updated. Parameter **generationNumberObjects** added. Clusters not configured for firewall are excluded from the status output.

### /4.0/firewall/globalroot-0/drafts
Import and Export Firewall Configurations
----

* **post** *(secured)*: Save a firewall configuration.
* **get** *(secured)*: Displays the draft IDs of all saved configurations.

### /4.0/firewall/globalroot-0/drafts/{draftID}
Working With a Specific Saved Firewall Configuration
----

* **get** *(secured)*: Get a saved firewall configuration.
* **put** *(secured)*: Update a saved firewall configuration.
* **delete** *(secured)*: Delete a configuration.

### /4.0/firewall/globalroot-0/drafts/{draftID}/action/export
Export a Firewall Configuration
----

* **get** *(secured)*: Export a configuration.

### /4.0/firewall/globalroot-0/drafts/action/import
Import a Firewall Configuration
-----

* **post** *(secured)*: Import a configuration.

### /4.0/firewall/globalroot-0/timeouts
Working With Distributed Firewall Session Timers
-------
You can configure session timers (session timeouts) for TCP, UDP, and
ICMP. There is a default configuration, which applies to all VMs protected by
Distributed Firewall. You can modify the session timers values of the
default configuration, but not the **appliedTo** values.

You can add additional session timer configurations with different
**appliedTo** configurations.

Parameter | Description | Comments
-----|-----|-----
**appliedTo > value** | The ID of the object on which to apply the timeout settings. | Required. For example VM ID *vm-216*.
**appliedTo > type** | The type of object on which to apply the timeout settings. | Required. Can be *VirtualMachine* or *Vnic*
**generationNumber** | Generation number for the configuration. | When updating session timers, you must ensure the latest generation number is included in the request body. 
**tcpFirstPacket** | The timeout value for the connection after the first packet has been sent. This will be the initial timeout for the connection once a SYN has been sent and the flow is created. | Valid timer values: *10*-*4320000* seconds. Default is *120*. 
**tcpOpen** | The timeout value for the connection after a second packet has been transferred. |Valid timer values: *10*-*4320000* seconds. Default is *30*. 
**tcpEstablished** | The timeout value for the connection once the connection has become fully established. |Valid timer values: *120*-*4320000* seconds. Default is *43200*. 
**tcpClosing** | The timeout value for the connection after the first FIN has been sent. |Valid timer values: *10*-*4320000* seconds. Default is *120*. 
**tcpFinWait** | The timeout value for the connection after both FINs have been exchanged and the connection is closed. |Valid timer values: *10*-*4320000* seconds. Default is *45*. 
**tcpClosed** | The timeout value for the connection after one endpoint sends an RST. |Valid timer values: *10*-*4320000* seconds. Default is *20*. 
**udpFirstPacket** | The timeout value for the connection after the first packet. This will be the initial timeout for the new UDP flow. |Valid timer values: *10*-*4320000* seconds. Default is *60*. 
**udpSingle** | The timeout value for the connection if the source host sends more than one packet but the destination host has never sent one back. |Valid timer values: *10*-*4320000* seconds. Default is *30*. 
**udpMultiple** | The timeout value for the connection if both hosts have sent packets. |Valid timer values: *10*-*4320000* seconds. Default is *60*. 
**icmpFirstPacket** | The timeout value for the connection after the first packet. This will be the initial timeout for the new ICMP flow. |Valid timer values: *10*-*4320000* seconds. Default is *20*. 
**icmpErrorReply** | The timeout value for the connection after an ICMP error came back in response to an ICMP packet. |Valid timer values: *10*-*4320000* seconds. Default is *10*. 

* **get** *(secured)*: Retrieve Distributed Firewall session timer configuration.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

* **post** *(secured)*: Create a Distributed Firewall session timer configuration.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

### /4.0/firewall/globalroot-0/timeouts/{configId}
Working With a Specific Distributed Firewall Session Timer Configuration
----

* **get** *(secured)*: Retrieve the specified Distributed Firewall session timer configuration.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

* **put** *(secured)*: Update the specified Distributed Firewall session timer configuration.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

* **delete** *(secured)*: Delete the specified Distributed Firewall session timer configuration.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method introduced.

### /4.0/firewall/stats/eventthresholds
Working With Distributed Firewall Event Thresholds
----
Configure memory, CPU, and connections per second (CPS) thresholds for
distributed firewall.

The firewall module generates system events when the memory and CPU
usage crosses these thresholds.

**Note**: Deprecated. Use *GET  /api/4.0/firewall/stats/thresholds* instead.

* **get** *(secured)*: Retrieve threshold configuration for distributed firewall. 

**Note**: Starting in NSX 6.4, using this GET API will not display new threshold types such as 
process memory, different types of heap memory, and concurrent connections. Instead, use the new API introduced in NSX 6.4 which is *GET /api/4.0/firewall/stats/thresholds/host/<hostId>?type=<>&thresholdValue;=<>*.

* **put** *(secured)*: Update threshold configuration for distributed firewall.

**Note**: Starting in NSX 6.4, using this PUT API will disable the new threshold types such as process memory and concurrent connections. Instead, use the new API introduced in NSX 6.4 which is *PUT /api/4.0/firewall/stats/thresholds*.

### /4.0/firewall/stats/thresholds
Working With Distributed Firewall Thresholds
----
Retrieve memory, CPU, and connections per second (CPS) thresholds for
distributed firewall. 

The firewall module generates system events when the memory and CPU
usage crosses these thresholds.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **put** *(secured)*: Configure threshold values for distributed firewall such as CPU utilization, heap memory, calls per second, concurrent connections, and process memory.

**Parameters** 

Types of threshold | Default Value | Range | Unit
-----|-----|-----|-----
CPU | 90 | 0 - 100  | Percent
Heap Memory | 90 | 0 - 100  | Percent
Process Memory | 70 | 0 - 100  | Percent
Connections per second | 40000 |   | Count
Maximum connections | 500000 |   | Count

### /4.0/firewall/stats/thresholds/host/{hostId}

* **get** *(secured)*: Retrieve threshold configuration for distributed firewall like  CPU utilization, heap memory, calls per second, concurrent connections, process memory.  
Use *GET /api/4.0/firewall/stats/thresholds/host/<hostId>?type=<>&thresholdValue;=<>*.

### /4.0/firewall/stats/thresholds/types

* **get** *(secured)*: Get the different types of thresholds for distributed firewall.

### /4.0/firewall/stats/rules
Working With Distributed Firewall Rule Hit Counts
----
You can review and reset the distributed firewall hit count.

Parameter |  Description 
---|---
**ruleId** |Rule identification number.  
**hitcount** | Number of times the rule was hit. 
**firstHitTime** | First time the rule is hit. 
**lastHitTime** | Most recent time the rule was hit.  

* **post** *(secured)*: Globally clears the rule hit count statistics for all rules. 

**Method history:**

Release | Modification
--------|-------------
  6.4.2 | Method introduced.

### /4.0/firewall/stats/rules/{ruleId}
Working with Rule Hit Counts for a Specific Rule
----

* **get** *(secured)*: Retrieves the rule hit count statistics for a given rule. 

**Method history:**

Release | Modification
--------|-------------
  6.4.2 | Method introduced.

### /4.0/firewall/config/globalconfiguration
Working With the Distributed Firewall Global Configuration
----------------------------------------------------------
You can use the following parameters to improve firewall performance:

* **layer3RuleOptimize** and **layer2RuleOptimize** to turn
on/off rule optimization.
* **tcpStrictOption** determines whether or not to drop an established
TCP connection when the firewall does not see the initial three-way
handshake. If set to true, the connection will be dropped.   
**Note**: starting in NSX 6.4.0 this setting in the global configuration is 
ignored. **tcpStrict** is instead configured at the section level. See 
"Working with Distributed Firewall Configuration" for more information.
* **autoDraftDisabled** improves performances when making large numbers
of changes to firewall rules.
* **ruleStatsDisabled** describes the state of the rule stats collection. Default value for this field is *false* meaning rule stats collection will be enabled by default. Set the value to *true* to disable rule stats collection on NSX Manager and hosts.

You can disable the auto draft feature by setting **autoDraftDisabled** to
true. Distributed Firewall saves up to 100 configurations, including
manually saved drafts (**preserve** parameter can be set to true or
false) and auto saved drafts (**preserve** parameter is set to false).
Once 100 configurations are saved, older drafts with the **preserve**
parameter set to false will be deleted in order to save new
configurations. You might want to disable the auto drafts feature before
making large numbers of changes to the firewall rules, to improve
performance, and to prevent previously saved drafts from being
overwritten.

Note: The **autoDraftDisabled** parameter does not appear in a GET of the global
configuration.

* **get** *(secured)*: Retrieve performance configuration for distributed firewall.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tcpStrict** in the global configuration is ignored. Instead, configure **tcpStrict** at the section level.
6.4.2 | *ruleStatsDisabled* introduced.

* **put** *(secured)*: Update the distributed firewall performance configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **autoDraftDisabled** parameter added.
6.4.0 | Method updated. **tcpStrict** in the global configuration is ignored. Instead, configure **tcpStrict** at the section level. 
6.4.2 | *ruleStatsDisabled* introduced.

### /4.0/firewall/config/sections
Working With the Distributed Firewall Universal Configuration
----------------------------------------------------------
You can use this *delete* API to delete all universal sections when NSX Manager is in *transit* mode. This API only works when  NSX Manager is in transit mode and universal section are only allowed to be deleted from primary NSX Manager. This API does not work for secondary NSX Manager.

* **delete** *(secured)*: Delete the universal sections when NSX Manager is in transit mode.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced. 

### /4.0/firewall/forceSync/{ID}
Synchronize Firewall
----
Synchronize hosts and clusters with the last good configuration in NSX
Manager database.

* **post** *(secured)*: Force sync host or cluster.

### /4.0/firewall/{domainID}/enable/{truefalse}
Enable Firewall
----
Enable or disable firewall components on a cluster.

* **put** *(secured)*: Enable or disable firewall components on a cluster

### /4.0/firewall/globalroot-0/config/ipfix
Working With IPFIX
---
Configuring IPFIX exports specific flows directly from Distributed
Firewall to a flow collector.

Parameter |  Description | Comments
---|---|---
**ipfixEnabled** | Enabled status of IPFIX | Valid values: *true* or *false*.
**observationDomainId** | Observation domain ID for IPFIX | Required. Must be greater than *0*.
**flowTimeout** | Flow timeout | Required. Valid values: *1-60*.
**collector** | IPFIX collector configuration | Can define multiple.
**collector > ip** | IPFIX collector IP address |
**collector > port** | IPFIX collector port | Valid values: *0-65535*. Default is *4739*. 

* **get** *(secured)*: Retrieve IPFIX configuration.
* **put** *(secured)*: Update IPFIX configuration.

**Method history:**

Release | Modification
--------|-------------
6.3.5 | Default value for collector port changed from *0* to *4739*.

* **delete** *(secured)*: Deleting IPFIX configuration resets the configuration to default values.

### /4.0/firewall/objects/status/vm/{vm_ID}/containers
Distributed Firewall State Realization for Grouping Objects
----
  Use this API to verify whether changes made in the grouping object (container), such as security group, has been realized or not. The API takes the VM ID, the list of container IDs, and the list of *appliedTo* parameter as an input request and returns the list of IPs realized for each vNIC of the VM for each container for the provided *appliedTo* parameters. The API supports maximum of five containers IDs and five *appliedTo* parameters. The API is for Layer3 rules.

Realized status can be:
* **Yes**: If the grouping object (container) has any one of the IPs of the vNIC
* **No**: If the grouping object (container) has none of the IPs of the vNIC
* **Not found**:  If the host could find the vNIC or the grouping object (container)

The API does not support:
* Excluded vNICs
* IPSET/MACSET grouping objects (containers)
* DFW/ Edge/ All Edges/ Any in the *appliedToList*  parameter

* **post** *(secured)*: Get VM Status for the grouping object (container). The parameters in the *container* field are mandatory, and parameters in the *appliedTo* field are optional in the POST request body.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

## spoofGuard
Working With SpoofGuard
==========
After synchronizing with the vCenter Server, NSX Manager collects the IP
addresses of all vCenter guest virtual machines. If a virtual machine has
been compromised, the IP address can be spoofed and malicious
transmissions can bypass firewall policies.

You create a SpoofGuard policy for specific networks that allows you to
authorize the reported IP addresses and alter them if necessary to prevent
spoofing.  SpoofGuard inherently trusts the MAC addresses of virtual
machines collected from the VMX files and vSphere SDK. Operating
separately from Firewall rules, you can use SpoofGuard to block traffic
determined to be spoofed.

### /4.0/services/spoofguard/policies/
Working With SpoofGuard Policies
---------
You can create a SpoofGuard policy to specify the operation mode for
specific networks. The system generated policy applies to port groups
and logical switches not covered by existing SpoofGuard policies.

The operationMode for a SpoofGuard policy can be set to one of the
following:

* **TOFU** - Automatically trust IP assignments on their first use
* **MANUAL** - Manually inspect and approve all IP assignments before first
use
* **DISABLE** - Disable the SpoofGuard policy

* **post** *(secured)*: Create a SpoofGuard policy to specify the operation mode for networks.

**Note:** you must include the trailing slash for this URI:
`/api/4.0/services/spoofguard/policies/`.

* **get** *(secured)*: Retrieve information about all SpoofGuard policies.

**Note:** you must include the trailing slash for this URI:
`/api/4.0/services/spoofguard/policies/`.

### /4.0/services/spoofguard/policies/{policyID}
Working With a Specific SpoofGuard Policy
---

* **get** *(secured)*: Retrieve information about the specified SpoofGuard policy.

* **put** *(secured)*: Modify the specified SpoofGuard policy.
* **delete** *(secured)*: Delete the specified SpoofGuard policy.

### /4.0/services/spoofguard/{policyID}
Perform SpoofGuard Operations on IP Addresses in a Specific Policy
---

* **post** *(secured)*: Approve or publish IP addresses.
* **get** *(secured)*: Retrieve IP addresses for the specified state.

## flowMonitoring
Working With Flow Monitoring
========

### /2.1/app/flow/flowstats
Working With Flow Monitoring Statistics 
----

* **get** *(secured)*: Retrieve flow statistics for a datacenter, port group, VM, or vNIC.

Response values for flow statistics:
* **blocked** - indicates whether traffic is blocked:
  * 0 - flow allowed
  * 1 - flow blocked
  * 2 - flow blocked by SpoofGuard
* **protocol** - protocol in flow:
  * 0 - TCP
  * 1 - UDP
  * 2 - ICMP
* **direction** - direction of flow:
  * 1 - from virtual machine
  * 2 - to virtual machine
* **controlDirection** - control direction for dynamic TCP traffic:
  * 0 - source -> destination
  * 1 - destination -> source

### /2.1/app/flow/flowstats/info
Working With Flow Monitoring Meta-Data
----

* **get** *(secured)*: Retrieve flow statistics meta-data.

This method retrieves the following information for each flow type:
* minimum start time
* maximum end time
* total flow count

### /2.1/app/flow/config
Working With Flow Monitoring Configuration
----

Flow records generated on all hosts are sent to NSX Manager, which
consumes the records and displays aggregated information.  Hosts can
generate large numbers of flow records.  You can configure flow
monitoring to exclude certain records from collection.  The flow
configuration applies to all hosts.

* **collectFlows** - if true, flow collection is enabled.
* **ignoreBlockedFlows** - if true, ignore blocked flows.
* **ignoreLayer2Flows** - if true, ignore layer 2 flows.
* **sourceIPs** - source IPs to exclude. For example: 10.112.3.14, 10.112.3.15-10.112.3.18,192.168.1.1/24.
* **sourceContainer** - source containers to exclude. Containers can contain VM, vNic, IP Set, MAC Set.
* **destinationIPs** - destination IPs to exclude.
* **destinationContainer** - destination containers to exclude. Containers can contain VM, vNic, IP Set, MAC Set.
* **destinationPorts** - destination ports to exclude.
* **serviceContainers** - service containers to exclude. Container can contain application or application group.

Flow exclusion happens at the host. The following flows are discarded by default:
* Broadcast IP (255.255.255.255)
* Local multicast group (224.0.0.0/24)
* Broadcast MAC address (FF:FF:FF:FF:FF:FF)

* **get** *(secured)*: Retrieve flow monitoring configuration.
* **put** *(secured)*: Update flow monitoring configuration.

### /2.1/app/flow/{contextId}
Working With Flow Configuration for a Specific Context
----

* **delete** *(secured)*: Delete flow records for the specified context.

## dfwExclusion
Exclude Virtual Machines from Firewall Protection
=========

### /2.1/app/excludelist

* **get** *(secured)*: Retrieve the set of VMs in the exclusion list.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. Added query parameter *excludelist?listSystemResources=true* to list the system resources in the exclude list.

### /2.1/app/excludelist/{memberID}
Working With the Exclusion List
---

* **put** *(secured)*: Add a vm to the exclusion list.
* **delete** *(secured)*: Delete a vm from exclusion list.

## nsxEdges
Working With NSX Edge
=======
There are two types of NSX Edge: Edge services gateway and logical
(distributed) router.

### Edge Services Gateway

The services gateway gives you access to all NSX Edge services such as
firewall, NAT, DHCP, VPN, load balancing, and high availability. You can
install multiple Edge services gateway virtual appliances in a
datacenter. Each Edge service gateway virtual appliance can have a
total of ten uplink and internal network interfaces. 

The internal interfaces connect to secured port groups and act as the
gateway for all protected virtual machines in the port group. The subnet
assigned to the internal interface can be a publicly routed IP space or
a NATed/routed RFC 1918 private space. Firewall rules and other NSX Edge
services are enforced on traffic between network interfaces.

Uplink interfaces of NSX Edge connect to uplink port groups that have
access to a shared corporate network or a service that provides access
layer networking. Multiple external IP addresses can be configured for
load balancer, site-to-site VPN, and NAT services.

### Logical (Distributed) Router

The logical router provides East-West distributed routing with tenant IP
address space and data path isolation. Virtual machines or workloads
that reside on the same host on different subnets can communicate with
one another without having to traverse a traditional routing interface.

A logical router can have up to 9 uplink interfaces and up to 990
internal interfaces.

### /4.0/edges

* **post** *(secured)*: You can install NSX Edge as a services gateway or as a logical router.

The **type** parameter determines which type of NSX Edge is deployed:
*distributedRouter* or *gatewayServices*. If no type is specified, the
type is *gatewayServices*.

Other parameters for this method will differ depending on which type of
NSX Edge you are deploying. See the examples and parameter tables for
more information.

### NSX Edge: Service Gateway

The NSX Edge installation API copies the NSX Edge OVF from the Edge
Manager to the specified datastore and deploys an NSX Edge on the given
datacenter. After the NSX Edge is installed, the virtual machine powers
on and initializes according to the given network configuration. If an
appliance is added, it is deployed with the specified configuration.

Installing an NSX Edge instance adds a virtual machine to the vCenter
Server inventory, you must specify an IP address for the management
interface, and you may name the NSX Edge instance.

The configuration you specify when you install an NSX Edge is stored in
the database. If an appliance is added, the configuration is applied to
it and it is deployed.

NOTE: Do not use hidden/system resource pool IDs as they are not
supported on the UI.

#### Request Body to Create Edge Services Gateway

    <edge>
      <datacenterMoid>datacenter-2</datacenterMoid>
      <name>org1-edge</name>
      <description>Description for the edge gateway</description>
      <tenant>org1</tenant>
      <fqdn>org1edge1</fqdn>
      <vseLogLevel>info</vseLogLevel>
      <enableAesni>false</enableAesni>
      <enableFips>true</enableFips>
      <appliances>
        <applianceSize>compact</applianceSize>
        <enableCoreDump>true</enableCoreDump>
        <appliance>
          <resourcePoolId>resgroup-53</resourcePoolId>
          <datastoreId>datastore-29</datastoreId>
          <hostId>host-28</hostId> 
          <vmFolderId>group-v38</vmFolderId> 
          <customField> 
            <key>system.service.vmware.vsla.main01</key>
            <value>string</value>
          </customField>
          <cpuReservation> 
            <limit>2399</limit>
            <reservation>500</reservation>
            <shares>500</shares>
          </cpuReservation>
          <memoryReservation> 
            <limit>5000</limit>
            <reservation>500</reservation>
            <shares>20480</shares>
          </memoryReservation>
        </appliance>
      </appliances>
      <vnics>
        <vnic>
          <index>0</index>
          <name>internal0</name>
          <type>internal</type>
          <portgroupId>dvportgroup-114</portgroupId>
          <addressGroups>
            <addressGroup>
              <primaryAddress>192.168.3.1</primaryAddress>
              <secondaryAddresses>
                <ipAddress>192.168.3.2</ipAddress>
                <ipAddress>192.168.3.3</ipAddress>
              </secondaryAddresses>
              <subnetMask>255.255.255.0</subnetMask>
            </addressGroup>
            <addressGroup>
              <primaryAddress>192.168.4.1</primaryAddress>
              <secondaryAddresses>
                <ipAddress>192.168.4.2</ipAddress>
                <ipAddress>192.168.4.3</ipAddress>
              </secondaryAddresses>
              <subnetPrefixLength>24</subnetPrefixLength>
            </addressGroup>
            <addressGroup>
              <primaryAddress>ffff::1</primaryAddress>
              <secondaryAddresses>
                <ipAddress>ffff::2</ipAddress>
              </secondaryAddresses>
              <subnetPrefixLength>64</subnetPrefixLength>
            </addressGroup>
          </addressGroups>
          <macAddress>
            <edgeVmHaIndex>0</edgeVmHaIndex>
            <value>00:50:56:01:03:23</value>
          </macAddress>
          <fenceParameter>
            <key>ethernet0.filter1.param1</key>
            <value>1</value>
          </fenceParameter>
          <mtu>1500</mtu>
          <enableProxyArp>false</enableProxyArp>
          <enableSendRedirects>true</enableSendRedirects>
          <isConnected>true</isConnected>
          <inShapingPolicy>
            <averageBandwidth>200000000</averageBandwidth>
            <peakBandwidth>200000000</peakBandwidth>
            <burstSize>0</burstSize>
            <enabled>true</enabled>
            <inherited>false</inherited>
          </inShapingPolicy>
          <outShapingPolicy>
            <averageBandwidth>400000000</averageBandwidth>
            <peakBandwidth>400000000</peakBandwidth>
            <burstSize>0</burstSize>
            <enabled>true</enabled>
            <inherited>false</inherited>
          </outShapingPolicy>
        </vnic>
      </vnics>
      <cliSettings>
        <userName>test</userName>
        <password>test123!</password>
        <remoteAccess>false</remoteAccess>
      </cliSettings>
      <autoConfiguration>
        <enabled>true</enabled>
        <rulePriority>high</rulePriority>
      </autoConfiguration>
      <dnsClient>
        <primaryDns>10.117.0.1</primaryDns>
        <secondaryDns>10.117.0.2</secondaryDns>
        <domainName>vmware.com</domainName>
        <domainName>foo.com</domainName>
      </dnsClient>
      <queryDaemon>
        <enabled>true</enabled>
        <port>5666</port>
      </queryDaemon>
    </edge>

### NSX Edge: Logical (Distributed) Router

Before installing a logical router, you must prepare the hosts on the
appropriate clusters. 

The user specified configuration is stored in the database
and Edge identifier is returned to the user. This identifier must be
used for future configurations on the given Edge.  If any appliance(s)
are specified and at least one connected interface/vnic is specified,
then the appliance(s) are deployed and configuration is applied to them.

It is not possible to set the <ecmp>true</ecmp> property upon creation
of a distributed logical router Edge and a subsequent API call is
required to enable ECMP.

DHCP relay settings are not able to be used when creating a distributed
logical router Edge and a subsequent API call is required to configure
DHCP relay properties.

#### Request Body to Create Logical (Distributed) Router

    <edge>
      <datacenterMoid>datacenter-2</datacenterMoid>
      <type>distributedRouter</type>
      <appliances>
        <appliance>
        <resourcePoolId>resgroup-20</resourcePoolId>
        <datastoreId>datastore-23</datastoreId>
        </appliance>
      </appliances>
      <mgmtInterface>
        <connectedToId>dvportgroup-38</connectedToId>
          <addressGroups> 
            <addressGroup>
              <primaryAddress>10.112.196.165</primaryAddress>
              <subnetMask>255.255.252.0</subnetMask>
            </addressGroup>
           </addressGroups>
      </mgmtInterface>
      <interfaces>
        <interface>
          <type>uplink</type>
          <mtu>1500</mtu>
          <isConnected>true</isConnected>
          <addressGroups> 
            <addressGroup>
              <primaryAddress>192.168.10.1</primaryAddress>
              <subnetMask>255.255.255.0</subnetMask>
            </addressGroup>
          </addressGroups>
          <connectedToId>dvportgroup-39</connectedToId>
        </interface>
        <interface>
          <type>internal</type>
          <mtu>1500</mtu>
          <isConnected>true</isConnected>
          <addressGroups> 
            <addressGroup>
              <primaryAddress>192.168.20.1</primaryAddress>
              <subnetMask>255.255.255.0</subnetMask>
            </addressGroup>
          </addressGroups>
          <connectedToId>dvportgroup-40</connectedToId>
        </interface>
      </interfaces>
    </edge>
### Request and Response Body Parameters for NSX Edge

#### General Request Body Parameters: Edge Services Gateway and Logical (Distributed) Router

Parameter |  Description | Comments 
---|---|---
**datacenterMoid** |Specify vCenter Managed Object Identifier of data center on which edge has to be deployed|Required. 
**type** | Specify which kind of NSX Edge to deploy. Choice of *distributedRouter* or *gatewayServices*. | Optional. Default is *gatewayServices*.
**name** |Specify a name for the new NSX Edge.|Optional. Default is *NSX-&lt;edgeId&gt;*. Used as a VM name on vCenter appended by *-&lt;haIndex&gt;*. 
**description** |NSX Edge description.|Optional. 
**tenant** |Specify the tenant. Used for syslog messages.|Optional. 
**fqdn** |Fully Qualified Domain Name for the edge.|Optional. Default is *NSX-&lt;edgeId&gt;* Used to set hostname on the VM. Appended by *-&lt;haIndex&gt;*
**vseLogLevel** |Defines the log level for log messages captured in the log files.|Optional. Choice of: *emergency*, *alert*, *critical*, *error*, *warning*, *notice*, *debug*. Default is *info*.
**enableAesni** |Enable support for Advanced Encryption Standard New Instructions on the Edge.|Optional. True/False. Default is *true*.
**enableCoreDump** |Deploys a new NSX Edge for debug/core-dump purpose.|Optional. Default is false. Enabling core-dump will deploy an extra disk for core-dump files.

#### Appliances Configuration: Edge Services Gateway and Logical (Distributed) Router

Parameter |  Description | Comments 
---|---|---
**applianceSize** |Edge form factor, it determines the NSX Edge size and capability. |Required. Choice of: *compact*, *large*, *quadlarge*, *xlarge*. Default is *compact*.
**deployAppliances** | Determine whether to deploy appliances. | Default is *true*.
**appliance** |Appliance configuration details.|Required. Can configure a maximum of two appliances. Until one appliance is configured and NSX Edge VM is deployed successfully, none of the configured features will serve the network.
**resourcePoolId** |Details of resource pool on which to deploy NSX Edge. |Required. Can be resource pool ID, e.g. *resgroup-15* or cluster ID, e.g. *domain-c41*.
**datastoreId** |Details of datastore on which to deploy NSX Edge.|Required. 
**hostId** |ID of the host on which to deploy the NSX Edge.|Optional. 
**vmFolderId** |The folder in which to save the NSX Edge.|Optional. 
**customField** |Custom key-value attributes. |Optional. Use custom attributes to associate user-specific meta-information with VMs and managed hosts, stored on vCenter Server.
**customField > key** |Meta information Key.|Required if customField is specified. 
**customField > value** |Meta information Value.|Required if customField is specified. 
**cpuReservation > limit** |Maximum CPU capacity the NSX Edge can use, specified in MHz.|Optional. -1 (unlimited), any positive integer
**cpuReservation > reservation** |CPU capacity reserved for NSX Edge in MHz.|Optional. 
**cpuReservation > shares** |Higher value implies NSX Edge has priority when accessing resources.|Optional. 
**memoryReservation > limit** |Maximum memory the NSX Edge can use, specified in MB.|Optional. -1 (unlimited), any positive integer
**memoryReservation > reservation** |Memory capacity reserved for NSX Edge in MB.|Optional. 
**memoryReservation > shares** |Higher value implies NSX Edge has priority when accessing resources.|Optional. 
**cliSettings > userName** |User name.|Required. length 1-33.
**cliSettings > password** |Password.|Required. The password must be at least 12 characters long. Must contain at-least 1 uppercase, 1 lowercase, 1 special character and 1 digit. In addition, a character cannot be repeated 3 or more times consectively.
**cliSettings > remoteAccess** |Enables or disables remote access through SSH. |Required. Relevant firewall rules to allow traffic on port 22 must be opened by user/client
**autoConfiguration > enabled** |Enable/Disable status of autoConfiguration|Optional. True/False. Default is *true*. If autoConfiguration is enabled, firewall rules are automatically created to allow control traffic. Rules to allow data traffic are not created.  For example, if you are using IPsec VPN, and **autoConfiguration** is *true*, firewall rules will automatically be configured to allow IKE traffic. However, you will need to add additional rules to allow the data traffic for the IPsec tunnel. If HA is enabled, firewall rules are always created, even if **autoConfiguration** is *false*, otherwise both HA appliances will become active.
**autoConfiguration > rulePriority** |Defines the priority of system-defined rules over user-defined rules.|Optional. High, Low.  Default is *high*.
**queryDaemon > enabled** |Configure the communication between server load balancer and NSX Edge VM.|Default is *false*.
**queryDaemon > port** |Defines the port through which the communication happens.|Integer 1-65535. Default is *5666*.

#### DNS Client: Edge Services Gateway and Logical (Distributed) Router 

Parameter |  Description | Comments 
---|---|---
**dnsClient** |Configures the DNS settings of the Edge Services Gateway.|Optional. If the primary/secondary are specified and the DNS service is not specified, the primary/secondary will be used as the default of the DNS service.
**primaryDns** |Primary DNS IP |
**secondaryDns** |Secondary DNS IP |
**domainName** |Domain Name of Edge |
**domainName** |Secondary Domain Name of Edge |

#### vNIC Parameters: Edge Services Gateway Only

Parameter |  Description | Comments
---|---|---
**vnic** |Configure interface (vNic).|Required. Until one connected vNic is configured, none of the configured features will serve the network.
**index** |Index of vNic to be configured. Value varies from 0-9. 4094 sub-interfaces can be configured in trunk mode.|Required. 
**name** |Name of the vNic.|Optional. System provides default names: vnic0...vnic9.
**label** |Label for the vNic.|Optional. System provides default labels: vNic_0...vNic_9.
**type** |Type of interface connected to vNic.|Optional. Choice of: *Uplink*, *Internal*, *TRUNK*. Default is *Internal*. *TRUNK* should be specified when sub-interfaces are configured.
**portgroupId** |Connect NSX Edge to the network through this port group.|Required. Choice of: *portgroupId* or *virtualWireId*. *portgroupId* needs to be defined if *isConnected=true*
**addressGroup** |Address Group assigned to vNic.|Required. More than one addressGroup/subnets can be assigned to the vNic.
**primaryAddress** |Primary Address of Edge Interface.|Required. IPv4 and IPv6 addresses are supported.
**secondaryAddresses > ipAddress** |IP assigned to interface.|Optional. One or more **ipAddress** parameters are allowed, to enable assigning multiple IP addresses to a vNic, for example, for load balancing, NAT, VPN. At least one is required if **secondaryAddresses** is specified. 
**subnetMask** or **subnetPrefixLength** |Subnet mask or prefix value.  |Required. Either **subnetMask** or **subnetPrefixLength** should be provided. When both are provided then **subnetprefixLength** is ignored.
**macAddress** |Option to manually specify the MAC address. |Optional.  Managed by vCenter if not provided.
**macAddress > edgeVmHaIndex** |HA index of the Edge VM. |Required. 0 or 1.
**macAddress > value** |Value of the MAC address.|Optional. Ensure that MAC addresses provided are unique within the given layer 2 domain.
**vnic > mtu** |The maximum transmission value for the data packets.|Optional.  Default is *1500*.
**enableProxyArp** |Enables proxy ARP. Do not use this flag unless you want NSX Edge to proxy ARP for all configured subnets.  |Optional.  True/False. Default is *false*.
**enableSendRedirects** |Enables ICMP redirect. |Optional. True/False.  Default is *true*.
**isConnected** |Sets if the interface is connected to the port group network. |Optional. True/False. Default is *false*. **portgroupId** needs to be defined if *isConnected=true*.
**inShapingPolicy** |Configure Incoming Traffic.|Optional. 
**outShapingPolicy** |Configure Outgoing Traffic.|Optional. 
**averageBandwidth**<br>(inShapingPolicy or outShapingPolicy) |Sets average bandwidth for traffic.|Optional. 
**peakBandwidth**<br>(inShapingPolicy or outShapingPolicy) |Sets peak bandwidth for traffic.|Required. 
**burstSize**<br>(inShapingPolicy or outShapingPolicy) |Sets the burst size of the interface.|Required. 
**enabled**<br>(inShapingPolicy or outShapingPolicy) |Enable/disable status of this traffic policy.|Required. 
**inherited**<br>(inShapingPolicy or outShapingPolicy) |Determine whether properties should be inherited to the vNic from the port group.|Required. 

#### HA (Management) Interfaces and Interfaces Configuration: Logical (Distributed) Router Only

Parameter |  Description | Comments 
---|---|---
**mgmtInterface** | High availability interface configuration. Interface index 0 is assigned. | Required.
**interface** | Interface configuration. 1-9 are reserved for uplinks, 10-999 are used for internal interfaces. | Optional. Can be added after logical router creation.
**connectedToId**<br>(mgmtInterface or interface) | Managed Object ID of logical switch or port group. | For example, *virtualwire-1* or *dvportgroup-50*. Logical router interfaces do not support legacy port groups. 
**name**<br>(mgmtInterface or interface) | Name assigned to interface. | Optional.
**addressGroup**<br>(mgmtInterface or interface) |Address Group assigned to interface. |Required. Only one **addressGroup** can be configured on each logical router **mgmtInterface** or **interface**.
**primaryAddress**<br>(mgmtInterface or interface) |Primary Address of interface. |Required. Secondary Addresses are not supported on logical routers. Address must be IPv4.
**subnetMask** or **subnetPrefixLength**<br>(mgmtInterface or interface) |Subnet mask or prefix value.  |Required. Either **subnetMask** or **subnetPrefixLength** should be provided. When both are provided then **subnetprefixLength** is ignored.
**mtu**<br>(mgmtInterface or interface) |The maximum transmission value for the data packets. |Optional. Default is 1500.
**type** | Type of interface. | Required. Choice of *uplink* or *internal*. 

* **get** *(secured)*: Retrieve a list of all NSX Edges in your inventory. You can use the query
parameters to filter results.

### /4.0/edges/{edgeId}
Working With a Specific NSX Edge
------

* **post** *(secured)*: Manage NSX Edge.
* **get** *(secured)*: Retrieve information about the specified NSX Edge.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **haAdminState**, **configuredResourcePool**, **configuredDataStore**, **configuredHost**, **configuredVmFolder** parameters added. 
6.4.0 | Method updated. New parameter **ipsecSessionType** added under the *site* section. This is a read-only parameter.

* **put** *(secured)*: Update the NSX Edge configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **haAdminState** parameter added.
6.3.0 | Method updated. **dnatMatchSourceAddress**, **snatMatchDestinationAddress**, **dnatMatchSourcePort**, **snatMatchDestinationPort** parameters added. <br>**protocol**, **originalPort**, and **translatedPort** now supported in SNAT rules.
6.4.0 | Method updated. New parameter **ipsecSessionType** added under the *site* section. This is a read-only parameter, and optional if used in a PUT call. If used, it must be set to *policybasedSession*.

* **delete** *(secured)*: Delete specified NSX Edge configuration. Associated appliances are
also deleted.

### /4.0/edges/{edgeId}/dnsclient
Working With DNS Client Configuration
----

* **put** *(secured)*: Update Edge DNS settings.

### /4.0/edges/{edgeId}/aesni
Working With AESNI 
----

* **post** *(secured)*: Modify AESNI setting.

### /4.0/edges/{edgeId}/coredump
Working With Core Dumps
-----
Enabling core-dump feature results in deployment of built-in extra disk
to save core-dump files. Disabling detaches the disk.

* **post** *(secured)*: Modify core dump setting.

### /4.0/edges/{edgeId}/fips
Working With FIPS on NSX Edge
----

* **post** *(secured)*: Modify FIPS setting.

### /4.0/edges/{edgeId}/logging
Working With NSX Edge Logs
-----

* **post** *(secured)*: Modify log setting.

### /4.0/edges/{edgeId}/summary
Working With NSX Edge Summary
----

* **get** *(secured)*: Retrieve details about the specified NSX Edge.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method updated. **enableFips** parameter added to **appliancesSummary**.

### /4.0/edges/{edgeId}/status
Working With NSX Edge Status
----

* **get** *(secured)*: Retrieve the status of the specified Edge.

The **edgeStatus** has the following possible states:
* *GREEN*: Health checks are successful, status is good.
* *YELLOW*: Intermittent health check failure. If health check fails
  for five consecutive times for all appliances, status will turn
  *RED*.
* *GREY*: unknown status.
* *RED*: None of the appliances for this NSX Edge are in a serving state.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. The **detailed** query parameter now specifies whether detailed info is displayed for **featureStatuses** only. Detailed info is now always displayed for **edgeVMStatus**. <br>The **systemStatus** parameter is deprecated, and might be removed in a future release.

### /4.0/edges/{edgeId}/healthsummary
Working With NSX Edge Health Summary
-----

* **get** *(secured)*: Retrieve detailed health information about an NSX Edge. 

This includes features, VM health status, upgrade availability, alarms
and pending jobs. 

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /4.0/edges/{edgeId}/techsupportlogs
Working With NSX Edge Tech Support Logs 
----

* **get** *(secured)*: Retrieve the tech support logs for the specified NSX Edge.

The response status for the tech support logs API request is `303 See
Other`, and the **Location** header contains the file location of the
tech support logs on the NSX Manager web server.

If your REST client is configured to not follow redirects, see the
Location header to find the location of the tech support logs on the
NSX Manager web server. You can retrieve the logs from
`https://<nsxmgr-address>/<location>`.

Example in curl:
```
$ curl -k -i -s -H 'Authorization: Basic YWRtaW46Vk13YXJlMSE=' -H "Content-Type: application/xml" -H "Accept: application/xml" -X GET https://192.168.110.42/api/4.0/edges/edge-4/techsupportlogs
HTTP/1.1 303 See Other
Cache-Control: private
Expires: Thu, 01 Jan 1970 00:00:00 GMT+00:00
Server:
Cache-Control: no-cache
Location: /tech_support_logs/vse/NSX_Edge_Support_edge-4_050217_155853GMT+00:00.log.gz
Date: Tue, 02 May 2017 15:59:02 GMT
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Frame-Options: SAMEORIGIN
Content-Length: 0
```

In this example, the log location is `https://192.168.110.42/tech_support_logs/vse/NSX_Edge_Support_edge-4_050217_155853GMT+00:00.log.gz`

If your REST client is configured to follow redirects, the request
retrieves the tech support log file from the file location in the
**Location** field. Consult your REST client documentation for
information on saving binary file responses.

Example in curl:
```
curl -k -L -s -H 'Authorization: Basic YWRtaW46ZGXXXXXXXX==' -H "Content-Type: application/xml" -H "Accept: application/xml" -X GET https://192.168.110.42/api/4.0/edges/edge-4/techsupportlogs > NSX_Edge_Support_edge-4.log.gz
```

### /4.0/edges/{edgeId}/clisettings
Working With NSX Edge CLI Settings
----

* **put** *(secured)*: Modify CLI credentials and enable/disable SSH for Edge.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. Modified existing API to enable SSH on edge without changing the password. Now you can enable SSH without mentioning the password. If password is provided, the provided password is saved in the database. If password is not provided, NSX Manager will retain password from the database.

### /4.0/edges/{edgeId}/cliremoteaccess
Working With NSX Edge Remote Access 
----

* **post** *(secured)*: Change CLI remote access

### /4.0/edges/{edgeId}/systemcontrol/config
Working With NSX Edge System Control Configuration
-----

* **put** *(secured)*: Update the NSX Edge system control (sysctl) configuration.

* **get** *(secured)*: Retrieve all NSX Edge system control configuration.

If no system control parameters are configured, the response is empty.

* **delete** *(secured)*: Delete all NSX Edge system control configuration.

Deleting the system control configuration requires a reboot of the
NSX Edge appliance.

### /4.0/edges/{edgeId}/firewall/config
Working With NSX Edge Firewall Configuration
----
Configures firewall for an Edge and stores the specified configuration
in database. If any appliances are associated with this Edge, applies
the configuration to them. While using this API, you should send the
globalConfig, defaultPolicy and the rules. If either of them are not
sent, the previous config if any on those fields will be removed and
will be changed to the system defaults.  

**ruleId** uniquely identifies a rule and should be specified only for
rules that are being updated.  If **ruleTag** is specified, the rules
on Edge are configured using this user input. Otherwise, Edge is
configured using **ruleIds** generated by NSX Manager.

Parameter | Comments
----|----
**tcpPickOngoingConnections**|Boolean, optional, default: *false*.
**tcpAllowOutOfWindowPackets**|Boolean, optional, default: *false*.
**tcpSendResetForClosedVsePorts**|Boolean, optional, default: *true*.
**dropInvalidTraffic**|Boolean, optional, default: *true*.
**logInvalidTraffic**|Boolean, optional, default: *false*.
**tcpTimeoutOpen**|Integer, optional, default: *30*.
**tcpTimeoutEstablished**|Integer, optional, default: *21600*.
**tcpTimeoutClose**|Integer, optional, default: *30*.
**udpTimeout**|Integer, optional, default: *60*.
**icmpTimeout**|Integer, optional, default: *10*.
**icmp6Timeout**|Integer, optional, default: *10*.
**ipGenericTimeout**|Integer, optional, default: *120*.
**enableSynFloodProtection**|Protect against SYN flood attacks by detecting bogus TCP connections and terminating them without consuming firewall state tracking resources. Boolean, optional, default: *false*.
**logIcmpErrors** | Boolean, optional, default *false*.
**dropIcmpReplays** | Boolean, optional, default *false*.
**defaultPolicy**|Optional. Default is *deny*.
**action**|String, values: *accept*, *deny*.
**loggingEnabled**|Boolean, optional, default: *false*.
**firewallRules**|Optional.
**action**|String. Valid values: *accept*, *deny*.
**source  **|Optional.  Default is *any*.
**destination**|Optional. Default is *any*.
**exclude**<br>(source or destination)|Boolean. Exclude the specified source or destination.
**ipAddress**<br>(source or destination)|List of string. Can specify single IP address, range of IP address, or in CIDR format. Can define multiple.
**groupingObjectId**<br>(source or destination)|List of string, Id of cluster, datacenter, distributedPortGroup, legacyPortGroup, VirtualMachine, vApp, resourcePool, logicalSwitch, IPSet, securityGroup. Can defined multiple.
**vnicGroupId**<br>(source or destination)|List of string. Possible values are *vnic-index-[1-9]*, *vse*, *nat64*, *external* or *internal*. Can define multiple.
**application**| optional. When absent its treated as *any*.
**applicationId**|List of string. Id of service or serviceGroup groupingObject. 
**service**|List.   
**protocol**|String.    
**port**|List of string.    
**sourcePort**|List of string.    
**icmpType**|String.    
**name**|String.    
**description**|String.   
**enabled**|Boolean, optional. Default *true*. 
**loggingEnabled**|Boolean, optional. Default *false*. 
**matchTranslated**|Boolean.   
**direction**|String, optional. Possible values *in* or *out*. When absent its treated as *any*.
**ruleTag**|Long, optional. This can be used to specify user controlled **ruleId**. If not specified, NSX Manager will generate **ruleId**. Valid values: *1-65536*.  

* **get** *(secured)*: Retrieve the NSX Edge firewall configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **enableSynFloodProtection** parameter added. 
6.3.0 | Method updated. **logIcmpErrors** and **dropIcmpReplays** parameters added. 

* **put** *(secured)*: Configure NSX Edge firewall.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **enableSynFloodProtection** parameter added. Default value of **tcpTimeoutEstablished** increased from 3600 to 21600 seconds (6 hours).
6.3.0 | Method updated. **logIcmpErrors** and **dropIcmpReplays** parameters added. 
6.4.0 | Method updated. *nat64* is now a possible value for **vnicGroupId** for source and destination.

* **delete** *(secured)*: Delete NSX Edge firewall configuration.

### /4.0/edges/{edgeId}/firewall/config/rules
Working With Firewall Rules
----

* **post** *(secured)*: Add one or more rules. You can add a rule above a specific rule
using the query parameter, indicating the desired ruleID.

### /4.0/edges/{edgeId}/firewall/config/rules/{ruleId}
Working With a Specific Firewall Rule
----

* **get** *(secured)*: Retrieve specific rule.
* **put** *(secured)*: Modify a specific firewall rule.
* **delete** *(secured)*: Delete firewall rule

### /4.0/edges/{edgeId}/firewall/config/global
Working With the NSX Edge Global Firewall Configuration
----

* **get** *(secured)*: Retrieve the firewall default policy for an Edge.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **enableSynFloodProtection** parameter added. 
6.3.0 | Method updated. **logIcmpErrors** and **dropIcmpReplays** parameters added. 

* **put** *(secured)*: Configure firewall global config for an Edge.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **enableSynFloodProtection** parameter added. Default value of **tcpTimeoutEstablished** increased from 3600 to 21600 seconds (6 hours).
6.3.0 | Method updated. **logIcmpErrors** and **dropIcmpReplays** parameters added. 

### /4.0/edges/{edgeId}/firewall/config/defaultpolicy
Working With the Default Firewall Policy for an Edge
-----

* **get** *(secured)*: Retrieve default firewall policy
* **put** *(secured)*: Configure default firewall policy

### /4.0/edges/{edgeId}/firewall/statistics/{ruleId}
Working With Statistics for a Specific Firewall Rule
-----

* **get** *(secured)*: Retrieve stats for firewall rule.

### /4.0/edges/{edgeId}/nat/config
Working With NAT Configuration
-----
NSX Edge provides network address translation (NAT) service to protect
the IP addresses of internal (private) networks from the public
network.

You can configure NAT rules to provide access to services running on
privately addressed virtual machines.  You can configure source NAT (SNAT) 
and destination NAT (DNAT) rules.

For the data path to work, you need to add firewall rules to allow the
required traffic for IP addresses and port per the NAT rules.

You can also configure NAT64 rules to allow access from IPv6 networks
to IPv4 networks.

You must configure your Edge Services Gateway to have the IPv6 address
configured on an uplink interface, and the IPv4 address configured on an
internal interface.

See the *NSX Administration Guide* for more information about NAT64, 
including how to configure the Edge Services Gateway, and what features 
of NAT64 are supported.

**NAT Parameter Table**

Parameter |  Description | Other information
---|---
**enabled** |Enable rule. | Boolean. Optional. Default is *true*.
**loggingEnabled** |Enable logging. | Boolean. Optional. Default is *false*.
**ruleTag** | Rule tag. | This can be used to specify user-controlled **ruleId**. If not specified, NSX Manager will generate **ruleId**. Optional. Must be between 65537-131072.
**ruleId** |Identifier for the rule. |Read-only. Long.
**ruleType** |Rule type. |Read-only.  Values: *user*, *internal_high*.
**action** |Type of NAT.| Valid values: *snat* or *dnat*.
**vnic** | Interface on which the translating is applied.|String. Optional. *nat64* is supported as an interface.
**originalAddress** | Original address or address range. This is the source address for SNAT rules, and the destination address for DNAT rules. |String. Specify *any*, an IP address (e.g. *192.168.10.10*), an IP range (e.g. *192.168.10.10-192.168.10.19*), or a subnet in CIDR notation (e.g. *192.168.10.1/24*). Default is *any*. 
**translatedAddress** | Translated address or address range. |String. Specify *any*, an IP address (e.g. *192.168.10.10*), an IP range (e.g. *192.168.10.10-192.168.10.19*), or a subnet in CIDR notation (e.g. *192.168.10.1/24*). Default is *any*. 
**dnatMatchSourceAddress** | Source address to match in DNAT rules. | String. Specify *any*, an IP address (e.g. *192.168.10.10*), an IP range (e.g. *192.168.10.10-192.168.10.19*), or a subnet in CIDR notation (e.g. *192.168.10.1/24*). Default is *any*. Not valid for SNAT rules.
**snatMatchDestinationAddress** | Destination address to match in SNAT rules. | String. Specify *any*, an IP address (e.g. *192.168.10.10*), an IP range (e.g. *192.168.10.10-192.168.10.19*), or a subnet in CIDR notation (e.g. *192.168.10.1/24*). Default is *any*. Not valid for DNAT rules.
**protocol** |Protocol. |String. Optional. Default is *any*.
**icmpType** |ICMP type. |String. Only supported when protocol is *icmp*. Default is *any*.
**originalPort** |Original port. This is the source port for SNAT rules, and the destination port for DNAT rules. |String. Optional. Specify *any*, a port (e.g. 1234) or port range (1234-1239). Default is *any*. 
**translatedPort** |Translated port. |String. Optional. Specify *any*, a port (e.g. 1234) or port range (1234-1239). Default is *any*. 
**dnatMatchSourcePort** | Source port in DNAT rules. | String. Optional. Specify *any*, a port (e.g. 1234) or port range (1234-1239). Default is *any*. Not valid for SNAT rules.
**snatMatchDestinationPort** | Destination port in SNAT rules. | String. Optional. Specify *any*, a port (e.g. 1234) or port range (1234-1239). Default is *any*. Not valid for DNAT rules.

**NAT64 Parameter Table**

Parameter |  Description | Other information
---|---
**matchIpv6DestinationPrefix** | IPv6 address used to map IPv6 destinations to IPv4 destinations. | IPv6 CIDR. Prefix length must be *32*, *40*, *48*, *56*, *64*, or *96*. The IPv4 destination address is appended to this network. For example, if the prefix is *64:ff9b::/96*, and the destination IPv4 IP is *120.1.1.3*, the IPv6 destination is *64:ff9b::7801:0103* (*7801:0103* is *120.1.1.3* in hex). You can use the well-known prefix defined in RFC 6052: *64:ff9b::/96*, or use any other IPv6 CIDR that is not already in use in your environment. You can use a network or an IP address.
**translatedIpv4SourcePrefix** | IPv4 address used to translate an IPv6 source address into an IPv4 source address. | IPv4 CIDR. The translated IPv4 source address is assigned from this network. For example, if the prefix is *10.10.10.0/24*, the source address might be *10.10.10.5*. You can use any IPv4 CIDR that is not already in use in your environment, or optionally use the shared address defined in RFC 6598: *100.64.0.0/10*. You can use a network or an IP address.
**ruleId** | Identifier for the NAT64 rule. |Read-only. Long.
**ruleTag** | Rule tag for the NAT64 rule. | This can be used to specify user-controlled **ruleId**. If not specified, NSX Manager will generate **ruleId**. Optional. Must be between *65537-131072*.
**loggingEnabled** | Enable logging for the NAT64 rule. | Boolean. Optional. Default is *false*.
**enabled** | Enable the NAT64 rule. | Boolean. Optional. Default is *true*.
**description** | Description for the NAT64 rule. | Optional.

* **put** *(secured)*: Configure NAT rules for an Edge.

If you use this method to add new NAT rules, you must include all
existing rules in the request body. Any rules that are omitted will
be deleted.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **vnic** parameter is now optional. The **originalAddress** for DNAT rules, and the **translatedAddress** for SNAT rules is no longer required to be a IP configured on one of the NSX Edge vNics.
6.3.0 | Method updated. **dnatMatchSourceAddress**, **snatMatchDestinationAddress**, **dnatMatchSourcePort**, **snatMatchDestinationPort** parameters added. <br>**protocol**, **originalPort**, and **translatedPort** now supported in SNAT rules.
6.4.0 | Method updated. NAT64 support added.

* **get** *(secured)*: Retrieve NAT rules for the specified NSX Edge.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method updated. **dnatMatchSourceAddress**, **snatMatchDestinationAddress**, **dnatMatchSourcePort**, **snatMatchDestinationPort** parameters added. <br>**protocol**, **originalPort**, and **translatedPort** now supported in SNAT rules.

* **delete** *(secured)*: Delete all NAT rules for the specified NSX Edge. The auto plumbed
rules continue to exist.

### /4.0/edges/{edgeId}/nat/config/rules
Working With NAT Rules
----

* **post** *(secured)*: Add a NAT rule above a specific rule in the NAT rules table (using
**aboveRuleId** query parameter) or append NAT rules to the bottom.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **vnic** parameter is now optional. The **originalAddress** for DNAT rules, and the **translatedAddress** for SNAT rules is no longer required to be a IP configured on one of the NSX Edge vNics.
6.3.0 | Method updated. **dnatMatchSourceAddress**, **snatMatchDestinationAddress**, **dnatMatchSourcePort**, **snatMatchDestinationPort** parameters added. <br>**protocol**, **originalPort**, and **translatedPort** now supported in SNAT rules.

### /4.0/edges/{edgeId}/nat/config/rules/{ruleID}
Working With a Specific NAT Rule
-----

* **put** *(secured)*: Update the specified NAT rule.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **vnic** parameter is now optional. The **originalAddress** for DNAT rules, and the **translatedAddress** for SNAT rules is no longer required to be a IP configured on one of the NSX Edge vNics.
6.3.0 | Method updated. **dnatMatchSourceAddress**, **snatMatchDestinationAddress**, **dnatMatchSourcePort**, **snatMatchDestinationPort** parameters added. <br>**protocol**, **originalPort**, and **translatedPort** now supported in SNAT rules.

* **delete** *(secured)*: Delete the specified NAT rule.

### /4.0/edges/{edgeId}/routing/config
Working With the NSX Edge Routing Configuration
----
You can specify static and dynamic routing for each NSX Edge.

Dynamic routing provides the necessary forwarding information between
layer 2 broadcast domains, thereby allowing you to decrease layer 2
broadcast domains and improve network efficiency and scale. NSX
extends this intelligence to where the workloads reside for doing
East-West routing. This allows more direct virtual machine to virtual
machine communication without the costly or timely need to extend
hops. At the same time, NSX also provides North-South connectivity,
thereby enabling tenants to access public networks.

### Global Routing Configuration

Parameter  |   Description  | Comments  
--- | --- | --- 
**routerId**  | The first uplink IP address of the NSX Edge that pushes routes to the kernel for dynamic routing | Optional. RouterId is set only when configuring the dynamic routing protocols OSPF and BGP.
**ecmp**  | Enables equal-cost multi-path routing (ECMP) | Optional. Boolean. By default, ecmp is set to false.
**logging**  | Logging configuration. | Optional. 
**logging > enable** | Enable/disable status of logging. | Optional. Default is *false*.
**logging > logLevel**  | Sets the log level.  | Default is *info*.  Valid values: *emergency*, *alert*, *critical*, *error*, *warning*, *notice*, *info*, *debug*.
**ipPrefix**  | Details for one IP prefix. |  Optional. Required only if you define redistribution rules in dynamic routing protocols like ospf, bgp.
**ipPrefix > name**  | The name of the IP prefix. | All defined IP prefixes must have unique names.
**ipPrefix > ipAddress**  | IP addresses for the IP prefix. | Optional. String.
**ipPrefix > GE**  | Minimum prefix length to be matched. | Optional. 
**ipPrefix > LE**  | Maximum prefix length to be matched. | Optional. 

### Default Route Configuration

Parameter  |   Description  | Comments  
--- | --- | --- 
**description**  | A description for the default route. |
**type**  | Specifies whether the static route was created by the system as an auto-generated route or the default route (internal); or whether it is a local (user) route. |
**mtu**  | The maximum transmission value for the data packets |Default is 1500. The MTU value cannot be higher than the MTU value set on the NSX Edge interface. By default, mtu is the MTU value of the interface on which the route is configured. 
**vnic**  | Interface on which the default route is added. |
**gatewayAddress**  | Default gateway IP used for routing. |
**adminDistance**  |Admin distance. Used to determine which routing protocol to use if two protocols provide route information for the same destination. | Optional. Default value is *1*.

### Static Route Configuration

Parameter  |   Description  | Comments  
--- | --- | --- 
**vnic**  | Interface on which the route is added. | Valid values: *0-4103*, *vNic_[0-4103]*, *gre-[1-96]*.
**description** | A description for the static route. |
**mtu**  | The maximum transmission value for the data packet. |Default is 1500. By default, mtu is the MTU value of the interface on which the route is configured.
**network**  | The network in CIDR notation. |
**nextHop**  | Next hop IP address. |The router must be able to directly reach the next hop. When ECMP is enabled, multiple next hops can be displayed.
**adminDistance**  | Admin distance. Used to determine which routing protocol to use if two protocols provide route information for the same destination. | Optional. Default value is *1*.
**type**  | Specifies whether the static route was created by the system as an auto-generated route or the default route (internal); or whether it is a local (user) route. |

### OSPF Configuration

Parameter  |   Description  | Comments  
--- | --- | --- 
**enabled**  | OSPF enabled status. |  When not specified, it will be treated as false, When false, it will delete the existing config.
**gracefulRestart**  | For packet forwarding to be uninterrupted during restart of services. | Optional.
**defaultOriginate**  | Allows the Edge Services Gateway to advertise itself as a default gateway to its peers. | Optional.  Default is *false*. Not allowed on a logical distributed router.
**forwardingAddress** | The IP address of one of the uplink interfaces. | Logical (distributed) router only.
**protocolAddress** | An IP address on the same subnet as the forwarding address. | Logical (distributed) router only.
**areaId**  | The area ID. The NSX Edge supports an area ID in the form of a decimal number. Valid values are 0-4294967295. | Required. The value for areaId must be a unique number.
**translateType7ToType5** | Configure whether this NSX Edge should be used for translating Type 7 to Type 5 LSAs for this OSPF area. If not set, the router with highest router ID is used for translating. | Valid values:  *true* or *false*. Optional, default is *false*. Only configurable for OSFP areas of type NSSA.
**type**  | Gives whether the type is *normal* or *nssa*. | Optional.  Default type is normal. NSSAs (the not-so-stubby areas feature described in RFC 3101) prevents the flooding of AS-external link-state advertisements (LSAs). They rely on default routing to external destinations. Therefore, NSSAs are placed at the edge of an OSPF routing domain. NSSA can import external routes into the OSPF routing domain, thereby providing transit service to small routing domains that are not part of the OSPF routing domain.
**authentication > type**  | Authentication type. | Choice of *none*, *password*, or *md5*. If authentication information isn't provided, type is *none*. Type *password*: a password is included in the transmitted packet. Type *md5*: an MD5 checksum is included in the transmitted packet.
**authentication > value**  | The password or MD5 key, respectively |
**vnic**  | The interface that is mapped to OSPF Area | Required. The interface specifies the external network that both NSX Edges are connected to.
**areaId**  | An area ID. Can be in the form of an IP address or decimal number. | Required.
**helloInterval**  | The default interval between hello packets that are sent on the interface | Optional. By default, set to 10 seconds with valid values 1-255.
**deadInterval**  | The default interval during which at least one hello packet must be received from a neighbor before the router declares that neighbor down. | Optional. By default, set to 40 seconds. Valid values are 1-65535.
**priority**  | The default priority of the interface. The interface with the highest priority is the designated router. | Optional. By default, set to 128 with valid values 0-255.
**cost**  | The default overhead required to send packets across that interface | Optional. Integer. The cost of an interface is inversely proportional to the bandwidth of that interface. The larger the bandwidth, the smaller the cost. Valid values are 1-65535.
**mtuIgnore** | Ignore interface MTU setting | *true* or *false*.

### BGP Configuration

Parameter  |   Description  | Comments  
--- | --- | --- 
**enabled**  | BGP routing enable/disable status. | Optional. By default, enabled is set to false.
**gracefulRestart**  | For packet forwarding to be uninterrupted during restart of services. | Optional.
**defaultOriginate**  | Allows the Edge Services Gateway to advertise itself as a default gateway to its peers. | Optional.  Default is *false*. Not allowed on a logical distributed router.
**localAS**  | The 2 byte local Autonomous System number that is assigned to the NSX Edge. The path of autonomous systems that a route traverses is used as one metric when selecting the best path to a destination.| Integer. A value (a globally unique number between 1-65535) for the local AS. This local AS is advertised when the NSX Edge peers with routers in other autonomous systems.  Either **localAS** or **localASNumber** is required. 
**localASNumber**  | The 2 or 4 byte local Autonomous System number that is assigned to the NSX Edge. The path of autonomous systems that a route traverses is used as one metric when selecting the best path to a destination. | Integer. A value (a globally unique number between 1-4294967295) for the Local AS. This local AS is advertised when the NSX Edge peers with routers in other autonomous systems.  Can be in plain or dotted format (e.g. 2 byte: 65001 or 0.65001, 4 byte: 65545 or 1.9). Either **localAS** or **localASNumber** is required. 
**bgpNeighbour > ipAddress**  | The IP address of the on-premises border device. | Required.  String. IPv4 only. IPv6 is not supported. Should not be the same as any of the NSX Edge interfaces's IPs, forwardingAddress, protocolAddress.
**bgpNeighbour > forwardingAddress** | The IP address of one of the uplink interfaces. | Logical (distributed) router only.
**bgpNeighbour > protocolAddress** | An IP address on the same subnet as the forwarding address. | Logical (distributed) router only.
**bgpNeighbour > remoteAS**  | The 2 byte remote Autonomous System number that is assigned to the the border device you are creating the connection for. | Integer. A value (a globally unique number between 1-65535) for the remote AS. Either **remoteAS** or **remoteASNumber** is required. 
**bgpNeighbour > remoteASNumber**  | The 2 or 4 byte remote Autonomous System number that is assigned to the border device you are creating the connection for. | Integer. A value (a globally unique number between 1-4294967295) for the remote AS. Can be in plain or dotted format (e.g. 2 byte: 65001 or 0.65001, 4 byte: 65545 or 1.9). Either **remoteAS** or **remoteASNumber** is required. 
**bgpNeighbour > removePrivateAS** | Determines whether to remove private AS number while redistributing routes. | Boolean. You can set to *true* only when remote and local AS are different.
**bgpNeighbour > weight**  | Weight for the neighbor connection | Optional. Integer. By default, weight is set to 60.
**bgpNeighbour > holdDownTimer**  | Interval for the hold down timer | Optional. Integer. The NSX Edge uses the standard, default values for the keep alive timer (60 seconds) and the hold down timer. The default value for the hold down timer is 3x keepalive or 180 seconds. Once peering between two neighbors is achieved, the NSX Edge  starts a hold down timer. Every keep alive message it receives from the neighbor resets the hold down timer to 0.  When the NSX Edge fails to receive three consecutive keep alive messages, so that the hold down timer reaches 180 seconds, the NSX Edge considers the neighbor down and deletes the routes from this neighbor.
**bgpNeighbour > keepAliveTimer**  | Interval for the keep alive timer. | Optional. Integer. Default is *60*. Valid values are 1-65534.
**bgpNeighbour > password**  | The authentication password. | Optional. String. Each segment sent on the connection between the neighbors is verified. MD5 authentication must be configured with the same password on both BGP neighbors, otherwise, the connection between them will not be made.
**bgpFilter > direction**  | Indicate whether you are filtering traffic to or from the neighbor | Optional. Choice of *in* or *out*.
**bgpFilter > action**  | Permit or deny traffic. | Optional. Choice of *permit* or *deny*.
**bgpFilter > network**  | The network that you want to filter to or from the neighbor. | CIDR format. IPv4 only. IPv6 is not supported.
**bgpFilter > ipPrefixGe**  | The IP prefixes that are to be filtered.  Filter prefixes greater than or equal to this value.  | Optional. Integer. Specify valid IPv4 prefixes.
**bgpFilter > ipPrefixLe**  | The IP prefixes that are to be filtered. Filter prefixes less than or equal to this value. | Optional. Integer. Specify valid IPv4 prefixes. 

**Note:** New parameters **localASNumber** and **remoteASNumber** have
been added in NSX 6.3.0 to allow configuration of 4 byte AS numbers.
The previous parameters, **localAS** and **remoteAS** are still valid.

When you configure BGP, you must provide a local AS number parameter
(**localAS** or **localASNumber**) and a remote AS number parameter
(**remoteAS** or **remoteASNumber**). If you provide both forms of
either local or remote AS number (for example, **localAS** and
**localASNumber**), the values must be the same.

You can use any combination of remote and local AS parameters, as long
as the values are valid. For example, **localAS** of *65501* and
**remoteASNumber** of *70000*.

If you configure a 2 byte number, both forms of the AS number
parameters are returned with a GET request (for example, **localAS**
and **localASNumber**). If you configure a 4 byte number, only the 4
byte parameter is returned (**localASNumber**).  

If both parameters are present (for example **localAS** and
**localASNumber**), and you update one parameter (**localAS**)
subsequent GET requests will show both parameters updated.  

### Multicast Configuration

Parameter  |   Description  | Comments  
--- | --- | --- 
**enabled**  | Multicast routing enable/disable status. | Optional. By default, enabled is set to false.
**igmp > queryInterval**  | Configures the frequency at which the designated router sends IGMP host-query messages | Optional. Default is *30 seconds*. Allowed values: 1-3744 seconds.
**igmp > queryMaxResponseTimee**  | Sets the maximum query response time advertised in IGMP queries | Optional.  Default is *10 seconds*. Allowed values: 1-25 seconds.
**igmp > lastMemberQueryInterval** | Configures the interval at which the router sends IGMP group-specific query messages. | Optional. Default is *1 second*.
**igmp > robustnessVariable**  | Robustness variable tunes the expected number of packet loss on a subnet. This variable is used to calculate the group membership timeout value.| Optional. Default is *2 seconds*. Allowed values: 1-255 seconds  
**pim > static-rendezvous-point-address**  | The IP address of a PIM RP. | Optional.  
**interface index list** | List of index of edge interface where PIM to be enabled. Max size of this list is one as PIM can be enabled on any one of the edge uplink interface.| Edge router only.
**IGMP Interface index list** | List of index of edge and vdr interfaces where IGMP to be enabled. | Optional.

### Route Redistribution Configuration for OSPF or BGP

Parameter  |   Description  | Comments  
--- | --- | --- 
**enabled** | Enabled status of route redistribution for the parent protocol (OSFP or BGP). | Optional. Default is *false*.
**rule**  | Route redistribution rule. |
**id**  | The ID for the rule. | Required. Number.
**prefixName**  | The name for the IP prefix to add for route redistribution | Optional. String. Default is *any*. **prefixName** is set using **routingGlobalConfig > ipPrefixes**. By default, the value of prefixName is set to *any*.
**from > ospf**  | Whether OSPF is a learner protocol (it learns routes from other protocols). | Optional. By default set to false for ospf.
**from > bgp**  | Whether BGP is a learner protocol (it learns routes from other protocols). | Optional. By default set to false for bgp.
**from > static**  | Whether routes can be learned from static networks. | Optional.  By default set to false for static.
**from > connected**  | Whether routes can be learned from connected networks. | Optional. By default set to false for connected.
**action**  | Whether to permit or deny redistribution from the selected types of networks. | Required. Choice of *deny* or *permit*.

* **get** *(secured)*: Retrieve routes.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **isis** configuration section removed. 
6.3.0 | Method updated. Parameter **defaultOriginate** removed for logical router NSX Edges.  <br>Parameter **translateType7ToType5** added to OSPF section. <br>Parameters **localASNumber** and **remoteASNumber** added to BGP section.
6.4.0 | Method updated. Parameters **LE** and **GE** added. Parameter **removePrivateAS** added.

* **put** *(secured)*: Configure NSX Edge global routing configuration, static routing, and
dynamic routing (OSPF and BGP).

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **isis** configuration section removed. 
6.3.0 | Method updated. Parameter **defaultOriginate** removed for logical router NSX Edges.  <br>Parameter **translateType7ToType5** added to OSPF section. <br>Parameters **localASNumber** and **remoteASNumber** added to BGP section.
6.4.0 | Method updated. Parameters **LE** and **GE** added. Parameter **removePrivateAS** added.

* **delete** *(secured)*: Delete the routing config stored in the NSX Manager database and the
default routes from the specified NSX Edge appliance.

### /4.0/edges/{edgeId}/routing/config/global
Working With the NSX Edge Global Configuration
----

* **put** *(secured)*: Configure global route.
* **get** *(secured)*: Retrieve routing info from NSX Manager database (default route
settings, static route configurations).

### /4.0/edges/{edgeId}/routing/config/static
Working With Static and Default Routes
----
Prior to NSX Data Center for vSphere 6.4.4, the maximum number of static routes
is limited to 2048 (2K) for all Edge appliance form factors.
Starting with NSX Data Center for vSphere 6.4.4, the maximum number of static
routes depends on the Edge appliance form factor.
However, for a Distributed Logical Router appliance, the maximum number of static routes
remains unchanged (2048) because the edge form factor is always *Compact*.

The following table shows the maximum number of permitted static routes for various 
Edge appliance form factors.

Edge Form Factor | Maximum Number of Static Routes
---|---
Compact  |2048 (2K)
Large  |2048 (2K)
Quad Large  |10240 (10K)
Xlarge  |10240 (10K)

* **get** *(secured)*: Read static and default routes.
* **put** *(secured)*: Configure static and default routes.
* **delete** *(secured)*: Delete both static and default routing config stored in the NSX
Manager database.

### /4.0/edges/{edgeId}/routing/config/staticroute
Working with Static Routes for a Specific Network
----
Starting with NSX Data Center for vSphere 6.4.4, you can add, update, and 
delete hops of the static routes for a given network.

* **get** *(secured)*: List all the hops for a specifed network.

**Method history:**

Release | Modification
--------|-------------
6.4.4 | Method introduced.

* **put** *(secured)*: Replace all the hops for a specifed network.
At a granular level, you can use this API to add, update, or delete next hops of static routes for a given network.
            
### Request body parameters
Parameter |  Description | Comments
---|---|---
**nextHop > vnic**  |Virtual network interface on which the static route is added. |Required. Integer value. Range is 0 to 9. For subinterfaces, the valid range is 10 to 4094.
**nextHop > localeId** |Locale ID associated with the static route in a cross-vCenter NSX environment.| Optional. Minimum length is 1. Maximum length is 37.
**nextHop > adminDistance** |Admin distance. Determines which route to use when there are multiple routes for a given network. |Integer. Range is 1 to 255. Default value is 1.
**nextHop > ipAddress** |IP address of the next hop in the static route. |Required. Specify a valid IPv4 or IPv6 address.
**nextHop > description**|Description of the hop in the static route.|Optional. String. Description must not exceed 1024 characters.

**Method history:**

Release | Modification
--------|-------------
6.4.4 | Method introduced.

* **delete** *(secured)*: Delete a static route and all its hops for a given network.

**Method history:**

Release | Modification
--------|-------------
6.4.4 | Method introduced.                              

### /4.0/edges/{edgeId}/routing/config/ospf
Working With OSPF Routing for NSX Edge
----
NSX Edge supports OSPF, an interior gateway protocol that routes IP packets
only within a single routing domain. It gathers link state information from
available routers and constructs a topology map of the network.  The topology
determines the routing table presented to the Internet Layer, which makes
routing decisions based on the destination IP address found in IP packets.

OSPF routing policies provide a dynamic process of traffic load balancing
between routes of equal cost. An OSPF network is divided into routing areas to
optimize traffic. An area is a logical collection of OSPF networks, routers,
and links that have the same area identification.

Areas are identified by an Area ID.          

* **get** *(secured)*: Retrieve OSPF configuration.            

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **isis** parameter removed from route redistribution rules configuration. 
6.3.0 | Method updated. Parameter **defaultOriginate** removed for logical router NSX Edges.  <br>Parameter **translateType7ToType5** added to OSPF section.

* **put** *(secured)*: Configure OSPF.            

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **isis** parameter removed from route redistribution rules configuration. 
6.3.0 | Method updated. Parameter **defaultOriginate** removed for logical router NSX Edges.  <br>Parameter **translateType7ToType5** added to OSPF section. 

* **delete** *(secured)*: Delete OSPF routing.

### /4.0/edges/{edgeId}/routing/config/bgp
Working With BGP Routes for NSX Edge
---
Border Gateway Protocol (BGP) makes core routing decisions. It includes a table
of IP networks or prefixes which designate network reachability among
autonomous systems. An underlying connection between two BGP speakers is
established before any routing information is exchanged. Keep alive messages
are sent out by the BGP speakers in order to keep this relationship alive. Once
the connection is established, the BGP speakers exchange routes and synchronize
their tables.

* **get** *(secured)*: Retrieve BGP configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **isis** configuration section removed. 
6.3.0 | Method updated. Parameter **defaultOriginate** removed for logical router NSX Edges.  <br>Parameters **localASNumber** and **remoteASNumber** added to BGP section.
6.4.0 | Method updated. Parameter **removePrivateAS** added.
6.4.4 | Method updated. Query parameter **showSensitiveData** added.

* **put** *(secured)*: Configure BGP.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **isis** configuration section removed. 
6.3.0 | Method updated. Parameter **defaultOriginate** removed for logical router NSX Edges. <br>Parameters **localASNumber** and **remoteASNumber** added to BGP section.
6.4.0 | Method updated. Parameter **removePrivateAS** added.

* **delete** *(secured)*: Delete BGP Routing

### /4.0/edges/{edgeId}/routing/config/multicast
Working With Multicast Routing 
----
NSX Edge supports Multicast routing on Edge Services Gateways and on Distributed Logical Routers. 

* **get** *(secured)*: Retrieve Multicast configuration. A GET example for Edge Services Gateway is shown below. 
```
<multicast>
  <enabled>true</enabled>
  <igmp>
    <globalConfig>
      <queryInterval>30</queryInterval>
      <queryMaxResponseTime>10</queryMaxResponseTime>
      <lastMemberQueryInterval>1</lastMemberQueryInterval>
      <robustnessVariable>2</robustnessVariable>
    </globalConfig>
  </igmp>
  <pim>
    <sparseMode>
      <globalConfig>
        <staticRendezvousPointAddress>198.168.23.2</staticRendezvousPointAddress>
      </globalConfig>
      <interface>
        <index>0</index>
      </interface>
      <interface>
        <index>1</index>
      </interface>
    </sparseMode>
  </pim>
</multicast>
```
A GET example for a Distributed Logical Router is shown below. 
```
multicast>
  <enabled>true<.enabled>
      <replicationMulticastRange>229.0.0.0/24</replicationMulticastRange>
      <igmp>
        <interface>
          <index>0</index>
        </interface>
        <interface>
          <index>10</index>
        </interface>
        <globalConfig>
          <queryInterval>30</queryInterval>
          <queryMaxResponseTime>10</queryMaxResponseTime>
          <lastMemberQueryInterval>10</lastMemberQueryInterval>
          <robustnessVariable>2</robustnessVariable>
        </globalConfig>
      </igmp>
    </multicast>
    ``` 

**Method history:**

Release | Modification
--------|-------------
6.4.2 |  Method introduced

* **put** *(secured)*: Configure Multicast. A PUT example for Edge Services Gateway is shown below. The uplink index interface is index 0, and the internal interface is index 1.
  ```
  <multicast>
    <enabled>true</enabled>
    <igmp>
      <globalConfig>
        <queryInterval>30</queryInterval>
        <queryMaxResponseTime>10</queryMaxResponseTime>
        <lastMemberQueryInterval>10</lastMemberQueryInterval>
        <robustnessVariable>2</robustnessVariable>
      </globalConfig>
    </igmp>
    <pim>
      <sparseMode>
        <interface>
          <index>0</index>
        </interface>
        <interface>
          <index>1</index>
        </interface>
        <globalConfig>
          <staticRendezvousPointAddress>10.1.1.10</staticRendezvousPointAddress>
        </globalConfig>
      </sparseMode>
    </pim>
  </multicast>
  ```
A PUT example for a Distributed Logical Router is shown below. The uplink interface is index 0, and the internal interface is index 10.
```
<multicast>
  <enabled>true<.enabled>
      <replicationMulticastRange>229.0.0.0/24</replicationMulticastRange>
      <igmp>
        <interface>
          <index>0</index>
        </interface>
        <interface>
          <index>10</index>
        </interface>
        <globalConfig>
          <queryInterval>30</queryInterval>
          <queryMaxResponseTime>10</queryMaxResponseTime>
          <lastMemberQueryInterval>10</lastMemberQueryInterval>
          <robustnessVariable>2</robustnessVariable>
        </globalConfig>
      </igmp>
    </multicast>
    ```
**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced. 

* **delete** *(secured)*: Delete Multicast routing.

### /4.0/edges/{edgeId}/tunnels
Working With GRE Tunnels
--------------

You can create GRE tunnels between your NSX Data Center for vSphere
environment and another site. Routing using BGP and static routes is
supported.

You can create up to 32 tunnels.

DHCP service is not supported through the tunnel, but DHCP relay is
supported.

Load balancer VIP on tunnel subnet is not supported. DNS relay through
tunnel is not supported.

**Tunnel Configuration**

Parameter  |   Description  | Comments  
--- | --- | --- 
**tunnelId** | Identifier for tunnel. | System generated. Integer, long.
**name** | Name for tunnel. | String. Max length 255.
**description** | Description for tunnel. | String. Max length 1024.
**type** | Type of tunnel. | *gre* is the only supported option.
**label** | Label of tunnel. | System generated. Format is *type-tunnelId*, for example *gre-1*.
**enabled** | Enabled status of tunnel. | Default is *true*.
**sourceAddress** | IPv4 address for source endpoint of tunnel. | Required. String. Maximum length 255.
**destinationAddress** | FQDN hostname / IPv4 address for remote address | Required. String. Maximum length 255.

**Tunnel Interface Configuration**

Parameter  |   Description  | Comments  
--- | --- | --- 
**mtu** | MTU for tunnel | You must set the MTU to 24 bytes less than the interface MTU. Default is *1476*. Valid values *92-8976*.
**tunnelAddress** | List of IPv4 or IPv6 addresses assigned to tunnel interfaces. | Required. CIDR format. BGP session runs on this IP. The BGP neighbor must be on the same subnet.
**enableKeepAliveAck** | Acknowledge keepAlives sent from the remote tunnel endpoint. | Optional. Default is *false*. Note that the Edge Services Gateway cannot initate keepalives, it can only acknowledge them.

**Tunnel Health Check Configuration**

Parameter  |   Description  | Comments  
--- | --- | --- 
**enabled** | Enabled status for tunnel health checks. | Default: *false*.
**type** | Mechanism to determine tunnel health. | Valid value: *ping*.
**interval** | Time interval in seconds between pings. | Default: *3*. Min: *1*. Max: *10*.
**deadTimeMultiplier** | Number of consecutive response failures before the tunnel status is set to down. | Default: *4*. Min: *0*. Max: *10*.

* **post** *(secured)*: Create a tunnel on this Edge Services Gateway.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **delete** *(secured)*: Delete all configured tunnels on this Edge Services Gateway.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **put** *(secured)*: Update all tunnels on this Edge Services Gateway.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **get** *(secured)*: Retrieve information about all tunnels on this Edge Services Gateway.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /4.0/edges/{edgeId}/tunnels/{tunnelId}
Working With a Specific GRE Tunnel
--------

* **get** *(secured)*: Retrieve information about the specified tunnel.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **put** *(secured)*: Update the specified tunnel.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **delete** *(secured)*: Delete the specified tunnel.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /4.0/edges/{edgeId}/bridging/config
Working With Layer 2 Bridging
----

* **get** *(secured)*: Retrieve bridge configuration. The value of the *enabled* field is always *true* for a Distributed Logical Router.
* **put** *(secured)*: Configure a bridge. Note that the bridging is always enabled for Distributed Logical Router and is unsupported for Edge Services Gateway.  You cannot disable the bridging by setting the *enable* field to *false*. The value for the *enable* field is not honored.
* **delete** *(secured)*: Delete bridges.

### /4.0/edges/{edgeId}/loadbalancer/config
Working With NSX Edge Load Balancer
----

The NSX Edge load balancer enables network traffic to follow multiple
paths to a specific destination. It distributes incoming service
requests evenly among multiple servers in such a way that the load
distribution is transparent to users. Load balancing thus helps in
achieving optimal resource utilization, maximizing throughput,
minimizing response time, and avoiding overload. NSX Edge provides load
balancing up to Layer 7.

You map an external, or public, IP address to a set of internal servers
for load balancing. The load balancer accepts TCP, HTTP, or HTTPS
requests on the external IP address and decides which internal server
to use.  Port 8090 is the default listening port for TCP, port 80 is
the default port for HTTP, and port 443 is the default port for HTTPs.

* **get** *(secured)*: Get load balancer configuration.
* **put** *(secured)*: Configure load balancer.

The input contains five parts: application profile, virtual server,
pool, monitor and application rule.

For the data path to work, you need to add firewall rules to allow
required traffic as per the load balancer configuration.

**General Load Balancer Parameters**

Parameter |  Description | Comments
---|---|---
  **logging**      |Load balancer logging setting.|Optional.
  **enable**     |Whether logging is enabled.|Optional. Options are *True* or *False*. Default is *False*.
  **logLevel**     |Logging level.|Optional. Options are: *EMERGENCY*, *ALERT*, *CRITICAL*, *ERROR*, *WARNING*, *NOTICE*, *INFO*, and *DEBUG*. Default is *INFO*.
  **accelerationEnabled**      |Whether **accelerationEnabled** is enabled.|Optional. Options are *True* or *False*. Default is *False*.
  **enabled**      |Whether load balancer is enabled.|Optional. Options are *True* or *False*. Default is *True*.
  
 **Parameter Table for Monitors**
 
 Parameter |  Description | Comments
 ---|---|---
  **monitor**      |Monitor list.|Optional.
  **monitorId**     |Generated monitor identifier.|Optional. Required if it is used in a pool.
  **name**     |Name of the monitor.|Required.
  **type**     |Monitor type.|Required. Options are : *HTTP*, *HTTPS*, *TCP*, *ICMP*, *UDP*.
  **interval**     |Interval in seconds in which a server is to be tested.|Optional. Default is *5*.
  **timeout**     |Timeout value is the maximum time in seconds within which a response from the server must be received.|Optional. Default is *15*.
  **maxRetries**     |Maximum number of times the server is tested  before it is declared DOWN.|Optional. Default is *3*.
  **method**     |Method to send the health check request to the server.|Optional. Options are: *OPTIONS*, *GET*, *HEAD*, *POST*, *PUT*, *DELETE*, *TRACE*, *CONNECT*. Default is *GET* for HTTP monitor.
  **url**     |URL to *GET* or *POST*.|Optional. Default is *"/"* for HTTP monitor.
  **expected**     |Expected string.|Optional. Default is "HTTP/1" for HTTP/HTTPS protocol.
  **send**     |String to be sent to the backend server after a connection is established.|Optional. URL encoded HTTP POST data for HTTP/HTTPS protocol.
  **receive**     |String to be received from the backend server for HTTP/HTTPS protocol.|Optional.
  **extension**     |Advanced monitor configuration.|Optional.
  
**Parameter Table for Virtual Servers**

 Parameter |  Description | Comments
 ---|---|---
  **virtualServer**      |Virtual server list.|Optional. 0-64 **virtualServer** items can be added
  **name**     |Name of the virtual server.|Required. Unique virtualServer name per NSX Edge.
  **description**     |Description of the virtual server.|Optional.
  **enabled**     |Whether the virtual server is enabled.|Optional. Boolean. Options are *True* or *False*. Default is *True*.
  **ipAddress**     |IP address that the load balancer  is listening on. |Required. A valid Edge vNic IP address (IPv4 or IPv6).
  **protocol**     |Virtual server protocol.|Required. Options are: *HTTP*, *HTTPS*, *TCP*, *UDP*.
  **port**    |Port number or port range.|Required. Port number such as *80*, port range such as *80,443* or *1234-1238*, or a combination such as *443,6000-7000*. Valid range: 1-65535.
  **connectionLimit**     |Maximum concurrent connections.|Optional. Long. Default is *0*.
  **connectionRateLimit**     |Maximum incoming new connection requests per second.|Optional. Long. Default is *null*.
  **defaultPoolId**     |Default pool ID.|Optional.
  **applicationProfileId**     |Application profile ID.|Optional. 
  **accelerationEnabled**     |Use the faster L4 load balancer  engine rather than L7 load  balancer engine.|Optional. Boolean. Options are *True* or *False*. Default is *False*. If a virtual server configuration such as application rules, HTTP type, or cookie persistence, is using the L7 load balancer engine, then the L7 load balancer engine is used, even if **accelerationEnabled** is not set to true.
  **applicationRuleId**     |Application rule ID list.|Optional.

**Parameter Table for Pools**

 Parameter |  Description | Comments
 ---|---|---
  **pool**      |Pool list.|Optional.
  **poolId**     |Generated pool identifier.|Optional. Required if you specify pool object.
  **name**     |Name of the pool.|Required.
  **description**     |Description of the pool.|Optional.
  **algorithm**     |Pool member balancing algorithm.|Optional. Options are: *round-robin*, *ip-hash*, *uri*, *leastconn*, *url*, *httpheader*. Default is *round-robin*.
  **algorithmParameters**     |Algorithm parameters for *httpheader*, *url*. |Optional. Required for *url*,*httpheader* algorithm.
  **transparent**     |Whether client IP addresses are  visible to the backend servers.|Optional. Options are *True* or *False*. Default is *False*.
  **monitorId**     |Monitor identifier list.|Optional. Only one monitor is supported.
  **member**     |Pool member list.|Optional.
  **memberId**    |Generated member identifier.|Optional. Required if you specify member object.
  **name**    |Member name.|Optional. Required when it is used in ACL rule.
  **ipAddress**    |Member IP address (IPv4/IPv6).|Optional. Required if **groupingObjectId** is null.
  **groupingObjectId**    |Member grouping object identifier.|Optional. Required if **ipAddress** is null.
  **groupingObjectName**    |Member grouping object name.|Optional.
  **weight**    |Member weight.|Optional. Default is *1*.
  **monitorPort**    |Monitor port.|Optional. Long. Either  **monitorPort** or **port** must be configured.
  **port**    |Member port.|Optional. Long. Either  **monitorPort** or **port** must be configured.
  **maxConn**    |Maximum number of concurrent connections a member can handle.|Optional. Default is *0* which means unlimited.
  **minConn**    |Minimum number of concurrent connections a member can handle.|Optional. Default is *0* which means unlimited.
  **condition**    |Whether the member is enabled or disabled.|Optional. Options are: *enabled* or *disabled*. Default is *enabled*.

**Parameter Table for Application Profiles**

Parameter |  Description | Comments
---|---|---
  **applicationProfile**      |Application profile list.|Optional.
  **applicationProfileId**     |Generated application profile identifier.|Optional. Required if it is used in virtual server.
  **name**     |Name of application profile.|Required.
  **persistence**     |Persistence setting.|Optional.
  **method**    |Persistent method.|Required. Options are: *cookie*, *ssl_sessionid*, *sourceip*, *msrdp*.
  **cookieName**    |Cookie name.|Optional.
  **cookieMode**    |Cookie mode.|Optional. Options are: *insert*, *prefix*, *app*.
  **expire**    |Expire time.|Optional.
  **insertXForwardedFor**     |Whether **insertXForwardedFor** is enabled.|Optional. Boolean. Options are *True* or *False*. Default is *False*.
  **sslPassthrough**     |Whether **sslPassthrough** is enabled.|Optional. Boolean. Options are *True* or *False*. Default is *False*.
  **httpRedirect**     |HTTP redirect setting.|Optional.
  **to**    |HTTP redirect to.|Required. Required if **httpRedirect** is specified.
  **serverSslEnabled**     |Whether **serverSsl** offloading is enabled.|Optional. Boolean. Options are *True* or *False*.
  **serverSsl**     |Server SSL setting.|Optional.
  **ciphers**    |Cipher suites.|Optional. Options are: *DEFAULT* *ECDHE-RSA-AES128-GCM-SHA256*, *ECDHE-RSA-AES256-GCM-SHA384*, *ECDHE-RSA-AES256-SHA*, *ECDHE-ECDSA-AES256-SHA*, *ECDH-ECDSA-AES256-SHA*, *ECDH-RSA-AES256-SHA*, *AES256-SHA AES128-SHA*, *DES-CBC3-SHA*. Default is *DEFAULT*.
  **serviceCertificate**    |Service certificate identifier list.|Optional. Only one certificate is supported.
  **caCertificate**    |CA identifier list.|Optional. Required if **serverAuth** is required.
  **crlCertificate**    |CRL identifier list.|Optional.
  **serverAuth**    |Whether peer certificate should be verified.|Optional. Options are *Required* or *Ignore*. Default is *Ignore*.
  **clientSsl**     |Client SSL setting.|Optional.
  **ciphers**    |Cipher suites.|Optional. Options are: *DEFAULT* *ECDHE-RSA-AES128-GCM-SHA256*, *ECDHE-RSA-AES256-GCM-SHA384*, *ECDHE-RSA-AES256-SHA*, *ECDHE-ECDSA-AES256-SHA*, *ECDH-ECDSA-AES256-SHA*, *ECDH-RSA-AES256-SHA*, *AES256-SHA AES128-SHA*, *DES-CBC3-SHA*. Default is *DEFAULT*.
  **serviceCertificate**    |Service certificate identifier list.|Required. Only one certificate is supported.
  **caCertificate**    |CA identifier list.|Optional.
  **crlCertificate**    |CRL identifier list.|Optional.
  **clientAuth**    |Whether peer certificate should be verified.|Optional. Options are *Required* or *Ignore*. Default is *Ignore*.
  
**Parameter Table for Application Rules**

Parameter |  Description | Comments
---|---|---
  **applicationRule**      |Application rule list.|Optional. 
  **applicationRuleId**     |Generated application rule identifier.|Optional. 
  **name**     |Name of application rule.|Required.
  **script**     |Application rule script.|Required.
  
For the data path to work, you need to add firewall rules to allow required
traffic as per the load balancer configuration. 

* **delete** *(secured)*: Delete load balancer configuration.

### /4.0/edges/{edgeId}/loadbalancer/config/applicationprofiles
Working With Application Profiles
----
You create an application profile to define the behavior of a
particular type of network traffic. After configuring a profile, you
associate the profile with a virtual server. The virtual server then
processes traffic according to the values specified in the profile.
Using profiles enhances your control over managing network traffic,
and makes traffic-management tasks easier and more efficient.

See *Working With NSX Edge Load Balancer* for **applicationProfiles** parameter information.

* **post** *(secured)*: Add an application profile.
* **get** *(secured)*: Retrieve all application profiles on the specified Edge.
* **delete** *(secured)*: Delete all application profiles on the specified Edge.

### /4.0/edges/{edgeId}/loadbalancer/config/applicationprofiles/{appProfileID}
Working With a Specific Application Profile
----

* **put** *(secured)*: Modify an application profile.
* **get** *(secured)*: Retrieve an application profile.
* **delete** *(secured)*: Delete an application profile.

### /4.0/edges/{edgeId}/loadbalancer/config/applicationrules
Working With Application Rules
----
You can write an application rule to directly manipulate and manage
IP application traffic.

See *Working With NSX Edge Load Balancer* for **applicationRule** parameter information.

* **post** *(secured)*: Add an application rule.
* **get** *(secured)*: Retrieve all application rules.
* **delete** *(secured)*: Delete all application rules.

### /4.0/edges/{edgeId}/loadbalancer/config/applicationrules/{appruleID}
Working With a Specific Application Rule
----

* **get** *(secured)*: Retrieve an application rule.
* **put** *(secured)*: Modify an application rule.
* **delete** *(secured)*: Delete an application rule.

### /4.0/edges/{edgeId}/loadbalancer/config/monitors
Working With Load Balancer Monitors
----
You create a service monitor to define health check parameters for a
particular type of network traffic. When you associate a service
monitor with a pool, the pool members are monitored according to the
service monitor parameters.

See *Working With NSX Edge Load Balancer* for **monitor** parameter information.

* **post** *(secured)*: Add a load balancer monitor.
* **get** *(secured)*: Retrieve all load balancer monitors.
* **delete** *(secured)*: Delete all load balancer monitors.

### /4.0/edges/{edgeId}/loadbalancer/config/monitors/{monitorID}
Working With a Specific Load Balancer Monitor
----

* **get** *(secured)*: Retrieve a load balancer monitor.
* **put** *(secured)*: Modify a load balancer monitor.
* **delete** *(secured)*: Delete a load balancer monitor.

### /4.0/edges/{edgeId}/loadbalancer/config/virtualservers
Working With Virtual Servers
----

* **post** *(secured)*: Add a virtual server.

You can add an NSX Edge internal or uplink interface as a virtual
server.

See *Working With NSX Edge Load Balancer* for **virtualServer** parameter information.

* **get** *(secured)*: Retrieve all virtual servers.
* **delete** *(secured)*: Delete all virtual servers.

### /4.0/edges/{edgeId}/loadbalancer/config/virtualservers/{virtualserverID}
Working With a Specific Virtual Server
----

* **get** *(secured)*: Retrieve details for the specified virtual server.
* **delete** *(secured)*: Delete the specified virtual server.

### /4.0/edges/{edgeId}/loadbalancer/config/pools
Working With Server Pools
----
You can add a server pool to manage and share backend servers
flexibly and efficiently. A pool manages load balancer distribution
methods and has a service monitor attached to it for health check
parameters.

See *Working With NSX Edge Load Balancer* for **pools** parameter information.

* **post** *(secured)*: Add a load balancer server pool to the Edge.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method updated. Member **condition** can be set to *drain*.

* **get** *(secured)*: Get all server pools on the specified NSX Edge.
* **delete** *(secured)*: Delete all server pools configured on the specified NSX Edge.

### /4.0/edges/{edgeId}/loadbalancer/config/pools/{poolID}
Working With a Specific Server Pool
----

* **get** *(secured)*: Retrieve information about the specified server pool.
* **put** *(secured)*: Update the specified server pool.

**Method history:**

Release | Modification
--------|-------------
6.3.0 | Method updated. Member **condition** can be set to *drain*.

* **delete** *(secured)*: Delete the specified server pool.

### /4.0/edges/{edgeId}/loadbalancer/config/members/{memberID}
Working With a Specific Load Balancer Member
----

* **post** *(secured)*: Update enabled status of the specified member.

### /4.0/edges/{edgeId}/loadbalancer/statistics
Working With Load Balancer Statistics
----
Retrieves load balancer statistics.
  
**Load Balancer Statistics Parameters**

Parameter |  Description
---|---
**virtualServer**      |Virtual server list.
**virtualServerId**     |Virtual server identifier.
**name**     |Name of the virtual server.
**description**     |Description of virtual server.
**ipAddress**     |IP address that the load balancer is listening on.
**status**     |Virtual server status.
**bytesIn**     |Number of bytes in.
**bytesOut**     |Number of bytes out.
**curSessions**     |Number of current sessions.
**httpReqTotal**     |Total number of HTTP requests received.
**httpReqRate**     |HTTP requests per second over last elapsed second.
**httpReqRateMax**     |Maximum number of HTTP requests per second observed.
**maxSession**     |Number of maximum sessions.
**rate**     |Number of sessions per second over last elapsed second.
**rateLimit**     |Configured limit on new sessions per second.
**rateMax**     |Maximum number of new sessions per second.
**totalSession**     |Total number of sessions.
**pool**      |Pool list.
**poolId**     |Generated pool identifier.
**name**     |Name of the pool.
**description**     |Description of the pool.
**status**     |Pool status.
**bytesIn**     |Number of bytes in.
**bytesOut**     |Number of bytes out.
**curSessions**     |Number of current sessions.
**httpReqTotal**     |Total number of HTTP requests received.
**httpReqRate**     |HTTP requests per second over last elapsed second.
**httpReqRateMax**     |Maximum number of HTTP requests per second observed.
**maxSession**     |Number of maximum sessions.
**rate**     |Number of sessions per second over last elapsed second.
**rateLimit**     |Configured limit on new sessions per second.
**rateMax**     |Maximum number of new sessions per second.
**totalSession**     |Total number of sessions.
**member**     |Pool member list.
**memberId**    |Generated member identifier.
**name**    |Member name.
**ipAddress**    |Member IP address.
**groupingObjectId**    |Member grouping object identifier.
**status**    |Member status.
**bytesIn**    |Number of bytes in.
**bytesOut**    |Number of bytes out.
**curSessions**    |Number of current sessions.
**httpReqTotal**    |Total number of HTTP requests received.
**httpReqRate**    |HTTP requests per second over last elapsed second.
**httpReqRateMax**    |Maximum number of HTTP requests per second observed.
**maxSession**    |Number of maximum sessions.
**rate**    |Number of sessions per second over last elapsed second.
**rateLimit**    |Configured limit on new sessions per second.
**rateMax**    |Maximum number of new sessions per second.
**totalSession**    |Total number of sessions.
**timestamp**      |Timestamp to fetch load balancer statistics.
**serverStatus**      |Load balancer server status.

* **get** *(secured)*: Retrieve load balancer statistics.

### /4.0/edges/{edgeId}/loadbalancer/acceleration
Working With Load Balancer Acceleration
----

* **post** *(secured)*: Configure load balancer acceleration mode.

### /4.0/edges/{edgeId}/dns/config
Working With NSX Edge DNS Server Configuration
----
You can configure external DNS servers to which NSX Edge can relay
name resolution requests from clients. NSX Edge will relay client
application requests to the DNS servers to fully resolve a network
name and cache the response from the servers.

The DNS server list allows two addresses – primary and secondary. The
default cache size is 16 MB where the minimum can be 1 MB, and the
maximum 8196 MB. The default listeners is any, which means listen on all
NSX Edge interfaces. If provided, the listener’s IP address must be
assigned to an internal interface. Logging is disabled by default.

* **get** *(secured)*: Retrieve DNS configuration.
* **put** *(secured)*: Configure DNS servers.
* **delete** *(secured)*: Delete DNS configuration

### /4.0/edges/{edgeId}/dns/statistics
Get DNS server statistics

* **get** *(secured)*: Get DNS server statistics
----

**DNS Server Statistics Parameters**

Parameter Name | Parameter Information
------|-----
**requests > total** | Indicates all of the incoming requests to the DNS server, including DNS query and other types of requests such as transfers, and updates. 
**requests > queries** | Indicates all of the DNS queries the server received.
**requests > total** | Indicates all of the responses the server returned to requests. This might be different from the requests.total because some requests might be rejected. total = success + nxrrset + servFail + formErr + nxdomain + others.
**responses > success** | Indicates all of the successful DNS responses.
**responses > nxrrset** | Indicates the count of no existent resource record. 
**responses > servFail** | Indicates the count of the SERVFAIL responses.
**responses > formErr** | Indicates the count of the format error responses.
**responses > nxdomain** | Indicates the count of no-such-domain answer
**responses > others** | Indicates the count of other types of responses.

### /4.0/edges/{edgeId}/dhcp/config
Configure DHCP for NSX Edge
----
NSX Edge provides DHCP service to bind assigned IP addresses to MAC
addresses, helping to prevent MAC spoofing attacks. All virtual
machines protected by a NSX Edge can obtain IP addresses dynamically
from the NSX Edge DHCP service.

NSX Edge supports IP address pooling and one-to-one static IP address
allocation based on the vCenter managed object ID (vmId) and interface
ID (interfaceId) of the requesting client.

If either bindings or pools are not included in the PUT call, existing
bindings or pools are deleted.

If the NSX Edge autoConfiguration flag and autoConfigureDNS is true, and the
primaryNameServer or secondaryNameServer parameters are not specified, NSX
Manager applies the DNS settings to the DHCP configuration.

NSX Edge DHCP service adheres to the following rules:
* Listens on the NSX Edge internal interface (non-uplink interface)
for DHCP discovery.
* As stated above, vmId specifies the vc-moref-id of the virtual
machine, and vnicId specifies the index of the
vNic for the requesting client. The hostname is an identification of
the binding being created. This hostName is not pushed as the
specified host name of the virtual machine.
* By default, all clients use the IP address of the internal interface
of the NSX Edge as the default gateway address. To override it,
specify **defaultGateway** per binding or per pool. The client’s broadcast
and subnetMask values are from the internal interface for the
container network.
* **leaseTime** can be infinite, or a number of seconds. If not specified,
the default lease time is 1 day.
* Logging is disabled by default.
* Setting the parameter **enable** to *true* starts the DHCP service
while setting **enable** to *false* stops the service.  
* Both **staticBinding** and **ipPools** must be part of the PUT request body.
If either bindings or pools are not included in the PUT call, existing
bindings or pools are deleted.

**DHCP Configuration Parameters**

Parameter Name | Parameter Information 
------|-----
**enabled** | Default is true.
**staticBinding** | Assign an IP address via DHCP statically rather than dynamically. You can either specify **macAddress** directly, or specify **vmId** and **vnicId**. In case both are specified, only **macAddress** will be used; **vmId** and **vnicId** will be ignored.
**staticBinding > macAddress** | Optional.
**staticBinding > vmId** | Optional. The VM must be connected to the specified **vnicId**.
**staticBinding > vnicId** | Optional. Possible values 0 to 9.
**staticBinding > hostname** | Optional. Disallow duplicate.
**staticBinding > ipAddress** | The IP can either belong to a a subnet of one of Edge's vNics or it can be any valid IP address, but the IP must not overlap with any primary/secondary IP addresses associated with any of Edge's vNICs. If the IP does not belong to any Edge vNic subnets, you must ensure that the default gateway and subnetMask are configured via this API call.
**ipPool > ipRange** |  Required. The IP range can either fall entirely within one of the Edge vNIC subnets, or it can be a valid IP range outside any Edge subnets. The IP range, however, cannot contain an IP that is defined as a vNic primary secondary IP. If the range does not fall entirely within one of the Edge vNIC subnets, you must provide correct **subnetMask** and **defaultGateway**.
**defaultGateway**<br>(staticBinding and ipPool) | Optional. If the ipRange (for ipPool) or assigned IP (for staticBinding) falls entirely within one of the Edge vNIC subnets, **defaultGateway** is set to the primary IP of the vNIC configured with the matching subnet.  Otherwise, you must provide the correct gateway IP. If an IP is not provided, the client host may not get default gateway IP from the DHCP server.
**subnetMask**<br>(staticBinding and ipPool) | Optional. If not specified, and the the ipRange (for ipPool) or assigned IP (for staticBinding) belongs to an Edge vNic subnet, it is defaulted to the subnet mask of this vNic subnet. Otherwise, it is defaulted to a minimum subnet mask which is figured out with the IP range itself, e.g. the mask of range 192.168.5.2-192.168.5.20 is 255.255.255.224. You can edit this range, if required. <br>**Note:** If you do not specify a subnet mask when configuring DHCP, **subnetMask** is not included in the output of `GET /api/4.0/edges/{edgeId}/dhcp/config` or `GET /api/4.0/edges/{edgeId}/dhcp/config/bindings/{bindingID}`. You can run `show configuration dhcp` on the Edge VM CLI to view the subnet mask.
**domainName** <br>(staticBinding and ipPool) | Optional.
**primaryNameServer**<br>**secondaryNameServer**<br>(staticBinding and ipPool)|  Optional. If **autoConfigureDNS** is *true*, the DNS primary/secondary IPs will be generated from DNS service (if configured).
**leaseTime**<br>(staticBinding and ipPool) | Optional. In seconds, default is *86400*. Valid **leaseTime** is a valid number or *infinite*. 
**autoConfigureDns**<br>(staticBinding and ipPool) |  Optional. Default is *true*. 
**nextServer**<br>(staticBinding and ipPool) | Global TFTP server setting. If an IP pool or static binding has a TFTP server configured via **option66** or **option150**, that server will be used instead.
**dhcpOptions** <br>(staticBinding and ipPool) | Optional.
**dhcpOptions > option121**<br>(staticBinding and ipPool) | Add a static route.
**dhcpOptions > option121 > destinationSubnet**<br>(staticBinding and ipPool) | Destination network, for example 1.1.1.4/30.
**dhcpOptions > option121 > router**<br>(staticBinding and ipPool) | Router IP address.
**dhcpOptions > option66**<br>(staticBinding and ipPool) | Hostname or IP address of a single TFTP server for this IP pool.
**dhcpOptions > option67**<br>(staticBinding and ipPool) | Filename to be downloaded from TFTP server.
**dhcpOptions > option150**<br>(staticBinding and ipPool) | IP address of TFTP server.
**dhcpOptions > option150 > server**<br>(staticBinding and ipPool) | Use to specify more than one TFTP server by IP address for this IP Pool.
**dhcpOptions > option26**<br>(staticBinding and ipPool) | MTU.
**dhcpOptions > other**<br>(staticBinding and ipPool) | Add DHCP options other than 26, 66, 67, 121, 150.
**dhcpOptions > other > code**<br>(staticBinding and ipPool) | Use the DHCP option number only. For example, to specify dhcp option 80, enter *80*.
**dhcpOptions > other > value**<br>(staticBinding and ipPool) | The DHCP option value, in hex. For example, *2F766172*.
**logging** | Optional. Logging is disabled by default.
**logging > enable** |  Optional, default is *false*.
**logging > logLevel** | Optional, default is *info*.

* **get** *(secured)*: Retrieve DHCP configuration.

**Method History**

Release | Modification
--------|-------------
6.2.3 | Method updated. DHCP options added.

* **put** *(secured)*: Configure DHCP service.

**Method History**

Release | Modification
--------|-------------
6.2.3 | Method updated. DHCP options added.

* **delete** *(secured)*: Delete the DHCP configuration, restoring it to factory default.

### /4.0/edges/{edgeId}/dhcp/config/ippools
Working With DHCP IP Pools
-----

* **post** *(secured)*: Add an IP pool to the DHCP configuration. Returns a pool ID within
a Location HTTP header.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. DHCP options added.

### /4.0/edges/{edgeId}/dhcp/config/ippools/{poolID}
Working With a Specific DHCP IP Pool
----

* **delete** *(secured)*: Delete a pool specified by pool ID

### /4.0/edges/{edgeId}/dhcp/config/bindings
Working With DHCP Static Bindings
----

* **post** *(secured)*: Append a static-binding to DHCP config. A static-binding ID is
returned within a Location HTTP header.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. DHCP options added.

* **get** *(secured)*: Retrieve the multiple DHCP bindings with IP and MAC address.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.   

### /4.0/edges/{edgeId}/dhcp/config/bindings/{bindingID}
Working With a Specific DHCP Static Binding
----

* **get** *(secured)*: Retrieve the specified static binding.

**Method history:**

Release | Modification
--------|-------------
6.3.3 | Method introduced.   

* **delete** *(secured)*: Delete the specified static binding.

### /4.0/edges/{edgeId}/dhcp/config/relay
Working With DHCP Relays
----
Dynamic Host Configuration Protocol (DHCP) relay enables you to leverage your
existing DHCP infrastructure from within NSX without any interruption to the
IP address management in your environment. DHCP messages are relayed from
virtual machine(s) to the designated DHCP server(s) in the physical world.
This enables IP addresses within NSX to continue to be in synch with IP
addresses in other environments. 

DHCP configuration is applied on the logical
router port and can list several DHCP servers. Requests are sent to all listed
servers. While relaying the DHCP request from the client, the relay adds a
Gateway IP Address to the request. The external DHCP server uses this gateway
address to match a pool and allocate an IP address for the request. The
gateway address must belong to a subnet of the NSX port on which the relay is
running. 

You can specify a different DHCP server for each logical switch and
can configure multiple DHCP servers on each logical router to provide support
for multiple IP domains. 

NOTE DHCP relay does not support overlapping IP address space (option 82). 

DHCP Relay and DHCP service cannot run on a
port/vNic at the same time. If a relay agent is configured on a port, a DHCP
pool cannot be configured on the subnet(s) of this port.  

Parameter | Comments
---|---
**relay**   |You can configure ipPool, static-binding and relay at the same time if there is not any overlap on vnic.
**relayServer**   |Required. There must be at least one external server.
**groupingObjectId**   |A list of dhcp server IP addresses. There can be multiple sever group objects, the maximum groupObject is 4, the maximum number of server IP addresses is 16. 
**ipAddress**   |Supports both IP address and FQDN.
**fqdn**   |Specify the IP of the fqdn, and add a Firewall rule to allow the response from the server represented by the fqdn such as: src - the IP; dest - any; service - udp:67:any.
**relayAgents**   |Required. There must be at least one relay agent.
**vnicIndex**   | Required. No default. Specify the vNic that proxy the dhcp request. 
**giAddress** | Optional. Defaults to the vNic primary address. Only one giAddress allowed. 

* **get** *(secured)*: Retrieve DHCP relay information.
* **put** *(secured)*: Configure DHCP relay.
* **delete** *(secured)*: Delete DHCP relay configuration.

### /4.0/edges/{edgeId}/dhcp/leaseInfo
Working With DHCP Leases
----

* **get** *(secured)*: Get DHCP lease information.

### /4.0/edges/{edgeId}/highavailability/config
Working With NSX Edge High Availability
----
High Availability (HA) ensures that a NSX Edge appliance is always
available on your virtualized network. You can enable HA either when
installing NSX Edge or on an installed NSX Edge instance.

If a single appliance is associated with NSX Edge, the appliance configuration
is cloned for the standby appliance. If two appliances are associated with NSX
Edge and one of them is deployed, this REST call deploys the remaining appliance
and push HA configuration to both. 

HA relies on an internal interface. If an
internal interface does not exist, this call will not deploy the secondary
appliance, or push HA config to appliance. The enabling of HA will be done once
an available internal interface is added. If the PUT call includes an empty 
&lt;highAvailability /&gt; or enabled=false, it acts as a DELETE call.

* **get** *(secured)*: Get high availability configuration.
* **put** *(secured)*: Configure high availability.

* **ipAddress** - Optional. A pair of ipAddresses with /30 subnet
  mandatory, one for each appliance. If provided, they must NOT
  overlap with any subnet defined on the Edge vNics. If not specified,
  a pair of IPs will be picked up from the reserved subnet,
  169.254.0.0/16.
* **declareDeadTime** Optional. The default is 6 seconds. 
* **enabled** - Optional. The default is set to true. The enabled flag
  will cause the HA appliance to be deployed or destroyed.

* **delete** *(secured)*: NSX Manager deletes the standby appliance and removes the HA config
from the active appliance. You can also delete the HA configuration by
using a PUT call with empty &lt;highAvailability /&gt; or with
&lt;highAvailability&gt;&lt;enabled&gt;false&lt;/enabled&gt;&lt;/highAvailability&gt;.

### /4.0/edges/{edgeId}/syslog/config
Working With Remote Syslog Server on NSX Edge
-----
You can configure one or two remote syslog servers. Edge events and logs
related to firewall events that flow from Edge appliances are sent to
the syslog servers

* **get** *(secured)*: Retrieve syslog servers information.

* **put** *(secured)*: Configure syslog servers.

* **delete** *(secured)*: Delete syslog servers.

### /4.0/edges/{edgeId}/sslvpn/config
Working With SSL VPN
----
With SSL VPN-Plus, remote users can connect securely to private
networks behind a NSX Edge gateway. Remote users can access servers and
applications in the private networks.

* **post** *(secured)*: Enable or disable SSL VPN on the NSX Edge appliance.

* **get** *(secured)*: Retrieve SSL VPN details.
* **put** *(secured)*: Update the entire SSL VPN configuration to the specified NSX Edge in a single call.

* **delete** *(secured)*: Delete the SSL VPN configurations on the Edge.

### /4.0/edges/{edgeId}/sslvpn/config/server
Working With SSL VPN Server
----

* **get** *(secured)*: Retrieve server settings.
* **put** *(secured)*: Update server settings.

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/privatenetworks
Working With Private Networks
---
You can use a private network to expose to remote users over SSL VPN
tunnel.

* **post** *(secured)*: Configure a private network.
* **get** *(secured)*: Retrieve all private network profiles in the SSL VPN instance.

* **put** *(secured)*: Update all private network configs of NSX Edge with the given list
of private network configs. If the config is present, it is
updated; otherwise, a new private network config is created.
Existing configs not included in the call body are deleted.

* **delete** *(secured)*: Delete all private networks from the SSL VPN instance.

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/privatenetworks/{networkID}
Working With a Specific Private Network
----

* **get** *(secured)*: Retrieve the specified private network in the SSL VPN service.

* **put** *(secured)*: Update the specified private network in the SSL VPN service.

* **delete** *(secured)*: Delete private network

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/ippools
Working With IP Pools for SSL VPN
----

* **post** *(secured)*: Create an IP pool.
* **get** *(secured)*: Retrieve all IP pools configured on SSL VPN.
* **put** *(secured)*: Update all IP pools with the given list of pools. If the pool is
present, it is updated; otherwise, a new pool is created. Existing
pools not in the body are deleted.

* **delete** *(secured)*: Delete all IP pools configured on SSL VPN

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/ippools/{ippoolID}
Working With a Specific IP Pool for SSL VPN
----

* **get** *(secured)*: Retrieve details of specified IP pool.
* **put** *(secured)*: Update specified IP pool.
* **delete** *(secured)*: Delete the specified IP pool.

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/clientconfig
Working With Network Extension Client Parameters 
-----

* **put** *(secured)*: Set advanced parameters for full access client configurations,
such as whether client should auto-reconnect in case of network
failures or network unavailability, or whether the client should be
uninstalled after logout.

* **get** *(secured)*: Retrieve client configuration.

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/installpackages
Working With SSL VPN Client Installation Packages
---

* **post** *(secured)*: Creates setup executables (installers) for full access network
clients. These setup binaries are later downloaded by remote
clients and installed on their systems. The primary parameters
needed to configure this setup are hostname of the gateway, and
its port and a profile name which is shown to the user to identify
this connection. The Administrator can also set other parameters
such as whether to automatically start the application on windows
login, or hide the system tray icon.

* **get** *(secured)*: Retrieve information about all installation packages.
* **put** *(secured)*: Update all installation packages with the given list. If the
package is present, it is updated; otherwise a new installation
package is created. Existing packages not included in the body are
deleted.

* **delete** *(secured)*: Delete all client installation packages.

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/installpackages/{packageID}
Working With a Specific SSL VPN Client Installation Package
---

* **get** *(secured)*: Get information about the specified installation package.

* **put** *(secured)*: Modify the specified installation package.
* **delete** *(secured)*: Delete the specified installation package.

### /4.0/edges/{edgeId}/sslvpn/config/layout
Working With Portal Layout
---

* **get** *(secured)*: Retrieve layout configuration.
* **put** *(secured)*: Update the portal layout.

### /4.0/edges/{edgeId}/sslvpn/config/layout/images/{imageType}
Working With Image Files for SSL VPN
---

* **post** *(secured)*: Upload images for use with SSL VPN portal and client.

You can upload a logo to use in the SSL VPN portal, and a banner
and icons to use in the SSL VPN client.

You must upload the image files using the form-data content-type.
Consult the documentation for your REST client for instructions. 

Do not set other Content-type headers in your request, for
example, *Content-type: application/xml*.

When you upload a file as form-data, you must provide a **key**
and a **value** for the file. See the table below for the
form-data **key** to use for each image type. The **value** is the
path to the image file.

Image Type | form-data key | Image format requirements
----|------|----
portallogo | layoutFile | n/a
phatbanner | banner | bmp
connecticon | icon | ico
disconnecticon | icon | ico
erroricon | icon | ico
desktopicon | icon | ico

**Example using curl**

```
/usr/bin/curl -v -k -i -F layoutFile=@/tmp/portalLogo.jpg -H 'Authorization: Basic YWRtaW46ZGXXXXXXXX==' 
https://192.168.110.42/api/4.0/edges/edge-3/sslvpn/config/layout/images/portallogo
```

### /4.0/edges/{edgeId}/sslvpn/config/auth/localserver/users
Working With Portal Users
----

* **post** *(secured)*: Add a new portal user.
* **put** *(secured)*: Modify the portal user specified in the request body.
* **delete** *(secured)*: Delete all users on the specifed SSL VPN instance

### /4.0/edges/{edgeId}/sslvpn/config/auth/localserver/users/{userID}
Working With a Specific Portal User
----

* **get** *(secured)*: Get information about the specified user.
* **delete** *(secured)*: Delete the specified user.

### /4.0/edges/{edgeId}/sslvpn/config/auth/settings
Working With Authentication Settings
--

* **get** *(secured)*: Retrieve information about authentication settings.
* **put** *(secured)*: Update authentication settings for remote users. Specify
username/password authentication, active directory, ldap, radius,
client certificate based authentication.

### /4.0/edges/{edgeId}/sslvpn/config/auth/settings/rsaconfigfile
Working With the RSA Config File 
----

* **post** *(secured)*: Upload RSA config file (See "Generate the Authentication Manager
Configuration File" section of the RSA Authentication Manager
Administrator's guide for instructions on how to configure and
download the RSA config file from RSA Authentication Manager).

### /4.0/edges/{edgeId}/sslvpn/config/advancedconfig
SSL VPN Advanced Configuration
-----

* **get** *(secured)*: Retrieve SSL VPN advanced configuration.
* **put** *(secured)*: Update SSL VPN advanced configuration.

### /4.0/edges/{edgeId}/sslvpn/config/script
Working With Logon and Logoff Scripts for SSL VPN
----

* **post** *(secured)*: Configure parameters associated with the uploaded script file.

* **get** *(secured)*: Retrieve all script configurations.
* **put** *(secured)*: Update all script configurations with the given list of
configurations. If the config is present, its is updated;
otherwise, a new config is created. Existing configs not included
in the body are deleted.

* **delete** *(secured)*: Delete all script configurations

### /4.0/edges/{edgeId}/sslvpn/config/script/{fileID}
Working With Uploaded Script Files
----

* **get** *(secured)*: Retrieve parameters associated with the specified script file.

* **put** *(secured)*: Update parameters associated with the specified script file.

* **delete** *(secured)*: Delete script parameters.

### /4.0/edges/{edgeId}/sslvpn/config/script/file/
Uploading Script Files for SSL VPN
----

* **post** *(secured)*: You can add multiple login or logoff scripts. For example, you can
bind a login script for starting Internet Explorer with gmail.com.
When the remote user logs in to the SSL client, Internet Explorer
opens up gmail.com. This method returns a *scriptFileId* which
can be used to update parameters associated with the script file.

You must upload the script files using the form-data content-type.
Consult the documentation for your REST client for instructions.

Do not set other Content-type headers in your request, for
example, *Content-type: application/xml*.

When you upload a file as form-data, you must provide a **key**
and a **value** for the file. The **key** is *file*, and the
**value** is the location of the script file.

**Example using curl**
```
/usr/bin/curl -v -k -i -F file=@/tmp/script.sh -H 'Authorization: Basic YWRtaW46ZGXXXXXXXX=='
https://192.168.110.42/api/4.0/edges/edge-3/sslvpn/config/script/file/
```

### /4.0/edges/{edgeId}/sslvpn/auth/localusers/users
Working With SSL VPN Users
---

* **put** *(secured)*: Update all users with the given list of users. If the user is
present, it is updated. Otherwise, and new user is created. Existing
users not included in the body are deleted.

### /4.0/edges/{edgeId}/sslvpn/activesessions
Working With Active Client Sessions
----

* **get** *(secured)*: Retrieve a list of active clients for the SSL VPN session.

### /4.0/edges/{edgeId}/sslvpn/activesessions/{sessionID}
Working With a Specific Active Client Session
----

* **delete** *(secured)*: Disconnect an active client.

### /4.0/edges/{edgeId}/statistics/dashboard/firewall
Working With NSX Edge Firewall Dashboard Statistics
----

* **get** *(secured)*: Retrieve number of ongoing connections for the firewall
configuration. 
This API is not supported for Distributed Logical Routers.

### /4.0/edges/{edgeId}/statistics/dashboard/sslvpn
Working With SSL VPN Dashboard Statistics
---

* **get** *(secured)*: Retrieve SSL VPN statistics on the specified NSX Edge.
This API is not supported for Distributed Logical Routers. 

### /4.0/edges/{edgeId}/statistics/dashboard/ipsec
Working With Tunnel Traffic Dashboard Statistics
----

* **get** *(secured)*: Retrieve tunnel traffic statistics for specified time interval.
This API is not supported for Distributed Logical Routers.

### /4.0/edges/{edgeId}/statistics/dashboard/interface
Working With Interface Dashboard Statistics
----

* **get** *(secured)*: Retrieves dashboard statistics between the specified start and end
times. When start and end time are not specified, all statistics
since the Edge deployed are displayed. When no end time is specified,
the current Edge Manager time is set as endTime. Each record has the
stats of 5 minutes granularity.
This API is not supported for Distributed Logical Routers.

### /4.0/edges/{edgeId}/statistics/interfaces
Working With Interface Statistics
----

* **get** *(secured)*: Retrieve the statistics of all configured vnics between a specified duration. 
If the duration is not specified, then all the statistics collected since
the deployment of the NSX Edge are retrieved. The statistics are retrieved 
after an interval of 5 minutes.

### /4.0/edges/{edgeId}/statistics/interfaces/uplink
Working With Uplink Interface Statistics
----

* **get** *(secured)*: Retrieve the statistics of all uplink interfaces between a specified duration. 
If the duration is not specified, then all the statistics collected since
the deployment of the NSX Edge are retrieved. The statistics are retrieved 
after an interval of 5 minutes.

### /4.0/edges/{edgeId}/statistics/interfaces/internal
Working With Internal Interface Statistics
-----

* **get** *(secured)*: Retrieve the statistics of all internal interfaces between a specified duration. 
If the duration is not specified, then all the statistics collected since
the deployment of the NSX Edge are retrieved. The statistics are retrieved 
after an interval of 5 minutes.

### /4.0/edges/{edgeId}/l2vpn/config
Working With L2 VPN Over SSL
----
L2 VPN allows you to configure a tunnel between two sites. 
VMs can move between the sites and stay on the same subnet,
enabling you to extend your datacenter. An NSX Edge at one site can
provide all services to VMs on the other site.

* **post** *(secured)*: Enable or disable the L2 VPN over SSL service.

* **get** *(secured)*: Retrieve the current L2 VPN over SSL configuration for the NSX Edge.

**Method history:**

Release | Modification
--------|-------------
6.3.5 | Method updated. *showSensitiveData* query parameter added. 

* **put** *(secured)*: Configure L2 VPN over SSL service for the server or client.

You first enable the L2 VPN service on the NSX Edge instance and then
configure a server and a client.

**L2 VPN Over SSL Parameters**

Parameter |  Description | Comments
---|---|---
**enabled**      |Whether L2 VPN is enabled.|Optional. Boolean. Options are *True* or *False*. Default is *True*. 
**logging**      |L2 VPN logging setting.|Optional. Disable by default.
**logging > enable**      |Whether logging is enabled.|Optional. Boolean. Options are *True* or *False*. Default is *False*.
**logging > logLevel**      |Logging level.|Optional. Options are: EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFO, and DEBUG. Default is *INFO*.
**listenerIp** | IP of external interface on which L2VPN service listens to. |Required.
**listenerPort** | Port on which L2VPN service listens to. |Optional. Default is 443.
**encryptionAlgorithm** | Encryption algorithm for communication between the server and the client. |Mandatory. Supported ciphers are *RC4-MD5*, *AES128-SHA*, *AES256-SHA*, *DES-CBC3-SHA*, *AES128-GCM-SHA256*, and *NULL-MD5*.
**serverCertificate** | Select the certificate to be bound to L2 VPN server. |Optional. If not specified server will use its default (self-signed) certificate.

**Peer Site Parameters**

Parameter |  Description | Comments
---|---|---
**peerSites **| To connect multiple sites to the L2 VPN server. |Required. Minimum one peer site must be configured to enable L2 VPN server service. 
**name **| Unique name for the site getting configured. |Required.
**description **| Description about the site. |Optional.
**l2VpnUser **| Every peer site must have a user configuration. |Required.
**l2VpnUser > userId **| L2 VPN user ID. |Required.
**l2VpnUser > password **| Password for L2 VPN user. |Required.
**vnics**| List of vNICs to be stretched over the tunnel. |Required.
**vnics > index** | Select the virtual machine NIC to bind to the IP address. |Required.
**egressOptimization > gatewayIpAddress** | The gateway IP addresses for which the traffic should be locally routed or for which traffic is to be blocked over the tunnel. |Optional.
**enabled**| Whether the peer site is enabled.|Optional. Boolean. Options are *True* or *False*. Default is *True*.    

**Example to configure L2 VPN for Client**

    <l2Vpn>
      <enabled>true</enabled>
      <logging>
        <enable>false</enable>
        <logLevel>info</logLevel>
      </logging>
      <l2VpnSites>
        <l2VpnSite>
          <client>
            <configuration>
              <serverAddress>192.168.15.23</serverAddress>
              <serverPort>443</serverPort>
              <vnic>10</vnic>
              <encryptionAlgorithm>AES128-SHA</encryptionAlgorithm>
              <caCertificate>certificate-4</caCertificate>
              <egressOptimization>
                <gatewayIpAddress>192.168.15.1</gatewayIpAddress>
              </egressOptimization>
            </configuration>
            <proxySetting>
              <type>https</type>
              <address>10.112.243.202</address>
              <port>443</port>
              <userName>root</userName>
              <password>java123</password>
            </proxySetting>
            <l2VpnUser>
              <userId>apple</userId>
              <password>apple</password>
            </l2VpnUser>
          </client>
        </l2VpnSite>
      </l2VpnSites>
    </l2Vpn>          

**Example to configure L2 VPN for Server**

    <l2Vpn>
      <enabled>true</enabled>
      <logging>
        <enable>false</enable>
        <logLevel>info</logLevel>
      </logging>
      <l2VpnSites>
        <l2VpnSite>
          <server>
            <configuration>
              <listenerIp>192.168.15.65</listenerIp>
              <listenerPort>443</listenerPort>
              <encryptionAlgorithm>RC4-MD5</encryptionAlgorithm>
              <peerSites>
                <peerSite>
                  <name>PeerSite1</name>
                  <description>description</description>
                  <l2VpnUser>
                    <userId>apple</userId>
                    <password>apple</password>
                  </l2VpnUser>
                  <vnics>
                    <index>10</index>
                  </vnics>
                  <egressOptimization>
                    <gatewayIpAddress>192.168.15.1</gatewayIpAddress>
                  </egressOptimization>
                  <enabled>true</enabled>
                </peerSite>
              </peerSites>
            </configuration>
          </server>
        </l2VpnSite>
      </l2VpnSites>
    </l2Vpn>

* **delete** *(secured)*: Delete the L2 VPN over SSL configuration.

### /4.0/edges/{edgeId}/l2vpn/config/statistics
Working With L2 VPN Over SSL Statistics
---

* **get** *(secured)*: Retrieve L2 VPN over SSL statistics, which has information such as tunnel status,
sent bytes, received bytes for the specified Edge.

### /4.0/edges/{edgeId}/l2t/config
Working with L2 VPN Over IPSec
-----
Starting with NSX 6.4.2, you can stretch your 
layer 2 networks between two sites with L2 VPN service over IPSec. 
Before configuring the L2 VPN service over IPSec, you must first create 
a route-based IPSec VPN tunnel. You then consume this route-based IPSec
VPN tunnel to create a L2 VPN tunnel between the two sites.

In NSX 6.4.2, you cannot create and edit route-based IPSec VPN tunnel by
using the vSphere Web Client. You must use the NSX Data Center for
vSphere REST APIs.

For a detailed workflow of configuring the L2 VPN service over IPSec,
see the *NSX Administration Guide*.

**L2 VPN Over IPSec Parameters**
  
Parameter |  Description | Comments
  ---|---|---
**L2TunnelsConfig > mode**    |Mode can be either *hub* or *spoke*.|Optional. Default value is *hub*.
**L2Tunnel > enabled**  |Whether L2 VPN over IPSec service is enabled.|Boolean. Optional. Default value is *True*.
**L2TTunnel > name**  |Name of the tunnel.|String. Optional.
**L2Tunnel > Description**  |Description of the tunnel.|Optional.
**StretchedSubInterfaces > index**  |Index of the subinterface that you want to stretch.|Integer. Required.
**TransportSession > protocol**  |Protocol supported.|Optional. Default value is *ipsec*.
**IpsecSession > ipsecSiteId**  |Site ID assigned to the route-based IPSec site.|String value. Required.
**IpsecSession > sharedCode**  |Validates the local IPSec site configuration. It contains VTI IP address to be assigned to the local VTI.|Required if the L2TunnelsConfig mode is *spoke*.

* **get** *(secured)*: Retrieve the configuration of all L2 VPN over IPSec tunnels on the specific NSX Edge.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.
6.4.4 | Method updated. **showSensitiveData** query parameter added. Output no longer includes sharedCode information by default.

* **post** *(secured)*: Enable the L2 VPN over IPSec service on the Edge.

**Method history:**
  
  Release | Modification
  --------|-------------
  6.4.2 | Method introduced.

### /4.0/edges/{edgeId}/l2t/config/l2tunnels
Working With L2 VPN Tunnels
-----

* **post** *(secured)*: Create a L2 VPN tunnel on the NSX Edge by consuming a route-based IPSec VPN tunnel.

**Note:** The shared code in the L2 VPN configuration contains the sensitive pre-shared key in plain text format.
This code must be kept securely according to the client security policy.

Specify the shared code as an input only when you are creating or updating the L2 VPN over IPSec tunnel in the client (spoke) mode.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

### /4.0/edges/{edgeId}/l2t/config/l2tunnels/{l2tunnelId}
Working With a Specific L2 VPN Tunnel
-------

* **put** *(secured)*: Update a specific L2 VPN over IPSec tunnel on the NSX Edge.

**Note:** The shared code in the L2 VPN configuration contains the
sensitive pre-shared key in plain text format. This code must be
kept securely according to the client security policy.

Specify the shared code as an input only when you are creating or
updating the L2 VPN over IPSec tunnel in the client (spoke) mode.

Starting in NSX 6.4.4, if an **ipsecSiteId** already exists, you
can omit the corresponding **sharedCode** information from the PUT
request body, and the existing **sharedCode** configuration will
be retained. If the **ipsecSiteId** does not exist, **sharedCode**
is required. 

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.
6.4.4 | Method updated. **sharedCode** is optional if the associated **ipsecSiteId** already exists.

* **delete** *(secured)*: Delete a specific L2 VPN over IPSec tunnel on the Edge.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

* **get** *(secured)*: Retrieve the configuration of a specific L2 VPN over IPSec tunnel on the Edge.

**Method history:**

Release | Modification
 --------|-------------
6.4.2 | Method introduced.
6.4.4 | Method updated. **showSensitiveData** query parameter added. Output no longer includes sharedCode information by default.

### /4.0/edges/{edgeId}/l2t/config/l2tunnels/{l2tunnelId}/peercodes
Working With Peer Codes for L2 VPN over IPSec
-------

* **get** *(secured)*: Retrieve the peer code of the client from the NSX Edge that is configured as the server (hub).

This peer code becomes the input code (shared code) for configuring L2 VPN over IPSec service on the client Edge.

**Note:** The peer code contains the sensitive pre-shared key in plain text format. 
The peer code must be kept securely according to the client security policy.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

### /4.0/edges/{edgeId}/l2t/config/globalconfig
Working With Global Configuration for L2 VPN Over IPSec 
-------

* **get** *(secured)*: Retrieve the mode of the L2 VPN over IPSec service on the Edge.
  
**Method history:**

 Release | Modification
 --------|-------------
 6.4.2 | Method introduced.

* **put** *(secured)*: Modify the mode of the L2 VPN over IPSec service on the Edge.

**Method history:**
          
Release | Modification
--------|-------------
6.4.2 | Method introduced.

### /4.0/edges/{edgeId}/ipsec/config
Working With IPSec VPN
-----
NSX Edge supports site-to-site IPSec VPN between an NSX Edge instance
and remote sites. NSX Edge supports certificate authentication,
preshared key mode, and IP unicast traffic between the NSX Edge instance 
and remote VPN sites. 

Starting with NSX 6.4.2, you can configure both 
policy-based IPSec VPN service and route-based IPSec VPN service. However, 
you can configure, manage, and edit route-based IPSec VPN parameters only 
by using REST APIs. 

### Policy-based IPSec VPN
In a policy-based IPSec VPN, you can connect multiple local subnets 
behind the NSX Edge with the peer subnets on the remote VPN site by 
using IPSec tunnels.
The local subnets behind an NSX Edge must have address ranges that do not
overlap with the IP addresses on the peer VPN site. 

If the local and remote peer across an IPsec VPN tunnel have overlapping
IP addresses, traffic forwarding across the tunnel might not be consistent.
 
### Route-based IPSec VPN
Route-based IPSec VPN is similar to Generic Routing Encapsulation (GRE) 
over IPSec, with the exception that no additional encapsulation is added
to the packet before applying IPSec processing.

In a route-based IPSec tunnel configuration, you must define a VTI with a 
private IP address on both the local and peer sites. 
Traffic from the local subnets is routed through the VTI to the peer subnets. 
Use a dynamic routing protocol, such as BGP, to route traffic through the 
IPSec tunnel. The dynamic routing protocol decides traffic from which local 
subnet is routed using the IPSec tunnel to the peer subnet.

**Note:** The VTI that you configure is a static VTI. Therefore, it 
cannot have more than one IP address. A good practice is to ensure that
the IP address of the VTI on both the local and peer sites are on the same subnet.

**Important:** In NSX 6.4.2, static routing and OSPF 
dynamic routing through an IPSec tunnel is not supported.

For a detailed example of configuring a route-based IPSec VPN tunnel between 
an NSX Edge and a Cisco CSR 1000V Virtual Appliance, see the 
*NSX Administration Guide*.

**IPSec VPN Parameters**

Parameter |  Description | Comments
---|---|---
**logging**      |IPsec VPN logging setting.|Optional. Default is *Enabled*.
**logging > logLevel** |Logging level.|Optional. Options are: EMERGENCY, ALERT, CRITICAL, ERROR, WARNING, NOTICE, INFO, and DEBUG. Default is *WARNING*.
**logging > enable** |Whether logging is enabled.|Optional. Boolean. Options are *True* or *False*. Default is *True*.
**psk**  |Indicates that the secret key shared between NSX Edge and the peer site is to be used for authentication. |Optional. Required only when peerIp is specified as *Any* in site configuration.
**site > psk**  |Indicates that the secret key shared between NSX Edge and the peer site is to be used for authentication. |Required when site > AuthenticationMode is specified *psk*. Optional only when peerIp is specified as *Any* in site configuration.
**site > encryptionAlgorithm** | Encryption algorithm for communication. |Optional. Supported ciphers are *AES*, *AES256*, *Triple DES*, and *AES-GCM*. Deault is *AES*.
**serviceCertificate** | Select the certificate to be bound to IPsec VPN server. |Optional. Required when *x.509* certificate mode is selected.
**caCertificate**| List of CA certificates. |Optional. 
**crlCertificate**| List of CRL certificates. |Optional. 
**site > enablePfs** |Perfect Forward Secrecy (PFS) ensures that each new cryptographic key is unrelated to any previous key. | Optional. Boolean. Options are *True* or *False*. Default is *True*. 
**site > authenticationMode** |Select authentication mode as *psk* or *x.509*.| Required.
**site **| To connect multiple sites to the IPsec VPN server. |Required. Minimum one site must be configured to enable IPsec VPN server service. 
**site > enabled**  |Enables site.|Optional. Boolean. Options are *True* or *False*. Default is *True*. 
**site > name **| Unique name for the site being configured. |Optional.
**site > description **| Site description. |Optional.
**site > digestAlgorithm** | Secure Hashing Algorithm (SHA) used for digitial signatures. | Optional. Options are *sha1*, and *sha-256*. Default is *sha1*.
**site > ikeOption** | IKE protocol version to be used. Use IKEFlex to always initiate using IKEv2, and while responding accept any of IKEv1 and IKEv2.| Optional. Options are *IKEv1*, *IKEv2*, and *IKEFlex*. Default is *IKEv1*.
**site > localId**| Enter the IP address of the NSX Edge instance. |Required.
**site > localIp**| Enter the IP address of the local endpoint. |Required.
**site > localSubnets** |Type the subnets to share between the sites in CIDR format. |Required if **ipsecSessionType** parameter value is *policybasedsession*. For route-based IPSec site, the default and only valid subnet is *0.0.0.0/0*.
**site > peerId**| Enter the peer ID to uniquely identify the peer site. This should be a Distinguishing Name (DN) if authentication mode is *x.509*. | Required.
**site > peerIp** | Enter the IP address of the peer endpoint.| Required.
**site > peerSubnets** |Type the subnets to share between the sites in CIDR format.|Required if **ipsecSessionType** parameter value is *policybasedsession*. For route-based IPSec site, the default and only valid subnet is *0.0.0.0/0*.
**site > responderOnly** |When set to true, the edge doesn't initiate negotiation, instead it waits for peer to initiate negotiation.| Optional. Options are *True* or *False*. Default is *False*.
**site > dhGroup** |In Diffie-Hellman (DH) Group, select the cryptography scheme that will allow the peer site and the NSX Edge to establish a shared secret over an insecure communications channel. | Optional. *dh14* is selected by default.
**extension** |When add_spd is set to on, security policies are installed regardless of whether the tunnel is established. ike_fragment_size is used to avoid failure in the IKE negotiation when the link MTU size is small. For example, ike_frament_size=900.|Optional. Global extensions: add_spf and ike_frament_size. <br> add_spd options are *off* or *on*. The default is *on*. 
**site > extension** | To disable securelocaltrafficbyip=&lt;IPAddress&gt;, replace with securelocaltrafficbyip=0. <br> Users can explicitly set this value to one of the other local IP addresses configured in the local subnets of Edge.  passthroughSubnets is used to exclude specific subnets from VPN policy enforcement if they overlap with the peerSubnets configured for the same site.|Optional. Configurable per site level: securelocaltrafficbyip=&lt;IPAddress&gt; and passthroughSubnets=&lt;PeerSubnetIPAddress&gt;. <br> By default, securelocaltrafficbyip=&lt;IPAddress&gt; is *enabled* and set to one of the local IP addresses configured on the local subnets of Edge.
**ipsecSessionType** |Configure whether the site is used for policy-based VPN or route-based VPN. Default value is *policybasedsession*. | Optional. Allowed values are *policybasedsession* and *routebasedsession*.
**tunnelInterface** | Configure tunnel interface parameters.|Required if **ipsecSessionType** parameter value is *routebasedsession*. This parameter is not valid for *routebasedsession*. 
**tunnelInterface > ipAddress**  |Specify a valid IPv4 address.|Required if **ipsecSessionType** parameter value is *routebasedsession*. Allowed value is an IPv4 address. IPv6 address is not allowed.
**tunnelInterface > mtu**  |Specify the maximum transmission unit.|Optional. Default is *1416*. Valid range is *152 - 8916*.

* **get** *(secured)*: Retrieve IPSec VPN configuration.

**Note:** The Pre-shared Key (PSK) in IPSec VPN configuration is a shared secret or sensitive data in plain text format.
This pre-shared key must be kept securely according to the client security policy.

 **Method history:**
 
 Release | Modification
 --------|-------------
 6.3.5 | Method updated. *showSensitiveData* query parameter added. 
 6.4.0 | Method updated. New parameters **ikeOption**, **responderOnly**, and **digestAlgorithm** added. New parameter **ipsecSessionType** added under the *site* section. This is a read-only parameter.
 6.4.2 | Method updated. Added a new value *routebasedsession* for **ipsecSessionType** parameter. Added a new parameter **tunnelInterface** when the value of **ipsecSessionType** is set to *routebasedsession*.

 **Response: Policy-based IPSec site**
 ```  
 <ipsec>
   <version>38</version>
   <enabled>true</enabled>
   <disableEvent>false</disableEvent>
   <logging>
     <enable>true</enable>
     <logLevel>debug</logLevel>
   </logging>
   <sites>
     <site>
       <enabled>true</enabled>
       <name>VPN to edge-pa-1</name>
       <description>psk VPN to edge-pa-1 192.168.11.0/24 == 192.168.1.0/24</description>
       <localId>11.0.0.11</localId>
       <localIp>11.0.0.11</localIp>
       <peerId>11.0.0.1</peerId>
       <peerIp>any</peerIp>
       <ipsecSessionType>policybasedsession</ipsecSessionType>
       <encryptionAlgorithm>aes256</encryptionAlgorithm>
       <authenticationMode>psk</authenticationMode>
       <enablePfs>true</enablePfs>
       <dhGroup>dh2</dhGroup>
       <localSubnets>
         <subnet>192.168.11.0/24</subnet>
       </localSubnets>
       <peerSubnets>
         <subnet>192.168.1.0/24</subnet>
       </peerSubnets>
     </site>
   </sites>
   <global>
     <psk>*****</psk>
     <serviceCertificate>certificate-4</serviceCertificate>
     <caCertificates>
       <caCertificate>certificate-3</caCertificate>
     </caCertificates>
     <crlCertificates>
       <crlCertificate>crl-1</crlCertificate>
     </crlCertificates>
   </global>
 </ipsec>
 ```
 **Response: Route-based IPSec site**
 ```
 <ipsec>
   <version>143</version>
   <enabled>true</enabled>
   <disableEvent>false</disableEvent>
   <logging>
     <enable>true</enable>
     <logLevel>debug</logLevel>
   </logging>
   <sites>
     <site>
       <enabled>true</enabled>
       <name>RBVPN-252</name>
       <description>Route-based VPN to edge 19</description>
       <localId>10.109.229.252</localId>
       <localIp>10.109.229.252</localIp>
       <peerId>10.109.229.251</peerId>
       <peerIp>10.109.229.251</peerIp>
       <ipsecSessionType>routebasedsession</ipsecSessionType>
       <tunnelInterface>
         <label>vti-1</label>
         <ipAddress>2.2.2.2/24</ipAddress>
         <mtu>1416</mtu>
       </tunnelInterface>
       <encryptionAlgorithm>aes256</encryptionAlgorithm>
       <enablePfs>true</enablePfs>
       <dhGroup>dh2</dhGroup>
       <localSubnets>
         <subnet>0.0.0.0/0</subnet>
       </localSubnets>
       <peerSubnets>
         <subnet>0.0.0.0/0</subnet>
       </peerSubnets>
       <psk>******</psk>
       <authenticationMode>psk</authenticationMode>
       <siteId>ipsecsite-34</siteId>
       <ikeOption>ikev2</ikeOption>
       <digestAlgorithm>sha1</digestAlgorithm>
       <responderOnly>false</responderOnly>
     </site>
   </sites>
   <global>
     <psk>******</psk>
     <caCertificates/>
     <crlCertificates/>
   </global>
 </ipsec>
 ```

* **put** *(secured)*: Update IPSec VPN configuration.

**Note:** The Pre-shared Key (PSK) in IPSec VPN configuration is a shared secret or sensitive data in plain text format.
This pre-shared key must be kept securely according to the client security policy.

 **Method history:**
 
 Release | Modification
 --------|-------------
 6.4.0 | Method updated. New parameters **ikeOption**, **responderOnly**, and **digestAlgorithm** added. New parameter **ipsecSessionType** added under the *site* section. This is a read-only parameter, and optional if used in a PUT call. If used, it must be set to *policybasedSession*.
 6.4.2 | Method updated. Added a new value *routebasedsession* for **ipsecSessionType** parameter. Added a new parameter **tunnelInterface** when the value of **ipsecSessionType** is set to *routebasedsession*.
 
 **Request: Policy-based IPSec site**
 ```
 <ipsec>
   <enabled>true</enabled>
   <disableEvent>false</disableEvent>
   <logging>
     <enable>true</enable>
     <logLevel>debug</logLevel>
   </logging>
   <sites>
     <site>
       <enabled>true</enabled>
       <name>VPN to edge-pa-1</name>
       <description>psk VPN to edge-pa-1 192.168.11.0/24 == 192.168.1.0/24</description>
       <localId>11.0.0.11</localId>
       <localIp>11.0.0.11</localIp>
       <peerId>11.0.0.1</peerId>
       <peerIp>any</peerIp>
       <ipsecSessionType>policybasedsession</ipsecSessionType>
       <encryptionAlgorithm>aes256</encryptionAlgorithm>
       <authenticationMode>psk</authenticationMode>
       <enablePfs>true</enablePfs>
       <dhGroup>dh2</dhGroup>
       <localSubnets>
         <subnet>192.168.11.0/24</subnet>
       </localSubnets>
       <peerSubnets>
         <subnet>192.168.1.0/24</subnet>
       </peerSubnets>
     </site>
   </sites>
   <global>
     <psk>*****</psk>
     <serviceCertificate>certificate-4</serviceCertificate>
     <caCertificates>
       <caCertificate>certificate-3</caCertificate>
     </caCertificates>
     <crlCertificates>
       <crlCertificate>crl-1</crlCertificate>
     </crlCertificates>
   </global>
 </ipsec>
 ```
 **Request: Route-based IPSec site**
 ```
 <ipsec>
   <enabled>true</enabled>
   <disableEvent>false</disableEvent>
   <logging>
     <enable>true</enable>
     <logLevel>debug</logLevel>
   </logging>
   <sites>
     <site>
       <enabled>true</enabled>
       <name>RBVPN-252</name>
       <description>Route-based VPN to edge 19</description>
       <localId>10.109.229.252</localId>
       <localIp>10.109.229.252</localIp>
       <peerId>10.109.229.251</peerId>
       <peerIp>10.109.229.251</peerIp>
       <ipsecSessionType>routebasedsession</ipsecSessionType>
       <tunnelInterface>
         <label>vti-1</label>
         <ipAddress>2.2.2.2/24</ipAddress>
         <mtu>1416</mtu>
       </tunnelInterface>
       <encryptionAlgorithm>aes256</encryptionAlgorithm>
       <enablePfs>true</enablePfs>
       <dhGroup>dh2</dhGroup>
       <localSubnets>
         <subnet>0.0.0.0/0</subnet>
       </localSubnets>
       <peerSubnets>
         <subnet>0.0.0.0/0</subnet>
       </peerSubnets>
       <psk>******</psk>
       <authenticationMode>psk</authenticationMode>
       <siteId>ipsecsite-34</siteId>
       <ikeOption>ikev2</ikeOption>
       <digestAlgorithm>sha1</digestAlgorithm>
       <responderOnly>false</responderOnly>
     </site>
   </sites>
   <global>
     <psk>******</psk>
     <caCertificates/>
     <crlCertificates/>
   </global>
 </ipsec>
 ```

* **delete** *(secured)*: Delete the IPSec VPN configuration.

### /4.0/edges/{edgeId}/peerconfig
Downloading IPSec VPN and BGP Neighbor Configuration
---            

* **get** *(secured)*: Retrieve the IPSec VPN configuration, or the BGP neighbor configuration, or both 
for the NSX Edge either in plain text format or JSON format. 
You can use the configuration details as reference to configure the IPSec VPN parameters and 
the BGP neighbor on the third-party VPN Gateway at the peer site.
For a policy-based IPSec VPN site, BGP neighbor configuration is not applicable.

**Note:** The Pre-shared Key (PSK) in IPSec VPN configuration is a shared secret or sensitive data in plain text format.
This pre-shared key must be kept securely according to the client security policy.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

**Response: Text (Route-based IPSec VPN and BGP Neighbor Configuration)**
```
# Configuration for IPsec VPN connection
#
# Peer NSX Edge and IPSec Site configuration details.
#
# IPsec site Id : ipsecsite-4
# IPsec site name : SecondSite
# IPsec site description:
# IPsec site enabled : true
# IPsec site vpn type : Route-based VPN
# NSX Edge Id : edge-1
# Feature version : 4
# Time stamp : 122817_181701GMT
#
# Internet Key Exchange Configuration
# Phase 1
# Configure the IKE SA as outlined below
-
Connection initiation mode : initiator
IKE version : ikev1
Authentication method : psk
Pre shared key : vmware
Authentication algorithm : sha1
Encryption algorithm : aes
SA life time : 28800 seconds
Phase 1 negotiation mode : main
DH group : DH14
# IPsec_configuration
# Phase 2
# Configure the IPsec SA as outlined below
Protocol : ESP
Authentication algorithm : sha1
Encryption algorithm : aes
Sa life time : 3600 seconds
Encapsulation mode : Tunnel mode
Enable perfect forward secrecy : true
Perfect forward secrecy DH group: DH14
# Peer configuration
Peer address : 10.10.10.10 # Peer gateway public IP.
Peer id : 10.10.10.10
Peer subnets : [ 0.0.0.0./0 ]
# IPsec Dead Peer Detection (DPD) settings
DPD enabled : true
DPD interval : 30 seconds
DPD timeout : 150 seconds
# Local configuration
Local address : 10.10.10.30 # Local gateway public IP.
Local id : 10.10.10.30
Local subnets : [ 0.0.0.0/0 ]
# Virtual Tunnel Interface
Peer VTI address : 172.16.2.45
Local VTI address : Your tunnel interface IP address
Tunnel Interface MTU : 1416 bytes
# BGP Configuration
#
BGP neighbour IP : 172.16.2.45
BGP neighbour AS number : 65000
BGP local IP : 172.16.3.45
BGP local AS number : 65300
BGP secret : VMWare
BGP weight : 60 (optional)
BGP hold down timer : 180
BGP keep alive timer : 60 
```

**Response: JSON (Route-based IPSec VPN and BGP Neighbor Configuration)**          
```
{
  "peer_config": {
    "ipsecSiteConfig_ipsecsite-4": {
      "ipsec_site_config": {
      "ipsec_site_id": "ipsecsite-4",
      "ipsec_site_name": "SecondSite",
      "ipsec_site_description": "",
      "ipsec_site_enabled": true,
      "ipsec_site_vpn_type": "Route based VPN",
      "edge_id": "edge-1",
      "feature_version": "4",
      "time_stamp": "122817_181701GMT",
      
      "ike_configuration": {
        "ike_version": "ikev1",
        "connection_initiation_mode": "initiator",
        "authentication_method": "psk",
        "pre_shared_key": "vmware",
        "authentication_algorithm": "sha1",
        "encryption_algorithm": "aes",
        "sa_life_time": "28800 seconds",
        "negotiation_mode": "main",
        "dh_group": "DH14"
      },
      "ipsec_configuration": {
        "protocol": "ESP",
        "authentication_algorithm": "sha1",
        "encryption_algorithm": "aes",
        "sa_life_time": "3600 seconds",
        "encapsulation_mode": "Tunnel mode",
        "enable_perfect_forward_secrecy": true,
        "perfect_forward_secrecy_dh_group": "DH14"
      },
      "peer_configuration": {
        "peer_address": "10.10.10.10",
        "peer_id": "10.10.10.10",
        "peer_subnets": "[ 0.0.0.0/0 ]",
        "dpd_enabled": true,
        "dpd_interval": "30 seconds",
        "dpd_timeout": "150 seconds"
      },
      "local_configuration": {
        "local_address": "10.10.10.30",
        "local_id": "10.10.10.30",
        "local_subnets": "[ 0.0.0.0/0 ]"
      },
      "virtual_tunnel_interface": {
        "peer_vti_address": "172.16.2.45",
        "local_vti_address": "172.16.3.45",
        "tunnel_interface_mtu": "1416 bytes"
      }
    },
     "bgpNeighbourConfig_172.16.3.45": {"bgp_config": {
        "bgp_neighbour_ip": "172.16.2.45",
        "bgp_neighbour_as": "65000",
        "bgp_local_ip": "172.16.3.45",
        "bgp_local_as": "65300",
        "bgp_secret": "VMWare",
        "bgp_weight": "60 (optional)",
        "bgp_hold_down_timer": "180",
        "bgp_keep_alive_timer": "60"
      }
    }
  }
}
```

### /4.0/edges/{edgeId}/ipsec/statistics
Working With IPSec VPN Statistics
---

* **get** *(secured)*: Retrieve IPSec VPN statistics.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. New parameter **channelIkeVersion** added under **IkeStatus** section. New parameters **failureMessage**, **packetsOut**, **packetSentErrors**, **encryptionFailures**, **sequenceNumberOverFlowErrors**, **packetsIn**, **packetReceivedErrors**, **decryptionFailures**, **replayErrorsintegrityErrors** added under **tunnelStatus** section. New parameter **siteId** added.
6.4.2 | Method updated. Added **virtualTunnelInterfaceStats**, **globalPacketDropStatistics** and **ikeStatistics** sections in the API response. 

### /4.0/edges/{edgeId}/autoconfiguration
Automatic Configuration of Firewall Rules
----
If autoConfiguration is enabled, firewall rules are automatically
created to allow control traffic. Rules to allow data traffic are not
created.  For example, if you are using IPsec VPN, and
**autoConfiguration** is *true*, firewall rules will automatically be
configured to allow IKE traffic. However, you will need to add
additional rules to allow the data traffic for the IPsec tunnel. If HA
is enabled, firewall rules are always created, even if
**autoConfiguration** is *false*, otherwise both HA appliances will
become active.

* **get** *(secured)*: Retrieve the auto configuration settings for the NSX Edge.

* **put** *(secured)*: Update the auto configuration settings for the NSX Edge.

### /4.0/edges/{edgeId}/appliances
Working With NSX Edge Appliance Configuration
-----
See *Working With NSX Edge* for additional parameters used to configure appliances.

When you create an NSX Edge, you define parameters that determine how
the appliance is deployed, including **resourcePoolId**, **dataStoreId**,
**hostId**, and **vmFolderId**. After the appliance is deployed, these
deployment details may change, and the appliance parameters are updated
to reflect the current, live location.

You can view the originally configured parameters by using the
**configuredResourcePool**, **configuredDataStore**, **configuredHost**, and
**configuredVmFolder** parameters.

You can trigger a high availability failover on the active NSX Edge
appliance by changing the haAdminState value to *down* as part of
appliance configuration for an NSX Edge. The haAdminState parameter
determines whether or not an NSX Edge appliance is participating in
high availability. Both appliances in an NSX Edge high availability
configuration normally have an haAdminState of *up*. When you set the
haAdminState of the active appliance to be *down*, it stops
participating in high availability, and informs the standby appliance
of its status.  The standby appliance becomes active immediately.  

Parameter | Description | Comments
--------|-------------|---------
**highAvailabilityIndex** | Index number of the appliance | Read only.
**haAdminState** | Indicates whether appliance is participating in high availability. | If the active appliance **haAdminState** is set to *down*, it stops participating in HA, and informs the standby appliance of its status. The standby appliance becomes active immediately. 
**configuredResourcePool > id** | ID of resource pool on which NSX Edge was originally deployed. | Read only.
**configuredResourcePool > name** | Name of resource pool on which NSX Edge was originally deployed. | Read only.
**configuredResourcePool > isValid** | True if resource pool on which NSX Edge was originally deployed currently exists. | Read only. *true* or *false*.
**configuredDataStore > id** | ID of data store on which NSX Edge was originally deployed. | Read only.
**configuredDataStore > name** | Name of data store on which NSX Edge was originally deployed. | Read only.
**configuredDataStore > isValid** | True if resource pool on which NSX Edge was originally deployed currently exists. | Read only. *true* or *false*.
**configuredHost > id** | ID of host on which NSX Edge was originally deployed. | Read only.
**configuredHost > name** | Name of host on which NSX Edge was originally deployed. | Read only.
**configuredHost > isValid** | True if resource pool on which NSX Edge was originally deployed currently exists. | Read only. *true* or *false*.
**configuredVmFolder > id** | ID of folder in which NSX Edge was originally deployed. | Read only.
**configuredVmFolder > name** | Name of folder in which NSX Edge was originally deployed. | Read only.
**configuredVmFolder > isValid** | True if resource pool on which NSX Edge was originally deployed currently exists. | Read only. *true* or *false*.

* **post** *(secured)*: Change the size of both appliances.

* **get** *(secured)*: Retrieve appliance configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **haAdminState**, **configuredResourcePool**, **configuredDataStore**, **configuredHost**, **configuredVmFolder** parameters added. 

* **put** *(secured)*: You can retrieve the configuration of both appliances by using the
GET call and replace the size, resource pool, datastore, and custom
parameters of the appliances by using a PUT call. If there were two
appliances earlier and you PUT only one appliance, the other
appliance is deleted.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **haAdminState** parameter added.

### /4.0/edges/{edgeId}/appliances/{haIndex}
Working With NSX Edge Appliance Configuration by Index
----

* **post** *(secured)*: Used to send CLI Commands to the Edge Gateway. To use CLI commands you also
need to add an additional Accept Header with type text/plain, as well as
the query parameter action=execute.

VMware recommends using the Central CLI instead of this method.
See *Working With the Central CLI* 

* **get** *(secured)*: Retrieve the configuration of the specified appliance.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **haAdminState**, **configuredResourcePool**, **configuredDataStore**, **configuredHost**, **configuredVmFolder** parameters added. 

* **put** *(secured)*: Update the configuration of the specified appliance.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method updated. **haAdminState** parameter added.

* **delete** *(secured)*: Delete the appliance

### /4.0/edges/{edgeId}/vnics
Working With Edge Services Gateway Interfaces
----
See *Working With NSX Edge* for descriptions of parameters used to
configure Edge Service Gateway interfaces.

* **post** *(secured)*: Add an interface or sub interface.
* **get** *(secured)*: Retrieve all interfaces for the specified Edge Services Gateway.

### /4.0/edges/{edgeId}/vnics/{index}
Working With a Specific Edge Services Gateway Interface
----
See *Working With NSX Edge* for descriptions of parameters used to
configure Edge Service Gateway interfaces.

* **get** *(secured)*: Retrieve the specified interface.
* **put** *(secured)*: Update the specified interface.
* **delete** *(secured)*: Delete interface

### /4.0/edges/{edgeId}/vnics/{parentVnicIndex}/subinterfaces/{subInterfaceIndex}
Working With a Sub-Interface of a Backing Type 
----
View, modify, or delete a sub-interface for a backing type VLAN or Network.

* **get** *(secured)*: Retrieve the specified sub-interface.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **put** *(secured)*: Update the specified sub-interface.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **delete** *(secured)*: Delete a sub-interface. 

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /4.0/edges/{edgeId}/{parentVnicIndex}/subinterfaces
Creating a Sub-Interface of a Backing Type
----
Create a sub-interface with backing type, VLAN or Network.

* **post** *(secured)*: Add an sub-interface of backing type VLAN or Network.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /4.0/edges/{edgeId}/mgmtinterface
Working With Logical Router HA (Management) Interface
----

* **get** *(secured)*: Retrieve the management interface configuration for the logical
router.

* **put** *(secured)*: Configure high availability (management) interface for logical
(distributed) router.  See *Working With NSX Edge* for descriptions
of parameters used to configure the logical router HA interface.

### /4.0/edges/{edgeId}/interfaces
Working With Logical Router Interfaces
----
Configure interfaces for logical (distributed) router.  See *Working
with NSX Edge* for descriptions of parameters used to configure the
logical router interfaces.

* **post** *(secured)*: Add interfaces for a logical router. 

* **get** *(secured)*: Retrieve all interfaces on the logical router.
* **delete** *(secured)*: Delete all interfaces on the logical router.

### /4.0/edges/{edgeId}/interfaces/{index}
Working With a Specific Logical Router Interface
----

* **get** *(secured)*: Retrieve information about the specified logical router interface.

* **delete** *(secured)*: Delete interface configuration and reset to factory default.

* **put** *(secured)*: Update interface configuration for the specified logical router
interface.

### /4.0/edges/jobs
Configuring Edge Services in Async Mode
----
You can configure NSX Edge to work in async mode. In the async mode, accepted
commands return an Accepted status and a taskId. To know the status of
the task, you can check the status of that taskId.  The advantage of the
async mode is that APIs are returned very fast and actions like vm
deployment, reboots, publish to NSX Edge appliance, are done behind the
scene under the taskId .  To configure async mode, ?async=true at the end
of any 4.0 service configuration URL for POST, PUT, and DELETE calls.
Without async mode, the location header in HTTP response has the resource
ID whereas in async mode, location header has the job ID.

The job status response includes the job status (*SUCCESS*, *FAILED*,
*QUEUED*, *RUNNING*, *ROLLBACK*), URI of the resource, and ID of the
resource. 

* **get** *(secured)*: Retrieve NSX Edge job status.

### /4.0/edges/jobs/{jobId}
Working With a Specific Edge Job Status
-----

* **get** *(secured)*: Retrieve job status for the specified job.

## nsxEdgePublish
Working With NSX Edge Configuration Publishing
=========

### /4.0/edgePublish/tuningConfiguration
Working With NSX Edge Tuning Configuration
------

Starting in 6.2.3 you can configure default values for NSX Edge
configuration parameters, including publishing and health check
timeouts, and CPU and memory reservation, which are applicable to all
NSX Edges.  The values for the tuning configuration parameters have been
set to sensible defaults and may not require any changes. However, based
on datacenter capacity and requirements, you can change the default CPU
and memory resource reservation percentages using this API.  This
percentage is applied across all Edge VM Sizes {COMPACT, LARGE,
QUADLARGE, XLARGE}.
The default values are:
* 100% for CPU reservation
* 100% for Memory reservation
* 1000 MHz per CPU

| Name | Comments |
|------|----------|
| lockUpdatesOnEdge | Default value is false. Serialize specific Edge operations related to DHCP and vnic configuration to avoid concurrency errors when too many configuration change requests arrive at the same time.|
| aggregatePublishing | Default value is true (enabled). Speed up configuration change publishing to the NSX Edge by aggregating over the configuration versions.|
| edgeVMHealthCheckIntervalInMin | Default value for time interval between NSX Edge VM's health check is 0, where NSX Manager manages the interval based on the number of NSX Edge VM's. A positive integer value overrides the default behavior.|
| healthCheckCommandTimeoutInMs | Default timeout value for health check command is 120000.|
| maxParallelVixCallsForHealthCheck | The maximum concurrent health check calls that can be made for NSX Edge VM's based on VIX communication channel is 25.|
| publishingTimeoutInMs | The timeout value to publish a configuration change on NSX Edge appliance.  Default is 1200000 (20 minutes).|
| edgeVCpuReservationPercentage | Integer value [0-100], specifying the CPU reservation percentage which will be applied to the NSX Edge appliance. To disable this resource reservation, enter 0. |
| edgeMemoryReservationPercentage | integer value [0-100], specifying the memory reservation percentage which will be applied to the NSX Edge appliance. To disable this resource reservation, enter 0. |
| megaHertzPerVCpu | integer value specifying the megahertz per each vCPU (1000, 1500, 2000) |

* **get** *(secured)*: Retrieve the NSX Edge tuning configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **put** *(secured)*: Update the NSX Edge tuning configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

## truststore
Working With Certificates
=============
NSX Edge supports self-signed certificates, certificates signed by a
Certification Authority (CA), and certificates generated and signed by a
CA.

### /2.0/services/truststore/certificate
Working With Certificates and Certificate Chains
------

* **post** *(secured)*: Import a certificate or a certificate chain against a certificate
signing request.

### /2.0/services/truststore/config
Working With Certificate Configuration
----

* **get** *(secured)*: View certificate expiry notification duration in days. This API is available for all roles.

**Method history:**

Release | Modification
--------|-------------
6.4.1 | Method introduced.

* **put** *(secured)*: Update certificate expiry notification duration in days. This duration is used to generate notification before the certificate expires, which helps you to monitor and renew certificates. 
Default value for the expiry notification is 7 days. This API is available to Enterprise Administrator, NSX Administrator, and Security Administrator roles.

**Method history:**

Release | Modification
--------|-------------
6.4.1 | Method introduced.

### /2.0/services/truststore/config/scope/{scopeId}
Working With Certificates on a Specific Scope
----

* **get** *(secured)*: Retrieve all certificates on the specified scope.

### /2.0/services/truststore/config/{scopeId}
Working With Self-Signed Certificates
------

* **post** *(secured)*: Create a single certificate

You can create a certificate for a specific NSX Edge, or if you
specify a scope of *globalroot-0* you can create a global certificate
in NSX Manager which is available to all NSX Edges.

### /2.0/services/truststore/config/{certificateId}
Working With a Specific Certificate
-----

* **get** *(secured)*: Retrieve the certificate object specified by ID. If the ID specifies
a chain, multiple certificate objects are retrieved.

* **delete** *(secured)*: Delete the specified certificate.

### /2.0/services/truststore/csr/{scopeId}
Working With Certificate Signing Requests
----

* **post** *(secured)*: Create a certificate signing request (CSR).

### /2.0/services/truststore/csr/{csrId}
Working With Self-Signed Certificate for CSR
-----

* **put** *(secured)*: Create a self-signed certificate for CSR.

* **get** *(secured)*: Retrieve the specified certificate signing request (CSR).

### /2.0/services/truststore/csr/scope/{scopeId}
Working With Certificate Signing Requests on a Specific Scope
----

* **get** *(secured)*: Retrieve certificate signing requests (CSR) on the specified scope.

### /2.0/services/truststore/crl/{scopeId}
Working With Certificate Revocation Lists on a Specific Scope
-----

* **post** *(secured)*: Create a certificate revocation list (CRL) on the specified scope.

### /2.0/services/truststore/crl/scope/{scopeId}
Working With CRL Certificates in a Specific Scope
----

* **get** *(secured)*: Retrieve all certificates for the specified scope.

### /2.0/services/truststore/crl/{crlId}
Working With a Specific CRL Certificate
----

* **get** *(secured)*: Retrieve certificate object for the specified certificate revocation
list (CRL).

* **delete** *(secured)*: Delete the specified certificate revocation list (CRL).

## policy
Working With Service Composer
============================
Service Composer helps you provision and assign network and security
services to applications in a virtual infrastructure. You map these services
to a security group, and the services are applied to the virtual machines in
the security group.

## Security Groups

You begin by creating a security group to define assets that you want to
protect. Security groups may be static (including specific virtual machines)
or dynamic where membership may be defined in one or more of the following
ways:
* vCenter containers (clusters, port groups, or datacenters).
* Security tags, IPset, MACset, or even other security groups. For example,
  you may include a criteria to add all members tagged with the specified
  security tag (such as AntiVirus.virusFound) to the security group.
* Directory Groups (if NSX Manager is registered with Active Directory).
* Regular expressions such as virtual machines with name *VM1*.

Note that security group membership changes constantly. For example, a
virtual machine tagged with the AntiVirus.virusFound tag is moved into the
Quarantine security group. When the virus is cleaned and this tag is removed
from the virtual machine, it again moves out of the Quarantine security
group.

## Security Policies

A security policy is a collection of the following service configurations.

Service | Description | Applies to
---|---|---
Distributed Firewall rules<br>**category**: *firewall* |  Rules that define the traffic to be allowed to, from, or within the security group. | vNIC
Guest Introspection service<br>**category**: *endpoint* | Third party solution provider services such as anti-virus or vulnerability management services. | virtual machines
Network Introspection services <br>(NetX or Network Extensibility)<br>**category**: *traffic_steering*| Services that monitor your network such as IPS. | virtual machines

## Applying Security Policies to Security Groups

You apply a security policy (say SP1) to a security group (say SG1). The
services configured for SP1 are applied to all virtual machines that are
members of SG1. If a virtual machine belongs to more than one security
group, the services that are applied to the virtual machine depends on the
precedence of the security policy mapped to the security groups. Service
Composer profiles can be exported and imported as backups or for use in
other environments. This approach to managing network and security services
helps you with actionable and repeatable security policy management.

## Service Composer Parameters

The following parameters are related to Service Composer, security
policies, and security groups.
  
### Common Parameters

* **actionType** - Defines the type of action belonging to a given
executionOrderCategory
* **executionOrderCategory** - Category to which the action belongs to
(endpoint, firewall or traffic_steering)
* **isActive** - In a security policy hierarchy, an action within a policy
may or may not be active based on the
precedence of the policy or usage of isActionEnforced flag in that
hierarchy
* **isActionEnforced** - Enforces an action of a parent policy on its
child policies for a given actionType and
executionOrderCategory. Note that in a policy hierarchy, for a given
actionType and executionOrderCategory, there can be only one action
which can be marked as enforced.
* **isEnabled** - Indicates whether an action is enabled
* **secondarySecurityGroup** - Applicable for actions which need secondary
security groups, say a source-destination firewall rule
* **securityPolicy** - Parent policy in an action

### Output-only Parameters

* **executionOrder** - Defines the sequence in which actions belonging to
an executionOrderCategory are executed. Note that this is not an input
parameter and its value is implied by the index in the list.

### Firewall Category Parameters

* **action** - Allow or block the traffic
* **applications** - Applications / application groups on which the rules
are to be applied
* **direction** - Direction of traffic towards primary security group.
Possible values: inbound, outbound, intra
* **logged** - Flag to enable logging of the traffic that is hit by this
rule
* **outsideSecondaryContainer** - Flag to specify outside i.e. outside
securitygroup-3

### Endpoint Category Parameters

* **serviceId** - ID of the service (as registered with the service
insertion module). If this tag is null, the
functionality type (as defined in actionType tag) is not applied which
will also result in blocking the actions (of given functionality type)
that are inherited from the parent security policy. This is true if
there is no action of enforce type.
* **invalidServiceId** - Flag to indicate that the service that was
referenced in this rule is deleted, which make
the rule ineffective (or deviate from the original intent that existed
while configuring the rule). You must either modify this rule by
adding correct Service or delete this rule.
* **serviceName** -Name of the service
* **serviceProfile** - Profile to be referenced in Endpoint rule.
* **invalidServiceProfile** - Flag to indicate that the service profile
that was referenced in this rule is deleted, which makes
the rule ineffective (or deviate from the original intent that existed
while configuring the rule). You must either modify this rule by
adding correct Service Profile or delete this rule.

The following parameters are deprecated:
* **vendorTemplateId**
* **invalidVendorTemplateId**
* **vendorTemplateName**

### Traffic Steering/NetX Category Parameters

* **redirect** - Flag to indicate whether to redirect the traffic or not
* **serviceProfile** - Service profile for which redirection is being
configured
* **logged** - Flag to enable logging of the traffic that is hit by this
rule

### /2.0/services/policy/securitypolicy
Working With Security Policies
------------------------------
A security policy is a set of Endpoint, firewall, and network
introspection services that can be applied to a security group.

See *Working With Security Groups* for more information about managing
security groups.

* **post** *(secured)*: Create a security policy.

When creating a security policy, a parent security policy can be
specified if required. The security policy inherits services from the
parent security policy. Security group bindings and actions can also
be specified while creating the policy. Note that execution order of
actions in a category is implied by their order in the list. The
response of the call has Location header populated with the URI using
which the created object can be fetched.

Ensure that:
* the required VMware built in services (such as Distributed Firewall
  and Endpoint) are installed. See *NSX Installation Guide*.
* the required partner services have been registered with NSX Manager.
* the required security groups have been created.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tag** parameter added. You can specify  *tag* for the firewall rule.

### /2.0/services/policy/securitypolicy/all
Working With all Security Policies
-----
  Retrieve information for all security policies. The **startIndex** and **pageSize** query parameters control how this information is displayed. **startIndex** determines
  which security policy to begin the list with, and **pageSize** determines how many security policies to list.

* **get** *(secured)*: Retrieve information for all security policies.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. Output is now paginated. **pageSize** and **startIndex** query parameters added.

### /2.0/services/policy/securitypolicy/{ID}
Working With a Specific Security Policy
------------------

* **get** *(secured)*: Retrieve security policy information. To view all security policies,
specify *all* as the security policy ID.

* **put** *(secured)*: Edit a security policy.

To update a security policy, you must first fetch it.
Then edit the received XML and pass it back as the input. The
specified configuration replaces the current configuration.

Security group mappings provided in the PUT call replaces the
security group mappings for the security policy. To remove all
mappings, delete the securityGroupBindings parameter.

You can add or update actions for the security policy by editing the
actionsByCategory parameter. To remove all actions (belonging to all
categories), delete the actionsByCategory parameter. To remove
actions belonging to a specific category, delete the block for that
category.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method updated. **tag** parameter added. You can specify  *tag* for the firewall rule.

* **delete** *(secured)*: Delete a security policy.

When you delete a security policy, its child security policies and
all the actions in it are deleted as well.

### /2.0/services/policy/securitypolicy/{ID}/sgbinding/{securityGroupId}
Working With Security Group Bindings
----

* **put** *(secured)*: Apply the specified security policy to the specified security group.

### /2.0/services/policy/securitypolicy/{ID}/securityactions
Working With Security Actions on a Security Policy
-------------

* **get** *(secured)*: Retrieve all security actions applicable on a security policy.

This list includes security actions from associated parent
security policies, if any. Security actions per Execution Order
Category are sorted based on the weight of security actions in
descending order.

### /2.0/services/policy/securitypolicy/maxprecedence
Working with Service Composer Policy Precedence
--------

* **get** *(secured)*: Retrieve the highest precedence (or weight) of the Service Composer
security policies.

The response body contains only the maximum precedence.

Example:

```
6300
```

### /2.0/services/policy/securitypolicy/status/
Working With Service Composer Status
------------------------------------

* **get** *(secured)*: Retrieve the consolidated status of Service Composer.

The possible return of value for status are: *in_sync*,
*in_progress*, *out_of_sync*, and *pending*.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/services/policy/securitypolicy/alarms/all
Working With All Service Composer Alarms
------------

* **get** *(secured)*: Retrieve all system alarms that are raised at Service Composer
level and policy level.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/services/policy/securitypolicy/serviceprovider/firewall
Working With Service Composer Firewall Applied To Setting
-------------
You can set the applied to setting for all firewall rules created
though Service Composer to either Distributed Firewall or Policy's
Security Groups. By default, the applied to is set to Distributed
Firewall. When Service Composer firewall rules have an applied to
setting of distributed firewall, the rules are applied to all clusters
on which distributed firewall is installed. If the firewall rules are
set to apply to the policy's security groups, you have more granular
control over the firewall rules, but may need multiple security
policies or firewall rules to get the desired result.

**Applied To Values for Service Composer Firewall Rules**

Value | Description
------|----------
dfw_only | Firewall rules are applied to all clusters on which Distributed Firewall is installed.
policy_security_group | Firewall rules are applied to security groups on which the security policy is applied.

* **get** *(secured)*: Retrieve the Service Composer firewall applied to setting.

* **put** *(secured)*: Update the Service Composer firewall applied to setting.

### /2.0/services/policy/securitypolicy/hierarchy
Working With Service Composer Configuration Import and Export
-----

* **post** *(secured)*: Import a security policy configuration

You can create multiple security policies and parent-child
hierarchies using the data fetched through export. All objects
including security policies, security groups and security actions
are created on a global scope.

The policy that is being imported needs to be included in the
request body.

If a suffix is specified, it is added after the names of the
security policy, security action, and security group objects in the
exported XML. The suffix can thus be used to differentiate locally
created objects from imported ones.

The location of the newly created security policy objects (multiple
locations are separated by commas) is populated in the Location
header of the response.

* **get** *(secured)*: Export a Service Composer configuration (along with the
security groups to which the security policies are mapped).
You can save the response to a file.  The saved configuration can be
used as a backup for situations where you may accidentally delete a
policy configuration, or it can be exported for use in another NSX
Manager environment.

If a prefix is specified, it is added before the names of the
security policy, security action, and security group objects in the
exported XML. The prefix can thus be used to indicate the remote
source from where the hierarchy was exported.

### /2.0/services/policy/securityaction/{category}/virtualmachines
Working With Virtual Machines with Security Actions Applied
--------------

* **get** *(secured)*: Retrieve all VirtualMachine objects on which security action of a
given category and attribute has been applied.

### /2.0/services/policy/securitygroup/{ID}/securityactions
Working With Security Actions Applicable on a Security Group
----

* **get** *(secured)*: Retrieve all security actions applicable on a security group for all
ExecutionOrderCategories. The list is sorted based on the weight of
security actions in descending order.  The **isActive** tag indicates
if a securityaction will be applied (by the enforcement engine) on the
security group.

### /2.0/services/policy/virtualmachine/{ID}/securityactions
Working With Security Actions Applicable on a Virtual Machine
----

* **get** *(secured)*: You can retrieve the security actions applicable on a virtual machine for
all ExecutionOrderCategories. The list of SecurityActions per
ExecutionOrderCategory is sorted based on the weight of security actions
in descending order. The **isActive** tag indicates whether a security
action will be applied (by the enforcement engine) on the virtual
machine.

### /2.0/services/policy/serviceprovider/firewall
Working With Service Composer Firewall
--------------

* **get** *(secured)*: **Deprecated.** Use `GET /api/2.0/services/serviceprovider/firewall/info` instead.

You can also use `GET /api/2.0/services/policy/securitypolicy/status/` to
retrieve the sync status of Service Composer firewall with Distributed
Firewall.

This GET method can perform certain functions, depending on the
request body provided. **Note:** Some REST clients do not allow you to
specify a request body with a GET request.

**Method history:**

  Release | Modification
  --------|-------------
  6.2.3 | Method updated and some functions deprecated. Changing auto save draft with the **autoSaveDraft** parameter is deprecated, and will be removed in a future release.  <br>The default setting of **autoSaveDraft** is changed from *true* to *false*.<br>Method to check if Service Composer and Distributed Firewall are in sync is deprecated, and will be removed in a future release. Use `GET /api/2.0/services/policy/securitypolicy/status/` instead.
  6.4.0 | All functions deprecated. Use `GET /api/2.0/services/serviceprovider/firewall/info` instead.

### /2.0/services/policy/serviceprovider/firewall/info
Working With Service Composer Firewall Information
--------------

* **get** *(secured)*: If Service Composer goes out of sync with Distributed Firewall, you
must re-synchronize Service Composer rules with firewall rules. If
Service Composer stays out of sync, firewall configuration may not
stay enforced as expected.

Using query parameters, you can get the sync status, force a sync,
and retrieve or update the auto save draft propertly. 

You can also use `GET /api/2.0/services/policy/securitypolicy/status/` to
retrieve the sync status of Service Composer firewall with distributed
Firewall.

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /2.0/services/policy/securitygroup/{ID}/securitypolicies
Working With Security Policies Mapped to a Security Group
-----

* **get** *(secured)*: Retrieve security policies mapped to a security group.

The list is sorted based on the precedence of security policy precedence
in descending order. The security policy with the highest precedence
(highest numeric value) is the first entry (index = 0) in the list.

## snmp
Working With SNMP
=================
NSX Manager receives events from other NSX Data Center for vSphere
components, including NSX Edge, network fabric, and hypervisors.

You can configure NSX Manager to forward SNMP traps to an SNMP Manager.

### /2.0/services/snmp/status
Working With SNMP Status Settings
-----
You can configure settings for SNMP on the NSX Manager.

Parameter | Description
----------|------------
serviceStatus | Boolean. Set to true to enable SNMP. There must be at least one SNMP manager configured to enable SNMP.
groupNotification | Boolean. Set to true to group similar SNMP notifications. This reduces the number of notifications being sent out, which can improve SNMP manager performance when there is a high volume of SNMP notifications.

* **get** *(secured)*: Retrieve SNMP status settings.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **put** *(secured)*: Update SNMP status settings.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/services/snmp/manager
Working With SNMP Managers
-----

* **get** *(secured)*: Retrieve information about SNMP managers.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **post** *(secured)*: Add an SNMP manager.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/services/snmp/manager/{managerId}
Working With a Specific SNMP Manager
------------------------------------

* **get** *(secured)*: Retrieve information about the specified SNMP manager.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **put** *(secured)*: Update an SNMP manager configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **delete** *(secured)*: Delete an SNMP manager configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/services/snmp/trap
Working With SNMP Traps
-----------------------

* **get** *(secured)*: Retrieve information about SNMP traps.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/services/snmp/trap/{oid}
Working With a Specific SNMP Trap
-----------------------

* **get** *(secured)*: Retrieve information about the specified SNMP trap.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **put** *(secured)*: Update the specified SNMP trap.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

## VMTranslationIp
Working With Translation of Virtual Machines to IP Addresses
=================
Support translation of Virtual Machines (VM) to IP addresses. Input VM ID and receive the corresponding IP addresses.

### /2.0/services/translation/virtualmachine/{vmId}/ipaddresses

* **get** *(secured)*: Retrieve IP addresses of the provided virtual machine.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

## TechSupportBundle
Working With Support Bundle
====================================
You can collect the support bundle data for NSX Data Center for vSphere
components like NSX Manager, hosts, edges, and controllers. 
These support bundles are required to troubleshoot problems in the NSX
Data Center for vSphere environment.
Bundle Status has the following values:
* Pending: Wait for the process to start.
* In Progress: Wait for process to complete.
* Skipped: This can be due to limited disk space. The bundle gets generated with partial logs and is made available for local download or is uploaded to remote server. 
The status of logs that are skipped is displayed. Note that 30% of disk space is always reserved for NSX.
* Failed: Log collection is failed due to various reasons like connectivity issues or timeout error. Click START NEW to start data collection again.
* Completed: You can now download the bundle or view at the remote server.

**Permissions**

API |  Role   |Permission 
--------|---- |------------ 
Generate Bundle | NSX Admin, Security Admin, Enterprise Admin   | Read/Write
Bundle Status|  NSX Admin, Security Admin, Enterprise Admin , Auditor   | Read
Cancel Bundle |  NSX Admin, Security Admin, Enterprise Admin   | Read/Write
Delete Bundle |   NSX Admin, Security Admin, Enterprise Admin   |Read/Write
Download Bundle |  NSX Admin, Security Admin, Enterprise Admin , Auditor   |Read

### /2.0/techsupportbundle

* **post** *(secured)*: Generates the technical support log bundle or aborts the bundle generation process.
Use */techsupportbundle?action=generate* to generate the bundle.
Use */techsupportbundle?action=cancel* to abort the bundle generation that is in in-progress.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

* **delete** *(secured)*: Deletes the support bundle.

### /2.0/techsupportbundle/status
Status of the Technical Support Bundle
------------------

* **get** *(secured)*: Retrieves the status of the technical support bundle.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

### /2.0/techsupportbundle/{filename}
Download Support Bundle 
--------------

* **get** *(secured)*: You can use the filename to download the support bundle. You can get the file name from the */techsupportbundle/status* API.

**Method history:**

Release | Modification
--------|-------------
6.4.0 | Method introduced.

## nsxCli
Working With the Central CLI
=======

### /1.0/nsx/cli

* **post** *(secured)*: The central command-line interface (central CLI) commands are run from the
NSX Manager command line, and retrieve information from the NSX Manager and other
devices. These commands can also be executed in the API.

You can insert any valid central CLI command as the **command**
parameter. For a complete list of the central CLI commands executable
through the API, please see the central CLI chapter of the *NSX Command
Line Interface Reference*.

You must set the **Accept** header to *text/plain*.

## inventoryStatus
Communication Status
====================
This feature allows the user to check the connection status between the
NSX Manager and hosts. A hash map is used to hold all hosts' connection
status. It keeps track of the latest heartbeat from each host.  When
querying a host’s connection status, NSX Manager will get the latest
heartbeat information to compare the last heartbeat time and current time.
If the duration is longer than a threshold, it returns *DOWN*, otherwise
it returns *UP*. If no last heartbeat information is found and this host
has not been prepared or the netcpa version on this host is lower than
6.2.0, it will return *NOT_AVAILABLE*.  But if no last heartbeat
information is found and the host has been prepared with netcpa version no
less than 6.2.0, it will return *DOWN*. When a host has been unprepared,
its heartbeat information will be removed from the NSX Manager memory.

### /2.0/vdn/inventory/host/{hostId}/connection/status
Communication Status of a Specific Host
---------------------------------------

* **get** *(secured)*: Retrieve the status of the specified host.

History:

Release | Modification
--------|-------------
6.2.3 | Method updated. Introduced **hostToControllerConnectionErrors** array.<br>Deprecated **fullSyncCount** parameter. Parameter is still present, but always has value of -1.

### /2.0/vdn/inventory/hosts/connection/status
Communication Status of a List of Hosts
---------------------------------------

* **get** *(secured)*: Retrieve the status of a list of hosts.

Release | Modification
--------|-------------
6.2.3 | Method updated. Introduced **hostToControllerConnectionErrors** array.<br>Deprecated **fullSyncCount** parameter. Parameter is still present, but always has value of -1.

## hardwareGateways
Working With Hardware Gateways
============

### /2.0/vdn/hardwaregateways

* **post** *(secured)*: Install a hardware gateway.

### Request body parameters
  
Parameter |  Description | Comments 
---|---|---
**bfdEnabled** |Enable or disable Bidirectional Forwarding Detection (BFD) between the hardware gateway and the replication cluster.| Optional. Default value is *true*. 
**replicationClusterId** | Object ID of the replication cluster that this hardware gateway will use.|Optional. If not specified, then default replication cluster ID is used.
      
**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.
6.4.2 | Method updated. New request body parameter **replicationClusterId** added.

* **get** *(secured)*: Retrieve information about all hardware gateways.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateways/{hardwareGatewayId}
Working With a Specific Hardware Gateway
----

* **get** *(secured)*: Retrieve information about the specified hardware gateway.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **put** *(secured)*: Update the specified hardware gateway.

### Request body parameters

  * **replicationClusterId** - Optional. Object ID of the replication cluster that this hardware gateway will use.
    If not specified, then default replication cluster ID is used in the hardware gateway.
  
**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.
6.4.2 | Method updated. A new request body parameter **replicationClusterId** added.

* **delete** *(secured)*: Delete the specified hardware gateway.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateways/{hardwareGatewayId}/switches
Working With Switches on a Specific Hardware Gateway
-----

* **get** *(secured)*: Retrieve information about switches on the specified hardware
gateway.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateways/{hardwareGatewayId}/switches/{switchName}
Working With a Specific Switch on a Specific Hardware Gateway
-----

### /2.0/vdn/hardwaregateways/{hardwareGatewayId}/switches/{switchName}/switchports
Working With Ports on a Specific Switch on a Specific Hardware Gateway
----

* **get** *(secured)*: Retrieve information about the hardware gateway switch ports for
the specified switch and hardware gateway.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateways/replicationclusters
Working With All Hardware Gateway Replication Clusters
----

* **get** *(secured)*: Retrieve information about all hardware gateway replication clusters.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

### /2.0/vdn/hardwaregateways/replicationcluster
Working With a Specific Hardware Gateway Replication Cluster
----

* **put** *(secured)*: Update the hardware gateway replication cluster.

Add or remove hosts on a replication cluster.

### Request body parameters

* **replicationClusterName** - Optional. Specify any UTF-8 string to change the replication cluster name. 
  If the parameter is not specified, then cluster name is not changed. 

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.
6.4.2 | Method updated. Query parameter **id** and request body parameter **replicationClusterName** added.

* **get** *(secured)*: Retrieve information about a hardware gateway replication cluster.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.
6.4.2 | Method updated. Query parameter **id** added.

* **post** *(secured)*: Create a hardware gateway replication cluster.

### Request body parameters

Parameter |  Description | Comments 
---|---|---
**replicationClusterName** |Specify any UTF-8 string for the name of the hardware gateway replication cluster. |Required. 
**hosts** | Specify the object IDs of the hosts on which VXLAN is configured. Specified hosts will be added to the replication cluster.|Optional. Default value is *empty*.

* **delete** *(secured)*: Delete a specific hardware gateway replication cluster.

**Method history:**

Release | Modification
--------|-------------
6.4.2 | Method introduced.

## hardwareGateway
Working With Hardware Gateway Bindings and BFD
=====

### /2.0/vdn/hardwaregateway/bindings
Working With Hardware Gateway Bindings
-----

* **post** *(secured)*: Create a hardware gateway binding.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **get** *(secured)*: Retrieve information about hardware gateway bindings.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateway/bindings/{bindingId}
Working With a Specific Hardware Gateway Binding
-----

* **get** *(secured)*: Retrieve information about the specified hardware gateway binding.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **put** *(secured)*: Update the specified hardware gateway binding.

You can update the binding parameters. This API will fail if:
* the specified *hardwareGatewayId* does not exist.
* the specified logical switch (*virtualWire*) is not present or there is a software
  gateway on the binding.
* the new binding value is a duplicate of an existing binding.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **delete** *(secured)*: Delete the specified hardware gateway binding.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateway/bindings/{bindingId}/statistic
Working With Hardware Gateway Binding Statistics
----

* **get** *(secured)*: Retrieve statistics for the specified hardware gateway binding.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateway/bindings/manage
Working With Hardware Gateway Binding Objects
----

* **post** *(secured)*: Manage hardware gateway binding objects.

Use this API to attach, detach, and update multiple bindings in a
single API call.  This API accepts three lists for add, update, and
delete. Each list accepts a hardwareGatewayManageBindingsItem with a
full description of the new binding with its objectID. This API
handles a maximum of 100 HardwareGatewayManageBindingsItem objects
for each of the Add/Update/Delete lists.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateway/bfd
Working With Hardware Gateway BFD (Bidirectional Forwarding Detection)
-----

### /2.0/vdn/hardwaregateway/bfd/config
Working With Hardware Gateway BFD Configuration
-----

* **put** *(secured)*: Update global hardware gateway BFD configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **get** *(secured)*: Retrieve global hardware gateway BFD configuration.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateway/bfd/status
Working With Hardware Gateway BFD Tunnel Status
------

* **get** *(secured)*: Retrieve hardware gateway BFD tunnel status for all tunnel
endpoints, including hosts and hardware gateways.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

