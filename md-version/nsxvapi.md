# VMware NSX for vSphere API documentation version 6.2.3
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

---

## vdsManage
This collection of methods are used to configure and prepare the VDS's for
the use with NSX. Before creating a logical switch, ensure that you have
installed the network virtualization components on the appropriate clusters
and that you have configured VXLAN on the appropriate clusters.

### /2.0/vdn/switches

* **post** *(secured)*: The MTU is the maximum amount of data that can be transmitted in one
packet before it is divided into smaller packets. The frames are slightly
larger in size because of the traffic encapsulation, so the MTU required
is higher than the standard MTU. You must set the MTU for each switch to
1600 or higher.

* **get** *(secured)*: You can retrieve all configured switches.

### /2.0/vdn/switches/datacenter/{datacenterID}
You can retrieve all configured switches on a datacenter.

* **get** *(secured)*: Lists all VDS's in a specified vSphere Datacenter Object

### /2.0/vdn/switches/{vdsId}
Retrieve a specific switch by specific switch ID (e.g. dvs-26).

* **get** *(secured)*: Retrieve a specific vds by specific switchId (e.g. dvs-26)

* **delete** *(secured)*: Delete a specific VDS by specific switchId (e.g. dvs-22). Use the
switch ID as the vdsId.

## vdnConfig
Configurations of Segment ID's and Multicast Ranges for logical switches

### /2.0/vdn/config/segments
You can specify one or more segment ID pools that is used to provide
virtual network identifiers to logical switches which helps you isolate
your network traffic.

* **post** *(secured)*: You can add a new segment ID range that provides virtual network
identifiers to logical switches. More than one segment ID range is
supported in the system. The segment range is inclusive – the beginning
and ending IDs are included.

* **get** *(secured)*: Lists all Segment ID Pools.

### /2.0/vdn/config/segments/{segmentPoolId}
Operations on individual segment ID Pool

* **get** *(secured)*: Retrieve details of an individual segment ID Pool.
* **put** *(secured)*: Update an individual segment ID Pool. If the segment pool is
universal the API call must be made to the primary NSX manager.

* **delete** *(secured)*: Delete an individual segment ID Pool. If the segment pool is
universal the API call must be made to the primary NSX manager.

### /2.0/vdn/config/multicasts
Operations on multicast range Pools for logical switches. Specifying a
multicast address range helps in spreading traffic across your network to
avoid overloading a single multicast address.A virtualized network‐ready
host is assigned an IP address from this range.

* **post** *(secured)*: Adds a multicast range for logical switches. The address range is
inclusive – the beginning and ending addresses are included.

* **get** *(secured)*: List all configured VDN Multicast Pools. Universal pools will have the
property isUniversal set tot true.

### /2.0/vdn/config/multicasts/{multicastAddresssRangeId}
Operations in individual multicast range Pools for logical switches

* **get** *(secured)*: Retrieve details of an individual Multicast range Pool

* **put** *(secured)*: Update an individual multicast range pool. If the multicast pool is
universal the API call must be made to the primary NSX manager.

* **delete** *(secured)*: Delete an individual Multicast range pool. If the multicast pool is
universal the API call must be made to the primary NSX manager.

### /2.0/vdn/config/vxlan/udp/port
Managing the logical switch UDP port.

* **get** *(secured)*: View configured UDP port for VXLAN.

### /2.0/vdn/config/vxlan/udp/port/{portNumber}
You can view the UDP port for VXLAN

* **put** *(secured)*: You can change the UDP port for the logical switch. If not set, the
port defaults to port 8472.

### /2.0/vdn/config/resources/allocated
Query allocated resources

* **get** *(secured)*: Retrieve a list of resources allocated

## vdnScopes
A network scope is the networking infrastructure within provider virtual
datacenters. Read all scopes (transport zones), or create a new scope
(Transport Zone).

### /2.0/vdn/scopes

* **get** *(secured)*: Retrieve a list of all known VDN Scopes / Transport Zones
* **post** *(secured)*: Create a new Transport Zone. Note that you can only add one initial
cluster when creating the TZ. You must specify the clusters that are to
be part of the network scope. You must have the VLAN ID, UUID of the
vCenter Server, and vDS ID.

### /2.0/vdn/scopes/{scopeId}
Read, update and delete an existing scope (transport Zone)

* **get** *(secured)*: Retrieve the properties of an existing network scope
* **post** *(secured)*: Updates a transport zone, you can add a cluster to or delete a cluster
from a transport zone.

* **delete** *(secured)*: delete a transport zone

### /2.0/vdn/scopes/{scopeId}/attributes
update the attributes of a transport zone (e.g. Name, description)

* **put** *(secured)*: Update the attributes of a transport zone (e.g. Name, description)

### /2.0/vdn/scopes/{scopeId}/conn-check/multicast
Test multicast group connectivity in a transport zone

* **post** *(secured)*: Test multicast group connectivity in a transport zone

## logicalSwitches
Create and List operations of logical switches inside a Transport Zone.

### /2.0/vdn/scopes/{scopeId}/virtualwires

* **get** *(secured)*: Lists all logical Switches in the Transport Zone (Scope)
* **post** *(secured)*: Creates a logicalSwitch. To create a universal logical switch use the
appropriate universal scope as the scopeId and use the primary NSX
manager.

## logicalSwitchesGlobal
List Operations of logicalSwitches in all transport Zones (scope)

### /2.0/vdn/virtualwires

* **get** *(secured)*: List all logicalSwitches

### /2.0/vdn/virtualwires/vm/vnic
Migrate a Virtual Maschine vnic to a logical switch

* **post** *(secured)*: Migrate a Virtual Maschine vnic to a logical switch

### /2.0/vdn/virtualwires/{virtualWireID}
Retrieves the configuration of an individual logical switch

* **get** *(secured)*: Retrieves the configuration of an individual logical switch. If the
switch is a universal logical switch the isUniversal flag will be set in
the response body.

* **put** *(secured)*: Update a logical switch, possible updates are name changes &
Controlplane Mode

* **delete** *(secured)*: Delete a logical switch

### /2.0/vdn/virtualwires/{virtualWireID}/conn-check/multicast
Test multicast group connectivity in logical switch

* **post** *(secured)*: Test multicast group connectivity in logical switch

### /2.0/vdn/virtualwires/{virtualWireID}/conn-check/p2p
Perform point to point connectivity test between two hosts across which
a logical switch spans

* **post** *(secured)*: Perform point to point connectivity test between two hosts across
which a logical switch spans

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

* **post** *(secured)*: Adds a new NSX controller on the specified given cluster. The hostId
parameter is optional. The resourcePoolId can be either the clusterId or
resourcePoolId. The IP address of the controller node will be allocated
from the specified IP pool. deployType determines the controller node
memory size and can be small, medium, or large. However, different
controller deployment types are not currently supported because the OVF
overrides it and different OVF types require changes in the manager build
scripts. Despite not being supported, an arbitrary deployType size must
still be specified or an error will be returned. Request without body to
upgrade controller cluster.

* **get** *(secured)*: Retrieves details and runtime status for all controllers.  Runtime status
can be one of the following:
  **Deploying** ‐ controller is being deployed and the procedure has not
  completed yet.
  **Removing** ‐ controller is being removed and the procedure has not
  completed yet.
  **Running** ‐ controller has been deployed and can respond to API
  invocation.
  **Unknown** ‐ controller has been deployed but fails to respond to API
  invocation.

### /2.0/vdn/controller/upgrade-available
Query controller upgrade availability

* **get** *(secured)*: Query controller upgrade availability

### /2.0/vdn/controller/progress/{jobId}
Status of controller creation or removal

* **get** *(secured)*: Retrieve status of controller creation or removal. Returns percentage
indication of job progress

### /2.0/vdn/controller/{controllerId}
Working with specified controller

* **delete** *(secured)*: Delete NSX controller. When deleting last controller from cluster,
forceRemoval must be set to true

### /2.0/vdn/controller/{controllerId}/techsupportlogs
Controller logs

* **get** *(secured)*: Retrieve controller logs

### /2.0/vdn/controller/{controllerId}/syslog
Syslog exporter on controller node

* **post** *(secured)*: Add controller syslog exporter on the controller
* **get** *(secured)*: Retrieve details about the syslog exporter on the controller

* **delete** *(secured)*: Delete the syslog exporter

### /2.0/vdn/controller/{controllerId}/snapshot
Take a snapshot of the control cluster from the specified controller
node

* **get** *(secured)*: Take a snapshot of the control cluster from the specified controller
node

### /2.0/vdn/controller/cluster
Cluster configuration

* **get** *(secured)*: Retrieve cluster-wise configuration information for controller

* **put** *(secured)*: Modify cluster configuration information for controller

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
Create a pool of IP addresses

### /2.0/services/ipam/pools/scope/{scopeId}

* **get** *(secured)*: Read all IP Pools in a scope
* **post** *(secured)*: Create a pool of IP addresses

## ipPool
Working with a specified IP pool

### /2.0/services/ipam/pools/{poolId}

* **get** *(secured)*: Retrieve details about the IP pool
* **put** *(secured)*: Modify an IP pool
* **delete** *(secured)*: Delete an IP pool

### /2.0/services/ipam/pools/{poolId}/ipaddresses
Work with IP's and their allocation status in IP Pools

* **get** *(secured)*: Retrieve all IP's and their allocation status in an IP Pool
* **post** *(secured)*: Allocate an IP Address from the pool. Use 'ALLOCATE' in the
'allocationMode' field in the body to allocate the next available ip.
To allocate a specific one use 'RESERVE' and pass the IP to reserve in
the 'ipAddress' fiels in the body

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
Network virtualization components

### /2.0/nwfabric/configure
Network virtualization components

* **post** *(secured)*: You install the network infrastructure components in your virtual
environment on a per‐cluster level for each vCenter server, which
deploys the required software on all hosts in the cluster. This software
is also referred to as an NSX vSwitch. When a new host is added to this
cluster, the required software is automatically installed on the newly
added host. After the network infrastructure is installed on a cluster,
Logical Firewall is enabled on that cluster.

* **put** *(secured)*: This API call can be used to upgrade network virtualization components.
After NSX Manager is upgraded, previously prepared clusters must have
the 6.x network virtualization components installed.

* **delete** *(secured)*: Removes previously installed VIBs, tears down NSX manager to ESX
messaging, and remove any other network fabric dependent features like
logical wires etc. If a feature like logical wire is being used in your
environment, this call fails.

### /2.0/nwfabric/features

* **get** *(secured)*: Retrieves all features available on the cluster

### /2.0/nwfabric/status

* **get** *(secured)*: Retrieves the Status of Resources

### /2.0/nwfabric/status/child/{parentResourceID}
Status of child resources

* **get** *(secured)*: Retrieve status

### /2.0/nwfabric/status/alleligible/{resourceType}
Status of resources by criterion

* **get** *(secured)*: Query status of resources by criterion

### /2.0/nwfabric/clusters/{clusterID}
Network virtualization component cluster configuration

* **get** *(secured)*: Read the locale ID on a cluster
* **put** *(secured)*: Update the locale ID on a cluster
* **delete** *(secured)*: Delete locale ID on a cluster

### /2.0/nwfabric/hosts/{hostID}
Network virtualization component host configuration

* **get** *(secured)*: Read the locale ID on a host
* **put** *(secured)*: Update the locale ID on a host
* **delete** *(secured)*: Delete locale ID on a host

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

## macset
Operations on an individual MACset

### /2.0/services/macset/{macsetId}

* **get** *(secured)*: Retrieve details about a MACset
* **put** *(secured)*: Modify an existing MACset
* **delete** *(secured)*: Delete a MACset

## macsetScopes
Working with MAC Sets.

### /2.0/services/macset/scope/{scopeId}

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
* **put** *(secured)*: Updates a L3 DFW Section. To do this you need to read it first, make your changes,
and then update the section by supplying the Etag value received in the read in the If-Match header

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
Operations on flowdata

### /2.1/app/flow/flowstats
Retrieve flow statistics for a datacenter, port group, VM, or vNIC

* **get** *(secured)*: Retrieve flow statistics for a datacenter, port group, VM, or vNIC

### /2.1/app/flow/flowstats/info
Flow statistics info

* **get** *(secured)*: Retrieve flow statistics info

### /2.1/app/flow/config
Configure flow Monitoring

* **get** *(secured)*: Retrieve flow details
* **put** *(secured)*: Update specified flows

### /2.1/app/flow/{contextId}
Flow configuration by contextId

* **delete** *(secured)*: Delete flow records for context by contextId

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
body

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
You can add an NSX Edge internal or uplink interface as a virtual
server

* **post** *(secured)*: Add a virtual server
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

## nsxEdgeUpgrade
Upgrading NSX Edge

### /3.0/edges/{edgeID}

* **post** *(secured)*: Upgrade NSX Edge

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

