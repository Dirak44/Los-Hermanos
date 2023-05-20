#--------------------------------------------------------------------------------
# Autor: Tommaso und Rene
# Funktion des Skripts: Usere Testumgebung um bestimmte Funktione/Abläufe zu testen.
# Datum: 11.05.2023
# Version: 1.0
# Bemerkungen:
#--------------------------------------------------------------------------------

Import-Module ".\Powershell-Skript\log.psm1"
Import-Module ActiveDirectory
foreach ($Global:schueler in $schuelers) {
    New-ADUser -name $schueler.Name -GivenName $schueler.FirstName -Surname $schueler.Lastname -SamAccountName $schueler.Username -UserPrincipalName $schueler.UPN -AccountPassword (ConvertTo-SecureString $schueler.Password -AsPlainText -Force) -Enabled $true
    Write-Host "Benutzer $($user.Name) wurde erstellt."
}