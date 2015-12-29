# xz_test

## brief
xz_test is a simple C++-wrapper for xz utils, based on the sample programs from [xz](http://tukaani.org/xz/).

## usage
Add all files from src/xz and log.hpp to your source files. Then you can use
`xz::compress( std::istream& istream, std::ostream& ostream )`, which is based on [01_compress_easy.c](http://git.tukaani.org/?p=xz.git;a=blob;f=doc/examples/01_compress_easy.c;hb=HEAD)
and
`xz::decompress( std::istream& istream, std::ostream& ostream )` which is based on [02_decompress.c](http://git.tukaani.org/?p=xz.git;a=blob;f=doc/examples/02_decompress.c;hb=HEAD)

## building
To build 64 Bit static libs for Linux, Mac and Windows, just run the corresponding build script from the scripts folder.
Note: The Windows build script builds MT and MD libs.

## examples
In build/qmake are two sample projects, which use xz::compress and xz::decompress with std::cin and std::cout.
Note: These are linked with static CRT (MT) under Windows.

In testing/roundtrip_test is a Qt based unit test, which tests xz::compress and xz::decompress with std::strings and files.
Note: These are linked with dynamic CRT (MD) under Windows.
