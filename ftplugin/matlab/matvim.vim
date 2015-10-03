if !has('python')
    finish
endif

" load python module

python import vim
python import sys
python sys.path.append(vim.eval('expand("<sfile>:h")'))
python import matvim

" python wrappers

function! MatlabStart()
python matvim.startMatlab()
endfunction

function! MatlabConnect(sessionID)
python matvim.connectMatlab(vim.eval('a:sessionID'))
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

" shortkeys

nmap <buffer>,l :call MatlabRunLine() <cr>
nmap <buffer>,r :call MatlabRunFile() <cr>
vmap <buffer>,s :call MatlabRunSelection() <cr>
nmap <buffer>,s :call MatlabRunSection() <cr>
