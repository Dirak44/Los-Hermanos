Import-Module ActiveDirectory

function Unlock-ADBenutzer {
    
    $username = Read-Host "Geben Sie den Benutzernamen ein"
    $user = Get-ADUser -Identity $username -Properties LockedOut -ErrorAction SilentlyContinue

    if ($user -eq $null) {
        Write-Host "Das Konto "$username" existiert nicht." 
    } else {
        $locked = $user.LockedOut
        if ($locked) {
            Unlock-ADAccount -Identity $username
            Write-Host "Das Konto "$username" wurde erfolgreich entsperrt."
        } else {
            Write-Host "Das Konto "$username" ist nicht gesperrt."
        }
    }
}


