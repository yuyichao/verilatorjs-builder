#!/bin/sh

builder_dir=$(realpath "$1")
source_dir=$(realpath "$2")

export CFLAGS='-g0 -O3 -flto'
export CXXFLAGS='-g0 -O3 -flto'
export LDFLAGS='-g0 -O3 -flto -s INVOKE_RUN=0 -s MODULARIZE=1 -s EXPORTED_RUNTIME_METHODS=["callMain","FS"]'
export EM_NODE_JS="$builder_dir/scripts/node_wrapper"

cd "$source_dir"
autoconf
emconfigure ./configure --disable-defenv
emmake make -C src opt
