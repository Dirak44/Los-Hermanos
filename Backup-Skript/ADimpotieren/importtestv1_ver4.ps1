Import-Module ".\Powershell-Skript\log.psm1"
Import-Module ActiveDirectory

function ADimpotieren {
    param (
        [int]$counter = 0,
        [Object]$namespace = $null
    )
    $namespace = New-Object System.Xml.XmlNamespaceManager($Global:schueler.NameTable)
    $namespace.AddNamespace("ns", "http://schemas.microsoft.com/powershell/2004/04")

    # Funktion zum Erstellen einer OU
    function OUerstellen($ouName, $ouPath) {
        if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$ouName'")) {
            New-ADOrganizationalUnit -Name $ouName -Path $ouPath
            Write-Host "OU erstellt: $ouName"
        }
    }

    # OU für Benutzer erstellen
    $usersOU = "Benutzer"
    $usersOUPath = "OU=$usersOU,DC=deine-domain,DC=com"
    OUerstellen $usersOU $usersOUPath

    # OU für Gruppen erstellen
    $groupsOU = "Gruppen"
    $groupsOUPath = "OU=$groupsOU,DC=deine-domain,DC=com"
    OUerstellen $groupsOU $groupsOUPath

    foreach ($obj in $Global:schueler.SelectNodes("//ns:Obj", $namespace)) {
        # MS-Element auslesen
        $msElement = $obj.SelectSingleNode("ns:MS", $namespace).InnerText
    
        # Attribute aus dem MS-Element extrahieren
        $attributes = $msElement -split ';'

        # Attribute in Variablen speichern
        $name = $attributes[0]
        $vorname = $attributes[1]
        $benutzername = $attributes[2]
        $klasse = $attributes[3]
        $klasse2 = $attributes[4]
    
        # Benutzer im AD erstellen
        $schuelerParams = @{
            'SamAccountName' = $benutzername
            'GivenName' = $vorname
            'Surname' = $name
            'Name' = "$vorname $name"
            'UserPrincipalName' = "$benutzername@bztf.local"
            'Enabled' = $true
            'PasswordNeverExpires' = $true
            'AccountPassword' = (ConvertTo-SecureString -String $Global:InitPw -AsPlainText -Force)
            'ChangePasswordAtLogon' = $false
        }
    
        New-ADUser @schuelerParams -Path $usersOUPath -ErrorAction SilentlyContinue

        # Fortschritt anzeigen
        $counter++
        Write-Host "Schueler erstellt: $benutzername" + "Anzahl impotierts: $counter"

        # Klassen als Gruppen erstellen und Schülern zuweisen
        $classGroup = "Klasse-$klasse"
        if (-not (Get-ADGroup -Filter "Name -eq '$classGroup'")) {
            New-ADGroup -Name $classGroup -GroupScope Global -Path $groupsOUPath -ErrorAction SilentlyContinue
            Write-Host "Klasse erstellt: $classGroup"
        }
        Add-ADGroupMember -Identity $classGroup -Members $benutzername
        Write-Host "Schüler $benutzername der Klasse $classGroup hinzugefuegt"

        $classGroup2 = "Klasse-$klasse2"
        if (-not (Get-ADGroup -Filter "Name -eq '$classGroup2'")) {
            New-ADGroup -Name $classGroup2 -GroupScope Global -Path $groupsOUPath -ErrorAction SilentlyContinue
            Write-Host "Klasse erstellt: $classGroup2"
        }
        Add-ADGroupMember -Identity $classGroup2 -Members $benutzername
        Write-Host "Schüler $benutzername der Klasse $classGroup2 hinzugefuegt"
    }
}

ADimpotieren
