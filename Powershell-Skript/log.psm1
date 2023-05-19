#--------------------------------------------------------------------------------
# Autor: Tommaso und Rene
# Funktion des Skripts: Konfigurationen, z.B. Pfade bereitstellen
# Datum: 04.05.2023
# Version: 1.1
# Bemerkungen:
#--------------------------------------------------------------------------------

#Unsere Sammlung von Variabeln
$Global:SchuelerCsv  = "C:\tmp\PSProjekt\schueler.csv"
$Global:InitPw       = "bztf.001"
$Global:OUPath       = "OU=BZTF,DC=bztf,DC=local"
$Global:OULernende   = "Lernende"
$Global:OUKlasse     = "Klassengruppen"
$Global:LogFileUser  = "C:\tmp\users.log"
$Global:LogFileGroup = "C:\tmp\groups.log"
$Global:ClassFolder  = "C:\BZTF\Klassen"
#Meine Test Variabeln ob es richtig impotiert
$Global:Prozesse = Get-Process
$Global:var1 = "Nie HS test"

