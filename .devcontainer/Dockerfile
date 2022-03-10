# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.217.4/containers/cpp/.devcontainer/base.Dockerfile

# [Choice] Debian / Ubuntu version (use Debian 11, Ubuntu 18.04/21.04 on local arm64/Apple Silicon): debian-11, debian-10, ubuntu-21.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT="debian-11"
FROM mcr.microsoft.com/vscode/devcontainers/cpp:0-${VARIANT} AS stage_build_emscripten

# [Optional] Uncomment this section to install additional packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

ARG EMSCRIPTEN_VERSION=latest
ARG EMSCRIPTEN_REPO=https://github.com/emscripten-core/emsdk.git
ENV EMSDK /emsdk

# apt-get packages
RUN echo "# apt-get packages:git" \ 
    && apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    git \
    && echo "# Done"

# install EMSDK
RUN echo "# Install Emscripten" \
    && git clone ${EMSCRIPTEN_REPO} \
    && cd ${EMSDK} \
    && git pull \
    && ./emsdk install ${EMSCRIPTEN_VERSION} \
    && echo "# Done"

# This generates configuration that contains all valid paths according to installed SDK
# TODO(sbc): We should be able to use just emcc -v here but it doesn't
# currently create the sanity file.
RUN cd ${EMSDK} \
    && echo "# Generate standard configuration" \
    && ./emsdk activate ${EMSCRIPTEN_VERSION} \
    && chmod 777 ${EMSDK}/upstream/emscripten \
    && chmod -R 777 ${EMSDK}/upstream/emscripten/cache \
    && echo "int main() { return 0; }" > hello.c \
    && ${EMSDK}/upstream/emscripten/emcc -c hello.c \
    && cat ${EMSDK}/upstream/emscripten/cache/sanity.txt \
    && echo "# Done"

# Cleanup Emscripten installation and strip some symbols
RUN echo "# Aggressive optimization: Remove debug symbols" \
    && cd ${EMSDK} && . ./emsdk_env.sh \
    # Remove debugging symbols from embedded node (extra 7MB)
    && strip -s `which node` \
    # Tests consume ~80MB disc space
    && rm -fr ${EMSDK}/upstream/emscripten/tests \
    # Fastcomp is not supported
    && rm -fr ${EMSDK}/upstream/fastcomp \
    # strip out symbols from clang (~extra 50MB disc space)
    && find ${EMSDK}/upstream/bin -type f -exec strip -s {} + || true \
    && echo "# Done"


# DEPLOY
FROM mcr.microsoft.com/vscode/devcontainers/cpp:0-${VARIANT} AS stage_deploy

# deploy EMSDK
COPY --from=stage_build_emscripten /emsdk /emsdk
ENV EMSDK=/emsdk \
    EM_CONFIG=/emsdk/.emscripten \
    EMSDK_NODE=/emsdk/node/14.18.2_64bit/bin/node \
    PATH="/emsdk:/emsdk/upstream/emscripten:/emsdk/upstream/bin:/emsdk/node/14.18.2_64bit/bin:${PATH}"

# install WABT
# https://github.com/WebAssembly/wabt
ARG WABT_REPO=https://github.com/WebAssembly/wabt
RUN echo "# Install WABT" \
    && git clone --recursive ${WABT_REPO} \
    && cd wabt \
    && git submodule update --init \
    && make \
    && echo "# Done"

# Meson
RUN echo "# Install python for Meson" \
    && sudo apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get -y install python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    ninja-build \
    && echo "# Done"

RUN echo "# Install Meson" \
    && pip3 install meson \
    && echo "# Done"