# VMware NSX for vSphere API documentation version 6.2.4
https://{nsxmanager}/api

### Introduction
This manual, the NSX for vSphere API Guide, describes how to install, configure, monitor, and maintain the VMware® NSX system by using REST API requests.

## Intended Audience

This manual is intended for anyone who wants to use REST API to programmatically control NSX in a VMware vSphere environment. The information in this manual is written for experienced developers who are familiar with virtual machine technology, virtualized datacenter operations, and REST APIs. This manual also assumes familiarity with NSX for vSphere.

## VMware Technical Publications Glossary

VMware Technical Publications provides a glossary of terms that might be unfamiliar to you. For definitions of terms as they are used in VMware technical documentation go to http://www.vmware.com/support/pubs.

## Document Feedback

VMware welcomes your suggestions for improving our documentation. If you have comments, send your feedback to docfeedback@vmware.com.

## NSX Documentation

The following documents comprise the NSX documentation set:

- *NSX for vSphere Administration Guide*
- *NSX for vSphere Installation and Upgrade*
- *NSX API Programming Guide*

## Technical Support and Education Resources

The following sections describe the technical support resources available to you. To access the current version of this book and other books, go to http://www.vmware.com/support/pubs.

### Online and Telephone Support

To use online support to submit technical support requests, view your product and contract information, and register your products, go to http://www.vmware.com/support.

Customers with appropriate support contracts should use telephone support for the fastest response on priority 1 issues. Go to http://www.vmware.com/support/phone_support.

### Support Offerings

To find out how VMware support offerings can help meet your business needs, go to http://www.vmware.com/support/services.

### VMware Professional Services

VMware Education Services courses offer extensive hands-on labs, case study examples, and course materials designed to be used as on-the-job reference tools. Courses are available onsite, in the classroom, and live online. For onsite pilot programs and implementation best practices, VMware Consulting Services provides offerings to help you assess, plan, build, and manage your virtual environment. To access information about education classes, certification programs, and consulting services, go to
http://www.vmware.com/services.

## Ports Required for the NSX REST API

The NSX Manager requires port 443/TCP for REST API requests.

## Finding vCenter Object IDs

Many API methods reference vCenter object IDs in URI parameters, query
parameters, request bodies, and response bodies. You can find vCenter object
IDs via the vCenter Managed Object Browser.

### Find Datacenter ID

1. In a web browser, enter the vCenter Managed Object Browser URL:
   `http://vCenter-IP-Address/mob`.
2. Click **content**.
3. Find **rootFolder** in the Name column, and click the corresponding link in
   the Value column. e.g. *group-d1*.
4. Find the **childEntity** in the Name column, and the corresponding
  Value column entry is the datacenter MOID. e.g. *datacenter-21*.

### Find Host ID

1. In a web browser, enter the vCenter Managed Object Browser URL:
   `http://vCenter-IP-Address/mob`.
2. Click **content**.
3. Find **rootFolder** in the Name column, and click the corresponding link in
   the Value column. e.g. *group-d1*.
4. Find **childEntity** in the Name column, and click the corresponding
   link in the Value column. e.g. *datacenter-21*.
4. Find **hostFolder** in the Name column, and click the corresponding
   link in the Value column. e.g. *group-h23*.
4. Find **childEntity** in the Name column. The corresponding Value column
   contains links to host clusters. Click the appropriate host cluster link.
   e.g. *domain-c33*.
4. Find *host* in the Name column. The corresponding Value column
   lists the hosts in that cluster by vCenter MOID and hostname. e.g.
   *host-32 (esx-02a.corp.local)*.

### Find Portgroup ID

1. In a web browser, enter the vCenter Managed Object Browser URL:
   `http://vCenter-IP-Address/mob`.
2. Click **content**.
3. Find **rootFolder** in the Name column, and click the corresponding link in
   the Value column. e.g. *group-d1*.
4. Find **childEntity** in the Name column, and click the corresponding
   link in the Value column. e.g. *datacenter-21*.
4. Find **hostFolder** in the Name column, and click the corresponding
   link in the Value column. e.g. *group-h23*.
4. Find **childEntity** in the Name column. The corresponding Value column
   contains links to host clusters. Click the appropriate host cluster link.
   e.g. *domain-c33*.
4. Find **host** in the Name column. The corresponding Value column lists the
   hosts in that cluster by vCenter MOID and hostname. Click the appropriate
   host link, e.g. host-32.
5. Find **network** in the Name column. The corresponding Value column lists
   the port groups on that host, e.g. *dvportgroup-388*.

### Find VMID

1. In a web browser, enter the vCenter Managed Object Browser URL:
   `http://vCenter-IP-Address/mob`.
2. Click **content**.
3. Find **rootFolder** in the Name column, and click the corresponding link in
   the Value column. e.g. *group-d1*.
4. Find **childEntity** in the Name column, and click the corresponding
   link in the Value column. e.g. *datacenter-21*.
4. Find **hostFolder** in the Name column, and click the corresponding
   link in the Value column. e.g. *group-h23*.
4. Find **childEntity** in the Name column. The corresponding Value column
   contains links to host clusters. Click the appropriate host cluster link.
   e.g. *domain-c33*.
4. Find **host** in the Name column. The corresponding Value column lists the
   hosts in that cluster by vCenter MOID and hostname. Click the appropriate
   host link, e.g. host-32.
5. Find **vm** in the Name column. The corresponding Value column lists the
   virtual machines by vCenter MOID and hostname. e.g. *vm-216 (web-01a)*.

### part-number
EN-001545-07

---

## vdsManage
Working with vSphere Distributed Switches
===========

### /2.0/vdn/switches

* **post** *(secured)*: Prepare a vSphere Distributed Switch.
___
The MTU is the maximum amount of data that can be transmitted in one
packet before it is divided into smaller packets. VXLAN frames are slightly
larger in size because of the traffic encapsulation, so the MTU required
is higher than the standard MTU. You must set the MTU for each switch to
1600 or higher.

* **get** *(secured)*: Retrieve information about all vSphere Distributed Switches.

### /2.0/vdn/switches/datacenter/{datacenterID}
Working with vSphere Distributed Switches in a Datacenter
------

* **get** *(secured)*: Retrieve information about all vSphere Distributed Switches in the specified datacenter.

### /2.0/vdn/switches/{vdsId}
Working With a Specific vSphere Distributed Switch
------

* **get** *(secured)*: Retrieve information about the specified vSphere Distributed Switch.

* **delete** *(secured)*: Delete the specified vSphere Distributed Switch.

## vdnConfig
Working with Segement ID Pools and Multicast Ranges
========

### /2.0/vdn/config/segments
Working with segment ID pools
-------------
Segment ID pools (also called segment ID ranges) provide virtual network
identifiers (VNIs) to logical switches.
___
You must configure a segment ID pool for each NSX Manager. You can have
more than one segment ID pool. The segment ID pool includes the beginning
and ending IDs.
___
You should not configure more than 10,000 VNIs in a single vCenter
server because vCenter limits the number of dvPortgroups to 10,000.
___
If any of your transport zones will use multicast or hybrid replication
mode, you must also configure a multicast address range.

* **post** *(secured)*: Add a segment ID pool.
___
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
___
If the segment ID pool is universal you must send the API request to
the primary NSX Manager.

* **delete** *(secured)*: Delete the specified segment ID pool.
___
If the segment ID pool is universal you must send the API request to
the primary NSX Manager.

### /2.0/vdn/config/multicasts
Working with Multicast Address Ranges
------
If any of your transport zones will use multicast or hybrid replication
mode, you must add a multicast address range (also called a multicast
address pool). Specifying a multicast address range helps in spreading
traffic across your network to avoid overloading a single multicast
address.

* **post** *(secured)*: Add a multicast address range for logical switches.
___
The address range includes the beginning and ending addresses.

* **get** *(secured)*: Retrieve information about all configured multicast address ranges.
___
Universal multicast address ranges have the property isUniversal
set to *true*.

### /2.0/vdn/config/multicasts/{multicastAddresssRangeId}
Working With a Specific Multicast Address Range
--------

* **get** *(secured)*: Retrieve information about the specified multicast address range.

* **put** *(secured)*: Update the specified multicast address range.
___
If the multicast address range is universal you must send the API
request to the primary NSX Manager.

* **delete** *(secured)*: Delete the specified multicast address range.
___
If the multicast address range is universal you must send the API
request to the primary NSX Manager.

### /2.0/vdn/config/vxlan/udp/port
Working with the VXLAN Port Configuration
----------

* **get** *(secured)*: Retrieve the UDP port configured for VXLAN traffic.

### /2.0/vdn/config/vxlan/udp/port/{portNumber}
Update the VXLAN Port Configuration
-------

* **put** *(secured)*: Update the VXLAN port configuration to use port *portNumber*.
___
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

* **get** *(secured)*: Retrieve the status of the VXLAN port configuration update.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/config/resources/allocated
Working with Allocated Resources
------

* **get** *(secured)*: Retrieve information about allocated segment IDs or multicast
addresses.

## vdnScopes
Working with Transport Zones
==============

### /2.0/vdn/scopes

* **get** *(secured)*: Retrieve information about all transport zones (also known as network
scopes).

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
Working with a Specific Transport Zone
---------

* **get** *(secured)*: Retrieve information about the specified transport zone.

* **post** *(secured)*: Update the specified transport zone.
___
You can add a cluster to or delete a cluster from a transport zone.
___
You can also repair missing portgroups. For every logical switch
created, NSX creates a corresponding portgroup in vCenter. If the
portgroup is lost for any reason, the logical switch will stop
functioning. The repair action recreates any missing portgroups.

* **delete** *(secured)*: Delete the specified transport zone.

### /2.0/vdn/scopes/{scopeId}/attributes
Working with transport zone attributes.

* **put** *(secured)*: Update the attributes of a transport zone.
___
For example, you can update the name, description, or control plane
mode. You must include the cluster object IDs for the transport zone
in the request body.

### /2.0/vdn/scopes/{scopeId}/conn-check/multicast
Testing multicast group connectivity.
-------

* **post** *(secured)*: Test multicast group connectivity.
___
Test multicast group connectivity between two hosts connected to the
specified transport zone.
___
Parameter **packetSizeMode** has one of the following values:
* *0* - VXLAN standard packet size
* *1* - minimum packet size
* *2* - customized packet size.
If you set **packetSizeMode** to *2*, you must specify the size using
the **packetSize** parameter.

## logicalSwitches
Working with Logical Switches in a Specific Transport Zone
==================

### /2.0/vdn/scopes/{scopeId}/virtualwires

* **get** *(secured)*: Retrieve information about all logical switches in the specified
transport zone (network scope).

* **post** *(secured)*: Create a logical switch.
___
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
Working with Traceflow
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
However, traceflow bypasses this process, hence vdl2 may broadcast the
traceflow packet out.

### /api/2.0/vdn/traceflow

* **post** *(secured)*: Create a traceflow.

### /api/2.0/vdn/traceflow/{traceflowId}
Working with a Specific Traceflow
---------

* **get** *(secured)*: Query a specific traceflow by *tracflowId* which is the value returned
after executing the create Traceflow API call.

### /api/2.0/vdn/traceflow/{traceflowId}/observations
Traceflow Observations
-----

* **get** *(secured)*: Retrieve traceflow observations.

## logicalSwitchesGlobal
Working with Logical Switches in All Transport Zones
===========

### /2.0/vdn/virtualwires

* **get** *(secured)*: Retrieve information about all logical switches in all transport zones.

### /2.0/vdn/virtualwires/vm/vnic
Working Virtual Machine Connections to Logical Switches
-----

* **post** *(secured)*: Attach a VM vNIC to, or detach a VM vNIC from a logical switch.
___
Specify the logical switch ID in the **portgroupId** parameter. To
detach a VM vNIC from a logical switch, leave the **portgroupId** parameter
empty.
___
To find the ID of a VM vNIC, do the following:
1. In the vSphere MOB, navigate to the VM you want to connect or disconnect.
2. Click **config** and take note of the **instanceUuid**.
3. Click **hardware** and take note of the last three digits of the
appropriate network interface device.
___
Use these two values to form the VM vNIC ID.  For example, if the
**instanceUuid** is *502e71fa-1a00-759b-e40f-ce778e915f16* and the
appropriate **device** value is *device[4000]*, the **objectId** and
**vnicUuid** are both *502e71fa-1a00-759b-e40f-ce778e915f16.000*.

### /2.0/vdn/virtualwires/{virtualWireID}
Working with a specific logical switch.

* **get** *(secured)*: Retrieve information about the specified logical switch.
___
If the switch is a universal logical switch the **isUniversal**
parameter is set to true in the response body.

* **put** *(secured)*: Update the specified logical switch.
___
For example, you can update the name, description, or control plane
mode.

* **delete** *(secured)*: Delete the specified logical switch.

### /2.0/vdn/virtualwires/{virtualWireID}/conn-check/multicast
Testing Host Connectivity
-----

* **post** *(secured)*: Test multicast group connectivity.
___
Test multicast group connectivity between two hosts connected to the
specified logical switch.
___
Parameter **packetSizeMode** has one of the following values:
* *0* - VXLAN standard packet size
* *1* - minimum packet size
* *2* - customized packet size.
If you set **packetSizeMode** to *2*, you must specify the size using
the **packetSize** parameter.

### /2.0/vdn/virtualwires/{virtualWireID}/conn-check/p2p
Test point-to-point connectivity.

* **post** *(secured)*: Test point-to-point connectivity.
___
Test point-to-point connectivity between two hosts connected to the
specified logical switch.
___
Parameter **packetSizeMode** has one of the following values:
* *0* - VXLAN standard packet size
* *1* - minimum packet size
* *2* - customized packet size.
If you set **packetSizeMode** to *2*, you must specify the size using
the **packetSize** parameter.

### /2.0/vdn/virtualwires/{virtualWireID}/hardwaregateways
Working with Hardware Gateway Bindings for a Specific Logical Switch
-----

* **get** *(secured)*: Retrieve hardware gateway bindings for the specified logical switch.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/virtualwires/{virtualWireID}/hardwaregateways/{hardwareGatewayBindingId}
Working with Connections Between Hardware Gateways and Logical Switches
-------

* **post** *(secured)*: Manage the connection between a hardware gateway and a logical switch.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

## arpMAC
Working with ARP Suppression and MAC Learning for Logical Switches
==============

### /2.0/xvs/networks/{ID}/features

* **get** *(secured)*: Retrieve ARP suppression and MAC learning information.
* **put** *(secured)*: Enable or disable ARP suppression and MAC learning.

## nsxControllers
Working with NSX Controllers
==============
For the unicast or hybrid control plane mode,
you must add an NSX controller to manage overlay transport and provide
East-West routing. The controller optimizes virtual machine broadcast (ARP
only) traffic, and the learning is stored on the host and the controller.

### /2.0/vdn/controller

* **post** *(secured)*: Adds a new NSX controller on the specified given cluster. The *hostId*
parameter is optional. The *resourcePoolId* can be either the
*clusterId* or *resourcePoolId*.
___
The IP address of the controller node will be allocated
from the specified IP pool. The *deployType* property determines the
controller node memory size and can be small, medium, or large. However,
different controller deployment types are not currently supported because
the OVF overrides it and different OVF types require changes in the
manager build scripts. Despite not being supported, an arbitrary
*deployType* size must still be specified or an error will be returned.
Request without body to upgrade controller cluster.

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
Retrieve Controller Upgrade Availability
----

* **get** *(secured)*: Retrieve controller upgrade availability.

### /2.0/vdn/controller/progress/{jobId}
Status of Controller Job
-----

* **get** *(secured)*: Retrieves status of controller creation or removal. The progress gives
a percentage indication of current deploy / remove procedure.

### /2.0/vdn/controller/{controllerId}
Working with a Specific Controller
-----

* **delete** *(secured)*: Deletes the NSX controller.

### /2.0/vdn/controller/{controllerId}/techsupportlogs
Working with Controller Tech Support Logs
-----

* **get** *(secured)*: Retrieves controller logs. Response content type is
application/octet-stream and response header is filename. This
streams a fairly large bundle back (possibly hundreds of MB).

### /2.0/vdn/controller/{controllerId}/syslog
Working with Controller Syslog
-----

* **post** *(secured)*: Add controller syslog exporter on the controller.
* **get** *(secured)*: Retrieve details about the syslog exporter on the controller.

* **delete** *(secured)*: Deletes syslog exporter on the specified controller node.

### /2.0/vdn/controller/{controllerId}/snapshot
Working with Controller Cluster Snapshots
-----

* **get** *(secured)*: Take a snapshot of the control cluster from the specified controller
node.

### /2.0/vdn/controller/cluster
Working with the NSX Controller Cluster Configuration
----

* **get** *(secured)*: Retrieve cluster wide configuration information for controller.

* **put** *(secured)*: Modify cluster wide configuration information for controller.

### /2.0/vdn/controller/credential
Working with the NSX Controller Password
------

* **put** *(secured)*: Change the NSX controller password.

## servicesScope
Working with Services
=============

### /2.0/services/application/scope/{scopeId}

* **get** *(secured)*: List services that have been created on the scope.
* **post** *(secured)*: Create a new service on the specified scope.

## service
Working with a Specified Service
============

### /2.0/services/application/{applicationId}

* **get** *(secured)*: Retrieve details about the specified service.
* **put** *(secured)*: Modify the name, description, applicationProtocol, or port value of a
service.

* **delete** *(secured)*: Delete the specified service.

## applicationgroup
Working with Service Groups
============

### /2.0/services/applicationgroup/scope/{scopeId}
Working with Service Groups on a Specific Scope
-------

* **post** *(secured)*: Create a new service group on the specified scope.
* **get** *(secured)*: Retrieve a list of service groups that have been created on the scope.

### /2.0/services/applicationgroup/{applicationgroupId}
Working with a Specific Service Group
----

* **get** *(secured)*: Retrieve details about the specified service group.
* **put** *(secured)*: Modify the name, description, applicationProtocol, or port value of
the specified service group.

* **delete** *(secured)*: Delete the specified service group from a scope.

### /2.0/services/applicationgroup/{applicationgroupId}/members/{moref}
Working with a Specific Service Group Member
-----

* **put** *(secured)*: Add a member to the service group.
* **delete** *(secured)*: Delete a member from the service group.

### /2.0/services/applicationgroup/scope/{scopeId}/members
Working with Service Group Members on a Specific Scope
------

* **get** *(secured)*: Get a list of member elements that can be added to the service groups
created on a particular scope.
___
Since service group allows only either services or other service
groups as members to be added, this helps you get a list of all
possible valid elements that can be added to the
service.

## ipPools
Working with IP Pools
========

### /2.0/services/ipam/pools/scope/{scopeId}
Working with IP Pools on a Specific Scope
-----

* **get** *(secured)*: Retrieves all IP pools on the specified scope where the *scopeID* is the
reference to the desired scope. An example of the *scopeID* is
globalroot-0.

* **post** *(secured)*: Create a pool of IP addresses. For *scopeId* use globalroot-0 or
the *datacenterId* in upgrade use cases.

### /2.0/services/ipam/pools/{poolId}
Working with a Specific IP Pool
------

* **get** *(secured)*: Retrieve details about a specific IP pool.
* **put** *(secured)*: To modify an IP pool, query the IP pool first. Then modify the output and
send it back as the request body.

* **delete** *(secured)*: Delete an IP pool.

### /2.0/services/ipam/pools/{poolId}/ipaddresses
Working with IP Pool Address Allocations
------

* **get** *(secured)*: Retrieves all allocated IP addresses from the specified pool.

* **post** *(secured)*: Allocate an IP Address from the pool. Use *ALLOCATE* in the
**allocationMode** field in the body to allocate the next available
IP. To allocate a specific one use *RESERVE* and pass the IP to
reserve in the **ipAddress** fields in the body.

### /2.0/services/ipam/pools/{poolId}/ipaddresses/{ipAddress}
Working with Specific IPs Allocated to an IP Pool
----

* **delete** *(secured)*: Release an IP address allocation in the pool.

## capacityUsage
Working with Licensing Capacity
============
The licensing capacity usage API command reports usage of CPUs, VMs and
concurrent users for the distributed firewall and VXLAN.

### /2.0/services/licensing/capacityusage

* **get** *(secured)*: Retrieve capacity usage information on the usage of CPUs, VMs and concurrent
users for the distributed firewall and VXLAN.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

## securityTag
Working with Security Tags
=====

### /2.0/services/securitytags/tag

* **post** *(secured)*: Create a new security tag.
* **get** *(secured)*: Retrieve security tags.

### /2.0/services/securitytags/tag/{tagId}
Delete a security tag.

* **delete** *(secured)*: Delete the specified security tag.

### /2.0/services/securitytags/tag/{tagId}/vm
Retrieve the list of VMs that have the specified tag attached to
them.

* **get** *(secured)*: Retrieve the list of VMs that have the specified tag attached to
them.

### /2.0/services/securitytags/tag/{tagId}/vm/{vmMoid}
Apply or detach a security tag to virtual machine.

* **put** *(secured)*: Apply a security tag to virtual machine.
* **delete** *(secured)*: Detach a security tag from a virtual machine.

## ssoConfig
Working with NSX Manager SSO Registration
============

### /2.0/services/ssoconfig

* **get** *(secured)*: Retrieve SSO Configuration.
* **post** *(secured)*: Register NSX Manager to SSO Services.
* **delete** *(secured)*: Deletes the NSX Manager SSO Configuration.

### /2.0/services/ssoconfig/status
Working with SSO Configuration Status
-----

* **get** *(secured)*: Retrieve the SSO configuration status of NSX Manager.

## userMgmt
Working with User Management
==========

### /2.0/services/usermgmt/user/{userId}
Manage Users on NSX Manager
-----

* **get** *(secured)*: Get information about a user.
* **delete** *(secured)*: Remove the NSX role for a vCenter user.

### /2.0/services/usermgmt/role/{userId}
Manage NSX Roles for Users
-----

* **get** *(secured)*: Retrieve a user's role (possible roles are super_user, vshield_admin,
enterprise_admin, security_admin, and audit).

* **post** *(secured)*: Add role and resources for a user.
* **put** *(secured)*: Change a user's role.
* **delete** *(secured)*: Delete the role assignment for specified vCenter user. Once this role
is deleted, the user is removed from NSX Manager. You cannot delete the
role for a local user.

### /2.0/services/usermgmt/enablestate/{value}
Working with User Account State
-----

* **put** *(secured)*: Enable or disable a user account.

### /2.0/services/usermgmt/users/vsm
Working with NSX Manager Role Assignment
----

* **get** *(secured)*: Get information about users who have been assigned a NSX Manager role
(local users as well as vCenter users with NSX Manager role).

### /2.0/services/usermgmt/roles
Working with Available NSX Manager Roles
----

* **get** *(secured)*: Read all possible roles in NSX Manager

### /2.0/services/usermgmt/scopingobjects
Retrieve a list of objects that can be used to define a user's access
scope

* **get** *(secured)*: Retrieve a list of objects that can be used to define a user's access
scope

## secGroup
Working with Security Groups
===========

### /2.0/services/securitygroup/bulk/{scopeId}
Create a new security group
----
Create a new security group on a global scope or universal scope. Use
either "globalroot-0" or "universalroot-0". Universal security groups are
read-only when querying a secondary NSX manager.

* **post** *(secured)*: Create a new security group on a scope.
* **put** *(secured)*: Update a security group.

### /2.0/services/securitygroup/scope/{scopeId}
Working with Security Groups on a Specific Scope
----

* **get** *(secured)*: List all the security groups created on a specific scope.

### /2.0/services/securitygroup/scope/{scopeId}/memberTypes
Working with Security Group Member Types
----

* **get** *(secured)*: Retrieve a list of valid elements that can be added to a security
group.

### /2.0/services/securitygroup/scope/{scopeId}/members/{memberType}
Working with a Specific Security Group Member Type
----

* **get** *(secured)*: Retrieve members of a specific type in the specified scope.

### /2.0/services/securitygroup/{objectId}
Working with a Specific Security Group
----

* **get** *(secured)*: Retrieve all members of the specified security group.
* **put** *(secured)*: Update members of the specified security group.
* **delete** *(secured)*: Delete an existing security group.

### /2.0/services/securitygroup/{objectId}/members/{memberId}
Working with Members of a Specific Security Group
----

* **put** *(secured)*: Add a new member to the specified security group.
* **delete** *(secured)*: Delete member from the specified security group.

### /2.0/services/securitygroup/{objectId}/translation/virtualmachines
Working with Virtual Machines in a Security Group
----

* **get** *(secured)*: Retrieve list of virtual machine entities that belong to a specific security
group.

### /2.0/services/securitygroup/{objectId}/translation/ipaddresses
Working with IP Addresses in a Security Group
-----

* **get** *(secured)*: Retrieve list of IP addresses that belong to a specific security
group.

### /2.0/services/securitygroup/{objectId}/translation/macaddresses
Working with Mac Addresses in a Security Group
-----

* **get** *(secured)*: Retrieve list of MAC addresses that belong to a specific security
group.

### /2.0/services/securitygroup/{objectId}/translation/vnics
Working with vNICs in a Security Group
-----

* **get** *(secured)*: Retrieve list of vNICs that belong to a specific security group.

### /2.0/services/securitygroup/lookup/virtualmachine/{virtualMachineId}
Working with Virtual Machine Security Group Membership
------

* **get** *(secured)*: Retrieve list of security groups that the specified virtual machine
belongs to.

### /2.0/services/securitygroup/internal/scope/{scopeId}
Working with Internal Security Groups
----

* **get** *(secured)*: Retrieve all internal security groups on the NSX Manager. These are used
 internally by the system and should not be created or modified by end
users.

## ipsets
Working with IP Sets
=======

### /2.0/services/ipset/scope/{scopeMoref}
Working with IP Sets on a Specific Scope
----

* **get** *(secured)*: Retrieve all configured IPSets

### /2.0/services/ipset/{scopeMoref}
Creating New IP Sets
-----

* **post** *(secured)*: Create a new IP set.

### /2.0/services/ipset/{ipsetId}
Working with a Specific IP Set
----

* **get** *(secured)*: Retrieve an individual IP set.
* **put** *(secured)*: Modify an existing IP set.
* **delete** *(secured)*: Delete an IP set.

## vCenterConfig
Configuring NSX Manager with vCenter Server
=========

### /2.0/services/vcconfig

* **get** *(secured)*: Get vCenter Server configuration details on NSX Manager.
* **put** *(secured)*: Synchronize NSX Manager with vCenter server.

### /2.0/services/vcconfig/status
Connection Status for vCenter Server
-----

* **get** *(secured)*: Get default vCenter Server connection status

## universalSync
Working with Universal Sync Configuration in Cross-vCenter NSX
======

### /2.0/universalsync/configuration/role
Working with Universal Sync Configuration Roles
----
You can set the role of an NSX Manager to primary, secondary, or
standalone. If you set an NSX Manager’s role to primary, then use it to
create universal objects, and then set the role to standalone, the role
will be set as transit. In the transit role, the universal objects will
still exist, but cannot be modified, other than being deleted.

* **post** *(secured)*: Set the universal sync configuration role.
* **get** *(secured)*: Retrieve the universal sync configuration role.

### /2.0/universalsync/configuration/nsxmanagers
Working with Universal Sync Configuration of NSX Managers
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
Working with Universal Sync Entities
----

* **get** *(secured)*: Retrieve the status of a universal sync entity.

### /2.0/universalsync/status
Working wiht Universal Sync Status
-----

* **get** *(secured)*: Retrieve the universal sync status.

## applianceManager
Working with Appliance Manager
========

### /1.0/appliance-management/global/info
Global Information for NSX Manager
----

* **get** *(secured)*: Retrieve global information containing version information as well as
current logged in user.

### /1.0/appliance-management/summary/system
Summary Information for NSX Manager
----

* **get** *(secured)*: Retrieve system summary info such as address, dns name, version, CPU,
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
NSX Manager CPU Information
-----

* **get** *(secured)*: Retrieve NSX Manager CPU information.

### /1.0/appliance-management/system/uptime
NSX Manager Appliance Uptime Information
----

* **get** *(secured)*: Retrieve NSX Manager uptime information.

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

* **get** *(secured)*: Retrieve network information i.e. host name, IP address, DNS settings

### /1.0/appliance-management/system/tlssettings
Working with TLS Settings
----

* **get** *(secured)*: Retrieve TLS settings.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **post** *(secured)*: Update TLS settings.
___
Include a comma separated list of the TLS versions you want to enable,
for both server and client.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /1.0/appliance-management/system/tlssettings/dns
Working with DNS Configuration
-----

* **put** *(secured)*: Configure DNS.
* **delete** *(secured)*: Delete DNS server configuration.

### /1.0/appliance-management/system/timesettings
Working with Time Settings
------

* **get** *(secured)*: Retrieve time settings, like timezone or current date and time with
NTP server, if configured.

* **put** *(secured)*: Configure time or specify the NTP server to use for time
synchronization.

### /1.0/appliance-management/system/timesettings/ntp
Working with NTP Settings
----

* **delete** *(secured)*: Delete NTP server.

### /1.0/appliance-management/system/locale
Configure System Locale
----

* **get** *(secured)*: Retrieve locale info.
* **put** *(secured)*: Configure locale.

### /1.0/appliance-management/system/syslogserver
Working with Syslog Servers
-----

* **get** *(secured)*: Retrieve syslog servers.
* **put** *(secured)*: Configure syslog servers.
* **delete** *(secured)*: Delete syslog servers.

### /1.0/appliance-management/components
Components management
----

* **get** *(secured)*: Retrieve all appliance manager components.

### /1.0/appliance-management/components/{componentID}
Working with a Specific Component
----

* **get** *(secured)*: Retrieve details for specified component.

### /1.0/appliance-management/components/{componentID}/dependencies
Working with Component Dependencies
----

* **get** *(secured)*: Retrieve dependency details for specified component.

### /1.0/appliance-management/components/{componentID}/dependents
Working with Component Dependents
----

* **get** *(secured)*: Retrieve dependents for the specified component.

### /1.0/appliance-management/components/{componentID}/status
Working with Component Status

* **get** *(secured)*: Retrieve current status for specified component.

### /1.0/appliance-management/backuprestore/backupsettings
NSX Manager Appliance Backup Settings
-----

* **get** *(secured)*: Retrieve backup settings.
* **put** *(secured)*: Configure backup on the appliance manager.
* **delete** *(secured)*: Delete appliance manager backup configuration.

### /1.0/appliance-management/backuprestore/backup
NSX Manager Appliance On-Demand Backup
----

* **post** *(secured)*: Backup NSX data on-demand.

### /1.0/appliance-management/backuprestore/backups
Working with NSX Manager Appliance Backup Files
-----

* **get** *(secured)*: Retrieve list of all backups available at configured backup location.

### /1.0/appliance-management/backuprestore/restore
Restoring Data from a NSX Manager Appliance Backup File
------

* **post** *(secured)*: Restore data from a backup file.

### /1.0/appliance-management/techsupportlogs/{componentID}
Working with Tech Support Logs by Component
----

* **post** *(secured)*: Generate tech support logs. The location response header contains the
location of the created tech support file. 

### /1.0/appliance-management/techsupportlogs/{filename}
Working with Tech Support Log Files
-----

* **get** *(secured)*: Download tech support logs

### /1.0/appliance-management/notifications
Working with Support Notifications
----

* **get** *(secured)*: Retrieve all system generated notifications.
* **delete** *(secured)*: Delete all notifications.

### /1.0/appliance-management/notifications/{ID}/acknowledge
Acknowledge Notifications
----

* **post** *(secured)*: Acknowledge a notification. The notification is then deleted from
the system.

### /1.0/appliance-management/upgrade/uploadbundle/{componentID}
Upgrading NSX Manager
----
If you are upgrading from vCloud Networking and Security to NSX, all
grouping objects from vShield Manager 5.5 are carried over to NSX.
Though new objects in NSX can be created only at a global scope, the
scope of upgraded objects is maintained, and these objects can be
edited. For example, you can nest the following security groups within
an upgraded security group at the datacenter scope:

* security groups created at same datacenter scope (via REST only)
* security groups created at portgroup scope, which fall under the
datacenter (via REST only).

Security groups created at the global scope cannot be nested under a
security group created at a lower scope such as a
datacenter.

All users and associated roles are carried over to NSX as well.
In all API calls for upgrading the NSX Manager, the **componentId**
parameter can be *NSX* or *NSXAPIMGMT*.

* **post** *(secured)*: Upload upgrade bundle.
* **get** *(secured)*: After the upgrade bundle is uploaded, you can query upgrade details
such as pre‐upgrade validation warning or error messages along with
pre‐upgrade questions.

### /1.0/appliance-management/upgrade/start/{componentID}
Start Upgrade
----

* **get** *(secured)*: Start upgrade process.

### /1.0/appliance-management/status/{componentID}
Upgrade Status
----

* **get** *(secured)*: Query upgrade status.

### /1.0/appliance-management/certificatemanager
Working with Certificates on the NSX Manager Appliance
-------

### /1.0/appliance-management/certificatemanager/pkcs12keystore/nsx
Working with Keystore Files
------------

* **post** *(secured)*: Upload keystore file.
___
Input is PKCS#12 formatted NSX file along with password.

### /1.0/appliance-management/certificatemanager/certificates/nsx
NSX Manager Certificate Manager
--------

* **get** *(secured)*: Retrieve certificate information from NSX Manager.

### /1.0/appliance-management/certificatemanager/csr/nsx
Working with Certificate Signing Requests
------

* **post** *(secured)*: Create a certificate signing request (CSR) for NSX Manager.
___
The response header contains the created file location.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced. Replaces `PUT /api/1.0/appliance-management/certificatemanager/nsx/csr`.

* **get** *(secured)*: Retrieve generated certificate signing request (CSR).

### /1.0/appliance-management/certificatemanager/uploadchain/nsx
Working with Certificate Chains
-----

* **post** *(secured)*: Upload certificate chain.
___
Input is certificate chain file which is a PEM encoded chain of
certificates received from the CA after signing a CSR.

## systemEvents
Working with NSX Manager System Events
==========

### /2.0/systemevent

* **get** *(secured)*: Get NSX Manager system events

## auditLogs
Working with NSX Manager Audit Logs
==========

### /2.0/auditlog

* **get** *(secured)*: Get NSX Manager audit logs

## nwfabric
Working with Network Fabric Configuration
=====

### /2.0/nwfabric/configure
Working with Network Virtualization Components and VXLAN.
___
Cluster preparation can be broken down into the following:
  * Install VIB and non-VIB related action: Before any per-host config
  a VIB must be installed on the host. The feature can use this time to
  perform other bootstrapping tasks which do not depend on
  VIB-installation. e.g. VXLAN creates the vmknic-pg and sets up some
  opaque data.
  * Post-VIB install: Prepare each host for the feature. In the case of
  VXLAN, create vmknics.

* **post** *(secured)*: Install network fabric or VXLAN.
___
You install the network infrastructure components in your virtual
environment on a per-cluster level for each vCenter server, which
deploys the required software on all hosts in the cluster. This software
is also referred to as an NSX vSwitch. When a new host is added to this
cluster, the required software is automatically installed on the newly
added host. After the network infrastructure is installed on a cluster,
Logical Firewall is enabled on that cluster.
___
See examples for the following tasks:
* Install Network Virtualization Components
* Configure VXLAN
* Configure VXLAN with LACPv2
* Reset Communication
___
| Name | Comments |
|------|----------|
|**resourceId** | vCenter MOB ID of cluster. For example, domain-7. A host can be specified when resetting communication. For example, host-24. |
|**featureId** | Feature to act upon. Omit for network virtualization components operations. Use *com.vmware.vshield.vsm.vxlan* for VXLAN operations, *com.vmware.vshield.vsm.messagingInfra* for message bus operations.|
|**ipPoolId** | Used for VXLAN installation. If not specified, DHCP is used for VTEP address assignment.|
|**teaming** | Used for VXLAN installation. Options are *FAILOVER_ORDER*, *ETHER_CHANNEL*, *LACP_ACTIVE*, *LACP_PASSIVE*, *LOADBALANCE_LOADBASED*, *LOADBALANCE_SRCID*, *LOADBALANCE_SRCMAC*, *LACP_V2*|
|**uplinkPortName** | The *uplinkPortName* as specified in vCenter.|

* **put** *(secured)*: Upgrade Network virtualization components.
____
This API call can be used to upgrade network virtualization components.
After NSX Manager is upgraded, previously prepared clusters must have
the 6.x network virtualization components installed.

* **delete** *(secured)*: Remove VXLAN or network virtualization components.
___
Removing network virtualization components removes previously
installed VIBs, tears down NSX Manager to ESXi messaging, and removes
any other network fabric dependent features such as logical switches.
If a feature such as logical switches is being used in your
environment, this call fails.
___
Removing VXLAN does not remove the network virtualization components
from the cluster.
___
| Name | Comments |
|------|----------|
|**resourceId** | vCenter MOB ID of cluster. For example, domain-7.|
|**featureId** | Feature to act upon. Omit for network virtualization components operations. Use *com.vmware.vshield.vsm.vxlan* for VXLAN operations.|

### /2.0/nwfabric/features

* **get** *(secured)*: Retrieves all network fabric features available on the cluster. Multiple
**featureInfo** sections may be returned.

### /2.0/nwfabric/status
Working with network fabric status.

* **get** *(secured)*: Retrieve the network fabric status of the specified resource.

### /2.0/nwfabric/status/child/{parentResourceID}
Working with network fabric status of child resources.

* **get** *(secured)*: Retrieve the network fabric status of child resources of the specified resource.

### /2.0/nwfabric/status/alleligible/{resourceType}
Working with status of resources by criterion.

* **get** *(secured)*: Retrieve status of resources by criterion.

### /2.0/nwfabric/clusters/{clusterID}
Working with locale ID configuration for clusters.

* **get** *(secured)*: Retrieve the locale ID for the specified cluster.
* **put** *(secured)*: Update the locale ID for the specified cluster.
* **delete** *(secured)*: Delete locale ID for the specified cluster.

### /2.0/nwfabric/hosts/{hostID}
Working with locale ID configuration for hosts.

* **get** *(secured)*: Retrieve the locale ID for the specified host.
* **put** *(secured)*: Update the locale ID for the specified host.
* **delete** *(secured)*: Delete the locale ID for the specified host.

## securityFabric
Working with Security Fabric
======

### /2.0/si/deploy

* **post** *(secured)*: Deploy security fabric
* **put** *(secured)*: Upgrade service to recent version

### /2.0/si/deploy/service/{serviceID}
Working with a specified service

* **get** *(secured)*: Retrieve all clusters on which the service is installed
* **delete** *(secured)*: Uninstall specified service from specified clusters

### /2.0/si/deploy/service/{serviceID}/dependsOn
Identify service on which the specified service depends on

* **get** *(secured)*: Identify service on which the specified service depends on

### /2.0/si/deploy/cluster/{clusterID}
Working with installed services on a cluster

* **get** *(secured)*: Retrieve all services deployed along with their status
* **delete** *(secured)*: Uninstall a service. Fails if you try to remove a service that another
service depends on

### /2.0/si/deploy/cluster/{clusterID}/service/{serviceID}
Information about a service

* **get** *(secured)*: Retrieve detailed information about the service

## dataSecurityConfiguration
Working with Data Security
=======

### /2.0/dlp/regulation
Data loss prevention regulation

* **get** *(secured)*: Retrieve the list of available regulations for a policy.

### /2.0/dlp/policy/regulations
Enable one or more regulations by putting the regulation IDs into the
policy. You can get the IDs from the output of the dlpRegulation GET call

* **put** *(secured)*: Enable one or more regulations by putting the regulation IDs into the
policy. You can get the IDs from the output of the dlpRegulation GET
call

### /2.0/dlp/classificationvalue
Classification values associated with regulations

* **get** *(secured)*: Get all classification values

### /2.0/dlp/policy/classificationvalues
Configure a customized regex as a classification value

* **put** *(secured)*: Configure a customized regex as a classification value

### /2.0/dlp/excludableareas
Retrieve list of datacenters, clusters, and resource pools that are
excludable from policy inspection

* **get** *(secured)*: Retrieve list of datacenters, clusters, and resource pools that are
excludable from policy inspection

### /2.0/dlp/policy/excludedareas
(DEPRECATED; use PUT /2.0/dlp/policy/excludedsecuritygroups instead)
Exclude areas from policy inspection

* **put** *(secured)*: (DEPRECATED; use PUT /2.0/dlp/policy/excludedsecuritygroups instead)
Exclude areas from policy inspection

### /2.0/dlp/policy/includedsecuritygroups
Include security groups in data security scan

* **get** *(secured)*: Retrieve security groups that have been included in data security scans

* **put** *(secured)*: Include security groups in data security scan

### /2.0/dlp/policy/excludedsecuritygroups
Exclude security groups in data security scan

* **get** *(secured)*: Retrieve security groups that have been excluded from data security
scans

* **put** *(secured)*: Exclude security groups in data security scan

### /2.0/dlp/policy/FileFilters
Configure file filters for scanning

* **put** *(secured)*: Configure file filters for scanning

### /2.0/dlp/policy/saved
Retrieve last saved policy

* **get** *(secured)*: Get saved policy

### /2.0/dlp/policy/published
Retrieve currently published SDD policy

* **get** *(secured)*: Retrieve currently published policy

### /2.0/dlp/policy/publish
After updating a policy with added regulations, excluded areas, or
customized regex values, publish an updated policy to enforce new
parameters

* **put** *(secured)*: Publish the updated policy

### /2.0/dlp/scanop
Start, pause, resume, or stop a data security scan

* **put** *(secured)*: Start, pause, resume, or stop a data security scan

### /2.0/dlp/scanstatus
Retrieve the status of a scan operation

* **get** *(secured)*: Retrieve the status of a scan operation

### /2.0/dlp/scan/current/vms/{ID}
Retrieve information about the vm's being scanned

* **get** *(secured)*: Retrieve information about the vm's being scanned

### /2.0/dlp/completedscansummaries
Retrieve start and end time, total number of vm's scanned, and total
number of violations for the last five completed data security scans

* **get** *(secured)*: Retrieve scan summaries

### /2.0/dlp/scan/{scanID}/detailsascsv
Retrieve report on results of previous scan in CSV format

* **get** *(secured)*: Retrieve ID, Name, Scan status, and Violation counts for VM's scanned
during specified scan

### /2.0/dlp/scan/{scanID}/policyasxml
Retrieve XML representation of the policy used in the previous scan

* **get** *(secured)*: Retrieve XML representation of the policy used in the previous scan

### /2.0/dlp/violations
Query the regulations that have been violated in scans

* **get** *(secured)*: Get violation count for entire inventory

### /2.0/dlp/violations/{contextID}
Get violation count for specific resource

* **get** *(secured)*: Get violation count for specific resource

### /2.0/dlp/violatingfiles
Get violating files and the regulations each file violated

* **get** *(secured)*: Get violating files and the regulations each file violated

### /2.0/dlp/violatingfiles/{contextID}
Get violating files for a resource

* **get** *(secured)*: Get violating files for a resource

### /2.0/dlp/violatingfilesascsv
Display the violating files and the regulations each file violated in CSV
format

* **get** *(secured)*: Display the violating files and the regulations each file violated in
CSV format

### /2.0/dlp/violatingfilesascsv/{contextID}
Get violated regulations and violating files for the resource in CSV
format

* **get** *(secured)*: Get violated regulations and violating files for the resource in
CSV format

## eventControl
Working with Data Collection for Activity Monitoring
===========

### /1.0/eventcontrol/vm/{vmID}/request
Working With Data Collection on a Specific Virtual Machine
----

* **post** *(secured)*: Enable or disable data collection on a virtual machine

### /1.0/eventcontrol/eventcontrol-root/request
Working with the Data Collection Kill Switch
----

* **post** *(secured)*: Turn on/off data collection at global level

### /1.0/eventcontrol/config/vm/{vmID}
Retrieve Data Collection Configuration
-----

* **get** *(secured)*: Retrieve per vm configuration for data collection

## activityMonitoring
Working with Activity monitoring
======

### /3.0/ai/records
Get aggregated user activity (action records) using parameters. Requires
vShield Endpoint and NSX Endpoint configured, and Data collection enabled
on 1+ vm's

* **get** *(secured)*: Get aggregated user activity

### /3.0/ai/userdetails
Retrieve user detail records in accordance with given query parameters

* **get** *(secured)*: Retrieve user detail records in accordance with given query parameters

### /3.0/ai/user/{userID}
Retrieve details for a specific user

* **get** *(secured)*: Retrieve details for a specific user

### /3.0/ai/app
Retrieve app details

* **get** *(secured)*: Retrieve app details

### /3.0/ai/app/{appID}
Retrieve details for specific app

* **get** *(secured)*: Retrieve details for specific app

### /3.0/ai/host
Host details

* **get** *(secured)*: Retrieve list of all discovered hosts (both by agent introspection and
LDAP Sync) and their detail

### /3.0/ai/host/{hostID}
Specific host details

* **get** *(secured)*: Get host details

### /3.0/ai/desktoppool
Desktop pool details

* **get** *(secured)*: Retrieve list of all discovered desktop pools by agent introspection

### /3.0/ai/desktoppool/{desktoppoolID}
Specific desktop pool details

* **get** *(secured)*: Retrieve specific desktop pool details

### /3.0/ai/vm
Virtual machine details

* **get** *(secured)*: Retrieve list of all discovered vm's

### /3.0/ai/vm/{vmID}
Specific VM details

* **get** *(secured)*: Retrieve details about a specific virtual machine

### /3.0/ai/directorygroup
LDAP directory group details

* **get** *(secured)*: Retrieve list of all discovered (and configured) LDAP directory groups

### /3.0/ai/directorygroup/{directorygroupID}
Specific directory group details

* **get** *(secured)*: Retrieve details about a specific directory group

### /3.0/ai/directorygroup/user/{userID}
AD groups that a user belongs to

* **get** *(secured)*: Retrieve AD groups that user belongs to

### /3.0/ai/securitygroup
Security group details

* **get** *(secured)*: Retrieve list of all observed security groups

### /3.0/ai/securitygroup/{secgroupID}
Specific security group details

* **get** *(secured)*: Retrieve details about specific security group

## domain
Working with Domains
===========

### /1.0/directory/updateDomain
Updating Domains
---------------

* **post** *(secured)*: Register or update a domain with NSX Manager

### /1.0/directory/listDomains
Retrieve LDAP Domains
---

* **get** *(secured)*: Retrieve all agent discovered (or configured) LDAP domains

### /1.0/directory/deleteDomain/{ID}
Delete a Specific Domain
----

* **delete** *(secured)*: Delete domain

### /1.0/directory/directory
Working with LDAP Servers and EventLog Servers
----

### /1.0/directory/directory/updateLdapServer
Create LDAP Server
----

* **post** *(secured)*: Create LDAP server.

### /1.0/directory/directory/listLdapServersForDomain/{domainID}
Query LDAP Servers for a Domain
----

* **get** *(secured)*: Query LDAP servers for a domain

### /1.0/directory/directory/fullSync/{domainID}
Start LDAP Full Sync
----

* **put** *(secured)*: Start LDAP full sync.

### /1.0/directory/directory/deltaSync/{domainID}
Start LDAP Delta Sync
-----

* **put** *(secured)*: Start LDAP delta sync.

### /1.0/directory/directory/deleteLdapServer/{serverID}
Delete LDAP Server
----

* **delete** *(secured)*: Delete LDAP server.

### /1.0/directory/directory/updateEventLogServer
EventLog Server
----

* **post** *(secured)*: Create EventLog server

### /1.0/directory/directory/listEventLogServersForDomain/{domainID}
Working with EventLog Servers for a Domain
----

* **get** *(secured)*: Query EventLog servers for a domain

### /1.0/directory/directory/deleteEventLogServer/{serverID}
Delete EventLog server

* **delete** *(secured)*: Delete EventLog server

## mappingLists
Working with Mapping Lists
=========

### /1.0/identity/userIpMapping
Query user-to-ip mapping list from database

* **get** *(secured)*: Query user-to-ip mapping list from database

### /1.0/identity/hostIpMapping
Query host-to-ip mapping list from database

* **get** *(secured)*: Query host-to-ip mapping list from database

### /1.0/identity/ipToUserMapping
Query set of users associated with a given set of Ip addresses

* **get** *(secured)*: Query set of users associated with a given set of Ip addresses

### /1.0/identity/directoryGroupsForUser/{userID}
Query set of Windows Domain Groups (AD Groups) to which the specified
user belongs

* **get** *(secured)*: Query set of Windows Domain Groups (AD Groups) to which the specified
user belongs

### /1.0/identity/staticUserMapping/{userID}/{IP}
Create static user IP mapping

* **post** *(secured)*: Create static user IP mapping

### /1.0/identity/staticUserMappings
Query static user IP mapping list

* **get** *(secured)*: Query static user IP mapping list

### /1.0/identity/staticUserMappingsbyUser/{userID}
Query static user IP mapping for specified user

* **get** *(secured)*: Query static user IP mapping for specified user
* **delete** *(secured)*: Delete static user IP mapping for specified user

### /1.0/identity/staticUserMappingsbyIP/{IP}
Query static user IP mapping for specified IP

* **get** *(secured)*: Query static user IP mapping for specified IP
* **delete** *(secured)*: Delete static user IP mapping for specified IP

## activityMonitoringSyslog
Working with Activity Monitoring Syslog Support
==========

### /1.0/sam/syslog/enable
Enable Syslog Support

* **post** *(secured)*: Enable syslog support.

### /1.0/sam/syslog/disable
Disable Syslog Support
----

* **post** *(secured)*: Disable syslog support.

## solutionIntegration
Working with Solution Integrations
=========

### /2.0/si/host/{hostID}/agents
Agents on a specified host

* **get** *(secured)*: Retrieve all agents on the host

### /2.0/si/agent/{agentID}
Agent details (host components and appliances)

* **get** *(secured)*: Retrieve agent details

### /2.0/si/deployment/{deploymentunitID}/agents
Agents for a specified deployment

* **get** *(secured)*: Retrieve all agents for the specified deployment

### /2.0/si/fabric/sync/conflicts
Working with conflicting agencies

* **get** *(secured)*: Retrieve conflicting Deployment Units and EAM Agencies, if any, and the
allowed operations on them

* **put** *(secured)*: Create deployment units for conflicting EAM Agencies, delete
conflicting EAM agencies, or delete deployment units for conflicting
EAM agencies

## macsets
Working with MAC Sets
=============

### /2.0/services/macset/{macsetId}
Operations on an individual MAC set

* **get** *(secured)*: Retrieve details about a MAC set
* **put** *(secured)*: Modify an existing MAC set.
* **delete** *(secured)*: Delete a MAC set

### /2.0/services/macset/scope/{scopeId}
Working with MAC Sets.

* **post** *(secured)*: Create a MACset on a specified scope
* **get** *(secured)*: List MACsets created on a specified scope

## taskFramework
Working with the Task Framework
======
Working with filtering criteria and paging information for jobs on the task
framework

### /2.0/services/taskservice/job

* **get** *(secured)*: Query job instances by criterion

### /2.0/services/taskservice/job/{jobId}
Job instances on the task framework

* **get** *(secured)*: Retrieve all job instances for the specified job ID

## guestIntrospection
Working with Guest Introspection and Third-party Endpoint Protection (Anti-virus) Solutions
============

About Guest Introspection and Endpoint Protection Solutions
----------
VMware's Guest Introspection Service enables vendors to deliver an introspection-based, endpoint protection (anti-virus) solution
that uses the hypervisor to scan guest virtual machines from the outside, with only a thin agent on each guest virtual machine.

Version Compatibility
-----------

**Note:** The management APIs listed in this section are to be used only with partner endpoint protection solutions
that were developed with EPSec Partner Program 3.0 or earlier (for vShield 5.5 or earlier).
These partner solutions are also supported on NSX 6.0 and need the APIs listed below.
These APIs should not be used with partner solutions developed specifically for NSX 6.0 or later, as
these newer solutions automate the registration and deployment process by using the new features introduced in NSX.
Using these with newer NSX 6.0 based solutions could result in loss of features.

Register a Solution
----------

To register a third-party solution with Guest Introspection, clients can use four REST calls to do the following:
1. Register the vendor.
2. Register one or more solutions.
3. Set the solution IP address and port (for all hosts).
4. Activate registered solutions per host.

**Note:** Steps 1 through 3 need to be performed once per solution. Step 4 needs to be performed for each host.

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

* **post** *(secured)*: Register the vendor of an endpoint protection solution. Specify the following parameters in the request.

| Name            | Comments |
|-----------------|------------|
|**vendorId**     | VMware-assigned ID for the vendor. |
|**vendorTitle**  | Vendor-specified title. |
|**vendorDescription** | Vendor-specified description. |

### /2.0/endpointsecurity/registration/vendors
Registered Guest Introspection vendors

* **get** *(secured)*: Retrieve the list of all registered Guest Introspection vendors.

### /2.0/endpointsecurity/registration/{vendorID}
Guest Introspection vendors and endpoint protection solutions

* **post** *(secured)*: Register an endpoint protection solution. Specify the following parameters in the request.

| Name            | Comments |
|-----------------|------------|
|**solutionAltitude**     | VMware-assigned altitude for the solution. *Altitude* is a number that VMware assigns to uniquely identify the solution. The altitude describes the type of solution and the order in which the solution receives events relative to other solutions on the same host. |
|**solutionTitle**  | Vendor-specified title for the solution. |
|**solutionDescription** | Vendor-specified description of the solution. |

* **get** *(secured)*: Retrieve registration information for a Guest Introspection vendor.
* **delete** *(secured)*: Unregister a Guest Introspection vendor.

### /2.0/endpointsecurity/registration/{vendorID}/solutions
Information about registered endpoint protection solutions

* **get** *(secured)*: Get registration information for all endpoint protection solutions for a Guest Introspection vendor.

### /2.0/endpointsecurity/registration/{vendorID}/{altitude}
Endpoint protection solution registration information

* **get** *(secured)*: Get registration information for an endpoint protection solution.
* **delete** *(secured)*: Unregister an endpoint protection solution.

### /2.0/endpointsecurity/registration/{vendorID}/{altitude}/location
IP address and port for an endpoint protection solution.

To change the location of an endpoint protection solution:
1. Deactivate all security virtual machines.
2. Change the location.
3. Reactivate all security virtual machines.

* **post** *(secured)*: Set the IP address and port on the vNIC host for an endpoint protection solution.
* **get** *(secured)*: Get the IP address and port on the vNIC host for an endpoint protection solution.
* **delete** *(secured)*: Unset the IP address and port for an endpoint protection solution.

### /2.0/endpointsecurity/activation
Activate an Endpoint Protection Solution.

* **get** *(secured)*: Retrieve activation information for all activated security VMs on the specified host.

### /2.0/endpointsecurity/activation/{vendorID}/{solutionID}
Activated security virtual machines

* **get** *(secured)*: Retrieve a list of activated security VMs for an endpoint protection solution.

### /2.0/endpointsecurity/activation/{vendorID}/{altitude}
Activate a registered endpoint protection solution.

* **post** *(secured)*: Activate an endpoint protection solution that has been registered and located. Specify the following parameter in the request body.

| Name            | Comments |
|-----------------|------------|
|**svmMoid**     | Managed object ID of the virtual machine of the activated endpoint protection solution. |

### /2.0/endpointsecurity/activation/{vendorID}/{altitude}/{moid}
Get the activation status or deactivate an endpoint protection solution on a host.

* **get** *(secured)*: Retrieve the endpoint protection solution activation status, either true (activated) or false (not activated).
* **delete** *(secured)*: Deactivate an endpoint protection solution on a host.

## dfw
Working with Distributed Firewall
=================================

### /4.0/firewall/globalroot-0/config
Distributed firewall rules configuration
___
The following table lists the elements that can be used in firewall
rules.
___
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
| MAC set | MACSet | source/destination |
| network | Network | for legacy portgroups, network can be used in source or destination instead of appliedTo |
| profile | ALL_PROFILE_BINDINGS | |
| resource pool | ResourcePool | source/destination |
| security group | SecurityGroup | source/destination |
| virtual app | VirtualApp | source/destination |
| virtual machine | VirtualMachine | source/destination<br>appliedTo |
| vNIC | Vnic | source/destination<br>appliedTo |

* **get** *(secured)*: Retrieve distributed firewall rule configuration.
___
If no query parameters are used, all rule configuration is retrieved.
Use the query parameters to filter the rule configuration information.

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

* **delete** *(secured)*: Restore default configuration.
___
Restores a configuration with one defaultLayer3 section with default
allow rule and one defaultLayer2Section with default allow rule.

### /4.0/firewall/globalroot-0/config/layer3sections
Working with layer 3 sections in distributed firewall.

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

* **get** *(secured)*: Retrieve rules from the layer 3 section specified by section
**name**.

* **post** *(secured)*: Create a layer 3 distributed firewall section.
___
By default, the section is created at the top of the firewall table.
You can specify a location for the section with the **operation**
and **anchorId** query parameters.

### /4.0/firewall/globalroot-0/config/layer3sections/{sectionId}
Working with a specific layer 3 distributed firewall section.

* **get** *(secured)*: Retrieve information about the specified layer 3 section.
* **post** *(secured)*: Move the specified layer 3 section.
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

* **delete** *(secured)*: Delete the specified layer 3 distributed firewall section.

### /4.0/firewall/globalroot-0/config/layer3sections/{sectionId}/rules
Working with distributed firewall rules in a layer 3 section.

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
Operations on L3 rules in sections identified by section Id and
Rule Id

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
Working with layer 2 sections in distributed firewall.

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

* **get** *(secured)*: Retrieve rules from the layer 2 section specified by section
**name**.

* **post** *(secured)*: Create a layer 2 distributed firewall section.
___
By default, the section is created at the top of the firewall table.
You can specify a location for the section with the **operation**
and **anchorId** query parameters.

### /4.0/firewall/globalroot-0/config/layer2sections/{sectionId}
Working with a specific layer 2 distributed firewall section.

* **get** *(secured)*: Retrieve information about the specified layer 2 section.
* **post** *(secured)*: Move the specified layer 2 section.
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

* **delete** *(secured)*: Deletes a L2 section and its content by ID

### /4.0/firewall/globalroot-0/config/layer2sections/{sectionId}/rules
Working with distributed firewall rules in a layer 2 section.

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
Operations on L2 rules in sections identified by section Id and
Rule Id

* **get** *(secured)*: Read the configuration of a specific rule identified by rule Id

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
Layer3 redirect sections and rules

* **post** *(secured)*: Add L3 redirect section

### /4.0/firewall/globalroot-0/config/layer3redirectsections/{section}
Layer3 redirect section

* **get** *(secured)*: Get L3 redirect section configuration
* **put** *(secured)*: Modify L3 Redirect section. You will need to get the Etag value out
of the GET first. Then pass the modified version of the whole
redirect section configuration in the GET body

* **delete** *(secured)*: Delete specified L3 redirect section

### /4.0/firewall/globalroot-0/config/layer3redirectsections/{section}/rules
L3 redirect rules for specified section

* **post** *(secured)*: Add L3 redirect rule

### /4.0/firewall/globalroot-0/config/layer3redirectsections/{section}/rules/{ruleID}
Rule for specified section

* **get** *(secured)*: Get L3 redirect rule
* **put** *(secured)*: Modify L3 redirect rule. You will need Etag value from the
response header of GET call. Then, pass Etag value as the
if-match header in PUT call

* **delete** *(secured)*: Delete specified L3 redirect rule

### /4.0/firewall/globalroot-0/config/layer3redirect/profiles
Service Insertion profiles that can be applied to layer3 redirect rules

* **get** *(secured)*: Retrieve the Service Insertion profiles

### /4.0/firewall/globalroot-0/state
Enable distributed firewall after upgrade.
___
After upgrading NSX Manager, controllers, and network virtualization
components, check the status of distributed firewall. If it is ready to
enable, you can enable distributed firewall.
___
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
Working with Distributed Firewall Status
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
Working with Layer 3 Section Status

* **get** *(secured)*: Retrieve status of the last publish action for the specified layer 3 section.

**Method history:**

Release | Modification
--------|-------------
6.2.4 | Method updated. Parameter **generationNumberObjects** added. Clusters not configured for firewall are excluded from the status output.

### /4.0/firewall/globalroot-0/status/layer2sections/{sectionID}
L2 section status

* **get** *(secured)*: Retrieve status of the last publish action for the specified layer 2 section.

**Method history:**

Release | Modification
--------|-------------
6.2.4 | Method updated. Parameter **generationNumberObjects** added. Clusters not configured for firewall are excluded from the status output.

### /4.0/firewall/globalroot-0/drafts
Import and export firewall configurations

* **post** *(secured)*: Save a firewall configuration
* **get** *(secured)*: Displays the draft IDs of all saved configurations

### /4.0/firewall/globalroot-0/drafts/{draftID}
Specified saved firewall configuration

* **get** *(secured)*: Get a saved firewall configuration
* **put** *(secured)*: Update a saved firewall configuration
* **delete** *(secured)*: Delete a configuration

### /4.0/firewall/globalroot-0/drafts/{draftID}/action/export
Export a configuration

* **get** *(secured)*: Export a configuration

### /4.0/firewall/globalroot-0/drafts/{draftID}/action/import
Import a configuration

* **post** *(secured)*: Import a configuration

### /4.0/firewall/stats/eventthresholds
Configure memory, CPU, and connections per second (CPS) thresholds for
distributed firewall.
___
The firewall module generates system events when the memory and CPU
usage crosses these thresholds.

* **get** *(secured)*: Retrieve threshold configuration for distributed firewall.

* **put** *(secured)*: Update threshold configuration for distributed firewall.

### /4.0/firewall/config/globalconfiguration
Working with the Distributed Firewall Global Configuration
----------------------------------------------------------
You can use the following parameters to improve firewall performancer:

* **layer3RuleOptimize** and **layer2RuleOptimize** to turn
on/off rule optimization.
* **tcpStrictOption** determines whether or not to drop an established
TCP connection when the firewall does not see the initial three-way
handshake. If set to true, the connection will be dropped.
* **autoDraftDisabled** improves performances when making large numbers
of changes to firewall rules.

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
* **put** *(secured)*: Update the distributed firewall performance configuration.

### /4.0/firewall/forceSync/{ID}
Synchronize hosts and clusters with the last good configuration in NSX
Mgr database

* **post** *(secured)*: Force sync host/cluster

### /4.0/firewall/{domainID}/enable/{truefalse}
Enable or disable firewall components on a cluster

* **post** *(secured)*: Enable or disable firewall components on a cluster

### /4.0/firewall/{contextId}/config/ipfix
Export specific flows directly from firewall to a flow collector

* **get** *(secured)*: Query IPFix configuration
* **put** *(secured)*: Configure IPFix
* **delete** *(secured)*: Deleting IPFix configuration resets the config to default values

## spoofGuardPolicies
Working with SpoofGuard Policies
====================

### /4.0/services/spoofguard/policies

* **post** *(secured)*: Create a SpoofGuard policy to specify the operation mode for networks.

* **get** *(secured)*: Retrieve all SpoofGuard policies

### /4.0/services/spoofguard/policies/{policyID}
Specified policy

* **post** *(secured)*: Use query parameters to perform operations on a policy
* **get** *(secured)*: Retrieve policy information, or use the query parameters to perform
operations

* **put** *(secured)*: Modify SpoofGuard policy
* **delete** *(secured)*: Delete a policy

## flowMonitoring
Working with Flow Monitoring
========

### /2.1/app/flow/flowstats
Retrieve flow monitoring statistics information.

* **get** *(secured)*: Retrieve flow statistics for a datacenter, port group, VM, or vNIC
___
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
  * 0 - to virtual machine
  * 1 - from virtual machine
* **controlDirection** - control direction for dynamic TCP traffic:
  * 0 - source -> destination
  * 1 - destination -> source

### /2.1/app/flow/flowstats/info
Working with flow monitoring meta-data.

* **get** *(secured)*: Retrieve flow statistics meta-data.
___
This method retrieves the following information for each flow type:
* minimum start time
* maximum end time
* total flow count

### /2.1/app/flow/config
Working with flow monitoring configuration.
___
Flow records generated on all hosts are sent to NSX Manager, which
consumes the records and displays aggregated information.  Hosts can
generate large numbers of flow records.  You can configure flow
monitoring to exclude certain records from collection.  The flow
configuration applies to all hosts.
___
* **collectFlows** - if true, flow collection is enabled.
* **ignoreBlockedFlows** - if true, ignore blocked flows.
* **ignoreLayer2Flows** - if true, ignore layer 2 flows.
* **sourceIPs** - source IPs to exclude. For example: 10.112.3.14, 10.112.3.15-10.112.3.18,192.168.1.1/24.
* **sourceContainer** - source containers to exclude. Containers can contain VM, vNic, IP Set, MAC Set.
* **destinationIPs** - destination IPs to exclude.
* **destinationContainer** - destination containers to exclude. Containers can contain VM, vNic, IP Set, MAC Set.
* **destinationPorts** - destination ports to exclude.
* **serviceContainers** - service containers to exclude. Container can contain application or application group.
___
Flow exclusion happens at the host. The following flows are discarded by default:
* Broadcast IP (255.255.255.255)
* Local multicast group (224.0.0.0/24)
* Broadcast MAC address (FF:FF:FF:FF:FF:FF)

* **get** *(secured)*: Retrieve flow monitoring configuration
* **put** *(secured)*: Update flow monitoring configuration

### /2.1/app/flow/{contextId}
Flow configuration by contextId

* **delete** *(secured)*: Delete flow records for the specified context.

## dfwExclusion
Exclude Virtual Machines from Firewall Protection
=========

### /2.1/app/excludelist

* **get** *(secured)*: Retrieve the set of vm's in the exclusion list

### /2.1/app/excludelist/{memberID}
Exclude VM's from firewall protection

* **put** *(secured)*: Add a vm to the exclusion list
* **delete** *(secured)*: Delete a vm from exclusion list

## nsxEdges
Working with NSX Edge
=======

### /4.0/edges

* **post** *(secured)*: Install NSX Edge services gateway or logical router, depending on request
body.
___
The NSX Edge installation API copies the NSX Edge OVF from the Edge
Manager to the specified datastore and deploys an NSX Edge on the given
datacenter. After the NSX Edge is installed, the virtual machine powers
on and initializes according to the given network configuration. If an
appliance is added, it is deployed with the specified configuration.
___
Installing an NSX Edge instance adds a virtual machine to the vCenter
Server inventory, you must specify an IP address for the management
interface, and you may name the NSX Edge instance.
___
The configuration you specify when you install an NSX Edge is stored in
the database. If an appliance is added, the configuration is applied to
it and it is deployed.
___
NOTE: Do not use hidden/system resource pool IDs as they are not
supported on the UI.
___
Request body paramaters:
  * **name** - Optional. Default is *vShield-<edgeId>*. Used as a vm name
    on VC appended by "-<haIndex>"
  * **description** - Optional. A text string that describes the object.
  * **tenant** - Optional. Will be used in syslog messages.
  * **fqdn** - Optional. Defaut is *vshield-<edgeId>*. Used to set
    hostanme on the vm. Appended by *-<haIndex>*
  * **vseLogLevel** - Optional. Default is *INFO*. Other possible values:
      * *EMERGENCY*
      * *ALERT*
      * *CRITICAL*
      * *ERROR*
      * *WARNING*
      * *NOTICE*
      * *DEBUG*
  * **enableAesni** - Optional. Default is true.
  * **enableFips** - Optional. Default is false.
  * **appliances** - A maximum 2 appliances can be configured. Until one
    appliance is configured, none of the configured features configured
    will serve the network.
  * **applianceSize** - Optional. Default is *compact*. Possible values:
    * *compact*
    * *large*
    * *xlarge*
    * *quadlarge*
  * **enableCoreDump** - Optional. Default is false. Enabling core-dump
    will deploy an extra disk for core-dump files, which will consume
    1GB for COMPACT, LARGE, and QUADLARGE, and 8G for XLARGE Edge.
  * **vnics** - Mamimum 10 interfaces index 0-9 can be configured. Until
    one connected vnic is configured, none of the configured features
    will serve the network.
    * **name** - Optional. System has default Names. Format vNic0 ...
      vNic7.
    * **type** - Optional. Default is internal. Other possible value is
      "uplink".
    * **portgroupId* - Possible values here are portgroupIds or
      virtualWire-id. **portgroupId** needs to be defined if
      **isConnected**=*true*.
    * **addressGroups** - Supports one or more addressGroup except on the
      Edge used for the distributed router which can only have a primary
      IP address.
      * **addressGroup** - Vnic can be configured to have more than one
        addressGroup/subnets.
        * **primaryAddress** - This is mandatory for an **addressGroup**.
          May be either IPv4 of IPv6.
        * **secondaryAddresses** - Optional. Should be used to add/define
          other IPs used for NAT, LB, VPN, etc..
          * **ipAddress** - Optional. One or more can be provided.
            This way multiple IP Addresses can be assigned to a
            vnic/interface. May be eitehr IPv4 or IPv6.
        * **subnetMask** - Either **subnetMask** or **subnetPrefixLength**
          should be provided. If both then **subnetprefixLength** is
          ignored.
        * **subnetPrefixLength** - CIDR format style number of bits.
          Possible values are 1 - 32 for IPv4 or 1 - 128 for IPv6.
    * **macAddress** - Optional. When not specified, **macAddresses**
      will be managed by vCenter.
      * **edgeVmHaIndex**
        * **value** - Optional. User must ensure that **macAddresses**
        provided are unique withing the given layer 2 domain.
    * **fenceParameter** - Optional
        * **key** - Example *ethernet0.filter1.param1*
        * **value** - Example 1
    * **mtu** - Optional. Default is 1500.
    * **enableProxyArp** - Optional. Default is false.
    * **enableSendRedirects** - Optional. Default is true.
    * **isConnected** - Optional. Default is false.
    * **inShapingPolicy** - Optional
      * **averageBandwidth** - Example 200000000
      * **peakBandwidth** - Example 200000000
      * **burstSize>** - Example 0
      * **enabled** - Value can be *true* or *false*.
      * **inherite** - Value can be *true* or *false*.
    * **outShapingPolicy -Optional
      * **averageBandwidth** - Example 400000000
      * **peakBandwidth** - Example 400000000
      * **burstSize** - Example 0
      * **enabled** - Value can be *true* or *false*.
  * **cliSettings** - Optional. Default user/pass is admin/default, and
      remoteAccess is false (i.e. disabled).
    * **userName** - When you change the **userName** you are overwriting
      the current **userName**.
    * **password** - The password should be at least 12 characters long,
      must be a mix of alphabets, digits and special characters. Must
      contain at-least 1 uppercase, 1 lowercase, 1 special character and
      1 digit. In addition, a character cannot be repeated 3 or more
      times consectively.
    * **remoteAccess** - The **RemoteAccess** property specifies whether
      the CLI console access via SSH isenabled. Relevant firewall rules
      to allow traffic on port 22 must be opened by user/client. Please
      note that it is advisable to restrict SSH access to Edge CLI to
      only a limited IP addresses - firewall rules must be opened
      cautiously.
  * **autoConfiguration** - Optional.
    * **enabled** - Optional. Default is *true*. If set to *false*, user
      should add the nat, firewall, routing config to control plane work
      for LB, VPN, etc..
    * **rulePriority** - Optional. Default is *high*. Other possible
      value is *low*.
  * **dnsClient** - Optional. If the primary/secondary are specified and
    the DNS service not, the primary/secondary will to used as the
    default of the DNS service.
    * **primaryDns** - The IPv4 address of the primary DNS server.
    * **secondaryDns** - The IPv4 address of the secondary DNS server.
    * **domainName** - The domain name used for the DNS resolver.
  * **queryDaemon** - Optional. Defined for the sake of communication
    between SLB VM and edge vm for GSLB feature.
    * **enabled** - Default to *false*.
    * **port** - Default to 5666.

* **get** *(secured)*: Retrieve a list of NSX Edges in your inventory or use the query
parameters to filter results by datacenter or port group

### /4.0/edges/{edgeId}
NSX Edge operations

* **post** *(secured)*: Manage NSX Edge
* **get** *(secured)*: Retrieve Edge details
* **put** *(secured)*: Update the NSX Edge configuration
* **delete** *(secured)*: Delete specified Edge from database. Associated appliances are also
deleted

### /4.0/edges/{edgeId}/dnsclient
DNS settings (primary/secondary and search domain) of an Edge

* **put** *(secured)*: Update Edge DNS settings

### /4.0/edges/{edgeId}/aesni
AESNI Setting

* **post** *(secured)*: Modify AESNI setting

### /4.0/edges/{edgeId}/coredump
Enabling core-dump feature results in deployment of inbuilt extra disk
to save core-dump files. 1GB for compact edge and 8GB for other types.
Disabling detaches the disk

* **post** *(secured)*: Modify core dump setting

### /4.0/edges/{edgeId}/fips
FIPs setting

* **post** *(secured)*: Modify FIPs setting

### /4.0/edges/{edgeId}/logging
Log setting

* **post** *(secured)*: Modify log setting

### /4.0/edges/{edgeId}/summary
Edge summary

* **get** *(secured)*: Retrieve details about the specified Edge

### /4.0/edges/{edgeId}/status
Edge status

* **get** *(secured)*: Retrieve the status of the specified Edge

### /4.0/edges/{edgeId}/techsupportlogs
Tech support logs for specified Edge

* **get** *(secured)*: Retrieve the tech support logs for Edge

### /4.0/edges/{edgeId}/clisettings
Manage CLI credentials and access

* **put** *(secured)*: Modify CLI credentials and enable/disable SSH for Edge

### /4.0/edges/{edgeId}/cliremoteaccess
Enable or disable SSH on the Edge

* **post** *(secured)*: Change CLI remote access

### /4.0/edges/{edgeId}/firewall/config
Configure firewall for an Edge

* **get** *(secured)*: Read the firewall configuration
* **put** *(secured)*: Configure firewall for an Edge
* **delete** *(secured)*: Delete firewall configuration

### /4.0/edges/{edgeId}/firewall/config/rules
Firewall rules

* **post** *(secured)*: Add one or more rules. You can add a rule above a specific rule
using the query parameter, indicating the desired ruleID.

### /4.0/edges/{edgeId}/firewall/config/rules/{ruleId}
Specific firewall rule

* **get** *(secured)*: Retrieve specific rule
* **put** *(secured)*: Modify a specific firewall rule
* **delete** *(secured)*: Delete firewall rule

### /4.0/edges/{edgeId}/firewall/config/global
NSX Edge global firewall configuration

* **get** *(secured)*: Retrieve the firewall default policy for an Edge
* **put** *(secured)*: Configure firewall global config for an Edge

### /4.0/edges/{edgeId}/firewall/config/defaultpolicy
Default firewall policy for an Edge

* **get** *(secured)*: Retrieve default firewall policy
* **put** *(secured)*: Configure default firewall policy

### /4.0/edges/{edgeId}/firewall/statistics/firewall
Edge firewall statistics

* **get** *(secured)*: Retrieve number of ongoing connections for the firewall config

### /4.0/edges/{edgeId}/firewall/statistics/{ruleId}
Statistics for firewall rules

* **get** *(secured)*: Retrieve stats for firewall rule

### /4.0/edges/{edgeId}/nat/config
SNAT and DNAT rules for NSX Edge

* **put** *(secured)*: Configure SNAT and DNAT rules for an Edge
* **get** *(secured)*: Query SNAT and DNAT rules for an Edge
* **delete** *(secured)*: Delete all NAT rules for an Edge

### /4.0/edges/{edgeId}/nat/config/rules
NAT rules

* **post** *(secured)*: Add a NAT rule above a specific rule in the NAT rules table
(using aboveRuleId) or append NAT rules to the bottom

### /4.0/edges/{edgeId}/nat/config/rules/{ruleID}
Specified NAT rule

* **put** *(secured)*: Modify a NAT rule
* **delete** *(secured)*: Delete a NAT rule

### /4.0/edges/{edgeId}/routing/config
Static and dynamic routing for each NSX Edge

* **get** *(secured)*: Retrieve routes
* **put** *(secured)*: Configure globalConfig, staticRouting, OSPG, BGP, and IS-IS
* **delete** *(secured)*: Delete the routing config stored in the NSX Mgr database and the default routes from the specified NSX Edge appliance

### /4.0/edges/{edgeId}/routing/config/global
Global configuration

* **put** *(secured)*: Configure global route
* **get** *(secured)*: Retrieve routing info from NSX Mgr database (default route
settings, static route configurations)

### /4.0/edges/{edgeId}/routing/config/static
Static and default routes for specified Edge

* **get** *(secured)*: Read static and default routes
* **put** *(secured)*: Configure static and default routes
* **delete** *(secured)*: Delete both static and default routing config stored in the NSX
Mgr database

### /4.0/edges/{edgeId}/routing/config/ospf
OSPF Routing for NSX Edge

* **get** *(secured)*: Query OSPF config
* **put** *(secured)*: Configure OSPF
* **delete** *(secured)*: Delete OSPF routing

### /4.0/edges/{edgeId}/routing/config/isis
IS-IS Routes for NSX Edge

* **get** *(secured)*: Query ISIS
* **put** *(secured)*: Config ISIS
* **delete** *(secured)*: Delete ISIS routing

### /4.0/edges/{edgeId}/routing/config/bgp
Manage BGP routes for NSX Edge

* **get** *(secured)*: Query BGP
* **put** *(secured)*: Configure BGP
* **delete** *(secured)*: Delete BGP Routing

### /4.0/edges/{edgeId}/bridging/config
Working with L2 bridging

* **get** *(secured)*: Retrieve bridge configuration
* **put** *(secured)*: Configure a bridge
* **delete** *(secured)*: Delete bridges

### /4.0/edges/{edgeId}/loadbalancer/config
NSX Edge load balancer

* **get** *(secured)*: Get current load balancer config
* **put** *(secured)*: Configure load balancer
* **delete** *(secured)*: Delete load balancer configuration

### /4.0/edges/{edgeId}/loadbalancer/config/applicationprofiles
Application profiles define the behavior of a particular type of
network traffic

* **post** *(secured)*: Add an application profile
* **get** *(secured)*: Retrieve all application profiles on Edge
* **delete** *(secured)*: Delete all application profiles

### /4.0/edges/{edgeId}/loadbalancer/config/applicationprofiles/{appProfileID}
Modify or retrieve an application profile

* **put** *(secured)*: Modify an application profile
* **get** *(secured)*: Retrieve an application profile
* **delete** *(secured)*: Delete an application profile

### /4.0/edges/{edgeId}/loadbalancer/config/applicationrules
Manage application rules that directly manipulate and manage IP app
traffic

* **post** *(secured)*: Add an application rule
* **get** *(secured)*: Read all application rules
* **delete** *(secured)*: Delete all application rules

### /4.0/edges/{edgeId}/loadbalancer/config/applicationrules/{appruleID}
Application rule

* **get** *(secured)*: Retrieve an application rule
* **put** *(secured)*: Modify an app rule
* **delete** *(secured)*: Delete an application rule

### /4.0/edges/{edgeId}/loadbalancer/config/monitors
Load balancer monitors define health check parameters for a
particular type of network traffic

* **post** *(secured)*: Add a load balancer monitor
* **get** *(secured)*: Retrieve all load balancer monitors
* **delete** *(secured)*: Delete all load balancer monitors

### /4.0/edges/{edgeId}/loadbalancer/config/monitors/{monitorID}
Specific load balancer monitor

* **get** *(secured)*: Retrieve a load balancer monitor
* **put** *(secured)*: Modify a load balancer monitor
* **delete** *(secured)*: Delete a load balancer monitor

### /4.0/edges/{edgeId}/loadbalancer/config/virtualservers
Working with virtual servers.

* **post** *(secured)*: Add a virtual server.
___
You can add an NSX Edge internal or uplink interface as a virtual
server.
___
| Name | Required | Comments |
|----------------|----------|----------|
| **name** | yes | |
| **description** | no | |
| **enabled** | no | default is true |
| **ipAddress** | yes | |
| **protocol** | yes | Possible values are *HTTP*, *HTTPS*, *TCP*, or *UDP*.|
| **port** | yes | A single port, a comma separate list, a range, or a combination. For example, *443,6000-7000*. |
| **connectionLimit** | no | Maximum concurrent connections |
| **connectionRateLimit** | no | Maximum incoming new connection requests per second |
| **defaultPoolId** | no | The default backend server pool identifier |
| **applicationProfileId** | no | The application profile identifier |
| **accelerationEnabled** | no | Use the faster L4 load balancer engine rather than L7 load balancer engine. <br>**Note:**  If a virtual server configuration such as application rules, HTTP type, or cookie persistence, is using the L7 load balancer engine, then the L7 load balancer engine is used, even if **accelerationEnabled** is not set to true.|
| **applicationRuleId** | no | The application rule identifier list |
___

* **get** *(secured)*: Retrieve all virtual servers
* **delete** *(secured)*: Delete all

### /4.0/edges/{edgeId}/loadbalancer/config/virtualservers/{virtualserverID}
Specified virtual server

* **get** *(secured)*: Retrieve virtual server details
* **delete** *(secured)*: Delete a virtual server

### /4.0/edges/{edgeId}/loadbalancer/config/pools
Server pools manage load balancer distribution methods and has a
monitor attached to it for health check parameters

* **post** *(secured)*: Add a load balancer server pool to the Edge
* **get** *(secured)*: Get all backend pools for the specified NSX Edge
* **delete** *(secured)*: Delete all backend pools configured on the specified NSX Edge

### /4.0/edges/{edgeId}/loadbalancer/config/pools/{poolID}
Specific backend pool

* **get** *(secured)*: Get backend pool details
* **put** *(secured)*: Modify the specified pool
* **delete** *(secured)*: Delete backend pool

### /4.0/edges/{edgeId}/loadbalancer/config/members/{memberID}
Load balancer member condition

* **post** *(secured)*: Update member condition

### /4.0/edges/{edgeId}/loadbalancer/statistics
Load balancer statistics

* **get** *(secured)*: Retrieve load balancer statistics

### /4.0/edges/{edgeId}/loadbalancer/acceleration
Update acceleration mode

* **post** *(secured)*: 

### /4.0/edges/{edgeId}/dns/config
Configure DNS servers to which the Edge can relay name resolution
requests

* **get** *(secured)*: Retrieve DNS configuration
* **put** *(secured)*: Configure DNS servers
* **delete** *(secured)*: Delete DNS configuration

### /4.0/edges/{edgeId}/dns/statistics
Get DNS server statistics

* **get** *(secured)*: Get DNS server statistics

### /4.0/edges/{edgeId}/dhcp/config
Configure DHCP for NSX Edge

* **get** *(secured)*: Get DHCP configuration
* **put** *(secured)*: Configure DHCP service
* **delete** *(secured)*: Delete the DHCP configuration, restoring it to factory default

### /4.0/edges/{edgeId}/dhcp/config/ippools
Adding IP pools to DHCP configuration

* **post** *(secured)*: Add an IP pool to the DHCP configuration. returns a pool ID within
a Location HTTP header

### /4.0/edges/{edgeId}/dhcp/config/ippools/{poolID}
Specific DHCP pool

* **delete** *(secured)*: Delete a pool specified by pool ID

### /4.0/edges/{edgeId}/dhcp/config/bindings
Adding static-binding to DHCP configuration.

* **post** *(secured)*: Append a static-binding to DHCP config. A static-binding ID is
returned within a Location HTTP header

### /4.0/edges/{edgeId}/dhcp/config/bindings/{bindingID}
Specific DHCP static binding

* **delete** *(secured)*: Delete the static-binding by ID

### /4.0/edges/{edgeId}/dhcp/config/relay
Configure DHCP relay

* **get** *(secured)*: Query DHCP relay
* **put** *(secured)*: Configure DHCP relay
* **delete** *(secured)*: Delete DHCP relay configuration

### /4.0/edges/{edgeId}/dhcp/leaseInfo
DHCP Lease information

* **get** *(secured)*: Get DHCP lease information

### /4.0/edges/{edgeId}/highavailability/config
Ensures that an Edge appliance is always available on your virtualized
network.

* **get** *(secured)*: Get high availability configuration
* **put** *(secured)*: Configure high availability
* **delete** *(secured)*: Delete high availability configuration

### /4.0/edges/{edgeId}/syslog/config
Configure one or two remote syslog servers. Edge events and logs
related to firewall events that flow from Edge appliances are sent to
the syslog servers

* **get** *(secured)*: Query syslog servers
* **put** *(secured)*: Configure syslog servers
* **delete** *(secured)*: Delete syslog servers

### /4.0/edges/{edgeId}/sslvpn/config
Manage SSL VPN

* **post** *(secured)*: Enable or disable SSL VPN
* **get** *(secured)*: Retrieve SSL VPN details
* **put** *(secured)*: Reconfigure the entire SSL VPN
* **delete** *(secured)*: Delete the SSL VPN configurations on the Edge

### /4.0/edges/{edgeId}/sslvpn/config/server
Configure SSL VPN server on port 443 using the certificate named
server-cert that is already uploaded on the NSX Edge appliance and
the specified cipher

* **get** *(secured)*: Get server settings
* **put** *(secured)*: Apply server settings

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/privatenetworks
Configure a private network to expose to remote users over SSL VPN
tunnel

* **post** *(secured)*: Add a private network
* **get** *(secured)*: Get all private network profiles in the SSL VPN instance
* **put** *(secured)*: Update all private network configs of NSX Edge with the given list
of private network configs. If the config is present, it is
updated; otherwise, a new private network config is created.
Existing configs not included in the call body are deleted

* **delete** *(secured)*: Delete all Private Networks from the SSL VPN instance

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/privatenetworks/{networkID}
Specific private network

* **get** *(secured)*: Get the specified private network in the SSL VPN service

* **put** *(secured)*: Modify specified private network in the SSL VPN service
* **delete** *(secured)*: Delete private network

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/ippools
IP pools to assign IP addresses to remote users

* **post** *(secured)*: Create an IP pool
* **get** *(secured)*: Get all IP pools configured on SSL VPN
* **put** *(secured)*: Update all IP pools with the given list of pools. If the pool is
present, it is updated; otherwise, a new pool is created. Existing
pools not in the body are deleted

* **delete** *(secured)*: Delete all IP pools configured on SSL VPN

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/ippools/{ippoolID}
Specified IP pool

* **get** *(secured)*: Get details of specified IP pool
* **put** *(secured)*: Modify specified IP pool
* **delete** *(secured)*: Delete the specified IP pool

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/clientconfig
Advanced parameters for full access client configurations--such as
whether client should auto-reconnect in case of network failures or
network unavailability, or whether the client should be uninstalled
after logout

* **put** *(secured)*: Set parameters for full access client configurations
* **get** *(secured)*: Get client configuration

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/installpackages
Installation packages for SSL VPN clients

* **post** *(secured)*: Create installers for full access network clients. These setup
binaries are downloaded by remote clients and installed on their
systems.

* **get** *(secured)*: Get information about all installation packages
* **put** *(secured)*: Update all installation packages with the given list. If the
package is present, it is updated; otherwise a new installation
package is created. Existing packages not included in the body are
deleted.

* **delete** *(secured)*: Delete all client installation packages

### /4.0/edges/{edgeId}/sslvpn/config/client/networkextension/installpackages/{packageID}
Specified installation package

* **get** *(secured)*: Get information about the specified installation package

* **put** *(secured)*: Modify the specified installation package
* **delete** *(secured)*: Delete the specified installation package

### /4.0/edges/{edgeId}/sslvpn/config/layout
Layout configuration

* **get** *(secured)*: Query layout configuration

### /4.0/edges/{edgeId}/sslvpn/config/layout/images

* **put** *(secured)*: Set the portal layout

### /4.0/edges/{edgeId}/sslvpn/config/webresources
Web access server that a remote user can connect to via a web browser

* **post** *(secured)*: Add portal web resource
* **get** *(secured)*: Get all web resources on the SSL VPN instance
* **delete** *(secured)*: Delete all web resources on the SSL VPN instance

### /4.0/edges/{edgeId}/sslvpn/config/webresources/{id}
Specified web access server

* **get** *(secured)*: Get the specified web access server
* **put** *(secured)*: Modify the specified web access server
* **delete** *(secured)*: Delete the specified web access server

### /4.0/edges/{edgeId}/sslvpn/config/auth/localserver/users
Portal users

* **post** *(secured)*: Add a new portal user
* **put** *(secured)*: Modify the specified portal user
* **delete** *(secured)*: Delete all users on the specifed SSL VPN instance

### /4.0/edges/{edgeId}/sslvpn/config/auth/localserver/users/{userID}
Specified user

* **get** *(secured)*: Get information about a specified user
* **delete** *(secured)*: Delete specified user

### /4.0/edges/{edgeId}/sslvpn/config/auth/settings
Authentication settings

* **get** *(secured)*: Get information about authentication server
* **put** *(secured)*: Set authentication process for remote users. Specify
username/password authentication, active directory, ldap, radius,
client certificate based authentication

### /4.0/edges/{edgeId}/sslvpn/config/auth/settings/rsaconfigfile
RSA authentication server, bound to the SSL gateway

* **post** *(secured)*: Upload RSA config file (See "Generate the Authentication Manager
Configuration File" section of the RSA Authentication Manager
Administrator's guide for instructions on how to configure and
download the RSA config file from RSA Authentication Manager)

### /4.0/edges/{edgeId}/sslvpn/config/advancedconfig
SSL VPN advanced configuration

* **get** *(secured)*: Retrieve SSL VPN advanced configuration
* **put** *(secured)*: Apply advanced configuration

### /4.0/edges/{edgeId}/sslvpn/config/script
Logon and logoff scripts for NSX Edge gateway

* **post** *(secured)*: Configure parameters associated with the uploaded script file
* **get** *(secured)*: Retrieve all script configurations for the Edge
* **put** *(secured)*: Update all script configurations with the given list of
configurations. If the config is present, its is updated;
otherwise, a new config is created. Existing configs not included
in the body are deleted

* **delete** *(secured)*: Delete all script configurations

### /4.0/edges/{edgeId}/sslvpn/config/script/{fileID}
Specified uploaded script file

* **get** *(secured)*: Retrieve parameters associated with the specified script file

* **put** *(secured)*: Modify script parameters
* **delete** *(secured)*: Delete script parameters

### /4.0/edges/{edgeId}/sslvpn/config/script/file
Logon and logoff scripts for NSX Edge gateway

* **post** *(secured)*: Upload a login/logoff script. Returns a script file ID to
configure the parameters

### /4.0/edges/{edgeId}/sslvpn/auth/localusers/users
All users of NSX Edge

* **put** *(secured)*: Update all users with the given list of users. If the user is
present, it is updated. Otherwise, and new user is created. Existing
users not included in the body are deleted.

### /4.0/edges/{edgeId}/sslvpn/activesessions
Working with active clients

* **get** *(secured)*: Retrieve a list of active clients for the SSL VPN session

### /4.0/edges/{edgeId}/sslvpn/activesessions/{sessionID}
Specified client session

* **delete** *(secured)*: Disconnect an active client

### /4.0/edges/{edgeId}/statistics/dashboard/sslvpn
SSL VPN statistics on the specified NSX Edge

* **get** *(secured)*: Retrieve SSL VPN statistics on the specified NSX Edge

### /4.0/edges/{edgeId}/statistics/dashboard/ipsec
Tunnel traffic statistics

* **get** *(secured)*: Retrieve tunnel traffic statistics for specified time interval.
Default is 1 hour. Other possible values are 1-60 minutes|oneDay|
oneWeek|oneMonth|oneYear

### /4.0/edges/{edgeId}/statistics/dashboard/interface
Dashboard statistics

* **get** *(secured)*: Retrieve dashboard statistics between the specified start and end
times.

### /4.0/edges/{edgeId}/statistics/interfaces
Interface statistics

* **get** *(secured)*: Get interface statistics

### /4.0/edges/{edgeId}/statistics/interfaces/uplink
Uplink interface statistics

* **get** *(secured)*: Get uplink interface statistics

### /4.0/edges/{edgeId}/statistics/interfaces/internal
Internal interface statistics

* **get** *(secured)*: Get internal interface statistics

### /4.0/edges/{edgeId}/l2vpn/config
L2 VPN allows you to configure a tunnel between two sites. VM's remain
on the same subnet in spite of being moved between these sites,
enabling you to extend your datacenter. An NSX Edge at one site can
provide all services to VM's on the other site.

* **post** *(secured)*: Enable or disable L2 VPN service according to the value of the query
parameter "enableService"

* **get** *(secured)*: Retrieve the current L2VPN configuration for NSX Edge
* **put** *(secured)*: Configure L2VPN for server or client
* **delete** *(secured)*: Delete L2 VPN

### /4.0/edges/{edgeId}/l2vpn/config/statistics
L2 VPN statistics

* **get** *(secured)*: Retrieve L2 VPN stats, which has information such as tunnel status,
sent bytes, received bytes etc. for the given Edge

### /4.0/edges/{edgeId}/ipsec/config
Working with IPSEC VPN

* **get** *(secured)*: Retrieve IPSec configuration
* **put** *(secured)*: Configure IPSEC VPN
* **delete** *(secured)*: Delete the IPSec configuration

### /4.0/edges/{edgeId}/ipsec/statistics
IPSec statistics

* **get** *(secured)*: Retrieve IPSec statistics

### /4.0/edges/{edgeId}/autoconfiguration
Auto config is enabled by default. If you disable, you must add
required NAT, firewall, routing rules

* **get** *(secured)*: Retrieve auto config settings for the Edge
* **put** *(secured)*: Change the auto configuration settings for the NSX Edge

### /4.0/edges/{edgeId}/appliances
Working with Edge appliances

* **post** *(secured)*: Change the size of both appliances
* **get** *(secured)*: Retrieve appliance configuration
* **put** *(secured)*: Modify appliance configuration (tip -- retrieve the config using GET
call, then modify the parameters and send as body)

### /4.0/edges/{edgeId}/appliances/{haIndex}
Manage a specified appliance using its HA index

* **get** *(secured)*: Get configuration of specified appliance
* **put** *(secured)*: Modify the configuration of the specified appliance
* **delete** *(secured)*: Delete the appliance

### /4.0/edges/{edgeId}/vnics
Working with interfaces. Add up to ten internal/uplink interfaces to
each Edge. Each Edge must have at least one internal interface

* **post** *(secured)*: Add an interface or sub interface
* **get** *(secured)*: Retrieve all interfaces for Edge

### /4.0/edges/{edgeId}/vnics/{index}
Specified interface by index

* **get** *(secured)*: Retrieve interface
* **put** *(secured)*: Modify the specified interface
* **delete** *(secured)*: Delete interface

### /4.0/edges/{edgeId}/mgmtinterface
Working with management interfaces for an NSX Edge router

* **get** *(secured)*: Retrieve all managedment interfaces to the NSX Edge router
* **put** *(secured)*: Configure management interfaces for NSX Edge router

### /4.0/edges/{edgeId}/interfaces
Working with all NSX Edge router interfaces

* **post** *(secured)*: Add interfaces for NSX Edge router. Can have up to 8 uplink interfaces

* **get** *(secured)*: Retrieve all interfaces for Edge router
* **delete** *(secured)*: Delete interfaces

### /4.0/edges/{edgeId}/interfaces/{index}
Manage a specific NSX Edge router interface

* **get** *(secured)*: Retrieve information on specified DLR router interface
* **delete** *(secured)*: Delete interface configuration and reset to factory default

* **put** *(secured)*: Update interface configuration on specified DLR router interface

### /4.0/edges/jobs
NSX Edge async jobs

* **get** *(secured)*: Query jobs. Assumes Edge is configured in async mode, where ?async=true
is used at the end of any 4.0 service configuration URI for POST, PUT,
and DELETE calls.

### /4.0/edges/jobs/{jobId}
Status of Edge async jobs. Assumes Edge is configured in async mode,
where ?async=true is used at the end of any 4.0 service configuration
URI for POST, PUT, and DELETE calls.

* **get** *(secured)*: Retrieve job status (SUCCESS/FAILED/QUEUED/RUNNING/ROLLBACK), URI of
the resource, and ID of the resource as shown in response body

## nsxEdgePublish
Working with NSX Edge Configuration Publishing
=========

### /4.0/edgePublish/tuningConfiguration
Working with NSX Edge tuning configuration.
___
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
___
| Name | Comments |
|------|----------|
| lockUpdatesOnEdge | Default value is false. Serialize specific Edge operations related to DHCP and vnic configuration to avoid concurrency errors when too many configuration change requests arrive at the same time.|
| aggregatePublishing | Default value is true (enabled). Speed up configuration change publishing to the NSX Edge by aggregating over the configuration versions.|
| edgeVMHealthCheckIntervalInMin | Default value for time interval between NSX Edge VMʹs health check is 0, where NSX Manager manages the interval based on the number of NSX Edge VMʹs. A positive integer value overrides the default behavior.|
| healthCheckCommandTimeoutInMs | Default timeout value for health check command is 120000.|
| maxParallelVixCallsForHealthCheck | The maximum concurrent health check calls that can be made for NSX Edge VMʹs based on VIX communication channel is 25.|
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
Working with Certificates
=============

### /2.0/services/truststore/certificate
Certificates and certificate chains

* **post** *(secured)*: Create certificate for CSR

### /2.0/services/truststore/certificate/scope/{scopeId}
Certificates for a scope

* **get** *(secured)*: Query all certificates for a scope

### /2.0/services/truststore/certificate/{scopeId}
Working with vShield Edge self-signed certificates

* **post** *(secured)*: Create a single certificate

### /2.0/services/truststore/certificate/{certificateId}
Certificate specified by ID

* **get** *(secured)*: Retrieve the certificate object specified by ID. If the ID specifies
a chain, multiple certificate objects are retrieved.

* **delete** *(secured)*: Delete the specified certificate

### /2.0/services/truststore/csr/{scopeId}
Create Certificate Signing Requests (CSRs)

* **post** *(secured)*: Create a CSR

### /2.0/services/truststore/csr/{csrId}
Self signed certificate for CSR

* **put** *(secured)*: Create a self signed certificate for CSR
* **get** *(secured)*: Retrieve specific CSR

### /2.0/services/truststore/csr/scope/{scopeId}
CSRs for specific scope

* **get** *(secured)*: Query CSRs for specific scope

### /2.0/services/truststore/crl/{scopeId}
Create Certificate Revocation Lists (CRLs) on a specified scope

* **post** *(secured)*: Create CRL on the specified scope.

### /2.0/services/truststore/crl/scope/{scopeId}
Working with CRL Certificates in a Specific Scope
----

* **get** *(secured)*: Retrieve all certificates for the specified scope.

### /2.0/services/truststore/crl/{crlId}
Working with a Specific CRL Certificate
----

* **get** *(secured)*: Retrieve certificate object for the specified CRL.
* **delete** *(secured)*: Delete the specified CRL.

## policy
Working with Security Policies and Actions
============================

### /2.0/services/policy/securitypolicy
Working with Security Policies
------------------------------
A security policy is a set of Endpoint, firewall, and network
introspection services that can be applied to a security group.

* **post** *(secured)*: Create a security policy.
___
When creating a security policy, a parent security policy can be
specified if required. The security policy inherits services from the
parent security policy. Security group bindings and actions can also
be specified while creating the policy. Note that execution order of
actions in a category is implied by their order in the list. The
response of the call has Location header populated with the URI using
which the created object can be fetched.
___
Ensure that:
* the required VMware built in services (such as Distributed Firewall,
  Data Security, and Endpoint) are installed. See *NSX Installation
  Guide*.
* the required partner services have been registered with NSX Manager.
* the required security groups have been created.
___
Tags related to Service Composer, security policies, and security
groups:
Common Tags
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
security groups, say a
source-destination firewall rule
* **securityPolicy** - Parent policy in an action
Output only Tags
* **executionOrder** - Defines the sequence in which actions belonging to
an executionOrderCategory are
executed. Note that this is not an input parameter and its value is
implied by the index in the list.
Firewall Category Tags
* **action** - Allow or block the traffic
* **applications** - Applications / application groups on which the rules
are to be applied
* **direction** - Direction of traffic towards primary security group.
Possible values: inbound, outbound, intra
* **logged** - Flag to enable logging of the traffic that is hit by this
rule
* **outsideSecondaryContainer** - Flag to specify outside i.e. outside
securitygroup-3
Endpoint Category Tags
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
The following tags are deprecated:
* **vendorTemplateId**
* **invalidVendorTemplateId**
* **vendorTemplateName**
Traffic Steering/NetX Category Tags
* **redirect** - Flag to indicate whether to redirect the traffic or not
* **serviceProfile** - Service profile for which redirection is being
configured
* **logged** - Flag to enable logging of the traffic that is hit by this
rule

### /2.0/services/policy/securitypolicy/status
Working with Service Composer Status
------------------------------------

* **get** *(secured)*: Retrieve the consolidated status of Service Composer.
___
The possible return of value for status are: *in_sync*,
*in_progress*, *out_of_sync*, and *pending*.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/services/policy/securitypolicy/alarms
Working with Security Policy Alarms
-----------

### /2.0/services/policy/securitypolicy/alarms/all
Working with All Service Composer Alarms
------------

* **get** *(secured)*: Retrieve all system alarms that are raised at Service Composer
level and policy level.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/services/policy/securitypolicy/serviceprovider/firewall
Working with Service Composer Firewall Applied To Setting
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

### /2.0/services/policy/securitypolicy/{ID}
Working with Security Policies
------------------

* **get** *(secured)*: Retrieve security policy information.

* **put** *(secured)*: Edit a security policy.
___
To update a security policy, you must first fetch it.
Then edit the received XML and pass it back as the input. The
specified configuration replaces the current configuration.
___
Security group mappings provided in the PUT call replaces the
security group mappings for the security policy. To remove all
mappings, delete the securityGroupBindings parameter.
___
You can add or update actions for the security policy by editing the
actionsByCategory parameter. To remove all actions (belonging to all
categories), delete the actionsByCategory parameter. To remove
actions belonging to a specific category, delete the block for that
category.

* **delete** *(secured)*: Delete a security policy.
___
When you delete a security policy, its child security policies and
all the actions in it are deleted as well.

### /2.0/services/policy/securitypolicy/{ID}/securityactions
Working with Security Actions on a Security Policy
-------------

* **get** *(secured)*: Retrieve all security actions applicable on a security policy.
___
This list includes security actions from associated parent
security policies, if any. Security actions per Execution Order
Category are sorted based on the weight of security actions in
descending order.

### /2.0/services/policy/securitypolicy/hierarchy
Working With Security Policy Configuration Hierarchies
-----

* **post** *(secured)*: Import a security policy configuration
___
You can create multiple security policies and parent-child
hierarchies using the data fetched through export. All objects
including security policies, security groups and security actions
are created on a global scope.
___
The policy that is being imported needs to be included in the
request body.
___
If a suffix is specified, it is added after the names of the
security policy, security action, and security group objects in the
exported XML. The suffix can thus be used to differentiate locally
created objects from imported ones.
___
The location of the newly created security policy objects (multiple
locations are separated by commas) is populated in the Location
header of the response.

* **get** *(secured)*: Export a Service Composer configuration (along with the
security groups to which the security policies are mapped).
You can save the response to a file.  The saved configuration can be
used as a backup for situations where you may accidentally delete a
policy configuration, or it can be exported for use in another NSX
Manager environment.
___
If a prefix is specified, it is added before the names of the
security policy, security action, and security group objects in the
exported XML. The prefix can thus be used to indicate the remote
source from where the hierarchy was exported.

### /2.0/services/policy/securityaction/category/virtualmachines
Working with Virtual Machines with Security Actions Applied
--------------

* **get** *(secured)*: Retrieve all VirtualMachine objects on which security action of a
given category and attribute has been applied.

### /2.0/services/policy/securitygroup/{ID}/securityactions
Working With Security Actions Applicable on Security Groups
----

* **get** *(secured)*: Retrieve all security actions applicable on a security group.
___
Retrieve all security actions applicable on a security group for all
ExecutionOrderCategories. The list is sorted based on the weight of
security actions in descending order.  The **isActive** tag indicates
if a securityaction will be applied (by the enforcement engine) on the
security group.

### /2.0/services/policy/virtualmachine/{ID}/securityactions
Working with Security Actions Applicable on a Virtual Machine
----

* **get** *(secured)*: Retrieve the security actions applicable on a virtual machine.

### /2.0/services/policy/serviceprovider/firewall
Working with Service Composer Firewall
--------------

* **get** *(secured)*: If Service Composer goes out of sync with Distributed Firewall, you
must re-synchronize Service Composer rules with firewall rules. If
Service Composer stays out of sync, firewall configuration may not
stay enforced as expected.

This method can perform the following functions, depending on the
request body provided.

Key | Description | Comments
----|-------------|----------
getServiceComposerFirewallOutOfSyncTimestamp | Check if Service Composer firewall and Distributed Firewall are in sync. | If they are in sync, the response body does not contain any data.  <br>If they are out of sync, the response body contains the unix timestamp representing the time since when Service Composer firewall is out of sync.
forceSync | Synchronize Service Composer firewall with Distributed Firewall. |
getAutoSaveDraft | Retrieve the state of the auto save draft property in Service Composer. | Response is true or false.
autoSaveDraft | **Note:** Deprecated. Change the state of the auto save draft property in Service Composer. | Provide value true or false.
  **Method history:**

  Release | Modification
  --------|-------------
  6.2.3 | Method to change audo save draft via **autoSaveDraft** parameter is deprecated, and will be removed in a future release.  <br>The default setting of **autoSaveDraft** is changed from *true* to *false*.

### /2.0/services/policy/policy/securitygroup/{ID}/securitypolicies
Working with Security Policies Mapped to a Security Group
-----

* **get** *(secured)*: Retrieve security policies mapped to a security group.

## snmp
Working with SNMP
=================
NSX Manager receives events from other NSX components, including NSX Edge,
network fabric, and hypervisors.
___
You can configure NSX Manager to forward SNMP traps to an SNMP Manager.

### /2.0/services/snmp/status
Working with SNMP Status Settings
-----
You can configure settings for SNMP on the NSX Manager.

-------------------------
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
Working with SNMP Managers
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
Working with a Specific SNMP Manager
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
Working with SNMP Traps
-----------------------

* **get** *(secured)*: Retrieve information about SNMP traps.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/services/snmp/trap/{oid}
Working with a Specific SNMP Trap
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

## nsxCli
Working with the Central CLI
=======

### /1.0/nsx/cli

* **post** *(secured)*: The central command-line interface (central CLI) commands are run from the
NSX Manager command line, and retrieve information from the NSX Manager and other
devices. These commands can also be executed in the API.
___
You can insert any valid Central CLI command as the **command**
parameter. For a complete list of the Central CLI commands executable
through the API, please see the Central CLI chapter of the *NSX Command
Line Interface Reference*.

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
6.2.3 | Introduced **hostToControllerConnectionErrors** array.<br>Deprecated **fullSyncCount**parameter. Parameter is still present, but always has value of -1.

### /2.0/vdn/inventory/hosts/connection/status
Communication Status of a List of Hosts
---------------------------------------

* **get** *(secured)*: Retrieve the status of a list of hosts.

Release | Modification
--------|-------------
6.2.3 | Introduced **hostToControllerConnectionErrors** array.<br>Deprecated **fullSyncCount**parameter. Parameter is still present, but always has value of -1.

## hardwareGateways
Working with Hardware Gateways
============

### /2.0/vdn/hardwaregateways

* **post** *(secured)*: Install a hardware gateway.

**bfdEnabled** is true by default.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

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

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

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

* **get** *(secured)*: Retrive information about the hardware gateway switch ports for
the specified switch and hardware gateway.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateways/replicationcluster
Working With the Hardware Gateway Replication Cluster
----

* **put** *(secured)*: Update the hardware gateway replication cluster.
___
Add or remove hosts on a replication cluster.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **get** *(secured)*: Retrieve information about the hardware gateway replication cluster.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateways/bindings
Retrieve Information About Hardware Gateway Bindings
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

### /2.0/vdn/hardwaregateways/bindings/{bindingId}
Working With a Specific Hardware Gateway Binding
-----

* **get** *(secured)*: Retrieve information about the specified hardware gateway binding.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

* **put** *(secured)*: Update the specified hardware gateway binding.
___
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

### /2.0/vdn/hardwaregateways/bindings/{bindingId}/statistic
Working with Hardware Gateway Binding Statistics
----

* **get** *(secured)*: Retrieve statistics for the specified hardware gateway binding.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

### /2.0/vdn/hardwaregateways/bindings/manage
Working With Hardware Gateway Binding Objects
----

* **post** *(secured)*: Manage hardware gateway binding objects.
___
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

### /2.0/vdn/hardwaregateways/bfd
Working With Hardware Gateway BFD (Bidirectional Forwarding Detection)
-----

### /2.0/vdn/hardwaregateways/bfd/config
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

### /2.0/vdn/hardwaregateways/bfd/status
Working With Hardware Gateway BFD Tunnel Status
------

* **get** *(secured)*: Retrieve hardware gateway BFD tunnel status for all tunnel
endpoints, including hosts and hardware gateways.

**Method history:**

Release | Modification
--------|-------------
6.2.3 | Method introduced.

