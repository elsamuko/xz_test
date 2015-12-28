#include <xz/decode.hpp>

int main() {
    bool success = xz::deflate( std::cin, std::cout );
    fclose( stdout );
    return success ? EXIT_SUCCESS : EXIT_FAILURE;
}

