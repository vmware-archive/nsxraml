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

VMware Education Services courses offer extensive hands‐on labs, case study examples, and course materials designed to be used as on‐the‐job reference tools. Courses are available onsite, in the classroom, and live online. For onsite pilot programs and implementation best practices, VMware Consulting Services provides offerings to help you assess, plan, build, and manage your virtual environment. To access information about education classes, certification programs, and consulting services, go to
http://www.vmware.com/services.

### Ports Required for the NSX REST API

The NSX Manager requires port 443/TCP for REST API requests.

---

## vdsManage
Working with vSphere Distributed Switches

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

* **get** *(secured)*: Retrieve information about all vSphere Distributed Switches in the specified datacenter.

### /2.0/vdn/switches/{vdsId}
Working With a Specific vSphere Distributed Switch

* **get** *(secured)*: Retrieve information about the specified vSphere Distributed Switch.

* **delete** *(secured)*: Delete the specified vSphere Distributed Switch.

## vdnConfig
Working with Segement ID Pools and Multicast Ranges

### /2.0/vdn/config/segments
Working with segment ID pools.
___
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
Working with multicast address ranges.
___
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
Working with the VXLAN port configuration.

* **get** *(secured)*: Retrieve the UDP port configured for VXLAN traffic.

### /2.0/vdn/config/vxlan/udp/port/{portNumber}
Update the VXLAN port configuration.

* **put** *(secured)*: Update the VXLAN port configuration to use port *portNumber*.

### /2.0/vdn/config/resources/allocated
Working with allocated resources.

* **get** *(secured)*: Retrieve information about allocated segment IDs or multicast
addresses.

## vdnScopes
Working with Transport Zones

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
Working with a specific transport zone.

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

* **post** *(secured)*: Create Traceflow

### /api/2.0/vdn/traceflow/{traceflowId}
Per traceflow operations.

* **get** *(secured)*: Query a specific traceflow by *tracflowId* which is the value returned
after executing the create Traceflow API call.

### /api/2.0/vdn/traceflow/{traceflowId}/observations
Traceflow Observations

* **get** *(secured)*: List traceflow observations

## logicalSwitchesGlobal
Working with Logical Switches in All Transport Zones

### /2.0/vdn/virtualwires

* **get** *(secured)*: Retrieve information about all logical switches in all transport zones.

### /2.0/vdn/virtualwires/vm/vnic
Working Virtual Machine Connections to Logical Switches

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
Testing host connectivity.

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

## arpMAC
Working with ARP suppression and MAC learning for logical switches

### /2.0/xvs/networks/{ID}/features

* **get** *(secured)*: Query ARP suppression and MAC learning information
* **put** *(secured)*: Enable or disable ARP suppression and MAC learning

## nsxControllers
Working with NSX controllers - For the unicast or hybrid control plane mode,
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
  * **Deploying** ‐ controller is being deployed and the procedure has not
  completed yet.
  * **Removing** ‐ controller is being removed and the procedure has not
  completed yet.
  * **Running** ‐ controller has been deployed and can respond to API
  invocation.
  * **Unknown** ‐ controller has been deployed but fails to respond to API
  invocation.

### /2.0/vdn/controller/upgrade-available
Query controller upgrade availability

* **get** *(secured)*: Query controller upgrade availability

### /2.0/vdn/controller/progress/{jobId}
Status of controller creation or removal

* **get** *(secured)*: Retrieves status of controller creation or removal. The progress gives
a percentage indication of current deploy / remove procedure.

### /2.0/vdn/controller/{controllerId}
Working with specified controller

* **delete** *(secured)*: Deletes NSX controller. When deleting the last controller from a
cluster, the parameter forceRemovalForLast must be set to true.

### /2.0/vdn/controller/{controllerId}/techsupportlogs
Controller logs

* **get** *(secured)*: Retrieves controller logs. Response content type is
application/octet-stream and response header is filename. This
streams a fairly large bundle back (possibly hundreds of MB).

### /2.0/vdn/controller/{controllerId}/syslog
Configures a syslog exporter on the specified controller node.

* **post** *(secured)*: Add controller syslog exporter on the controller
* **get** *(secured)*: Retrieve details about the syslog exporter on the controller

* **delete** *(secured)*: Deletes syslog exporter on the specified controller node.

### /2.0/vdn/controller/{controllerId}/snapshot
Take a snapshot of the control cluster from the specified controller
node.

* **get** *(secured)*: To retrieve the controller IDs, log in to the vSphere Web Client.
Navigate to Networking & Security > Installation. The NSX Controller
Nodes table lists the controller IDs (Name column) and IP addresses
(Node column) of each controller.

### /2.0/vdn/controller/cluster
Cluster configuration

* **get** *(secured)*: Retrieve cluster wide configuration information for controller.

* **put** *(secured)*: Modify cluster wide configuration information for controller

### /2.0/vdn/controller/credential
Change the NSX controller password

* **put** *(secured)*: Change the NSX controller password

## servicesScope
Working with services on a scope

### /2.0/services/application/scope/{scopeId}

* **get** *(secured)*: List services that have been created on the scope
* **post** *(secured)*: Create a new service on the specified scope

## service
Working with a specified service

### /2.0/services/application/{applicationId}

* **get** *(secured)*: Retrieve details about the specified service
* **put** *(secured)*: Modify the name, description, applicationProtocol, or port value of a
service

* **delete** *(secured)*: Delete the specified service

## applicationgroup
Operations on Application Groups

### /2.0/services/applicationgroup/scope/{scopeId}
Working with service groups

* **post** *(secured)*: Create a new service group on the specified scope
* **get** *(secured)*: Retrieve a list of service groups that have been created on the scope

### /2.0/services/applicationgroup/{applicationgroupId}
Working with an individual service group

* **get** *(secured)*: Retrieve details about a service group
* **put** *(secured)*: Modify the name, description, applicationProtocol, or port value of a
service group

* **delete** *(secured)*: Delete a service group from a scope

### /2.0/services/applicationgroup/{applicationgroupId}/members/{moref}
Add or delete service group members

* **put** *(secured)*: Add a member to the service group
* **delete** *(secured)*: Delete a member from the service group

### /2.0/services/applicationgroup/scope/{scopeId}/members
Get the members of a service group

* **get** *(secured)*: Get a list of member elements that can be added to the service groups
created on a particular scope.

## ipPools
Working with IP pools.

### /2.0/services/ipam/pools/scope/{scopeId}
Working with IP pools by scope.

* **get** *(secured)*: Retrieves all IP pools on the specified scope where the *scopeID* is the
reference to the desired scope. An example of the *scopeID* is
globalroot-0.

* **post** *(secured)*: You can create a pool of IP addresses. For *scopeId* use globalroot-0 or
the *datacenterId* in upgrade use cases.

### /2.0/services/ipam/pools/{poolId}
Working with a specified IP pool.

* **get** *(secured)*: Retrieve details about a specific IP pool.
* **put** *(secured)*: To modify an IP pool, query the IP pool first. Then modify the output and
send it back as the request body.

* **delete** *(secured)*: Delete an IP pool

### /2.0/services/ipam/pools/{poolId}/ipaddresses
Work with IP's and their allocation status in IP Pools

* **get** *(secured)*: Retrieves all allocated IP addresses from the specified pool.

* **post** *(secured)*: Allocate an IP Address from the pool. Use 'ALLOCATE' in the
'allocationMode' field in the body to allocate the next available ip.
To allocate a specific one use 'RESERVE' and pass the IP to reserve in
the 'ipAddress' fields in the body.

### /2.0/services/ipam/pools/{poolId}/ipaddresses/{ipAddress}
Release an IP Address allocation in the Pool

* **delete** *(secured)*: Release an IP Address allocation in the Pool

## capacityUsage
The licensing capacity usage API command reports usage of CPUs, VMs and
concurrent users for the distributed firewall and VXLAN.

### /2.0/services/licensing/capacityusage

* **get** *(secured)*: Read capacity usage information on the useage of CPUs, VMs and concurrent
users for the distributed firewall and VXLAN.

## securityTag
Working with security tags

### /2.0/services/securitytags/tag

* **post** *(secured)*: Create a new security tag
* **get** *(secured)*: Retrieve security tags

### /2.0/services/securitytags/tag/{tagId}
Delete a security tag

* **delete** *(secured)*: Delete the specified security tag

### /2.0/services/securitytags/tag/{tagId}/vm
Retrieve the list of vm's that have the specified tag attached to them

* **get** *(secured)*: Retrieve the list of vm's that have the specified tag attached to them

### /2.0/services/securitytags/tag/{tagId}/vm/{vmMoid}
Apply or detach a security tag to virtual machine

* **put** *(secured)*: Apply a security tag to virtual machine
* **delete** *(secured)*: Detach a security tag from a virtual machine

## ssoConfig
Operations on NSX Manager SSO registration

### /2.0/services/ssoconfig

* **get** *(secured)*: Query SSO Details
* **post** *(secured)*: Register NSX Manager to SSO Services
* **delete** *(secured)*: Deletes the NSX Manager SSO Configuration

### /2.0/services/ssoconfig/status
Query the SSO configuration status of NSX Manager

* **get** *(secured)*: Query the SSO configuration status of NSX Manager

## userMgmt
User Management Operations

### /2.0/services/usermgmt/user/{userId}
Manage users

* **get** *(secured)*: Get information about a user
* **delete** *(secured)*: Remove the NSX role for a vCenter user

### /2.0/services/usermgmt/role/{userId}
Manage roles for users

* **get** *(secured)*: Retrieve a user's role (possible roles are super_user, vshield_admin,
enterprise_admin, security_admin, and audit)

* **post** *(secured)*: Add role and resources for a user
* **put** *(secured)*: Change a user's role
* **delete** *(secured)*: Delete the role assignment for specified vCenter user. Once this role
is deleted, the user is removed from NSX Manager. You cannot delete the
role for a local user.

### /2.0/services/usermgmt/enablestate/{value}
Change the state of a user account (enabled/disabled)

* **put** *(secured)*: Enable or disable a user account

### /2.0/services/usermgmt/users/vsm
Get information about users who have been assigned a NSX Manager role
(local users as well as vCenter users with NSX Manager role)

* **get** *(secured)*: Get information about users who have been assigned a NSX Manager role
(local users as well as vCenter users with NSX Manager role)

### /2.0/services/usermgmt/roles
NSX Manager user management operations on roles

* **get** *(secured)*: Read all possible roles in NSX Manager

### /2.0/services/usermgmt/scopingobjects
Retrieve a list of objects that can be used to define a user's access
scope

* **get** *(secured)*: Retrieve a list of objects that can be used to define a user's access
scope

## secGroup
Operations on securitygroups

### /2.0/services/securitygroup/bulk/{scopeId}
Create a new security group on a global scope or universal scope. Use
either "globalroot-0" or "universalroot-0". Universal security groups are
read-only when querying a secondary NSX manager.

* **post** *(secured)*: Create a new security group on a global scope
* **put** *(secured)*: Update a specific security group

### /2.0/services/securitygroup/scope/{scopeId}
Operations to list information about security groups on a given scope

* **get** *(secured)*: List all the security groups created on a specific scope

### /2.0/services/securitygroup/scope/{scopeId}/memberTypes
Information on valid elements that can be added to a security group

* **get** *(secured)*: Retrieve a list of valid elements that can be added to a security
group.

### /2.0/services/securitygroup/scope/{scopeId}/members/{memberType}
Retrieve members of a specific type under a scope

* **get** *(secured)*: Retrieve members of a specific type under a scope

### /2.0/services/securitygroup/{objectId}
Operations for an individual security group

* **get** *(secured)*: Retrieve all members of the specified security group
* **put** *(secured)*: Update members of the specified security group
* **delete** *(secured)*: Delete an existing security group

### /2.0/services/securitygroup/{objectId}/members/{memberMoref}
Operations on members of an individual security group

* **put** *(secured)*: Add a new member to specified security group
* **delete** *(secured)*: Delete member from specified security group

### /2.0/services/securitygroup/{objectId}/translation/virtualmachines

* **get** *(secured)*: Retrieve list of VmNode entities that belong to a specific security
group.

### /2.0/services/securitygroup/{objectId}/translation/ipaddresses

* **get** *(secured)*: Retrieve list of IpNode entities that belong to a specific security
group.

### /2.0/services/securitygroup/{objectId}/translation/macaddresses

* **get** *(secured)*: Retrieve list of MacNode entities that belong to a specific security
group.

### /2.0/services/securitygroup/{objectId}/translation/vnics

* **get** *(secured)*: Retrieve list of VnicNode entities that belong to a specific security
group.

### /2.0/services/securitygroup/lookup/virtualmachine/{virtualMachineId}
Retrieve list of security groups that the specified virtual machine
belongs to.

* **get** *(secured)*: Retrieve list of security groups that the specified virtual machine
belongs to.

### /2.0/services/securitygroup/internal/scope/{scopeId}
Information on internal security groups

* **get** *(secured)*: Retrieve all internal security groups on the NSX Manager. These are used
 internally by the system and should not be created or modified by end
users.

## ipsets
Operations on IP Sets

### /2.0/services/ipset/scope/{scopeMoref}

* **get** *(secured)*: Retrieve all configured IPSets

### /2.0/services/ipset/{scopeMoref}

* **post** *(secured)*: creates a new IPset

### /2.0/services/ipset/{ipsetId}

* **get** *(secured)*: Retrieve an individual IPset
* **put** *(secured)*: Modify an existing IPset
* **delete** *(secured)*: delete an IPset

## vCenterConfig
Configuring NSX Manager with vCenter Server

### /2.0/services/vcconfig

* **get** *(secured)*: Get vCenter Server configuration details on NSX Manager
* **put** *(secured)*: Synchronize NSX Manager with vCenter server

### /2.0/services/vcconfig/status
Connection status for vCenter Server

* **get** *(secured)*: Get default vCenter Server connection status

## universalSync
Configuring Universal Sync for the NSX manager

### /2.0/universalsync/configuration/role
Universal Sync Configuration

* **post** *(secured)*: Set the Universal Sync Configuration role
* **get** *(secured)*: Get the Universal Sync Configuration role

### /2.0/universalsync/configuration/nsxmanagers
Universal sync configuration of NSX managers

* **post** *(secured)*: Create a secondary NSX manager
* **delete** *(secured)*: Delete secondary NSX manager configuration

### /2.0/universalsync/configuration/nsxmanagers/thumbprint
Universal sync configuration NSX manager thumbprint

* **put** *(secured)*: Update the NSX manager thumprint in the universal sync configuration

### /2.0/universalsync/configuration/nsxmanagers/{nsxManagerID}
Universal sync configuration of a specific NSX manager

* **get** *(secured)*: Query universal sync configuration information on a specific NSX
manager by ID

* **delete** *(secured)*: Delete a secondary NSX manager by ID.

### /2.0/universalsync/sync
Sync all objects on the NSX manager

* **post** *(secured)*: Sync all objects on the NSX manager

### /2.0/universalsync/entitystatus
The status of an universal sync entity

* **get** *(secured)*: Read the status of a universal sync entity

### /2.0/universalsync/status
Universal sync status

* **get** *(secured)*: Read the universal sync status

## applianceManager
Working with Appliance Manager

### /1.0/appliance-management/global/info
Global appliance manager information

* **get** *(secured)*: Retrieve global information containing version information as well as
current logged in user

### /1.0/appliance-management/summary/system
Summary appliance manager information

* **get** *(secured)*: Retrieve system summary info such as address, dns name, version, CPU,
memory and storage

### /1.0/appliance-management/summary/components
Component information

* **get** *(secured)*: Retrieve summary of all available components and their status info

### /1.0/appliance-management/system/restart
Reboot the appliance manager

* **post** *(secured)*: Reboot the appliance manager

### /1.0/appliance-management/system/cpuinfo
CPU Info

* **get** *(secured)*: Query CPU information

### /1.0/appliance-management/system/uptime
Appliance Manager uptime

* **get** *(secured)*: Query appliance manager uptime

### /1.0/appliance-management/system/meminfo
Appliance Manager memory

* **get** *(secured)*: Query memory

### /1.0/appliance-management/system/storageinfo
Appliance Manager storage

* **get** *(secured)*: Query storage

### /1.0/appliance-management/system/network
Working with network settings

* **get** *(secured)*: Retrieve network information i.e. host name, IP address, DNS settings

### /1.0/appliance-management/system/network/dns
Configure DNS

* **put** *(secured)*: Configure DNS
* **delete** *(secured)*: Delete DNS servers

### /1.0/appliance-management/system/timesettings
Working with time settings

* **get** *(secured)*: Retrieve time settings
* **put** *(secured)*: Configure time or specify the NTP server to use for time synchronization

### /1.0/appliance-management/system/timesettings/ntp
Delete NTP server

* **delete** *(secured)*: Delete NTP server

### /1.0/appliance-management/system/locale
Configure locale

* **get** *(secured)*: Retrieve locale info
* **put** *(secured)*: Configure locale

### /1.0/appliance-management/system/syslogserver
Working with syslog servers

* **get** *(secured)*: Retrieve syslog servers
* **put** *(secured)*: Configure syslog servers
* **delete** *(secured)*: Delete syslog servers

### /1.0/appliance-management/components
Components management

* **get** *(secured)*: Retrieve all Appliance Manager components

### /1.0/appliance-management/components/{componentID}
Specific component management

* **get** *(secured)*: Retrieve details for specified component

### /1.0/appliance-management/components/{componentID}/dependencies
Component dependencies

* **get** *(secured)*: Retrieve dependency details for specified component

### /1.0/appliance-management/components/{componentID}/dependents
Component dependents

* **get** *(secured)*: Retrieve dependents for the specified component

### /1.0/appliance-management/components/{componentID}/status
Component status

* **get** *(secured)*: Retrieve current status for specified component

### /1.0/appliance-management/backuprestore/backupsettings
Appliance Manager backup settings

* **get** *(secured)*: Retrieve backup settings
* **put** *(secured)*: Configure backup on the Appliance Manager
* **delete** *(secured)*: Delete Appliance Manager backup configuration

### /1.0/appliance-management/backuprestore/backup
On-demand backup

* **post** *(secured)*: Backup NSX data on-demand

### /1.0/appliance-management/backuprestore/backups
Retrieve list of all backups available at configured backup location

* **get** *(secured)*: Retrieve list of all backups available at configured backup location

### /1.0/appliance-management/backuprestore/restore
Restore data from a backup file

* **post** *(secured)*: Restore data from a backup file

### /1.0/appliance-management/techsupportlogs/{componentID}
Generate tech support logs

* **post** *(secured)*: Generate tech support logs

### /1.0/appliance-management/techsupportlogs/{filename}
Download tech support logs

* **get** *(secured)*: Download tech support logs

### /1.0/appliance-management/notifications
Working with support notifications

* **get** *(secured)*: Retrieve all system generated notifications
* **delete** *(secured)*: Delete all notifications

### /1.0/appliance-management/notifications/{ID}/acknowledge
Acknowledge a notification

* **post** *(secured)*: Acknowledge a notification

### /1.0/appliance-management/upgrade/uploadbundle/{componentID}
NSX Manager upgrade details

* **post** *(secured)*: Upload upgrade bundle
* **get** *(secured)*: Query upgrade details (after uploading upgrade bundle)

### /1.0/appliance-management/upgrade/start/{componentID}
Start upgrade process

* **get** *(secured)*: Start upgrade process

### /1.0/appliance-management/status/{componentID}
Query upgrade status

* **get** *(secured)*: Query upgrade status

### /1.0/appliance-management/certificatemanager/certificates/nsx
NSX Manager certificate manager

* **get** *(secured)*: Query the certificate thumbprint from a NSX manager

## systemEvents
Get NSX Manager system events

### /2.0/systemevent

* **get** *(secured)*: Get NSX Manager system events

## auditLogs
Get NSX Manager audit logs

### /2.0/auditlog

* **get** *(secured)*: Get NSX Manager audit logs

## nwfabric
Working with Network Fabric Configuration

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
environment on a per‐cluster level for each vCenter server, which
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
Security fabric

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
Configuring Data Security

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
eventControl Operations

### /1.0/eventcontrol/vm/{vmID}/request
Enable or disable data collection on a virtual machine

* **post** *(secured)*: Enable or disable data collection on a virtual machine

### /1.0/eventcontrol/eventcontrol-root/request
Data collection kill switch on/off

* **post** *(secured)*: Turn on/off data collection at global level

### /1.0/eventcontrol/config/vm/{vmID}
Retrieve per vm configuration for data collection

* **get** *(secured)*: Retrieve per vm configuration for data collection

## activityMonitoring
Activity monitoring

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
Working with domains

### /3.0/directory/updateDomain

* **post** *(secured)*: Register or update a domain with NSX Manager

## domain
LDAP / Domain Operations

### /1.0/directory/updateDomain
Working with domains

* **post** *(secured)*: Register or update a domain with NSX Manager

### /1.0/directory/listDomains
Retrieve all agent discovered (or configured) LDAP domains

* **get** *(secured)*: Retrieve all agent discovered (or configured) LDAP domains

### /1.0/directory/deleteDomain/{ID}
Delete domain

* **delete** *(secured)*: Delete domain

### /1.0/directory/directory
Working with LDAP servers and EventLog servers

### /1.0/directory/directory/updateLdapServer
Create LDAP server

* **post** *(secured)*: Create LDAP server

### /1.0/directory/directory/listLdapServersForDomain/{domainID}
Query LDAP servers for a domain

* **get** *(secured)*: Query LDAP servers for a domain

### /1.0/directory/directory/fullSync/{domainID}
Start LDAP full sync

* **put** *(secured)*: Start LDAP full sync

### /1.0/directory/directory/deltaSync/{domainID}
Start LDAP delta sync

* **put** *(secured)*: Start LDAP delta sync

### /1.0/directory/directory/deleteLdapServer/{serverID}
Delete LDAP server

* **delete** *(secured)*: Delete LDAP server

### /1.0/directory/directory/updateEventLogServer
Create EventLog server

* **post** *(secured)*: Create EventLog server

### /1.0/directory/directory/listEventLogServersForDomain/{domainID}
Query EventLog servers for a domain

* **get** *(secured)*: Query EventLog servers for a domain

### /1.0/directory/directory/deleteEventLogServer/{serverID}
Delete EventLog server

* **delete** *(secured)*: Delete EventLog server

## mappingLists
Working with mapping lists

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
Working with Activity Monitoring syslog support

### /1.0/sam/syslog/enable
Enable syslog support

* **post** *(secured)*: Enable syslog support

### /1.0/sam/syslog/disable
Disable syslog support

* **post** *(secured)*: Disable syslog support

## solutionIntegration
Operations for solution Integrations

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
Working with MAC sets.

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
Working with filtering criteria and paging information for jobs on the task
framework

### /2.0/services/taskservice/job

* **get** *(secured)*: Query job instances by criterion

### /2.0/services/taskservice/job/{jobId}
Job instances on the task framework

* **get** *(secured)*: Retrieve all job instances for the specified job ID

## vShield
Register a vendor/solution, set network address

### /2.0/endpointsecurity/registration

* **post** *(secured)*: Register a vendor

### /2.0/endpointsecurity/registration/vendors
Registration status of vShield vendors

* **get** *(secured)*: Retrieve the list of all registered vendors

### /2.0/endpointsecurity/registration/{vendorID}
Antivirus solutions

* **post** *(secured)*: Register an antivirus solution
* **get** *(secured)*: Get vendor registration information
* **delete** *(secured)*: Unregister a vendor

### /2.0/endpointsecurity/registration/{vendorID}/solutions
Registration information for all registered solutions for a vendor

* **get** *(secured)*: Retrieve registration information for all registered solutions for a
vendor

### /2.0/endpointsecurity/registration/{vendorID}/{altitude}
Solution registration information

* **get** *(secured)*: Get registration information for a given solution
* **delete** *(secured)*: Unregister a solution

### /2.0/endpointsecurity/registration/{vendorID}/{altitude}/location
IP address and port for a solution

* **post** *(secured)*: Set a solution's IP address and port on the vNIC host
* **delete** *(secured)*: Unset a solution's IP address and port

### /2.0/endpointsecurity/registration/{vendorID}/{altitude}/{moid}
Solution activation status, given the managed object reference of its
virtual machine

* **get** *(secured)*: Get the solution activation status

## vShieldSolutionActivation
vShield solution activation

### /2.0/endpointsecurity/activation

* **get** *(secured)*: Retrieve activation information for all activated security vm's on the
specified host

### /2.0/endpointsecurity/activation/{vendorID}/{solutionID}
Activated security virtual machines

* **get** *(secured)*: Get a list of activated security vm's for the specified solution

### /2.0/endpointsecurity/activation/{vendorID}/{altitude}
Activate a registered vShield solution

* **post** *(secured)*: Activate a solution that has been registered and located

### /2.0/endpointsecurity/activation/{vendorID}/{altitude}/{moid}
Deactivate a solution on a host

* **delete** *(secured)*: Deactivate a solution on a host

## dfw
Distributed Firewall Operations

### /4.0/firewall/globalroot-0/config
Global Distributed Firewall Rules configuration

* **get** *(secured)*: Global Distributed Firewall Rules configuration, use query Parameters
to filter

* **put** *(secured)*: This will update the complete firewall configuration in all sections.
You will need to get the Etag value out of the GET (dfwConfigShow)
first. Then pass the modified version of the whole firewall
configuration in the GET body

* **delete** *(secured)*: Restores default configuration, which means one defaultLayer3 section
with default allow rule and one defaultLayer2Section with default
allow rule

### /4.0/firewall/globalroot-0/config/layer3sections
L3 Firewall Operations on specific section specified by name (in a
query Parameter)

* **get** *(secured)*: Read a specific section of the DFW config specified by name
* **post** *(secured)*: Creates a new L3 Firewall Section with a number of rules

### /4.0/firewall/globalroot-0/config/layer3sections/{sectionId}
L3 Firewall Operations on specific section specified by section ID

* **get** *(secured)*: Read a specific section of the DFW config specified by Id
* **put** *(secured)*: Updates a L3 DFW Section. To do this you need to read it first,
make your changes, and then update the section by supplying the
Etag value received in the read in the If-Match header

* **delete** *(secured)*: Deletes a L3 section and its content by ID

### /4.0/firewall/globalroot-0/config/layer3sections/{sectionId}/rules
Operations to add one or more L3 Rules

* **post** *(secured)*: Add a L3 Rule

### /4.0/firewall/globalroot-0/config/layer3sections/{sectionId}/rules/{ruleId}
Operations on L3 rules in sections identified by section Id and
Rule Id

* **get** *(secured)*: Read the configuration of a specific rule identified by rule Id

* **put** *(secured)*: Updates a L3 DFW Rule. To do this you need to read it first,
make your changes, and then update the section by supplying the
Etag value received in the read in the If-Match header

* **delete** *(secured)*: Delete a specific rule identified by rule Id

### /4.0/firewall/globalroot-0/config/layer3sections/{sectionName}
L3 Firewall Update Operations on specific section specified by
section Name

* **put** *(secured)*: Updates a L3 DFW Section. To do this you need to read it first, make your changes,
and then update the section by supplying the Etag value received in the read in the If-Match header

### /4.0/firewall/globalroot-0/config/layer2sections
L2 Firewall Operations on specific section specified by name (in a
query Parameter)

* **get** *(secured)*: Read a specific section of the DFW config specified by name
* **post** *(secured)*: Creates a new L2 Firewall Section with a number of rules

### /4.0/firewall/globalroot-0/config/layer2sections/{sectionId}
L2 Firewall Operations on specific section specified by section ID

* **get** *(secured)*: Read a specific section of the DFW config specified by Id
* **put** *(secured)*: Updates a L2 DFW Section. To do this you need to read it first,
make your changes, and then update the section by supplying the
Etag value received in the read in the If-Match header

* **delete** *(secured)*: Deletes a L2 section and its content by ID

### /4.0/firewall/globalroot-0/config/layer2sections/{sectionId}/rules
Operations to add one or more L2 Rules

* **post** *(secured)*: Add L2 Rule

### /4.0/firewall/globalroot-0/config/layer2sections/{sectionId}/rules/{ruleId}
Operations on L2 rules in sections identified by section Id and
Rule Id

* **get** *(secured)*: Read the configuration of a specific rule identified by rule Id

* **put** *(secured)*: Updates a L2 DFW Rule. To do this you need to read it first,
make your changes, and then update the section by supplying the
Etag value received in the read in the If-Match header

* **delete** *(secured)*: Delete a specific rule identified by rule Id

### /4.0/firewall/globalroot-0/config/layer2sections/{sectionName}
L3 Firewall Update Operations on specific section specified by section Name

* **put** *(secured)*: Updates a L2 DFW Section. To do this you need to read it first,
make your changes, and then update the section by supplying the
Etag value received in the read in the If-Match header

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
Upgrading distributed firewall

* **get** *(secured)*: Get current state of firewall functioning after NSX upgrade
* **put** *(secured)*: Enable distributed firewall

### /4.0/firewall/globalroot-0/status
Firewall configuration status

* **get** *(secured)*: Get firewall configuration status

### /4.0/firewall/globalroot-0/status/layer3sections/{sectionID}
L3 section status

* **get** *(secured)*: Get Layer3 status

### /4.0/firewall/globalroot-0/status/layer2sections/{sectionID}
L2 section status

* **get** *(secured)*: Get Layer2 status

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
Memory and CPU thresholds for firewall

* **get** *(secured)*: Retrieve memory, CPU, and CPS thresholds for firewall
* **put** *(secured)*: Configure thresholds

### /4.0/firewall/config/globalconfiguration
Tuning firewall performance

* **get** *(secured)*: Query RuleOptimize and TCPStrict flags
* **put** *(secured)*: Set RuleOptimize and TCPStrict flags in body to improve performance

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
SpoofGuard policies

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

### /2.1/app/flow/flowstats
Retrieve flow monitoring statistics information.

* **get** *(secured)*: Retrieve flow statistics for a datacenter, port group, VM, or vNIC
___
Response values for flow statistics:
* **blocked** - indicates whether traffic is blocked:
  * 0 - flow allowed
  * 1 - flow blocked
  * 2 - flow blocked by Spoofguard
* **protocol** - protocol in flow:
  * 0 - TCP
  * 1 - UDP
  * 2 - ICMP
* **direction** - direction of flow:
  * 0 - to virtual machine
  * 1 - from virtual machine
* **controlDirection** - control direction for dynamic TCP traffic:
  * 0 - source ‐> destination
  * 1 - destination ‐> source

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
Exclude VM's from firewall protection

### /2.1/app/excludelist

* **get** *(secured)*: Retrieve the set of vm's in the exclusion list

### /2.1/app/excludelist/{memberID}
Exclude VM's from firewall protection

* **put** *(secured)*: Add a vm to the exclusion list
* **delete** *(secured)*: Delete a vm from exclusion list

## nsxEdges
Installed NSX Edges in your inventory

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
Configure DNS servers to which vShield Edge can relay name resolution
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

## truststore
Operation on truststore (certificates)

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

* **post** *(secured)*: Create CRL on the specified scope

### /2.0/services/truststore/crl/scope/{scopeId}
Retrieve all certificates for the specified scope

* **get** *(secured)*: Retrieve all certificates for the specified scope

### /2.0/services/truststore/crl/{crlId}
CRL certificates for specified certificate

* **get** *(secured)*: Retrieve certificate object for specified crlID
* **delete** *(secured)*: Delete the specified CRL

## policy
Operations on policy objects

### /2.0/services/policy/securitypolicy
Working with security policies (Endpoint, firewall, network introspection
services applied to security group)

* **post** *(secured)*: Create a security policy

### /2.0/services/policy/securitypolicy/{ID}
Specific security policy

* **get** *(secured)*: Retrieve security policy information
* **put** *(secured)*: Edit a security policy
* **delete** *(secured)*: Delete a security policy

### /2.0/services/policy/securitypolicy/{ID}/securityactions
Security actions for a security policy

* **get** *(secured)*: Retrieve security actions for a security policy

### /2.0/services/policy/securitypolicy/hierarchy
Security policy configuration import/export

* **post** *(secured)*: Import a security policy configuration
* **get** *(secured)*: Export a Service Composer configuration and save to your desktop for
use as a backup

### /2.0/services/policy/securityaction/category/virtualmachines
Virtual machines for a security action

* **get** *(secured)*: Fetch all vm objects on which security action of a given category and
attribute has been applied

### /2.0/services/policy/securitygroup/{ID}/securityactions
Security actions on a security group

* **get** *(secured)*: Query all security actions applicable on a security group

### /2.0/services/policy/virtualmachine/{ID}/securityactions
Fetch the security actions applicable on a virtual machine

* **get** *(secured)*: Fetch the security actions applicable on a virtual machine

### /2.0/services/policy/policy/serviceprovider/firewall
Synchronizing Service Composer rules with distributed firewall

* **get** *(secured)*: Query the time since when Service Composer firewall is out of sync with
dfw, or synchronize Service Composer firewall with dfw

### /2.0/services/policy/policy/securitygroup/{ID}/securitypolicies
Retrieve security policies mapped to a security group

* **get** *(secured)*: Retrieve security policies mapped to a security group

## nsxCli
Working with the Central CLI

### /1.0/nsx/cli

* **post** *(secured)*: The central command-line interface (central CLI) commands are run from the
NSX Manager command line, and retrieve information from the NSX Manager and other
devices. These commands can also be executed in the API.
___
You can insert any valid Central CLI command as the **command**
parameter. For a complete list of the Central CLI commands executable
through the API, please see the Central CLI chapter of the *NSX Command
Line Interface Reference*.
___
The Accept header must be set to text/plain.

