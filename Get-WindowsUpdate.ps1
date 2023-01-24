# Allow Admin Privileges -- may need to configure Set-ExecutionPolicy -Scope CurrentUser
Set-ExecutionPolicy RemoteSigned 

# Install 3rd-Party Module to install updates from PowerShell
# Install-Module PSWindowsUpdate

# List Available Windows Updates 
Get-WindowsUpdate

# Accept Updates + Install Updates + Reboot
Get-WindowsUpdate -AcceptAll -Install -AutoReboot