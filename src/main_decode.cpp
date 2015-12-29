#include <xz/decode.hpp>

#if _WIN32
#include <assert.h>
#include <fcntl.h>
#include <io.h>
#endif // _WIN32

int main() {

#if _WIN32
    // set I/O to binary to avoid EOL casts
    int result = 0;
    result = _setmode( _fileno( stdin ), _O_BINARY );
    assert( result != -1 );
    result = _setmode( _fileno( stdout ), _O_BINARY );
    assert( result != -1 );
#endif // _WIN32

    bool success = xz::decompress( std::cin, std::cout );
    fclose( stdout );
    return success ? EXIT_SUCCESS : EXIT_FAILURE;
}

