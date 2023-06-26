#--------------------------------------------------------------------------------
# Autor: Tommaso und Rene
# Funktion des Skripts: Konfigurationen, z.B. Pfade bereitstellen
# Datum: 04.05.2023
# Version: 1.1
# Bemerkungen:
#--------------------------------------------------------------------------------

#Unsere Sammlung von Variabeln
$Global:InitPw       = "bztf.001"
$Global:schueler = [xml](Get-Content -Path "C:\pwsh\Los-Hermanos\schueler.xml")
#OU Verzeichnisse
$Global:OUPath       = "OU=BZTF,DC=bztf,DC=local"
$Global:OUPathlernende = "OU=Lernende,OU=BZTF,DC=bztf,DC=local"
$Global:OUPathklassegruppen = "OU=Klassengruppen,OU=BZTF,DC=bztf,DC=local"
#OU Bezeichnung
$Global:OULernende   = "Lernende"
$Global:OUKlasse     = "Klassengruppen"

#Logpfade
$Global:tmppath = "C:\tmp"
$Global:LogFileUser  = "C:\tmp\users.log"
$Global:LogFileGroup = "C:\tmp\groups.log"
$Global:ClassFolder  = "C:\BZTF\Klassen"





