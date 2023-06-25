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

function Aktivieren-ADBenutzer {

    $username = Read-Host "Geben Sie den Benutzernamen ein"
    $user = Get-ADUser -Identity $Username -ErrorAction SilentlyContinue

    if ($user -eq $null) {
        Write-Output "Das Konto $Username existiert nicht." 
    } elseif ($user.Enabled -eq $true) {
        Write-Output "Das Konto $Username ist bereits aktiviert."
    } else {
        Enable-ADAccount -Identity $Username
        Write-Output "Das Konto $Username wurde aktiviert."
    }
}

