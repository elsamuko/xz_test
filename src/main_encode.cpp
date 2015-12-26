#include <xz/encode.hpp>

int main() {
    bool success = xz::compress( std::cin, std::cout );
    return success ? EXIT_SUCCESS : EXIT_FAILURE;
}

