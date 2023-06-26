Import-Module ActiveDirectory

# Übersicht aller AD-Benutzer ohne Passwort, deren Passwort nie abläuft und deaktiviert/gesperrt sind
$users = Get-ADUser -Filter {(PasswordNeverExpires -eq $true) -and (Enabled -eq $false)} -Properties Name, SamAccountName, PasswordNeverExpires, Enabled |
    Where-Object { (Search-ADAccount -LockedOut -UsersOnly -SearchBase $_.DistinguishedName).Count -gt 0 }

# Ausgabe der Übersicht
Write-Host "Übersicht der AD-Benutzer ohne Passwort, deren Passwort nie abläuft und deaktiviert/gesperrt sind:"
foreach ($user in $users) {
    Write-Host "Benutzername: $($user.SamAccountName)"
    Write-Host "Name: $($user.Name)"
    Write-Host "Passwort nie abläuft: $($user.PasswordNeverExpires)"
    Write-Host "Aktiviert: $($user.Enabled)"
    Write-Host "Gesperrt: Yes"
    Write-Host "------------------------"
}

# Übersicht aller AD-Benutzer mit Passwort, das nie abläuft und deaktiviert/gesperrt sind
$usersWithPassword = Get-ADUser -Filter {(PasswordNeverExpires -eq $true) -and (Enabled -eq $false)} -Properties Name, SamAccountName, PasswordNeverExpires, Enabled |
    Where-Object { (Search-ADAccount -LockedOut -UsersOnly -SearchBase $_.DistinguishedName).Count -eq 0 }

# Ausgabe der Übersicht
Write-Host "Übersicht der AD-Benutzer mit Passwort, das nie abläuft und deaktiviert/gesperrt sind:"
foreach ($user in $usersWithPassword) {
    Write-Host "Benutzername: $($user.SamAccountName)"
    Write-Host "Name: $($user.Name)"
    Write-Host "Passwort nie abläuft: $($user.PasswordNeverExpires)"
    Write-Host "Aktiviert: $($user.Enabled)"
    Write-Host "Gesperrt: No"
    Write-Host "------------------------"
}
