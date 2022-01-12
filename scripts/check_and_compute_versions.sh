#!/bin/bash

verilator_ver=$1
build_ver=$(cat BUILD_VERSION)

echo "Verilator version $verilator_ver"
echo "Build version $build_ver"

read_verilatorjs_version() {
    local verilator_ver build_ver
    if [ -f verilatorjs/.source_ver ]; then
        . verilatorjs/.source_ver
        old_verilator_ver=$verilator_ver
        old_build_ver=$build_ver
        echo "Built verilator version $verilator_ver"
        echo "Built build version $build_ver"
    fi
}

read_verilatorjs_version

if [ "$verilator_ver" = "$old_verilator_ver" ] && [ "$build_ver" = "$old_build_ver" ]; then
    echo '::set-output name=uptodate::1'
    return 0
fi

echo '::set-output name=uptodate::0'
if ! [[ "$verilator_ver" =~ ^v([0-9]+)\.([0-9]+)$ ]]; then
    echo "Unexpected verilator version format: ${verilator_ver}" >&2
    return 1
fi

echo "::set-output name=version::${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.$build_ver"
{
    echo "verilator_ver=$verilator_ver"
    echo "build_ver=$build_ver"
} > verilatorjs/.source_ver
