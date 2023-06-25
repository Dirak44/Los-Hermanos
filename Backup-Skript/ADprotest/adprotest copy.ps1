Import-Module ".\Powershell-Skript\log.psm1"
Import-Module ActiveDirectory

function Log-ADUserInformation {
    $targetTime = Get-Date -Hour 15 -Minute 1 -Second 0

    # Überprüfen, ob die aktuelle Uhrzeit vor der Zielzeit liegt
    if ((Get-Date) -lt $targetTime) {
        # Berechnen der verbleibenden Zeit bis zur Zielzeit
        $waitTime = $targetTime - (Get-Date)

        Write-Host "Warten auf $targetTime..."
        Start-Sleep -Seconds $waitTime.TotalSeconds
    }

    # Zeitpunkt der Protokollierung
    $timestamp = Get-Date -Format "yyyy-MM-dd 15:mm:ss"

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
Log-ADUserInformation