# UsefulThings
This repo contains scripts created to simplify routine tasks. 
Originally for personal use, but maybe someone else will find them useful too.

## Table of Contents
- [Mouse Wheel Reverse](#Mouse Wheel Reverse)

## Mouse Wheel Reverse
This script changes the mouse wheel scroll direction (as it is implemented in macOS).

### How To Use
1. Download or copy the script and save it to a file with the .ps1 extension
2. Run PowerShell as Administrator and execute it (with your script path):
```
cd "<PathToScript>"
.\WheelReverse.ps1
```

The wheel may return to its default mode if the mouse is connected to a different port, 
as the computer will detect the device under a different registry branch. 
If this happens, please rerun the script.
