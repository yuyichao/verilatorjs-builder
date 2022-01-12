#!/bin/sh

builder_dir=$(realpath "$1")
source_dir=$(realpath "$2")

export CFLAGS='-g0 -O3'
export CXXFLAGS='-g0 -O3'
export LDFLAGS='-O3 -g0 -s INVOKE_RUN=0 -s MODULARIZE=1 -s EXPORTED_RUNTIME_METHODS=["callMain"]'
export EM_NODE_JS="$builder_dir/scripts/node_wrapper"

cd "$source_dir"
autoconf
emconfigure ./configure
emmake make verilator_bin
