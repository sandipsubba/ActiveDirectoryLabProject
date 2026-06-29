<# SYNOPSIS: Automates bulk user provisioning into a specific Active Directory OU.
   DESCRIPTION: Reads a list of unique names from a local text file, parses first and last names,
   generates standard 'firstname.lastname' usernames, and provisions them into the _EMPLOYEES
   Organizational Unit using advanced PowerShell splatting.
   PARAMETER PASSWORD_FOR_USERS: The default password assigned to all newly created user accounts.
   OUTPUTS: Outputs real-time creation status to the console window.
#>

#Requires -Modules ActiveDirectory

$PASSWORD_FOR_USERS = "Password0"
$NamesFilePath = "$PSScriptRoot\names.txt"

if (-not(Test-Path $NamesFilePath)) {
    Write-Error "Could not find names.txt!!! Run the generate script first"
    return
}

$UserList = Get-Content -Path $NamesFilePath
$count = 1

foreach ($Name in $UserList) {
    $NameParts = $Name.Trim() -split ' '
    $FirstName = $NameParts[0]
    $LastName = $NameParts[1..($NameParts.Count - 1)] -join ' '

    $Username = "$($FirstName.ToLower()).$($LastName.ToLower())"
    $Password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force

    Write-Host "[$count/500] Creating user: $Username" -ForegroundColor Green

    $UserParams = @{
        AccountPassword      = $Password
        GivenName            = $FirstName
        Surname              = $LastName
        DisplayName          = $Name
        Name                 = $Name
        SamAccountName       = $Username
        EmployeeID           = $count
        PasswordNeverExpires = $false
        Path                 = "ou=_EMPLOYEES,$(([ADSI]`"").distinguishedName)"
        Enabled              = $true
    }
    New-ADUser @UserParams

    $count++
}

[commit changes]
