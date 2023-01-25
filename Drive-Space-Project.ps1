<# 
I want to take what I learned from the last tutorial and apply it here: 
Scan a selected drive on a Windows machine
Return the space available
Push an email when storage is at 75% max capacity
#>

# Need a Cmdlet to determine drive space 
# Need an `if` statement to handle the logic 
# Need an SMPT server to handle the email + an email subject
# Use `Send-MailMessage` Cmdlet to deliver email

$volume = Get-Volume -DriveLetter C
$diskUsage = $volume.FreeSpace / $volume.Size
if ($diskUsage -le 0.25) {
    # Declare variables for the email
    $to = "mementovivereburner@gmail.com"
    $subject = "Disk Space Warning"
    $body = "Your disk is at or above 75% capacity. Please free up some space."
    $smtpServer = "smtp.gmail.com"
    $smtpPort = "587"
    $username = ""
    $password = ""
    $smtpCredentials = New-Object
    System.Management.Automation.PSCredential($username, (ConvertTo-SecureString $password -AsPlainText -Force))
    # Send the message
    Send-Mail -To $to -Subject $subject -Body $body -SmtpServer $smtpServer -Port $smtpPort -UseSsl -Credential $smtpCredentials
}

# else {
#     throw # Stop the script altogether
# }