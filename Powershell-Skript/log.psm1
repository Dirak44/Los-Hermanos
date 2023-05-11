#--------------------------------------------------------------------------------
# Autor: Tommaso und Rene
# Funktion des Skripts: Konfigurationen, z.B. Pfade bereitstellen
# Datum: 04.05.2023
# Version: 1.1
# Bemerkungen:
#--------------------------------------------------------------------------------

#Meine Sammlung von Variabeln
$SchuelerCsv  = "C:\tmp\PSProjekt\schueler.csv"
$InitPw       = "bztf.001"
$OUPath       = "OU=BZTF,DC=bztf,DC=local"
$OULernende   = "Lernende"
$OUKlasse     = "Klassengruppen"
$LogFileUser  = "C:\tmp\users.log"
$LogFileGroup = "C:\tmp\groups.log"
$ClassFolder  = "C:\BZTF\Klassen"
$Tmp = "C:\temp"
$Global:Prozesse = Get-Process

$Global:var1 = "Wir hs"

