project('c2wasm', 'c')

src = '../hello.c'
executable('hello', src, link_args: [
    '-s','WASM=1',
    '-o', 'hello.js'
])