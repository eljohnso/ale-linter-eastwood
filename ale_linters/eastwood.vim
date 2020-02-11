" Author: Everett Johnson <john2450@purdue.edu>
" Description: ALE linter integration for CS240 eastwood linter

call ale#Set('c_eastwood_executable', 'eastwood')
call ale#Set('c_eastwood_options', '')

function! ale_linters#c#eastwood#Handle(buffer, lines) abort
    " Looks for lines like the following.
    " [VII at line: 2] Error: Function missing function header comment
    let l:pattern = '\v^\[.+ at line: (\d+)\] (.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': str2nr(l:match[1]),
        \   'text': l:match[2],
        \})
    endfor

    return l:output
endfunction

function! ale_linters#c#eastwood#GetCommand(buffer) abort
    return '%e'
    \   . ale#Pad(ale#Var(a:buffer, 'c_eastwood_options'))
    \   . ' %t'
endfunction

call ale#linter#Define('c', {
\   'name': 'eastwood',
\   'executable': {b -> ale#Var(b, 'c_eastwood_executable')},
\   'output_stream': 'both',
\   'command': function('ale_linters#c#eastwood#GetCommand'),
\   'callback': 'ale_linters#c#eastwood#Handle',
\})
