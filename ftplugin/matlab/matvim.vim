if !has('python')
    finish
endif

" default settings

if !exists('g:matvim_auto_connect')
    let g:matvim_auto_connect = 0
endif

if !exists('g:matvim_auto_start')
    let g:matvim_auto_start = 0
endif

" load python module

python import vim
python import sys
python sys.path.append(vim.eval('expand("<sfile>:h")'))
python import matvim

" bold cell titles

highlight MATCELL cterm=bold term=bold gui=bold
match MATCELL /^%%[^%]*$/

" python wrappers

function! MatlabStart()
python matvim.startMatlab()
endfunction

function! MatlabConnect(...)
    if a:0 == 0
        python matvim.connectMatlab()
    elseif a:0 == 1
        python matvim.connectMatlab(vim.eval('a:1'))
    endif
endfunction

function! MatlabFind(...)
python matvim.findMatlab()
endfunction

function! MatlabRunLine()
python matvim.runLine()
endfunction

function! MatlabRunFile()
python matvim.runFile()
endfunction

function! MatlabRunSelection() range
python matvim.runSelection()
endfunction

function! MatlabRunSection()
python matvim.runSection()
endfunction

function! MatlabShowVariable()
python matvim.showVariable()
endfunction

function! MatlabRunCommand(...)
    if a:0 == 0
        let commandstr = input('>> ')
        echo ' '
        python matvim.runCommand(vim.eval('commandstr'))
    elseif a:0 == 1
        python matvim.runCommand(vim.eval('a:1'))
    endif
endfunction

" Initialize engine

if g:matvim_auto_connect && !g:matvim_auto_start
    python matvim.connectMatlab()
endif

if g:matvim_auto_start && !g:matvim_auto_connect
    python matvim.startMatlab()
endif

if g:matvim_auto_connect && g:matvim_auto_start
    python matvim.connectOrStartMatlab()
endif

" shortcuts and commands

command! -nargs=1 Matlab :call MatlabRunCommand(<f-args>)
command! MatlabStart :call MatlabStart()
command! MatlabFind :echo MatlabFind()
command! -nargs=? -complete=customlist,MatlabFind MatlabConnect :call MatlabConnect(<f-args>)

nmap <buffer>,m :call MatlabRunCommand() <cr>
nmap <buffer>,l :call MatlabRunLine() <cr>
nmap <buffer>,r :call MatlabRunFile() <cr>
vmap <buffer>,s :call MatlabRunSelection() <cr>
nmap <buffer>,s :call MatlabRunSection() <cr>
nmap <buffer>,v :call MatlabShowVariable() <cr>
