#--------------------------------------------------------------------------------
# Autor: Tommaso und Rene
# Funktion des Skripts: Das ist unser Skript das wir ausführen und von dort auf die verschiede Funktion zuzugreifen
# Datum: 19.05.2023
# Version: 1.2
# Bemerkungen:
#--------------------------------------------------------------------------------

Import-Module ".\Powershell-Skript\log.psm1"
Import-Module ".\Powershell-Skript\adimport.psm1"
Import-Module ".\Powershell-Skript\adprotokoll.psm1"
Import-Module ".\Powershell-Skript\aduseranpassung.psm1"
Import-Module ".\Powershell-Skript\aduseruebersicht.psm1"

Import-Module ActiveDirectory


while($true){
    "
    
    ******************************************
                AD-Verwaltung
    ******************************************
    Hinweis: Starten sie das Skirpt als Admin
    ******************************************
    0. Exit
    1. ADimport
    2. Sicherheitsinfo
    3. User anpassen
    4. Uebersicht Benutzer
    ******************************************
    
    "
    $Eingabe = read-host -prompt "Bitte Zahl eingeben"

    if($Eingabe -eq '0'){
     exit
    }elseif($Eingabe -eq '1'){
        Write-Host 'ADimport wird ausgeführt...' -ForegroundColor Green
        Start-Sleep -Seconds 5
        ADimpotieren
    } elseif($Eingabe -eq '2'){
        Write-Host 'Sicherheitsinfo werden abgerufen unter c:\tmp gespeichert...' -ForegroundColor Green
        Start-Sleep -Seconds 5
        Log-ADUserInfo
    } elseif($Eingabe -eq '3'){
        "

        ******************************************
        Was moechten sie am User aendern?
        0. Zurueck zum Hauptmenu
        1. Unlock-Benutzer
        2. Aktivieren-ADBenutzer
        3. User Passwort 
        4. Uebersicht Benutzer
        ******************************************
        
        "
        $Eingabe2 = read-host -prompt "Bitte Zahl eingeben"

        if($Eingabe2 -eq '0'){
            Write-Host 'Zurueckkehren zum Hauptmenu....' -ForegroundColor Green
            Start-Sleep -Seconds 5
        }elseif($Eingabe2 -eq '1'){
            Start-Sleep -Seconds 5
            Unlock-ADBenutzer
        }elseif($Eingabe2 -eq '2'){
            Start-Sleep -Seconds 5
            Aktivieren-ADBenutzer
        }elseif($Eingabe2 -eq '3'){
            Start-Sleep -Seconds 5
            Passwort-ändern
        }else{
            Write-Host 'Die Eingabe ist keine Zahl zwischen 0 und 4' -ForegroundColor Red
            Start-Sleep -Seconds 5
        }

    }elseif($Eingabe -eq '4')
    {
        SelectFunction
        Start-Sleep -Seconds 3
    }else{
        Write-Host 'Die Eingabe ist keine Zahl zwischen 0 und 4' -ForegroundColor Red
        Start-Sleep -Seconds 3
    }

}




