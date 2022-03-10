project('c2exe', 'c')

env = environment()
# set clang
env.append('CC', 'clang')
meson.add_devenv(env)

src = '../hello.c'
executable('hello', src)