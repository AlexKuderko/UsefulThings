# Header
Write-Host ""
Write-Host "Mouse Wheel Reverse" -BackgroundColor Magenta
Write-host ""

# Path to the registry where HID devices (including mice) are stored
$path = "HKLM:\SYSTEM\CurrentControlSet\Enum\HID"

# Initialize an array to store the device IDs that were updated
$updatedDevices = @()

# Get all keys in this path with forced access, excluding duplicates
$devices = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue | Select-Object -Unique

# Process each key
foreach ($subKey in $devices) {
    # Check if the FlipFlopWheel parameter exists in the key
    if (Test-Path $subKey.PSPath -ErrorAction SilentlyContinue) {
        $properties = Get-ItemProperty -Path $subKey.PSPath 
        
        # If the FlipFlopWheel parameter is found, change its value to [1]
        if ($properties.PSObject.Properties.Name -contains "FlipFlopWheel") {
            Set-ItemProperty -Path $subKey.PSPath -Name "FlipFlopWheel" -Value 1
            Write-Host "Updated FlipFlopWheel to value 1 in: `n$($subKey)`n"
            
            # Append the device to the array
            $deviceID = ($subKey.PSPath -split '\\')[-3] + "\\" +($subKey.PSPath -split '\\')[-2]
            $updatedDevices += Get-CimInstance -Query "SELECT * FROM Win32_PnPEntity WHERE DeviceID LIKE '%$deviceID%'"
        }
    }
}

# Restarting the updated devices to complete the reversal
Write-Host "Restarting devices...`n"
$updatedDevices | ForEach-Object {
    $dev = $_
    Invoke-CimMethod -InputObject $dev -MethodName "Disable" | Out-Null
    Start-Sleep -Seconds 2
    Invoke-CimMethod -InputObject $dev -MethodName "Enable" | Out-Null
}

Write-Host "DONE! The wheel is reversed now!" -BackgroundColor Magenta
Write-Host ""
