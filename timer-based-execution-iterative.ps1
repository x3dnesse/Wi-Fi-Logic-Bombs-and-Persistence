<# Please replace cmd.exe with the executable path for your payload #>
while ($true) {
    $process = Start-Process -FilePath "cmd.exe" -PassThru
    Start-Sleep -Seconds 2
    Stop-Process -Id $process.Id
}