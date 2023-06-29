# Check if the script is running with administrative privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

# If not running as admin, prompt for elevation and restart the script
if (-not $isAdmin) {
    $arguments = "& '" + $MyInvocation.MyCommand.Path + "'"
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile", "-ExecutionPolicy", "Bypass", "-File", $MyInvocation.MyCommand.Path, $arguments
    exit
}

##  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  
##  !!  Very important  !!  --  !!  THIS SCRIPT MUST NECESSARILY BE LAUNCHED FROM AN ABSOLUTE PATH THAT DOES NOT CONTAIN SPACES IN ANY OF ITS FIELDS  !!
##  Example:  D:\Games\UDCS-ModManager\UDCS.ps1 --> GOOD!  ;  D:\DCS World\UDCS.ps1 --> WRONG!  ;  D:\Games\UDCS Mod Manager.ps1 --> WRONG!  ;  D:\Games Folder With Spaces\UDCS-ModManager\UDCS.ps1 --> WRONG!  ;  D:\Games Folder With Spaces\UDCS-ModManager\UDCS.ps1 --> WRONG!
##  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  #  


## SCRIPT by Giuseppe Paradiso

Write-Output "Welcome to UDCS-MM: Ugly Dashing Cunning Symlink MOD MANAGER!!"
Write-Host "`n"

Write-Output "#################################################################"
Write-Output ""
Write-Output "##  !!  UDCS-MM: UGLY DASHING CUNNING SYMLINK MOD MANAGER  !!  ##"
Write-Output ""
Write-Output "#################################################################"

#old alternative name: UDCS-MM = Ultra Disgusting but Cool Symlink Mod Manager. All the names suck. I know.

Write-Host "`n"

Write-Host "N.B. Highly Suggested Prerequisites: Windows 10 or higher, NTFS disk, mods and game on the same disk"


Read-Host "Press Enter to continue"


# Check if logfile exists - Main Variable for "logFile"
$logFile = Join-Path -Path $PSScriptRoot -ChildPath "UDCS-MM-log.ini"

#SAFE CHECK
# Safe Check for corrupted logfile
$safeminimumlines = 3

# Check if log exists
if (Test-Path $logFile) {
    $linesinlog = Get-Content "$logFile"

    # Verify if the lines in logFile are less than the $safeminimumlines
    if ($linesinlog.Count -lt $safeminimumlines) {
        # Remove the corrupted log
        Remove-Item $logFile -Force
        Write-Host "The Log-File (with settings, directories and activated modlist) has been removed for safety reason because it could be corrupted.`n"
    }
} else {
    Write-Host "No settings registered.`n"
}

if (-not (Test-Path $logFile)) {
    # Create the logfile if it doesn't exist
    $null | Out-File -FilePath $logFile -Force
	
	# prompt for GENERIC use or DCS World use ( more checks )
	
	$DCSchecks = Read-Host "Do you want to use UDCS-MM for DCS World or for a generic game? (Type D for DCS or type anything else for a GENERIC USE)"

    if ($DCSchecks -eq "D" -or $DCSchecks -eq "d") {
        # DCSchecks enabled
        $FolderB = Read-Host "Enter the path of main Dcs World folder"
		
		# Check for exe file "DCS.exe"
		$checkFilePath = Join-Path -Path $FolderB -ChildPath "bin\DCS.exe"

		if (Test-Path -Path $checkFilePath -PathType Leaf) {
			Write-Host "DCS.exe found under ${FolderB} - correct Path set"
			# just a check
		} else {
			Write-Host "DCS.exe not found. Double check the path you wrote: ${FolderB}"
	
		# Exit if not found
			Read-Host "Press Enter to exit"
		
			exit
		}
	} else {
		# Prompt for FolderB path
		$FolderB = Read-Host "Enter the path of the game main folder"
	}

	
	Write-Host "`n"
	
	# Insert here
	

    # Prompt for backupFolderC path
    $backupFolderC = Read-Host "Enter the path of a backup folder for storing the original files"
	
	Write-Host "`n"
	
	# Prompt for Mods-Folder path FolderD
	$FolderD = Read-Host "Enter the directory of mods folder"
	
	Write-Host "`n"

    # Save the values of FolderB and FolderC to the logfile
    Add-Content -Path $logFile -Value "Main_Game_Folder=$FolderB"
    Add-Content -Path $logFile -Value "Original_Backup_Folder=$backupFolderC"
	Add-Content -Path $logFile -Value "Mods_Folder=$FolderD"
	Add-Content -Path $logFile -Value "`n"
}
else {
    # Read the values of FolderB and FolderC from the logfile
    $FolderB = Get-Content "$logFile" | Where-Object { $_ -like "Main_Game_Folder=*" } | ForEach-Object { $_ -replace "Main_Game_Folder=", "" }
    $backupFolderC = Get-Content "$logFile" | Where-Object { $_ -like "Original_Backup_Folder=*" } | ForEach-Object { $_ -replace "Original_Backup_Folder=", "" }
	$FolderD = Get-Content "$logFile" | Where-Object { $_ -like "Mods_Folder=*" } | ForEach-Object { $_ -replace "Mods_Folder=", "" }
}

# Print stuff to terminal output
Write-Host "`n"
Write-Output "Main game directory set as: ${FolderB}"
Write-Host "`n"
Write-Output "Backup folder: ${backupFolderC}"
Write-Host "`n"
Write-Output "Reading mods folders from: ${FolderD}"
Write-Host "`n"


# List the folders in $FolderD
# BUG with only 1 folder in $FolderD FIXED!! -- Force the creation of the array
$modsFoldersList = @(Get-ChildItem -Path $FolderD -Directory | Select-Object -ExpandProperty Name)

# take text from logfile
$settingsinlog = Get-Content -Path "$logFile"


# Set the revertlog File
$RevertlogFile = Join-Path $backupFolderC "UDCS-MM.log"

#absolute path for mods folders
$modsFoldersAbsoluteList = Get-ChildItem -Path $FolderD -Directory | Select-Object -ExpandProperty FullName

## REVERT TO CLEAN STATE SECTION
# Check if the log file exists
if (Test-Path $RevertlogFile) {
    # Prompt the user if wanna revert the changes
	Write-Host "`n"

	Write-Host "Your content in the logfile. Directories set and Mods activated right now"

	Write-Host "`n"
	
	# output un po' più bellino
	foreach ($linestring in $settingsinlog) {
		Write-Host $linestring -ForegroundColor DarkRed -BackgroundColor Gray
	}
	
	Write-Host "`n"
	
	# Revert to clean state prompt
    $choice = Read-Host "It seems you already have some mod activated. Do you want to disable them all and bring back original files? (y/n)"

    if ($choice -eq "Y" -or $choice -eq "y") {
        # Remove the log file
        Remove-Item $RevertlogFile
		Write-Host "`n"

		Write-Host "Reverting all files to a clean state..."

		Write-Host "`n"

        # Remove the symlinks in folder B
        $symlinks = Get-ChildItem -File -Recurse $folderB -Force | Where-Object { $_.Attributes -match 'ReparsePoint' }
        foreach ($symlink in $symlinks) {
            Remove-Item $symlink.FullName -Force
        }

        # Move the files from folder C to folder B
        $backupFiles = Get-ChildItem -File -Recurse $backupFolderC -Force
        foreach ($file in $backupFiles) {
            $relativePath = $file.FullName.Replace($backupFolderC, "")
            $destinationPath = Join-Path $folderB $relativePath

            $destinationDirectory = Split-Path $destinationPath -Parent
            if (-not (Test-Path $destinationDirectory)) {
                New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
            }

            Move-Item $file.FullName -Destination $destinationPath -Force
        }
		
		
		# DELETE STUFF SECTION. Read comments

		# This commented section will clean Main Game Directory ( "DCS World" for example ) from all of the empty folders. Some mod may leave them around. But it's a slow process. You choose.
		##DELETE EMPTY FOLDERS FROM MAIN GAME PATH##
		# Delete empty folders in Main Game Directory - too slow
		#Get-ChildItem -Path $FolderB -Recurse -Directory | Where-Object {
		#	$folderPath = $_.FullName
		#	$isEmpty = !(Get-ChildItem -Path $folderPath -Recurse -File)
		#	$isEmpty
		#} | Remove-Item -Force -Confirm:$false -ErrorAction SilentlyContinue -Recurse
		
		# Delete empty folders in FolderC
		Get-ChildItem -Path $backupFolderC -Recurse -Directory | Where-Object {
			$folderPath = $_.FullName
			$isEmpty = !(Get-ChildItem -Path $folderPath -Recurse -File)
			$isEmpty
		} | Remove-Item -Force -Confirm:$false -ErrorAction SilentlyContinue -Recurse
		# All of these fu** flags just to suppress the annoying prompt. CARE, it's a 'delete' command BUT it applies only to dumb harmless empty folders.
		
		# END OF DELETE STUFF SECTION
		
		
		# Delete mods activated entries on logfile... Switch approach - fucks array and line counting - Delete logFile entirely and then rewrite it...
		
		# delete old and mute output
		Remove-Item -Path $logFile -Force | Out-Null
		
		# create new and mute output
		New-Item -Path $logFile -ItemType File | Out-Null
		
		# Rewrite settings and mute output
		Add-Content -Path $logFile -Value "Main_Game_Folder=$FolderB" > $null
		Add-Content -Path $logFile -Value "Original_Backup_Folder=$backupFolderC" > $null
		Add-Content -Path $logFile -Value "Mods_Folder=$FolderD" > $null
		Add-Content -Path $logFile -Value "`n"	> $null
		

		Write-Host "Reverted the changes successfully. You can now update your game without worries : )"

        # Exit the script
        Read-Host "Press Enter to exit"
		
		exit
    }
}
## END OF REVERT TO CLEAN STATE SECTION

do {

	# List the folders in $FolderD
	# BUG with only 1 folder in $FolderD FIXED!! -- Force the creation of the array
	$modsFoldersList = @(Get-ChildItem -Path $FolderD -Directory | Select-Object -ExpandProperty Name)

	$modsFoldersAbsoluteList = Get-ChildItem -Path $FolderD -Directory | Select-Object -ExpandProperty FullName

	$settingsinlog = Get-Content -Path "$logFile"

	Write-Host "`n"

	Write-Host "Your content in the logfile. Directories set and Mods activated right now"

	Write-Host "`n"

	foreach ($linestring in $settingsinlog) {
		Write-Host $linestring -ForegroundColor DarkRed -BackgroundColor Gray
	}

	Write-Host "`n"

	### NEW INTERACTIVE MENU  --- WIP ### Minimal Version
	# Highlight activated mods .... Cooooool : )
	$logContent = Get-Content -Path $logFile

	# Verify Output has directories
	if ($modsFoldersList) {
		while ($true) {
			# Mostra il menu delle directory
			Write-Host "`n"
			Write-Host "Select a mod to activate:"
			Write-Host "`n"
			for ($i = 0; $i -lt $modsFoldersList.Count; $i++) {
				$menuEntry = "$($i + 1). $($modsFoldersList[$i])"
				$matchingLines = $logContent | Where-Object { $_ -like "*$($modsFoldersList[$i])*" }

				if ($matchingLines) {
					# Evidenzia la riga
					$menuEntry = $menuEntry | Write-Host -NoNewLine -ForegroundColor Green
				}
				Write-Host $menuEntry
			}

			# Prompt the user to select a folder
			Write-Host "`n"
			$choiceNumber = Read-Host "Enter the number corresponding to the selected mod"
			
			# Force converting in integer number
			$choiceNumber = [int]$choiceNumber
			
			Write-Host ""

			# Verify the user's choice
			if ($choiceNumber -ge 1 -and $choiceNumber -le $modsFoldersList.Count) {
				$selectedFolder = $modsFoldersList[$choiceNumber - 1]
				$FolderA = Join-Path -Path $FolderD -ChildPath $selectedFolder
				Write-Host "You selected: $FolderA"
				# You can use $FolderA as needed
				break
			} else {
				Write-Host "Invalid choice."
				Start-Sleep -Seconds 1
			}
		}
	} else {
		Write-Host "Invalid Main Mod Folder: ${FolderD} - No folders found"

		# Sleep for 1 second
		Start-Sleep -Seconds 1
		
		# Alarm!
		Write-Host "Invalid Main Mod Folder: ${FolderD} - No folders found"
		Start-Sleep -Seconds 1
		
		Read-Host "Press Enter to exit and delete invalid directory from previously configured setting file"
		
		Remove-Item $logFile -Force
		
		Write-Host "${logFile} deleted"
		
		Write-Host "Exiting"

		Start-Sleep -Seconds 1
		
		exit
	}
	################# FINE LAVORI


	# Add mod to logFile
	Add-Content -Path $logFile -Value "MOD - ${FolderA} - activated"



	### MAIN LOGIC SECTION ###

	# Function to create symlinks and backup files
	function Create-Symlink {
		param (
			[Parameter(Mandatory=$true)]
			[string]$SourcePath,
			
			[Parameter(Mandatory=$true)]
			[string]$DestinationPath
		)

		# Check if the destination path is already a symlink
		$isSymlink = $false
		try {
			$item = Get-Item -Path $DestinationPath -ErrorAction SilentlyContinue
			if ($item.Attributes -match 'ReparsePoint') {
				$isSymlink = $true
			}
		} catch {
			# Ignore any errors when checking if the item exists or not
		}

		if (-not $isSymlink) {
			# Create the backup folder structure in folder C
			$backupFolderPath = Join-Path $backupFolderC ($DestinationPath -replace [regex]::Escape($folderB), '')
			$backupFolder = Split-Path $backupFolderPath -Parent
			if (-not (Test-Path $backupFolder)) {
				New-Item -ItemType Directory -Path $backupFolder -Force | Out-Null
			}

			# Move the file from folder B to the backup folder C
			if (Test-Path $DestinationPath) {
				Move-Item $DestinationPath -Destination $backupFolderPath -Force
			}
		}

		# Create the symbolic link in folder B
		try {
			New-Item -ItemType SymbolicLink -Path $DestinationPath -Target $SourcePath -Force | Out-Null
		} catch {
			Write-Host "Error creating symlink at $DestinationPath"
		}
	}
	### END OF MAIN LOGIC SECTION ###



	# Create the backup folder C if it doesn't exist
	if (-not (Test-Path $backupFolderC)) {
		New-Item -ItemType Directory -Path $backupFolderC -Force | Out-Null
	}

	# Process files and folders recursively
	$itemsInA = Get-ChildItem -Path $FolderA -Recurse -Force
	foreach ($item in $itemsInA) {
		if ($item -is [System.IO.FileInfo]) {
			# Process file
			$relativePath = $item.FullName.Replace($FolderA, "")
			$destinationPath = Join-Path $folderB $relativePath

			# Create the symlink and backup the existing file
			Create-Symlink -SourcePath $item.FullName -DestinationPath $destinationPath
		}
		elseif ($item -is [System.IO.DirectoryInfo]) {
			# Process folder
			$relativePath = $item.FullName.Replace($FolderA, "")
			$destinationPath = Join-Path $folderB $relativePath

			# Create the destination folder
			if (-not (Test-Path $destinationPath)) {
				New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null
			}
		}
	}

	# Create or update the log file
	$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
	$logMessage = "Script executed successfully at $timestamp. MOD - ${folderA} - ACTIVATED"
	$logMessage | Out-File -FilePath $RevertlogFile -Append

	## DELETE SECTION - just like before, read comments from above

	#TEMPORARELY COMMENT-OUT
	# Delete empty folders in FolderB
	#Get-ChildItem -Path $FolderB -Recurse -Directory | Where-Object {
	#    $folderPath = $_.FullName
	#    $isEmpty = !(Get-ChildItem -Path $folderPath -Recurse -File)
	#    $isEmpty
	#} | Remove-Item -Force -Confirm:$false -ErrorAction SilentlyContinue -Recurse

	# !! WARNING !! with the -Confirm:$false flag you're not asking for a prompt when deleting folders.

	# Delete empty folders in FolderC
	Get-ChildItem -Path $backupFolderC -Recurse -Directory | Where-Object {
		$folderPath = $_.FullName
		$isEmpty = !(Get-ChildItem -Path $folderPath -Recurse -File)
		$isEmpty
	} | Remove-Item -Force -Confirm:$false -ErrorAction SilentlyContinue -Recurse

	## END OF DELETE SECTION
	
	Write-Host ""
	Write-Host "Script executed successfully. MOD - $FolderA installed."
	Write-Host ""



	# Prompt the user if they want to execute the script again
	$choice = Read-Host "Do you want to install other mods? (Y/N)"

} while ($choice -eq "Y" -or $choice -eq "y")

# Final salute : )
Write-Host "`n"
Write-Host "Fly Safe : )"
Write-Host "`n"
Read-Host "Press Enter to exit"
