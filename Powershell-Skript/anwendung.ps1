#--------------------------------------------------------------------------------
# Autor: Tommaso und Rene
# Funktion des Skripts: Das ist unser Skript das wir ausführen und von dort auf die verschiede Funktion zuzugreifen
# Datum: 19.05.2023
# Version: 1.1
# Bemerkungen:
#--------------------------------------------------------------------------------

Import-Module ".\Powershell-Skript\log.psm1"
Import-Module ".\Powershell-Skript\adimport.psm1"
Import-Module ".\Powershell-Skript\adprotokoll.psm1"
Import-Module ".\Powershell-Skript\aduseranpassung.psm1"

Import-Module ActiveDirectory


while($true){
    "Hinweis: Starten sie das Skirpt als Admin
    0. Exit
    1. ADimport
    2. Sicherheitsinfo
    3. User anpassen
    4. Uebersicht Benutzer"
    $Eingabe = read-host -prompt "Bitte Zahl eingeben"


    if($Eingabe -eq '0'){
     exit
    }elseif($Eingabe -eq '1'){
        ADimpotieren
    } elseif($Eingabe -eq '2'){
        Log-ADUserInfo
    } elseif($Eingabe -eq '3'){
        "Was möchten sie am User ändern?
        0. Exit
        1. ADimport
        2. Sicherheitsinfo
        3. User anpassen
        4. Uebersicht Benutzer"
        $Eingabe2 = read-host -prompt "Bitte Zahl eingeben"
        
        if($Eingabe2 -eq '0'){

        }elseif($Eingabe2 -eq '1'){

        }elseif($Eingabe2 -eq '2'){
            
        }elseif($Eingabe2 -eq '3'){
            
        }else{
            Write-Host 'Die Eingabe ist keine Zahl zwischen 0 und 4' -ForegroundColor Red
        }


    }elseif($Eingabe -eq '4'){

    }else{
        Write-Host 'Die Eingabe ist keine Zahl zwischen 0 und 4' -ForegroundColor Red
    }

}




