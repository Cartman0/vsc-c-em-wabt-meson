#!/bin/bash
gcc -v
echo;
clang -v
echo;
emcc -v
echo;
echo "wasm2wat ver:"
/wabt/bin/wasm2wat --version
echo;
echo "Node.js ver:"
node -v
echo;
echo "meson ver:"
meson -v
echo;
echo "ninja ver:"
ninja --version
exit 0