Import-Module ".\Powershell-Skript\log.psm1"
Import-Module ActiveDirectory

function ADimpotieren {
    param (
        [int]$counter = 0,
        [Object]$namespace = $null
    )
    $namespace = New-Object System.Xml.XmlNamespaceManager($Global:schueler.NameTable)
    $namespace.AddNamespace("ns", "http://schemas.microsoft.com/powershell/2004/04")

    $ouPath = $Global:OUPath

    # Überprüfen, ob die OU "Klassengruppen" vorhanden ist, andernfalls erstellen
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Klassengruppen'")) {
        New-ADOrganizationalUnit -Name "Klassengruppen" -Path $ouPath -ErrorAction SilentlyContinue
        Write-Host "OU 'Klassengruppen' erstellt"
    }

    foreach ($obj in $Global:schueler.SelectNodes("//ns:Obj", $namespace)) {
        $msElement = $obj.SelectSingleNode("ns:MS", $namespace).InnerText
        $attributes = $msElement -split ';'

        $name = $attributes[0]
        $vorname = $attributes[1]
        $benutzername = $attributes[2]
        $klasse = $attributes[3]
        $klasse2 = $attributes[4]

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

        New-ADUser @schuelerParams -Path $Global:OUPathlernende -ErrorAction SilentlyContinue

        $counter++
        Write-Host "Schüler erstellt: $benutzername" + " Anzahl importiert: $counter"

        if ($klasse) {
            $classGroup = "Klasse-$klasse"
            if (-not (Get-ADGroup -Filter "Name -eq '$classGroup'")) {
                New-ADGroup -Name $classGroup -GroupScope Global -Path $Global:OUPathklassegruppen -ErrorAction SilentlyContinue
                Write-Host "Klasse erstellt: $classGroup"
            }
            Add-ADGroupMember -Identity $classGroup -Members $benutzername
            Write-Host "Schüler $benutzername der Klasse $classGroup hinzugefuegt"
        }

        if ($klasse2) {
            $classGroup2 = "Klasse-$klasse2"
            if (-not (Get-ADGroup -Filter "Name -eq '$classGroup2'")) {
                New-ADGroup -Name $classGroup2 -GroupScope Global -Path $Global:OUPathklassegruppen -ErrorAction SilentlyContinue
                Write-Host "Klasse erstellt: $classGroup2"
            }
            Add-ADGroupMember -Identity $classGroup2 -Members $benutzername
            Write-Host "Schüler $benutzername der Klasse $classGroup2 hinzugefuegt"
        }
    }
}

ADimpotieren