This manual, the NSX for vSphere API Guide, describes how to install,
configure, monitor, and maintain the VMware® NSX system by using REST API
requests.

## Intended Audience

This manual is intended for anyone who wants to use REST API to
programmatically control NSX in a VMware vSphere environment. The information
in this manual is written for experienced developers who are familiar with
virtual machine technology, virtualized datacenter operations, and REST APIs.
This manual also assumes familiarity with NSX for vSphere.

## VMware Technical Publications Glossary

VMware Technical Publications provides a glossary of terms that might be
unfamiliar to you. For definitions of terms as they are used in VMware
technical documentation go to http://www.vmware.com/support/pubs.

## Technical Documentation and Product Updates

You can find the most up-to-date technical documentation on the VMware Web site at:
http://www.vmware.com/support/.

The VMware Web site also provides the latest product updates.

If you have comments about this documentation, submit your feedback to:
<docfeedback@vmware.com>.

## Using the NSX REST API

To use the NSX REST API, you must configure a REST client, verify the required
ports are open between your REST client and the NSX Manager, and understand
the general RESTful workflow.

### Configuring REST Clients for the NSX REST API

Some browser-based clients include the Chrome app, Postman, or the Firefox
add-on, RESTClient. Curl is a command-line tool that can function as a REST
client. The details of REST client configuration will vary from client to
client, but this general information should help you configure your REST client
correctly.


* **The NSX REST API uses basic authentication.**   
You must configure your REST client to send the NSX Manager authentication
credentials using basic authentication.

* **You must use https to send API requests to the NSX Manager.**   
You might need to import the certificate from the NSX Manager to your REST
client to allow it to connect to the NSX Manager.

* **When you submit an API request with an XML request body, you must include the  
`Content-Type: application/xml` header.**   
Some requests require additional headers, for example, firewall configuration
changes require the `If-Match` header. This is noted on each method
description.

* **To ensure you always receive XML response bodies, set the `Accept:  
application/xml` header.**  
Some API methods respond with JSON output, which is an experimental feature.
Setting the Accept header ensures you always get XML output.  **Note:** some
methods, for example, the central CLI method, `POST /1.0/nsx/cli`, might
require a different Accept header.

The following API method will return a response on a newly deployed NSX
Manager appliance, even if you have not made any configuration changes. You
can use this as a test to verify that your REST client is configured correctly
to communicate with the NSX Manager API.

`GET /api/2.0/services/usermgmt/user/admin`

### Ports Required for the NSX REST API

The NSX Manager requires port 443/TCP for REST API requests.

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
