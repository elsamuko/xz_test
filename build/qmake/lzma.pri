
LZMA_DIR=$${MAIN_DIR}/libs/lzma/bin/$${PLATFORM}/$${COMPILE_MODE}
INCLUDEPATH += $${MAIN_DIR}/libs/lzma/include

LIBS += -L$${LZMA_DIR}
LIBS += $${LZMA_DIR}/liblzma.a

HEADERS += $${SRC_DIR}/log.hpp

SOURCES += $${SRC_DIR}/xz/encode.cpp
HEADERS += $${SRC_DIR}/xz/encode.hpp

SOURCES += $${SRC_DIR}/xz/decode.cpp
HEADERS += $${SRC_DIR}/xz/decode.hpp
