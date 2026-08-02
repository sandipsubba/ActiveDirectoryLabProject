<#  .SYNOPSIS
    Interactive Active Directory user lookup and account management tool.
    .DESCRIPTION 
    Queries Active Directory for a user’s account status  (Enabled, Lockout, Last Logon, Password Set) and provides an interactive menu to unlock the account or reset the password.
    .PARAMETER USERNAME 
    The SamAccountName (Username) of the target Active Directory user account.
    .OUTPUTS 
    Displays account status and messages on the console in real-time.
#>

param(
    [parameter(Mandatory=$true)]
    [string]$Username
)

Import-Module ActiveDirectory

$user = $null

$user = Get-ADUser -Identity $Username -Properties Enabled, LastLogonDate, PasswordLastSet, LockedOut -ErrorAction SilentlyContinue

if(-not $user) {
    Write-Host "[!] User '$Username' not found" -ForegroundColor Red
    exit
}

if ($user.LockedOut) {
    $color = "Red"
} else {
    $color = "Green"
}

Write-Host "---Account Status For: $($user.Name)---" -ForegroundColor Cyan
Write-Host "Username: $($user.SamAccountName)"
Write-Host "Enabled: $($user.Enabled)"
Write-Host "Locked Out: $($user.LockedOut)" -ForegroundColor $color
Write-Host "Last Logon: $($user.LastLogonDate)"
Write-Host "Password Set: $($user.PasswordLastSet)"
Write-Host "------------"

Write-Host "Select an action" -ForegroundColor Yellow
Write-Host "1) Unlock account"
Write-Host "2) Reset password to default (Password0)"
Write-Host "3) Exit"

$choice = Read-Host "Enter option (1-3)"

switch($choice) {
    1{
    Unlock-ADAccount -Identity $Username
    Write-Host "[+] Success: account '$Username' unlocked." -ForegroundColor Green
    }
    2{
    $securePass = ConvertTo-SecureString "Password0" -AsPlainText -Force
    Set-ADAccountPassword -Identity $Username -NewPassword $securePass -Reset
    Set-ADUser -Identity $Username -ChangePasswordAtLogon $true
    Write-Host "[+] Success: password reset to 'Password0'." -ForegroundColor Green
    }
    3{
    Write-Host "Exiting, Goodbye." -ForegroundColor Magenta
    }
    default { Write-Host "[!] Invalid selection" }
}
