QT       += testlib

CONFIG -= app_bundle
CONFIG += x86_64
TEMPLATE = app
DESTDIR = bin

macx: PLATFORM=mac
win32: PLATFORM=win
unix: !macx: PLATFORM=linux

MAIN_DIR=../..

PRI_DIR  = $${MAIN_DIR}/build/qmake
SRC_DIR  = $${MAIN_DIR}/src

include( $${PRI_DIR}/setup.pri )
include( $${PRI_DIR}/lzma.pri )
macx:  include( $${PRI_DIR}/mac.pri )
linux: include( $${PRI_DIR}/linux.pri )

SOURCES += roundtrip_test.cpp
