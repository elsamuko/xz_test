
LIBS += -framework CoreServices -framework Carbon -framework ApplicationServices

# c++11 specials
LIBS += -lc++
# INCLUDEPATH += /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/c++/v1
QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.7
QMAKE_CXXFLAGS += -std=c++1y -stdlib=libc++
QMAKE_MAC_SDK = macosx10.9

QMAKE_CXXFLAGS_RELEASE += -msse2 -Ofast -finline -ffast-math -funsafe-math-optimizations

QMAKE_CXXFLAGS_WARN_ON -= -Wall
QMAKE_CXXFLAGS_WARN_ON += -Wall -Wno-unknown-pragmas

INCLUDEPATH += /opt/local/include
LIBS += -L/opt/local/lib
