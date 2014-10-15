if !exists('g:rtags#command')
    let g:rtags#command = 'rc'
endif

function! rtags#do_cmd(cmd)
    let res = split(system(g:rtags#command . ' ' . a:cmd), '\n')
    return res
endfunction

function! rtags#find_references()
    let def = expand('%:p') . ':' . line('.') . ':' . col('.')
    let loclist = []
    let res = rtags#do_cmd('--references "' . def . '"')
    for i in res
        let t = split(i, ':')
        let item = {'filename' : t[0], 'lnum' : t[1], 'col' : t[2], 'text' : join(t[3:], ':')}
        call add(loclist, item)
    endfor
    call setloclist(0, loclist)
    exec "lopen"
endfunction

function! rtags#follow()
    let def = expand('%:p') . ':' . line('.') . ':' . col('.')
    let res = rtags#do_cmd('--follow-location "' . def . '"')
    if len(res) > 0
        let t = split(res[0], ':')
        exec 'e ' . t[0]
        call cursor(t[1], t[2])
    endif
endfunction
