
#include <sstream>
#include <fstream>

#include <QtTest>

#include <xz/decode.hpp>
#include <xz/encode.hpp>

class Roundtrip_test : public QObject {
        Q_OBJECT

    public:
        Roundtrip_test();

    private Q_SLOTS:
        void testString();
        void testFile();
};

Roundtrip_test::Roundtrip_test() {
}

void Roundtrip_test::testString() {

    std::string longString = "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789";

    for( size_t i = 0; i < 100; ++i ) {
        std::string original = longString.substr( 0, i );
        std::string compressed;
        std::string decompressed;

        // compress
        {
            std::stringstream in( original );
            std::stringstream out;
            xz::compress( in, out );
            compressed = out.str();
        }

        // deflate
        {
            std::stringstream in( compressed );
            std::stringstream out;
            xz::decompress( in, out );
            decompressed = out.str();
        }

        QVERIFY2( !compressed.empty(), std::to_string( i ).c_str() );
        QVERIFY2( decompressed.size() == i, std::to_string( i ).c_str() );
        QVERIFY2( decompressed == original, std::to_string( i ).c_str() );
    }
}

namespace utils {
    std::string fromFile( const std::string& filename ) {
        std::ifstream file( filename.c_str(), std::ifstream::in | std::ifstream::binary );
        return std::string( ( std::istreambuf_iterator<char>( file ) ), ( std::istreambuf_iterator<char>() ) );
    }

    void toFile( const std::string& filename, const std::string& data ) {
        std::ofstream file( filename.c_str(), std::ofstream::out | std::ofstream::binary );
        file << data;
    }
}

void Roundtrip_test::testFile() {

    std::string longString = "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789"
                             "0123456789";

    for( size_t i = 0; i < 100; ++i ) {
        std::string data = longString.substr( 0, i );
        std::string compressed;
        std::string decompressed;

        std::string filename_original       = "original.txt";
        std::string filename_compressed     = "compressed.xz";
        std::string filename_decompressed   = "deflated.txt";

        utils::toFile( filename_original.c_str(), data );

        // compress
        {
            std::ifstream in( filename_original.c_str(), std::ifstream::in | std::ifstream::binary );
            std::ofstream out( filename_compressed.c_str(), std::ofstream::out | std::ofstream::binary );
            xz::compress( in, out );
        }
        compressed = utils::fromFile( filename_compressed );

        // deflate
        {
            std::ifstream in( filename_compressed.c_str(), std::ifstream::in | std::ifstream::binary );
            std::ofstream out( filename_decompressed.c_str(), std::ofstream::out | std::ofstream::binary );
            xz::decompress( in, out );
        }
        decompressed = utils::fromFile( filename_decompressed );

        QVERIFY( !compressed.empty() );
        QVERIFY( decompressed.size() == i );
        QVERIFY( decompressed == data );
    }
}

QTEST_MAIN( Roundtrip_test )

#include "roundtrip_test.moc"
