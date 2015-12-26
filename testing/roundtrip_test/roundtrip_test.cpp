
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

    std::string original = "PgHDt7UVKDqnZm3zXARL5zOKtB3nmWPZgRYJDzuuDY61W5YixD";
    std::string compressed;
    std::string deflated;

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
        xz::deflate( in, out );
        deflated = out.str();
    }

    QVERIFY( !compressed.empty() );
    QVERIFY( !deflated.empty() );
    QVERIFY( deflated == original );
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

    std::string data = "d8LUeENFcqcwTdRH2cgifU1K9tp7pMmHErQeQLh5U0k58ybMHR";
    std::string compressed;
    std::string deflated;

    std::string filename_original   = "original.txt";
    std::string filename_compressed = "compressed.xz";
    std::string filename_deflated   = "deflated.txt";

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
        std::ofstream out( filename_deflated.c_str(), std::ofstream::out | std::ofstream::binary );
        xz::deflate( in, out );
    }
    deflated = utils::fromFile( filename_deflated );

    QVERIFY( !compressed.empty() );
    QVERIFY( !deflated.empty() );
    QVERIFY( deflated == data );
}

QTEST_MAIN( Roundtrip_test )

#include "roundtrip_test.moc"
