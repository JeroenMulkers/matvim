if !has('python')
    finish
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

function! MatlabConnect(sessionID)
python matvim.connectMatlab(vim.eval('a:sessionID'))
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
