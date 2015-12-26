
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
macx:  include( $${PRI_DIR}/mac.pri )

LIBS += -llzma

SOURCES += $${SRC_DIR}/main_decode.cpp
SOURCES += $${SRC_DIR}/xz/decode.cpp

HEADERS += $${SRC_DIR}/xz/decode.hpp
HEADERS += $${SRC_DIR}/log.hpp
