
# UDCS-ModManager
**Ugly Dashing Cunning Symlink Mod Manager**

## Overview

UDCS-MM is a generic mod manager ( but written with DCS in mind and heart ) that consists of a single 16 KB PowerShell file developed by a single DCS fan in less than a week. It is currently the most powerful, fast, lightweight, and hardware-friendly solution to mod management .

Why you should care: because UDCS-MM uses a completely different approach from other mod-managers. UDCS does not rewrite data. It does not corrupt files by copying and pasting them schizophrenically one on top of the other but instead uses symlinks by intervening on a very small part of the data concerning the indexing of directories and files to manage mods thus respecting the health and longevity of your hard drives and respecting your time as well.

### Time

Without going into details, I'll summarize the benefits like this: the fact is that UDCS is fast. Incredibly fast. Yes but how fast? Well, if we take any of the other mod managers out there, and assume that this is an old Smart car launched at the frightening speed of 90 kilometers per hour on a bumpy road with shaking windows, UDCS-MM is an AIM-54C Phoenix at 25,000 meters traveling at Mach 5 toward a poor, unsuspecting MIG. And let's be clear, I'm not even kidding with the numbers. In fact, this numerical relationship is definitely downward for UDCS-MM.

This is the time it took to activate and then deactivate Taz's fantastic "DCS Optimized Textures" mod used as a template as it was nice and full-bodied. It occupies about twenty GB and acts on about forty GB of vanilla files.

DCS Optimized Textures Link: https://forum.dcs.world/topic/323252-dcs-optimized-textures/

Time taken to Deploy and Revert Taz's "DCS Optimized Textures" mod:

* ***Other popular Mod Managers***:
_ENABLE ---> 5 min 32 sec ; DISABLE ---> 3 min 47 sec._

* ***UDCS-ModManager***:
_ENABLE ---> less than 2 sec ; DISABLE ---> less than 6 sec._


### Data written to hard disk

It doesn't end there. Let's talk briefly about writing data to your hard disk. Let's start with the bad news. Hard disks are not eternal. They have a life cycle measured in amount of data written. Probably a few years ago, when at most you had to change a .lua file to rightly put Fox-3s on an Su-27 (it would be nice to natively bridge the gap that has come about, don't you think, Eagle Dynamic?) it might as well have been okay to use mod managers that unceremoniously copy and paste the modded files, the original and backupplied files... But now, we have to turn on, then turn off for an Open-Beta update, dozens and dozens of GBs to get the indispensable "Taz's Optimized Textures," "Modern Weapons for the F-14," "Barthek's Caucasian Textures," and other very high quality stuff!

Well, UDCS writes virtually zero Bytes of data to your disk. Windows will report as many as 0 bytes of weight on the symlink files! hey, of course it's not zero. Let's not kid ourselves. If we want to make pseudo-realistic estimates, we can approximate 1 KB for each individual file involved in the operations. Now compare a few measly KB to the imposing, gargantuan bulk of say 40 GB ( which is a VERY optimistic estimate of how much data is written by other mod managers simply to enable "Taz's Optimized Textures" ).

__README is WIP__