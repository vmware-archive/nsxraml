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
