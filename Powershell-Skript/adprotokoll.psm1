#--------------------------------------------------------------------------------
# Autor: Tommaso und Rene
# Funktion des Skripts: Das ist unser Skript das wir ausführen und von dort auf die verschiede Funktion zuzugreifen
# Datum: 19.05.2023
# Version: 1.0
# Bemerkungen:
#--------------------------------------------------------------------------------

Import-Module ".\Powershell-Skript\log.psm1"
Import-Module ActiveDirectory

function Write-Log {
    param (
        [string]$Message
    )
    Add-content -Path $Global:LogFileUser -Value "$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss')) - $Message"
}

function Log-ADUserInfo {

    if(!(Test-Path $Global:tmppath))
{
    new-item -ItemType Directory -Path $Global:tmppath
    Write-Host Order tmp unter $Global:tmppath wurde erstellt.
}else {
    Write-Host dieser Order ist schon bereits vorhanden.
}

    # Zeitpunkt der Protokollierung
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Alle AD-Benutzer abrufen
    $users = Get-ADUser -Filter * -Properties PasswordLastSet, LastLogonDate, LogonCount

    foreach ($user in $users) {
        $username = $user.SamAccountName
        $passwordAge = (Get-Date) - $user.PasswordLastSet
        $lastLogon = $user.LastLogonDate
        $loginCount = $user.LogonCount

        $logMessage = "Username: $username, Password Age: $passwordAge, Last Logon: $lastLogon, Login Count: $loginCount"

        Write-Log -Message $logMessage
    }
    Write-Host "AD User information logged successfully for $users.Count users."
}
