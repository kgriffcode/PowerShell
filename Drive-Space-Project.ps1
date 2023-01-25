<# Tutorial from TechThoughts (https://www.youtube.com/watch?v=IABNJEl2ZWk)
We want to be notified whena  drive in our home network is running low on space.
The script will check the desired drive for free space,
and send a Telegram notification if it is below 20%.
All actions should be logged.
The script should support scanning a drive the user specifies. 
The script should support both Linux and Windows.
#>

<#
Will need to support logging
Checks drive for space
Lets user specify driver
Supports Windows & Linux
Sends Telegram notification
#>

# Log Directory
if ($PSVersionTable.Platform -eq 'Unix') {
    $logPath = '/tmp'
}
else {
    $logPath = 'C:\Logs'
}

$logFile = "$logPath\driveCheck.log" #log file here

# Verify if Log Directory exists
try {
    if (-not (Test-Path -Path $logPath -ErrorAction Stop)) {
        #output dir is not found -- Creat the dir
        New-Item -ItemType Directory -Path $logPath -ErrorAction Stop | Out-Null #Out-Null prevents console output
        New-Item -ItemType -Path $logFile -ErrorAction | Out-Null 
    }
}

catch {
    throw #cancels the process
}

Add-Content -Path $logFile -Value "[INFO] Running $PSCommandPath" #tells log where the script was ran from to be logged

# Verify that PoshGram is installed
if (-not (Get-Module -Name PoshGram -ListAvailable)) {
    Add-Content -Path $logFile -Value "[ERROR] PoshGram is not installed."
    throw #cancels script altogether
} #press F8 to run script and verify

else {
    Add-Content -Path $logFile -Value "[INFO] PoshGram is installed."
}

# Get hard drive information
try {
if ($PSVersionTable.Platform -eq 'Unix') {
    #used
    #free
    $volume = Get-PSDrive -Name $Drive -ErrorAction Stop 
    #verify volume exists
    if ($volume) {
        $total = $volume.Used + $volume.Free
        $percentFree = [int](($volume.Free / $total) * 100)
        Add-Content -Path $logFile -Value "[INFO] Percent Free: $percentFree%."
    }
    else {
        Add-Content -Path $logFile -Value "[ERROR] $Drive was not found."
        throw
    }
}
else {
    $volume = Get-Volume -ErrorAction Stop | Where-Object {$_.DriveLetter -eq $Drive}
    f ($volume) {
        $total = $volume.Size
        $percentFree = [int](($volume.SizeRemaining / $total) * 100)
        Add-Content -Path $logFile -Value "[INFO] Percent Free: $percentFree%."
    }
    else {
        Add-Content -Path $logFile -Value "[ERROR] $Drive was not found."
        throw
    }
}
}
catch {
    Add-Content -Path $logFile -Value "[ERROR] Unable to retrieve volume information."
    Add-Content -Path $logFile -Value $_
    throw
}


# Send Telegram message *if the drive is low
if ($percentFree -le 20) {
    try {
        Import-Module -Name PoshGram -ErrorAction Stop
        Add-Content -Path $logFile -Value "[INFO] Imported PoshGram successfully."
    }
    catch {
        Add-Content -Path $logFile -Value "[ERROR] PoshGram could not be imported:"
        Add-Content - path $logFile -Value $_
    }

    Add-Content -Path $logFile -Value "[INFO] Sending Telegram Notification..."

    $botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
    $chat = '-nnnnnnnnn'
    Send-TelegramTextMessage -BotToken $botToken -ChatID $chat -Message "Your drive is low"
}