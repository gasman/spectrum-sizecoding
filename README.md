ZX Spectrum sizecoding
======================

Resources from my seminar at [Lovebyte 2021](http://www.lovebyte.party/).

Essential tools
---------------
* [Fuse](http://fuse-emulator.sourceforge.net/) - ZX Spectrum emulator for Unix, Mac OS and Windows
* [Pasmo](http://pasmo.speccy.org/) - Z80 cross-assembler
* [zmakebas](http://www.svgalib.org/rus/zmakebas.html) - converts text files to tokenised BASIC in .tap format

Files included here
-------------------
* `hello.asm` - the finished XOR-pattern intro
* `hello.bas` - BASIC launcher for the intro
* `Makefile` - build script for intro (edit and change program paths as appropriate)
* `border.asm` - the simplest possible program that does something: turn the border red
* `screen.asm` - slowly fill the video memory, to demonstrate the screen layout
* `upde.asm` - routine for finding the address of the next pixel line in screen memory

Books
-----
* [Mastering Machine Code On Your ZX Spectrum](https://www.spectrumcomputing.co.uk/index.php?cat=96&id=2000237) by Toni Baker
* [Programming The Z80](https://spectrumcomputing.co.uk/entry/2000292/Book/Programming_the_Z80) by Rodnay Zaks
* [The Complete Spectrum ROM Disassembly](https://spectrumcomputing.co.uk/entry/2000076/Book/The_Complete_Spectrum_ROM_Disassembly) by Dr. Ian Logan and Dr. Frank O'Hara - [transcribed as text and PDF](http://freestuff.grok.co.uk/rom-dis/)

Other resources
---------------
* [ZXNumber](https://github.com/neonz80/zxtools/tree/main/zxnumber) by Neon - script for encoding numbers in floating-point notation
