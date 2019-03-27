#!/usr/bin/env bash

OS=win
PROJECT=lzma
VERSION="5.2.4"
DL_URL="https://tukaani.org/xz/xz-$VERSION.tar.xz"

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
MAIN_DIR="$SCRIPT_DIR/.."
TARGET_DIR="$MAIN_DIR/libs/$PROJECT"
PROJECT_DIR="$MAIN_DIR/tmp/$PROJECT"
DOWNLOAD="$PROJECT_DIR/$PROJECT-$VERSION.tar.xz"
SRC_DIR="$PROJECT_DIR/src"
BUILD_DIR="$SRC_DIR/$PROJECT-$VERSION/windows/vs2017"
BUILD_HELPER="$BUILD_DIR/build.bat"

function indent {
    sed  's/^/     /'
}

function doPrepare {
    if [ -d "$SRC_DIR" ]; then
        rm -rf "$SRC_DIR"
    fi
    if [ -d "$TARGET_DIR" ]; then
        rm -rf "$TARGET_DIR"
    fi
    mkdir -p "$PROJECT_DIR"
    mkdir -p "$TARGET_DIR"
    mkdir -p "$SRC_DIR"
}

function doDownload {
    if [ ! -f "$DOWNLOAD" ]; then
        curl -Ls "$DL_URL" -o "$DOWNLOAD"
    fi
}

function doUnzip {
    tar xJf "$DOWNLOAD" -C "$SRC_DIR"
    for FROM in "$SRC_DIR"/*; do
        echo $FROM
        mv "$FROM" "$SRC_DIR/$PROJECT-$VERSION"
        break
    done
}

function create_helper {
    # VS2017 has no VS150COMNTOOLS
    if [ -d 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\' ]; then
        export VS150COMNTOOLS='C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\Tools\'
    fi
    if [ -d 'C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\' ]; then
        export VS150COMNTOOLS='C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\Common7\Tools\'
    fi

    # VS 2017
    if [ -n "$VS150COMNTOOLS" ]; then
        local ALLCONFIG="/p:platform=x64 /p:PlatformToolset=v141 /p:PreferredToolArchitecture=x64"
        echo "Building with VS 2017"
		echo -ne '@echo off\r\n\r\ncall "%VS150COMNTOOLS%..\\..\\VC\\Auxiliary\\Build\\vcvars32.bat"\r\n' > "$BUILD_HELPER"
		echo -ne '\r\n' >> "$BUILD_HELPER"
		echo -ne "msbuild liblzma.vcxproj /p:configuration=debugMT $ALLCONFIG\r\n" >> "$BUILD_HELPER"
		echo -ne "msbuild liblzma.vcxproj /p:configuration=releaseMT $ALLCONFIG\r\n" >> "$BUILD_HELPER"
		echo -ne "msbuild liblzma.vcxproj /p:configuration=debug $ALLCONFIG\r\n" >> "$BUILD_HELPER"
		echo -ne "msbuild liblzma.vcxproj /p:configuration=release $ALLCONFIG\r\n" >> "$BUILD_HELPER"
	else 
        echo "This script needs VS2017"
	fi

    chmod +x "$BUILD_HELPER"
}

function doBuild {
	create_helper
	
	# patched version with DebugMT target
	cp "$SCRIPT_DIR/liblzma.vcxproj" "$BUILD_DIR" 

    # debug and release
    cd "$BUILD_DIR"
	"$BUILD_HELPER"
}

function doCopy {
    mkdir -p "$TARGET_DIR/bin/$OS/debug"
    mkdir -p "$TARGET_DIR/bin/$OS/release"
    mkdir -p "$TARGET_DIR/include"
    cp -r "$BUILD_DIR/debug/x64/liblzma/liblzma.lib" "$TARGET_DIR/bin/$OS/debug/liblzma_MD.lib"
    cp -r "$BUILD_DIR/release/x64/liblzma/liblzma.lib" "$TARGET_DIR/bin/$OS/release/liblzma_MD.lib"
    cp -r "$BUILD_DIR/debugMT/x64/liblzma/liblzma.lib" "$TARGET_DIR/bin/$OS/debug/liblzma_MT.lib"
    cp -r "$BUILD_DIR/releaseMT/x64/liblzma/liblzma.lib" "$TARGET_DIR/bin/$OS/release/liblzma_MT.lib"
    cp -r "$BUILD_DIR/../../src/liblzma/api"/* "$TARGET_DIR/include"
}


echo "Prepare"
doPrepare | indent

echo "Download"
doDownload | indent

echo "Unzip"
doUnzip | indent

echo "Build"
doBuild 2>&1 | indent

echo "Copy"
doCopy | indent
