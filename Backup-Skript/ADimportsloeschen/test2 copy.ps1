#Löscht alle Benutzer aus dem XML File

Import-Module ActiveDirectory

$counter = 0

# Namespace definieren
$namespace = New-Object System.Xml.XmlNamespaceManager($Global:schueler.NameTable)
$namespace.AddNamespace("ns", "http://schemas.microsoft.com/powershell/2004/04")

# Durch die Objekte in der XML-Datei iterieren
foreach ($obj in $Global:schueler.SelectNodes("//ns:Obj", $namespace)) {
    # MS-Element auslesen
    $msElement = $obj.SelectSingleNode("ns:MS", $namespace).InnerText

    # Attribute aus dem MS-Element extrahieren
    $attributes = $msElement -split ';'

    # Benutzername extrahieren
    $benutzername = $attributes[2]

    # Benutzer aus dem AD löschen
    Remove-ADUser -Identity $benutzername -Confirm:$false -ErrorAction SilentlyContinue
    $counter++
    Write-Host "Benutzer geloescht: $benutzername" + "Counter: $counter"
}
