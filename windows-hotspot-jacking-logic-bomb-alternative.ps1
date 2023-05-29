<# Similarly to the hosted networks, the mobile hotspot feature on windows can be used. This script performs necessary checks then hosts the hotspot internally, once connected to one of the target networks #>

$desiredNetworks = @("targetSSID1", "targetSSID2")
$executablePath = "cmd.exe"
$process = $null
$networkName = "Target-Hotspot"
$networkPassword = "Password123$$"

# Check if Mobile Hotspot feature is supported
$hotspotCapability = Get-WmiObject -Namespace "Root\StandardCimv2\MSFT_NetMobileHotspot" -Class MSFT_NetMobileHotspot -ErrorAction SilentlyContinue

while ($true) {
    $connectedNetwork = Get-NetConnectionProfile | Where-Object { $_.InterfaceAlias -like "*Wi-Fi*" }

    if ($connectedNetwork -and $desiredNetworks -contains $connectedNetwork.Name) {
        if (-not $process) {
            $process = Start-Process -FilePath $executablePath -PassThru
        }

        if ($hotspotCapability -and $hotspotCapability.SharingEnabled) {
            # Enable Mobile Hotspot
            $hotspotCapability.Enable($networkName, $networkPassword)
            Write-Host "Mobile hotspot enabled with network name: $networkName"
        } else {
            Write-Host "Mobile hotspot feature is not supported on this system."
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
