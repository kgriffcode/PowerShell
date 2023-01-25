# Removes bloat programs that are normally difficult to remove from Windows 

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


