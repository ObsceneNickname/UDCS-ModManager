
# UDCS-ModManager
**Ugly Dashing Cunning Symlink Mod Manager**

![alt text](https://github.com/ObsceneNickname/UDCS-ModManager/blob/main/Logo_UDCS-ModManager.png)

## Overview

UDCS-MM is a generic mod manager ( but written with DCS in mind and heart ) that consists of a single 16 KB PowerShell file developed by a decades-long DCS fan moved by frustration at the lack of similar solutions. It is currently the most powerful, fast, lightweight, and hardware-friendly solution to mod management. Oh, and it is also the most aesthetically pleasing ( see "Ugliness" section ).

Why you should care: because UDCS-MM uses a completely different approach from other mod-managers. UDCS does not rewrite data. It does not corrupt files by copying and pasting them schizophrenically one on top of the other but instead uses symlinks by intervening on a very small part of the data concerning the indexing of directories and files to manage mods thus respecting the health and longevity of your hard drives and respecting your time as well.

### Ugliness

UDCS-ModManager has a retro interface; commands are given from the terminal. Nothing can beat the thrill of typing Y or pressing enter on a horrible blue background and white text! The User Experience is simply stellar and will make each user really feel in charge. It's pretty much the same difference in feeling as flying in a powerful, flawed and potentially self-destructive F-14 and flying in a modern, clean and deadly slow F-18 looking at its displays with its satellite coordinates... Ehy, I'm kidding, they're both great planes.

### Simplicity

How complicated could it possibly be to operate this script by people who know how to successfully operate a modern war jet?

### Time

Without going into details, I'll summarize the benefits like this: the fact is that UDCS is fast. **Incredibly fast**. If you want you can stop here, take my word for it and avoid continuing to read boring explanations and ravings.

Yes but how fast? Well, if we take any of the other mod managers out there, and assume that this is an old Smart car launched at the frightening speed of 90 kilometers per hour on a bumpy road with shaking windows, UDCS-MM is an AIM-54C Phoenix at 25000 meters traveling at Mach 5 toward a poor, unsuspecting MIG. And let's be clear, I'm not even kidding with the numbers. In fact, this numerical relationship is definitely downward for UDCS-MM.

This is the time it took to activate and then deactivate Taz's fantastic "DCS Optimized Textures" mod used as a template as it is very nice and full-bodied. It occupies about twenty GB and acts on about forty GB of vanilla files.

DCS Optimized Textures by Taz link: https://forum.dcs.world/topic/323252-dcs-optimized-textures/

Time taken to Deploy and Revert Taz's "DCS Optimized Textures" mod:

* ***Other popular Mod Managers***:
_ENABLE ---> 5 min 32 sec ; DISABLE ---> 3 min 47 sec._

* ***UDCS-ModManager***:
_ENABLE ---> less than 2 sec ; DISABLE ---> less than 6 sec._


### Data written to hard disk

It doesn't end there. Let's talk briefly about writing data to your hard disk. Let's start with the bad news. Hard disks are not eternal. They have a life cycle measured in amount of data written. Probably a few years ago, when at most you had to change a .lua file to rightly put Fox-3s on an Su-27 ( it would be nice to natively bridge the gap that has come about, don't you think, Eagle Dynamic? ) it might as well have been okay to use mod managers that unceremoniously copy and paste the modded files, the original and backupplied files... But now, we have to turn on, then turn off for an Open-Beta update, dozens and dozens of GBs to get the indispensable "Taz's Optimized Textures," "Modern Weapons for the F-14," "Barthek's Caucasian Textures," and other very high quality stuff!

Well, UDCS writes virtually zero Bytes of data to your disk. Windows will report as many as 0 bytes of weight on the symlink files! hey, of course it's not zero. Let's not kid ourselves. If we want to make pseudo-realistic estimates, we can approximate 1 KB for each individual file involved in the operations. Now compare a few measly KB to the imposing, gargantuan bulk of say 40 GB ( which is a VERY optimistic estimate of how much data is written by other mod managers simply by enabling "Taz's Optimized Textures" ).

Below is some data on the disk space used by writing data when we activate and then deactivate the fantastic mod "DCS Optimized Textures" ( which we will still use as a template for this example ). The data is in relation to my Samsung SSD 860 EVO 500GB with NTFS file system

Available hard disk space &
Data written for Deploy & Revert of Taz's "DCS Optimized Textures" mod:

* ***Other popular Mod Managers***:

available space:

before ENABLE - - - - intra-operation ENABLE - - - - end of ENABLE

75.725 GB - - - - - - - - - - 29.635 GB - - - - - - - - - - 56.883 GB

data written:

before ENABLE - - - - intra-operation ENABLE - - - - end of ENABLE

0 GB - - - - - - - - - - 46.090 GB - - - - - - - - - - 18.842 GB

The other Mod Managers write at least **46 GB** of data. Most likely they write even more than that. This is a rough downward estimate. And we are not even considering here the disk write of when we disable the mod.

* ***UDCS-ModManager***:

available space:

before ENABLE - - - - intra-operation ENABLE - - - - end of ENABLE

75.725 GB - - - - - - - - - - 75.725 GB - - - - - - - - - - 75.725 GB

data written:

before ENABLE - - - - intra-operation ENABLE - - - - end of ENABLE

0 GB - - - - - - - - - - 0 GB - - - - - - - - - - 0.000811 GB

The same operation conducted by UDCS-ModManager writes to disk the ridiculous amount of  **0.000811 GB** practically less than a single megabyte.

## INSTALL AND HOW TO USE

### Steps ###

- **Download** the folder "UDCS-ModManager" from https://github.com/ObsceneNickname/UDCS-ModManager and place it on the root of your games drive. Example: *D:\UDCS-ModManager\\*

- **Execute** the PowerShell file "**UDCS-ModManager.ps1**" inside that folder. **Right click** on the file --> **Run with PowerShell**

- If a prompt asks for confirmation say "**Yes**". Do not say "Yes to all". The PowerShell terminal should start up.

Remember that you can exit the PowerShell terminal at any time by pressing CTRL+C

- Follow the instructions on the terminal. You'll need to set up the directories of where the game you want to mod, where you want to keep the original files, and where your folder with the mods is. Don't worry, this operation only needs to be done the first time.

Example: - Main Game: *D:\DCS World\\* - Backup Folder: *D:\UDCS-ModManager\backup\\* - Mods Folder: *D:\DCS World\\_MODS\\*

N.B. Consider that inside DCS World there is already natively a Mods folder. That's why the one with our mods is called "_MODS" with the underscore.

- From the menu that appears with the list of your mods, choose which one you want to activate by typing in the corresponding number and press enter. The mods displayed in green are the ones you have already activated. If multiple mods impact the same files, the last one activated will take priority.

Under no circumstances the original files of both the game and your mods will be altered.

- To disable all mods and return the game to its vanilla state simply run the script again. If you have mods enabled you will be asked if you want to disable all of them.

If you want to start from scratch and set up different directories, you can simply delete that .ini file in the "UDCS-ModManager" folder.


### More info ###

N.B. Highly Suggested Prerequisites: Windows 10 or higher, NTFS disk, mods and game on the same disk

Download and extract (if zipped) the folder "UDCS-ModManager" on your drive. That folder should contain the "**UDCS-ModManager.ps1**" file that we are going to run.

Possibly directly in the root of the hard drive. This is not mandatory but **the point is that you must launch UDCS-ModManager from a directory that contains no space in its absolute-path**. If this is clear to you, feel free to rename both the folder and the .ps1 file itself as you wish.

So  *D:\UDCS-ModManager\\*  is fine. Also *D:\Games\UDCS-ModManager\\*.

If the folder is, let's say, *D:\DCS World\UDCS-ModManager\\* the script **will not work**.

The folder that houses your mods must be structured as usual as with other mod managers. It must contain folders with the name of the mod and inside the same structure as the Main Game directories. Example:

*D:\DCS World\\_MODS\\*\
├───BARTHEK's CAUCASUS REDONE 2022 - REV 2\
│&nbsp;&nbsp;&nbsp;├───Bazar\
│&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;└───Textures\
│&nbsp;&nbsp;&nbsp;└───Mods\
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└───terrains\
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└───Caucasus\
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├───shadingOptions\
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└───vfstextures\
├───BARTHEK's CAUCASUS REDONE 2022 - SNOWLESS WINTER REV 2\
│&nbsp;&nbsp;&nbsp;└───Mods\
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└───terrains\
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└───Caucasus\
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├───shadingOptions\
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└───vfstextures\


### Limitations ###

README is WIP

## Thanks ##

This script was developed for personal needs but it is a pleasure to be able to share it with the community, from which I have taken and learned so much, in the hope that you will enjoy it and find it useful.
