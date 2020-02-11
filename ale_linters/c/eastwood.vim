" Author: Everett Johnson <john2450@purdue.edu>
" Description: ALE linter integration for CS240 eastwood linter

call ale#Set('c_eastwood_executable', 'eastwood')
call ale#Set('c_eastwood_options', '')

function! ale_linters#c#eastwood#Handle(buffer, lines) abort
    " Looks for lines like the following.
    " [VII at line: 2] Error: Function missing function header comment
    let l:pattern = '\v^\[([A-Z\.]{-1,})( at line: )?(\d+)?\] (.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call add(l:output, {
        \   'lnum': str2nr(l:match[3]),
        \   'type': 'W',
        \   'text': '[' . l:match[1] . '] ' . l:match[4],
        \})
    endfor

    return l:output
endfunction

function! ale_linters#c#eastwood#GetCommand(buffer) abort
    return '%e'
    \   . ale#Pad(ale#Var(a:buffer, 'c_eastwood_options'))
    \   . ' %s'
endfunction

call ale#linter#Define('c', {
\   'name': 'eastwood',
\   'executable': {b -> ale#Var(b, 'c_eastwood_executable')},
\   'output_stream': 'both',
\   'lint_file': 1,
\   'command': function('ale_linters#c#eastwood#GetCommand'),
\   'callback': 'ale_linters#c#eastwood#Handle',
\})
