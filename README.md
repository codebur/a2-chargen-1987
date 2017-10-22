# Apple // Character Generator for HGR

- Author: Urs Hochstrasser
- Date: 1987
- Platform: Apple //
- Language: 6502 Assembly
- IDE used: Merlin Assembler (8-Bit)

My assembly line dabblings created back in 1987. In fact this is    already version 4 of a project I probably started back in the early 80ies.

I provide the code as is. I haven’t touched it for decades. Have fun!

**Files**

- ``CHRDEF.BAS`` An Applesoft Basic program to create the neccessary fonts. It is a TXT file to be EXECed to become a real Applesoft program. Probably won’t work out of the box since it contains code for joystick and mouse (//c first ROM), which might not work on all Apple // machines.
- ``chrgen400.s`` Merlin source for the Character Generator 4.02
- ``KEYGEN22.DSK.zip`` Zipped DSK file containing a demo and some font files (DOS 3.3). Unfortunately some emulators can’t cope with “bit shifted” pixels, so the font may look a bit odd.
