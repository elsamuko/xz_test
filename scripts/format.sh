#!/usr/bin/env bash

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
MAIN_DIR="$SCRIPT_DIR/.."

function format_code {
    astyle \
        --style=java \
        --indent=spaces \
        --indent-classes \
        --indent-switches \
        --indent-col1-comments \
        --indent-namespaces \
        --break-blocks \
        --pad-oper \
        --pad-paren-in \
        --unpad-paren \
        --add-brackets \
        --align-pointer=type \
        -r "$1"
}

format_code "$MAIN_DIR/src/*.cpp"
format_code "$MAIN_DIR/src/*.hpp"
format_code "$MAIN_DIR/src/*.h"

format_code "$MAIN_DIR/testing/*.cpp"
format_code "$MAIN_DIR/testing/*.hpp"

