all: hello.tap
	/Applications/Fuse.app/Contents/MacOS/Fuse --tape hello.tap

hello.bas.tap: hello.bas
	zmakebas -o hello.bas.tap -n hello -a 10 hello.bas

hello.bin.tap: hello.asm
	pasmo --name hello1 --tap hello.asm hello.bin.tap

hello.tap: hello.bas.tap hello.bin.tap
	cat hello.bas.tap hello.bin.tap > hello.tap
