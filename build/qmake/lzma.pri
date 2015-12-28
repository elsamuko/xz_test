
LZMA_DIR=$${MAIN_DIR}/libs/lzma/bin/$${PLATFORM}/$${COMPILE_MODE}
INCLUDEPATH += $${MAIN_DIR}/libs/lzma/include

LIBS += -L$${LZMA_DIR}
unix: LIBS += $${LZMA_DIR}/liblzma.a
win32 {
    DEFINES += LZMA_API_STATIC
    static: LIBS += $${LZMA_DIR}/liblzma_MT.lib
    !static: LIBS += $${LZMA_DIR}/liblzma_MD.lib
}

HEADERS += $${SRC_DIR}/log.hpp

SOURCES += $${SRC_DIR}/xz/encode.cpp
HEADERS += $${SRC_DIR}/xz/encode.hpp

SOURCES += $${SRC_DIR}/xz/decode.cpp
HEADERS += $${SRC_DIR}/xz/decode.hpp
