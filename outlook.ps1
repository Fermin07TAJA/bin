$package = Get-AppxPackage -Name "*outlook*" | Select-Object -First 1
Start-Process "shell:AppsFolder\$($package.PackageFamilyName)!microsoft.outlookforwindows"
