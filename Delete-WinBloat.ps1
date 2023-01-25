# Removes bloat programs that are normally difficult to remove from Windows 
# Use winget list to view installed apps

# Remove Skype
Get-AppxPackage *skypeapp* | Remove-AppxPackage

# Remove Solitaire Collection
Get-AppxPackage *solitairecollection* | Remove-AppxPackage

# Remove Movies & TV
Get-AppxPackage *zunevideo* | Remove-AppxPackage

# Remove Groove Music 
Get-AppxPackage *zunemusic* | Remove-AppxPackage

# Remove 3D Viewer / Builder
Get-AppxPackage *3dbuilder* | Remove-AppxPackage

# Remove Microsoft News
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage

# Remove Microsoft Maps
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage

# Remove Xbox Gaming Bar
Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage

# Remove Microsoft Edge 
Get-AppxPackage Microsoft.Edge | Remove-AppxPackage

# Remove Microsoft Mixed Reality Portal
Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage