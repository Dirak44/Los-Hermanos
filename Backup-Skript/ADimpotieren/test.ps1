#--------------------------------------------------------------------------------
# Autor: Tommaso und Rene
# Funktion des Skripts: Usere Testumgebung um bestimmte Funktione/Abläufe zu testen.
# Datum: 11.05.2023
# Version: 1.0
# Bemerkungen: Hat nicht funktioniert
#--------------------------------------------------------------------------------

Import-Module ".\Powershell-Skript\log.psm1"
Import-Module ActiveDirectory
foreach ($Global:schueler in $schuelers) {
    New-ADUser -name $schueler.Name -GivenName $schueler.FirstName -Surname $schueler.Lastname -SamAccountName $schueler.Username -UserPrincipalName $schueler.UPN -AccountPassword (ConvertTo-SecureString $schueler.Password -AsPlainText -Force) -Enabled $true
    Write-Host "Benutzer $($user.Name) wurde erstellt."
}


foreach ($schueler in $xml.schuelers.schueler) {
    $schuelernachname  = $schueler.Name
    $schuelervorname = $schueler.Vorname
    $schuelerusername = $schueler.Benutzername
    $schuelerklasse1 = $schueler.Klasse
    $schuelerklasse2 = $schueler.Klasse2


    # Hier fügst du deinen Code hinzu, um den Benutzer im AD zu erstellen
    # Du kannst z.B. das New-ADUser-Cmdlet verwenden
    New-ADUser -SamAccountName $schuelerusername -Surname $schuelernachname 

    # Gib eine Bestätigungsmeldung aus
    Write-Host "Benutzer '$schuelerusername' wurde erfolgreich erstellt."
}