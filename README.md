<h1>Active Directory Project</h1>

<h2>Description</h2>
Project consists of a simple PowerShell script that walks the user through "zeroing out" (wiping) any drives that are connected to the system. The utility allows you to select the target disk and choose the number of passes that are performed. The PowerShell script will configure a diskpart script file based on the user's selections and then launch Diskpart to perform the disk sanitization.
<img width="651" height="701" alt="grand drawio" src="https://github.com/user-attachments/assets/b198db06-1fd2-4364-85cd-e20f078a4244" />


<br />


<h2>Languages and Utilities Used</h2>

- <b>PowerShell</b> 
- <b>Diskpart</b>

<h2>Environments Used </h2>

- <b>Windows2022Server</b>
- <b>Windows 11</b> (25H2)
<h2>Program walk-through:</h2>

<p align="left">
<b>Lab Specifications & Network Architecture</b>
 
This lab project uses Windows Server 2022 as the Domain Controller and Windows 11 Pro (25H2) as the client machine. The resources allocated for both virtual machines are 4 CPU Cores, 4GB of RAM, and 80GB of storage. The Domain Controller is configured with both a NAT and an Internal NIC, while the Client is configured with only an Internal NIC. <br/>

<img width="990" height="870" alt="image" src="https://github.com/user-attachments/assets/bff4b740-7e79-4b5e-afb9-72a40ebdff05" />
<p align="left">
<b>Installation & Configuration Details</b>

This lab uses the Windows Server Desktop Experience (GUI) to replicate a real-world enterprise Active Directory management environment and provide clear visual confirmation of configurations.

<b>Steps taken during and immediately after the setup process:</b>
- <b>Credential Standardization:</b> For the scope of this lab, a single complex password was used across both the domain controller and client machine to simplify deployment while still meeting the default Windows Server password complexity requirements.
- <b>VirtualBox Guest Additions:</b> Installed on both virtual machines immediately following deployment. This step improves mouse pointer integration, display scaling, and VM responsiveness.
<br/>
<br />
<h2></h2>
<b>Network Interface & DNS Settings</b>

The Domain Controller was configured with a static IPv4 address on the internal network. The default gateway was left blank because this interface is used only for internal communication within the virtual lab, while routing is handled through the NAT adapter.

<b>DNS Loopback Integration</b>

The Preferred DNS Server was set to the loopback address 127.0.0.1, so the Domain Controller resolves names using its own local DNS service. Since Active Directory heavily relies on DNS to map the location of domain resources, this ensures reliable name resolution within the lab environment.

<img width="1024" height="768" alt="network settings ipv4" src="https://github.com/user-attachments/assets/606429f1-1948-47e8-a821-0aebbf2f2da3" />
<p align="left">
<b>Computer Renaming & System Identity</b>
 
Before configuring roles or promoting the server, the computer name was changed from the default Windows-generated string to a standardized hostname: 2022-ServerDC. This is considered best practice because the hostname is used throughout Active Directory and related services to identify the server. Renaming a Domain Controller after promotion can introduce complications and require additional steps to update directory records and service references.
<br />
<br />
<br />
<h2></h2>
<b>Active Directory Domain Services (AD DS) Installation</b>

The next step was installing AD DS. This step installs the core software files for the server to be promoted to a Domain Controller.
- <b>Active Directory Domain Services:</b> This service establishes a centralized infrastructure for user authentication, network resource management, and secure domain access.
- <b>Group Policy Management:</b> This enables centralized management of configurations, allowing administrators to push security baselines, software updates, and restrictions to domain-joined assets.
- <b>Remote Server Administration Tools (RSAT):</b> Installs the suite of local GUI and powershell tools that allow the IT Administrator to manage server roles and services remotely.

The last step was to promote the server to a Domain Controller by selecting "Add a new forest" and naming the root domain mydomain.org.

<img width="1024" height="768" alt="AD installation" src="https://github.com/user-attachments/assets/61587d6d-14a8-4a0a-9bed-116e5aa84ca4" />
<b>Administrative Account Separation:</b> Following the initial domain setup, enterprise best practice dictates that configuring and installing other Active Directory services should be done with an actual Administrative account rather than a default built-in Windows Administrator profile. To implement this, Active Directory Users and Computers or ADUC was used to create a new Organizational Unit (OU) named Admins. A new user account was then created inside this OU and directly added to the Domain Admins group.

<br />
<br />
<h2></h2>
<b>Routing and Remote Access (RAS/NAT)</b>

Following the login to the new Administrative account, the next phase was deploying the Routing and Remote Access Service (RRAS). Configuring RRAS with Network Address Translation (NAT) allows internal client virtual machines to securely access the internet through the host server's external network interface. This configuration ensures the server acts as a gateway for the client machines while isolating them from the physical home network.

<img width="1024" height="767" alt="routing and remote" src="https://github.com/user-attachments/assets/52bef14d-35a8-4dd4-b51a-0e7342d6f5dc" />

<br />
<br />
<h2></h2>
<b>DHCP Server Installation</b>

This phase deploys the DHCP Server role, which automates network configuration for the internal virtual machine clients. This enables the internal clients to automatically receive a valid IP address, subnet mask, default gateway, and the correct DNS settings.

<img width="1024" height="767" alt="DHCP" src="https://github.com/user-attachments/assets/1b3429e7-d5e6-4c14-9deb-dc01a8b10a16" />

<br />
<br />
<h2></h2>
<b>DHCP Scope</b>

To complete the deployment of the DHCP server role, a new DHCP scope was configured within the 172.16.0.0/24 subnet, establishing an address pool from 172.16.0.100 to .200. Within the scope options, the default gateway was set to 172.16.0.1, ensuring all internal clients automatically route through the network's local NAT gateway to access external networks. 

<img width="1024" height="767" alt="DHCPFinal" src="https://github.com/user-attachments/assets/e7e2729e-f457-4a04-801f-9d179c610671" />

<br />
<br />
<h2></h2>
<b>Generate Unique Names</b>

Instead of downloading a generic list of names from the internet, I created a custom PowerShell script that was built to generate a completely randomized list of 500 unique names. The script pulls from arrays of first and last names, dynamically checks each combination against a tracking list to ensure the name is unique, and skips duplicates. Once 500 unique names are successfully generated, they are exported to a text file "names.txt", which will be used as the data input for the next script.

<img width="1024" height="767" alt="realtxt" src="https://github.com/user-attachments/assets/6ff4d43e-ae0d-4084-a877-b2edb631bbc3" />
<br />
<br />
<br />
<h2></h2>
<b>Bulk Active Directory Provisioning</b>

With the raw data generated, I created a second custom PowerShell script that was built to parse "names.txt" and automatically create the accounts. The script reads each line, splits the full name into individual first and last name strings, and dynamically constructs standardized `firstname.lastname` usernames. Using a parameter splatting hashtable "@UserParams", the script maps out the unique user attributes-including secure passwords and different Employee IDs-before executing `New-ADUser` to rapidly create all 500 records directly to an organizational unit named "_EMPLOYEES".

<img width="1024" height="767" alt="realcreate" src="https://github.com/user-attachments/assets/7044ac29-1236-4c22-a19e-04a9211e3c3b" />
<br />
<br />
<br />
<h2></h2>
<b>Infrastructure and Network Connectivity Validation</b>

Directly following the execution of the bulk script, the Windows 11 client machine was booted and accessed via the local user account to perform a pre-join audit. Using the Command Prompt, an `ipconfig` analysis verified proper IP network addressing within the isolated lab environment. The Following connectivity tests were performed using the ping utility: an internal ping successfully validated DNS resolution and low-latency traversal to the Active Directory Domain Controller (mydomain.org), while an outbound request was executed through an external network (google.com), confirming functional NAT routing and gateway access.

<img width="1024" height="768" alt="realping" src="https://github.com/user-attachments/assets/0fcf728c-16f4-4712-9254-5a3ed35771fc" />

<br />
<br />
<br />
<h2></h2>
<b>Active Directory Domain Integration</b>

With the validation of network connectivity and DNS resolution, the Windows 11 Pro machine (client1) was successfully joined to the "mydomain.org" Active Directory domain using privileged credentials. This establishes secure communication between the client and the primary Domain Controller, finalizing this workstation's transition into the enterprise directory infrastructure.

<img width="1024" height="768" alt="realjoin" src="https://github.com/user-attachments/assets/52c296db-f309-49d0-91b2-59f43d93389d" />
<br />
<br />
<br />
<h2></h2>
<b>User Authentication and Domain Session Verification</b>

Following the successful domain integration and a system restart, authentication was verified by logging into the workstation using the domain account "andrew.jones", which was provisioned during the bulk script. The Command Prompt was utilized to run the `whoami` utility, confirming an active domain session context ("mydomain\andrew.jones"). This test validates the workstation securely works with the Active Directory Domain Controller and that script-created directory objects are fully operational for enterprise network access.

<img width="1024" height="768" alt="whoami" src="https://github.com/user-attachments/assets/3e8aff1d-61e3-4f84-bd3c-fdd8864a72ff" />
<br />
<br />
<br />
<h2></h2>
<b>Group Policy Enforcement and Security Baseline Verification</b>

A security baseline configuration was executed using the Group Policy Management Console (GPMC). To deliver these security thresholds to the client machine, a forced policy update was initiated. Utilizing the Command Prompt on the target machine, the `gpresult /r` utility was used to audit the configuration. As shown in the picture, the resulting output verifies that the account lockout policies and administrative restrictions are actively binding directory objects within the "_HR" Organizational Unit.

<img width="1024" height="768" alt="finalbaseline" src="https://github.com/user-attachments/assets/78661b73-1cd2-4d74-97bc-d04983b5cf9b" />

</p>

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
