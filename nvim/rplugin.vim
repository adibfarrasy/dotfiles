if exists('g:loaded_hello')
    finish
endif
let g:loaded_hello = 1

function! s:Requirehello(host) abort
    " 'hello' is the binary created by compiling the program above.
    return jobstart(['hello'], {'rpc': v:true})
endfunction

call remote#host#Register('hello', 'x', function('s:Requirehello'))
" The following lines are generated by running the program
" command line flag --manifest hello
call remote#host#RegisterPlugin('hello', '0', [
\ {'type': 'function', 'name': 'Hello', 'sync': 1, 'opts': {}},
\ {'type': 'function', 'name': 'Hello2', 'sync': 1, 'opts': {}},
\ ])

" vim:ts=4:sw=4:et
