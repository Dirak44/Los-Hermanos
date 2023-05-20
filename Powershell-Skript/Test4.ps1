if (Get-ADGroup -Filter Name -eq $klasse){
    Write-Host "Keine Neue Klasse erstellt"   
   } else{
       Write-Host "Neue Klasse erstellt!"
       New-ADGroup -Name $klasse -GroupCategory Security -GroupScope Global -ErrorAction SilentlyContinue
   }

   if (Get-ADGroup -Filter Name -eq $klasse2){
       Write-Host "Keine Neue Klasse erstellt"   
      } else{
          Write-Host "Neue Klasse erstellt!"
          New-ADGroup -Name $klasse2 -GroupCategory Security -GroupScope Global -ErrorAction SilentlyContinue
   }