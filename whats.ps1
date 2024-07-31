$package = Get-AppxPackage -Name "*WhatsApp*" | Select-Object -First 1
Start-Process "shell:AppsFolder\$($package.PackageFamilyName)!App"