if &cp || exists("g:loaded_rtags")
 finish
endif
let g:loaded_rtags = 1

command! -nargs=0 RtagsFindReferences :call rtags#find_references()
command! -nargs=0 RtagsFollow :call rtags#follow()
