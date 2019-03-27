
LIBS += -framework CoreServices -framework Carbon -framework ApplicationServices

QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.10
QMAKE_CXXFLAGS_RELEASE += -msse2 -Ofast
