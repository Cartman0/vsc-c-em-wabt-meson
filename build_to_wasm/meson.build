# b_asneeded=false
project('CtoWasm', 'c', 
  default_options:[
    'b_asneeded=false',
  ])
src = '../hello.c'
dst_js_wasm = 'hello'

compiler_c = meson.get_compiler('c')

linker_c_id = compiler_c.get_linker_id()
link_args=[]
if linker_c_id == 'ld.wasm'
  #link_args = ['-s', 'WASM=1']
  #add_project_link_arguments(link_args, language : ['c'])
endif

executable(dst_js_wasm, src)
message(get_option('b_asneeded')) 
message(get_option('b_lundef')) 