#--------------------------------------------------------------------------------
# Autor: Tommaso und Rene
# Funktion des Skripts: Dieses Skript hat 3 Funktionen um den User zu unlocken, Passwort ändern und auch um diese zu aktivieren.
# Datum: 24.05.2023
# Version: 1.0
# Bemerkungen:
#--------------------------------------------------------------------------------


Import-Module ActiveDirectory
function Unlock-ADBenutzer {
    
    $username = Read-Host "Geben Sie den Benutzernamen ein"
    $user = Get-ADUser -Identity $username -Properties LockedOut -ErrorAction SilentlyContinue

    if ($user -eq $null) {
        Write-Host "Das Konto "$username" existiert nicht." 
    } else {
        $locked = $user.LockedOut
        if ($locked) {
            Unlock-ADAccount -Identity $username
            Write-Host "Das Konto "$username" wurde erfolgreich entsperrt."
        } else {
            Write-Host "Das Konto "$username" ist nicht gesperrt."
        }
    }
}

function Aktivieren-ADBenutzer {

    $username = Read-Host "Geben Sie den Benutzernamen ein"
    $user = Get-ADUser -Identity $Username -ErrorAction SilentlyContinue

    if ($user -eq $null) {
        Write-Output "Das Konto $Username existiert nicht." 
    } elseif ($user.Enabled -eq $true) {
        Write-Output "Das Konto $Username ist bereits aktiviert."
    } else {
        Enable-ADAccount -Identity $Username
        Write-Output "Das Konto $Username wurde aktiviert."
    }
}

function Passwort-ändern {
    
    $username = Read-Host "Geben Sie den Benutzernamen ein"
    $user = Get-ADUser -Identity $Username -ErrorAction SilentlyContinue
    if ($user -eq $null) {
        Write-Output "Das Konto $Username existiert nicht." 
    } else {
        $newPassword = Read-Host "Geben Sie das neue Passwort ein" -AsSecureString
        Set-ADAccountPassword -Identity $Username -NewPassword $newPassword -Reset
        Write-Output "Das Passwort fuer das Konto $Username wurde erfolgreich geaendert."
    }
}

