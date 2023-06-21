Import-Module ActiveDirectory

New-ADObject -Type "organizationalUnit" -Name BZTF -Path "OU=Schüler,OU=Benutzer,DC=meine-domain,DC=com"