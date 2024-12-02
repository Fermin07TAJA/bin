$basePath = "C:\Users\Chickenfish\AppData\Local\Discord"
$appFolder = Get-ChildItem -Path $basePath -Directory -Filter "app-*" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if ($appFolder -ne $null) {
    $discordExePath = Join-Path -Path $appFolder.FullName -ChildPath "discord.exe"
    if (Test-Path $discordExePath) {
        # Run discord.exe
        Start-Process -FilePath $discordExePath
    } else {
        Write-Output "discord.exe not found in $($appFolder.FullName)"
    }
} else {
    Write-Output "No app-* folders found in $basePath"
}
