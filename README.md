<h1>Active Directory Project</h1>

 ### [YouTube Demonstration](https://youtu.be/7eJexJVCqJo)

<h2>Description</h2>
Project consists of a simple PowerShell script that walks the user through "zeroing out" (wiping) any drives that are connected to the system. The utility allows you to select the target disk and choose the number of passes that are performed. The PowerShell script will configure a diskpart script file based on the user's selections and then launch Diskpart to perform the disk sanitization.
<br />


<h2>Languages and Utilities Used</h2>

- <b>PowerShell</b> 
- <b>Diskpart</b>

<h2>Environments Used </h2>

- <b>Windows 11</b> (25H2)

<h2>Program walk-through:</h2>

<p align="center">
This lab project uses Windows Server 2022 as the Domain Controller and Windows 11 Pro (25H2) as the client machine. The resource allocations provisioned for both virtual machines are 4 vCPU Cores, 4GB of RAM, and 80GB of storage. The Domain Controller is configured with both a NAT and an Internal NIC, while the Client is configured with only an Internal NIC. <br/>
<img width="990" height="870" alt="image" src="https://github.com/user-attachments/assets/bff4b740-7e79-4b5e-afb9-72a40ebdff05" />
This lab uses the Windows Server Desktop Experience (GUI) to replicate a real-world enterprise Active Directory management environment and provide clear visual confirmation of configurations. For the scope of this proof-of-concept lab, a standardized, complex password was utilized across both the domain controller and client machine to streamline deployment while still satisfying default Windows Server password complexity requirements. <br/>
<br />
<br />
Select the disk:  <br/>
<img src="https://i.imgur.com/tcTyMUE.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
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
