#--------------------------------------------------------------------------------
# Autor: Tommaso und Rene
# Funktion des Skripts: Hier werden die Sachen der User ausgelesen.
# Datum: 26.06.2023
# Version: 1.0 
# Bemerkungen: 
#--------------------------------------------------------------------------------

Import-Module ActiveDirectory

# Funktion zur Anzeige der Übersicht aller AD-Benutzer ohne Passwort
function ShowADUsersWithoutPassword {
    $users = Get-ADUser -Filter {(PasswordNeverExpires -eq $true) -and (Enabled -eq $false)} -Properties SamAccountName

    Write-Host "Übersicht der AD-Benutzer ohne Passwort:"
    foreach ($user in $users) {
        Write-Host "Benutzername: $($user.SamAccountName)"
    }
}

# Funktion zur Anzeige der Übersicht aller AD-Benutzer mit Passwort, das nie abläuft
function ShowADUsersWithPassword {
    $usersWithPassword = Get-ADUser -Filter {(PasswordNeverExpires -eq $true) -and (Enabled -eq $false)} -Properties SamAccountName

    Write-Host "Übersicht der AD-Benutzer mit Passwort, das nie abläuft:"
    foreach ($user in $usersWithPassword) {
        Write-Host "Benutzername: $($user.SamAccountName)"
    }
}

# Funktion zur Anzeige der Übersicht aller deaktivierten und gesperrten AD-Benutzer
function ShowDisabledAndLockedOutADUsers {
    $disabledUsers = Get-ADUser -Filter {Enabled -eq $false} -Properties SamAccountName
    $lockedOutUsers = Search-ADAccount -LockedOut | Select-Object -ExpandProperty SamAccountName

    Write-Host "Übersicht der deaktivierten und gesperrten AD-Benutzer:"
    foreach ($user in $disabledUsers) {
        Write-Host "Benutzername: $($user.SamAccountName)"
    }
    foreach ($user in $lockedOutUsers) {
        Write-Host "Benutzername: $user"
    }
}

# Funktion zur Anzeige der umfassenden Übersicht aller AD-Benutzer
function ShowComprehensiveADUserOverview {
    $users = Get-ADUser -Filter * -Properties *

    Write-Host "Umfassende Übersicht aller AD-Benutzer:"
    foreach ($user in $users) {
        Write-Host "Benutzername: $($user.SamAccountName)"
        Write-Host "Passwort nie abläuft: $($user.PasswordNeverExpires)"
        Write-Host "Deaktiviert: $($user.Enabled)"
        Write-Host "Gesperrt: $(IsUserLockedOut $user.SamAccountName)"
        Write-Host "------------------------"
    }
}

# Funktion zur Überprüfung, ob ein Benutzer gesperrt ist
function IsUserLockedOut($username) {
    $user = Get-ADUser -Identity $username -Properties LockedOut
    return $user.LockedOut
}

# Funktion zur Auswahl der gewünschten Übersicht
function SelectFunction {
    Write-Host " "
    Write-Host " "
    Write-Host "    ******************************************"
    Write-Host "    Bitte wähle eine Funktion:"
    Write-Host "    0. Exit"
    Write-Host "    1. Übersicht aller AD-Benutzer ohne Passwort"
    Write-Host "    2. Übersicht aller AD-Benutzer mit Passwort, das nie abläuft"
    Write-Host "    3. Übersicht der deaktivierten und gesperrten AD-Benutzer"
    Write-Host "    4. Umfassende Übersicht aller AD-Benutzer"
    Write-Host "    ******************************************"
    Write-Host " "
    Write-Host " "

    $choice = Read-Host "Gib die Nummer der gewünschten Funktion ein"

    switch ($choice) {
        "1" {
            ShowADUsersWithoutPassword
            SelectFunction
        }
        "2" {
            ShowADUsersWithPassword
            SelectFunction
        }
        "3" {
            ShowDisabledAndLockedOutADUsers
            SelectFunction
        }
        "4" {
            ShowComprehensiveADUserOverview
            SelectFunction
        }
        "0" {
            return
        }
        default {
            Write-Host "Ungueltige Eingabe. Bitte wähle eine Zahl zwischen 0 und 4."
            SelectFunction
        }
    }
}

