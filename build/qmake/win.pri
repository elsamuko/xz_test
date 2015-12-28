
# set 'd'
CONFIG(debug, debug|release) {
    COMPILE_FLAG=d
}

static {
    # change MD -> MT
    # \sa mkspecs/common/msvc-desktop.conf
    QMAKE_CFLAGS_RELEASE -= -MD
    QMAKE_CFLAGS_RELEASE += -MT
    QMAKE_CXXFLAGS_RELEASE -= -MD
    QMAKE_CXXFLAGS_RELEASE += -MT
    QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO -= -MD
    QMAKE_CFLAGS_RELEASE_WITH_DEBUGINFO += -MT
    QMAKE_CFLAGS_DEBUG -= -MDd
    QMAKE_CFLAGS_DEBUG += -MTd
    QMAKE_CXXFLAGS_DEBUG -= -MDd
    QMAKE_CXXFLAGS_DEBUG += -MTd

    LIBS += msvcrt$${COMPILE_FLAG}.lib libcpmt$${COMPILE_FLAG}.lib
    LIBS += /NODEFAULTLIB:libcmt$${COMPILE_FLAG}
}
