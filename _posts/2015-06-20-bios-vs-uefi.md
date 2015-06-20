---
layout: post
title: "BIOS vs UEFI"
comments: true
permalink: bios-vs-uefi
description: Discussion of differences between bios and uefi
tags: [hardware]
layout: post
---
*Differences between BIOS and UEFI*
-----

<!--adsense1-->

A coworker asked me a question about the differences between the BIOS and UEFI this week.  I gave a general answer but took some time to elaborate more here for anyone interested.

BIOS (basic input/output system) is the program a personal computer's microprocessor uses to get the computer system started after you turn it on. It also manages data flow between the computer's operating system and attached devices such as the hard disk, video adapter, keyboard, mouse and printer.

Reference: [Wikipedia](https://en.wikipedia.org/wiki/BIOS)

UEFI (Unified Extensible Firmware Interface) is a standard firmware interface for PCs, designed to replace BIOS (basic input/output system). This standard was created by over 140 technology companies as part of the UEFI consortium, including Microsoft.

Reference: [Wikipedia](https://en.wikipedia.org/wiki/Unified_Extensible_Firmware_Interface)

Now that the obligatory definitions are done, lets hop into it.

BIOS workflow:
  
  * Computer powers on

  * BIOS reads first sector on hard drive then executes it 

  * Executed code finds then executes more code

This process isn't secure as anyone that can modify the first sector of hard drive can then change the boot order to allow for malicious programs ([Bootkit](http://support.kaspersky.com/us/viruses/solutions/2727)) to run prior to the operating system.  UEFI takes a step to secure this process by providing a mechanism called secure boot.  Basically, worrying about security for the loader is a relatively new attack vector and a good demo was shown at BlackHat 2009 with Peter Kleissner's [Stoned Bootkit](http://www.blackhat.com/presentations/bh-usa-09/KLEISSNER/BHUSA09-Kleissner-StonedBootkit-SLIDES.pdf).

SecureBoot: "Secure Boot is a technology where the system firmware checks that the system boot loader is signed with a cryptographic key authorized by a database contained in the firmware."

Reference: [Fedora](http://docs.fedoraproject.org/en-US/Fedora/18/html/UEFI_Secure_Boot_Guide/chap-UEFI_Secure_Boot_Guide-What_is_Secure_Boot.html)

UEFI workflow:

<img src="{{ site.url }}/assets/efi.png" />

Reference: [Wikimedia](https://commons.wikimedia.org/wiki/File:Efi_flowchart_extended.jpg)

So besides increase security against bootkits, UEFI provides increased pains for those of us that like to legitimately modify the boot process for say, dual booting.  I use this commmonly for booting between Linux and Windows operating systems.

That being said, nothing is secure!

<img src="{{ site.url }}/assets/uefi-leak.png" />



<!--adsense2-->