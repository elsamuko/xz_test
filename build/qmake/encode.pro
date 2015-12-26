
TEMPLATE = app
CONFIG += console c++11
CONFIG -= app_bundle
CONFIG -= qt

MAIN_DIR = ../..
PRI_DIR  = $${MAIN_DIR}/build/qmake
SRC_DIR  = $${MAIN_DIR}/src

include( $${PRI_DIR}/setup.pri )
DESTDIR  = $${MAIN_DIR}/bin/$${COMPILE_MODE}
linux: include( $${PRI_DIR}/linux.pri )

LIBS += -llzma

SOURCES += $${SRC_DIR}/main_encode.cpp
SOURCES += $${SRC_DIR}/xz/encode.cpp

HEADERS += $${SRC_DIR}/xz/encode.hpp
HEADERS += $${SRC_DIR}/log.hpp
