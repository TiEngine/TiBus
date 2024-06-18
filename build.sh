#!/bin/bash

set -e
CURRENT_PATH=$(cd "$(dirname "$0")"; pwd)
cd ${CURRENT_PATH}

usage() {
    echo ""
    echo "Usage: bash <workspace>/build.sh [options]"
    echo "-b | --build_config_mode, { Debug, Release }"
    echo "-h | --help"
    echo ""
}

parse_args() {
    for arg in "$@"
    do
        case $arg in
            -h | --help)
            usage
            exit
            ;;
            -b=* | --build_config_mode=*)
            build_config_mode="${arg#*=}"
            ;;
            *)
            echo "Error: unknown parameter $arg"
            usage
            exit 1
            ;;
        esac
    done
}

build_config_mode=Debug
parse_args $@

cmake -S . -B build
cmake --build build --config ${build_config_mode} --parallel
cmake --install build --prefix output --config ${build_config_mode}
