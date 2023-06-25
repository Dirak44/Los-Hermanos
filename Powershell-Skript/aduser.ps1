
# Abfrage der Benutzer ohne Passwort
$usersWithoutPassword = Get-ADUser -Filter {Enabled -eq $true -and PasswordNeverExpires -eq $false} -Properties PasswordLastSet |
    Where-Object { $_.PasswordLastSet -eq $null }

# Ausgabe der Übersicht
Write-Output "Benutzer ohne Passwort in der Active Directory:"
Write-Output "----------------------------------------------"
foreach ($user in $usersWithoutPassword) {
    Write-Output "Benutzername: $($user.SamAccountName)"
    Write-Output "DistinguishedName: $($user.DistinguishedName)"
    Write-Output ""
}


