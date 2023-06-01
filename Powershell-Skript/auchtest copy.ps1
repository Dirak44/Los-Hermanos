# Importieren des Active Directory-Moduls
Import-Module ActiveDirectory

# Pfad zum übergeordneten Container, in dem der neue Ordner erstellt werden soll
$parentContainer = "OU=Schüler,OU=Benutzer,DC=meine-domain,DC=com"

# Name des neuen Ordners
$folderName = "NeuerOrdner"

# Erstellen des neuen Ordners
New-ADObject -Type "organizationalUnit" -Name $folderName -Path $parentContainer

# Pfad zum neu erstellten Ordner
$newFolderPath = "OU=$folderName,$parentContainer"

# Erstellen einer neuen Gruppe
$groupName = "NeueGruppe"
New-ADGroup -Name $groupName -GroupCategory Security -GroupScope Global -Path $newFolderPath

# Anzeigen der Informationen über den neu erstellten Ordner und die Gruppe
Get-ADObject -Filter "Name -eq '$folderName'" -SearchBase $parentContainer
Get-ADGroup -Filter "Name -eq '$groupName'" -SearchBase $newFolderPath
