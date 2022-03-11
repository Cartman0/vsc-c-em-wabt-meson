Docker Iamge for development environment of C/C++, [Emscripten](https://emscripten.org/), [WABT](https://github.com/WebAssembly/wabt) and [Meson](https://mesonbuild.com/) on Dcoker and VSCode RemoteContainer

## Image info

- base image: [mcr.microsoft.com/vscode/devcontainers/cpp](https://github.com/microsoft/vscode-dev-containers/blob/v0.217.4/containers/cpp/.devcontainer/Dockerfile)
    - based on OS:Debian 11
- image size: 2.97 GB


## installed packages/tools

- gcc/clang
- [emscripten](https://github.com/emscripten-core/emsdk/blob/main/docker/Dockerfile)
    - Node.js installed with emscripten
- [WABT](https://github.com/WebAssembly/wabt) (wasm2wat, etc)
- Meson(building tool)
    - ninja-builld
- python3, python3-pip (for installing Meson)

## VScode Extensions

- [Microsoft, "C/C++ Extension Pack",
id: `ms-vscode.cpptools-extension-pack`](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack)
- [WebAssembly Foundation, "WebAssembly ", id: `dtsvet.vscode-wasm`](https://marketplace.visualstudio.com/items?itemName=dtsvet.vscode-wasm)

## TIPS

- project's patterns how to write Meson's `meson.build` file: https://mesonbuild.com/Users.html
