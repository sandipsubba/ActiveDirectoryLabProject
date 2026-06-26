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

<b>Steps that were immediately taken after the setup process:</b>
- <b>VirtualBox Guest Additions:</b> Installed on both virtual machines immediately following deployment. This step improves mouse pointer integration, display scaling, and VM responsiveness.
- <b>Credential Standardization:</b> For the scope of this lab, a single complex password was used across both the domain controller and client machine to simplify deployment while still meeting the default Windows Server password complexity requirements.
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
Enter the number of passes: <br/>
<img src="https://i.imgur.com/nCIbXbg.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Confirm your selection:  <br/>
<img src="https://i.imgur.com/cdFHBiU.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Wait for process to complete (may take some time):  <br/>
<img src="https://i.imgur.com/JL945Ga.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Sanitization complete:  <br/>
<img src="https://i.imgur.com/K71yaM2.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Observe the wiped disk:  <br/>
<img src="https://i.imgur.com/AeZkvFQ.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
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
