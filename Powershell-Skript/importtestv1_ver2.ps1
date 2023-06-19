# Skript um AD Benutzer erstellen V3 hier versuche ich eine Funktion daraus zu machen

Import-Module ".\Powershell-Skript\log.psm1"
Import-Module ActiveDirectory

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

    # Funktion zum Erstellen einer Klasse
    function Gruppernerstellen($className) {
        if (-not (Get-ADGroup -Filter "Name -eq '$className'")) {
            New-ADGroup -Name $className -GroupScope Global -Path $groupsOUPath
            Write-Host "Klasse erstellt: $className"
        }
    }

    # Funktion zum Hinzufügen eines Schülers zu einer Klasse
    function Gruppenzuweisen($className, $studentName) {
        Add-ADGroupMember -Identity $className -Members $studentName
        Write-Host "Schüler $studentName der Klasse $className hinzugefuegt"
    }

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
            'UserPrincipalName' = "$benutzername@butzbach.ch"
            'Enabled' = $true
            'PasswordNeverExpires' = $true
            'AccountPassword' = (ConvertTo-SecureString -String 'DeinPasswort' -AsPlainText -Force)
            'ChangePasswordAtLogon' = $false
        }
    
        New-ADUser @schuelerParams -Path $usersOUPath -ErrorAction SilentlyContinue
    
        # Fortschritt anzeigen
        $counter++
        Write-Host "Schueler erstellt: $benutzername" + "Anzahl impotierts: $counter"

        # Klassen als Gruppen erstellen und Schülern zuweisen
        $classGroup = "Klasse-$klasse"
        Gruppernerstellen $classGroup
        Gruppenzuweisen $classGroup $benutzername

        $classGroup2 = "Klasse-$klasse2"
        Gruppernerstellen $classGroup2
        Gruppenzuweisen $classGroup2 $benutzername
    }
}
ADimpotieren