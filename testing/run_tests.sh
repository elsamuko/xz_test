#!/usr/bin/env bash

function silent_remove {
    for i in "$1"
    do
        if [ -f "$1" ]; then
            rm "$1"
        fi
        if [ -d "$1" ]; then
            rm -rf "$1"
        fi
    done
}

silent_remove results.txt

case $(uname) in
    Linux)
        SPEC="linux-g++-64"
        MAKE="make --silent -j8"
        ;;
    Darwin)
        SPEC="macx-clang"
        MAKE="make --silent -j8"
        ;;
    CYGWIN*)
        SPEC="win32-msvc2012"
        MAKE="jom.exe -j8"
        # add this line to C:\cygwin\Cygwin.bat
        # call "%VS110COMNTOOLS%..\..\VC\vcvarsall.bat" amd64 >NUL;
        # and revert PATH order in /etc/profile :
        # PATH="${PATH}:/usr/local/bin:/usr/bin/"
         ;;
    *)
        echo "Unknown OS"
        ;;
esac

TESTS="roundtrip_test"
for TEST in $TESTS
do
    cd "$TEST"
    silent_remove Makefile*
    silent_remove bin/${TEST}*

    qmake $TEST.pro -r -spec "$SPEC" CONFIG+=Release CONFIG-=Debug CONFIG+=x86_64

    $MAKE clean > /dev/null 2>&1
    echo "Clean"
    $MAKE > /dev/null 2>&1
    echo "Compile"

    if [ -f ./bin/$TEST ]; then
        echo "Running $TEST"
        cd bin
        ./$TEST >> ../../results.txt
        cd ..
    else
        echo "Error: $TEST did not build"
    fi
    echo "" >> ../results.txt
    cd ..
    echo
done

echo
cat results.txt | grep Totals

