"=============================================================================
" FILE: omni_complete.vim
" AUTHOR:  Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 22 Jun 2010
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

function! neocomplcache#complfunc#omni_complete#initialize()"{{{
  " Initialize omni completion pattern."{{{
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  if has('ruby')
    try 
      ruby 1
      call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'ruby',
            \'[^. *\t]\.\h\w*\|\h\w*::')
    catch
    endtry
  endif
  if has('python')
    try 
      python 1
      call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'python',
            \'[^. \t]\.\h\w*')
    catch
    endtry
  endif
  call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'html,xhtml,xml,markdown',
        \'<[^>]*')
  call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'css',
        \'^\s\+\w+\|\w+[):;]?\s\+\|[@!]')
  call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'javascript',
        \'[^. \t]\.\%(\h\w*\)\?')
  call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'actionscript',
        \'[^. \t][.:]\h\w*')
  "call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'php',
        "\'[^. \t]->\h\w*\|\$\h\w*\|\%(=\s*new\|extends\)\s\+\|\h\w*::')
  call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'java',
        \'\%(\h\w*\|)\)\.')
  "call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'perl',
  "\'\h\w*->\h\w*\|\h\w*::')
  "call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'c',
        "\'\h\w\+\|\%(\h\w*\|)\)\%(\.\|->\)\h\w*')
  "call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'cpp',
        "\'\h\w*\%(\.\|->\)\h\w*\|\h\w*::')
  call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'vimshell',
        \'\%(\\[^[:alnum:].-]\|[[:alnum:]@/.-_+,#$%~=*]\)\{2,}')
  call neocomplcache#set_variable_pattern('g:neocomplcache_omni_patterns', 'objc',
        \'\h\w\+\|\h\w*\%(\.\|->\)\h\w*')
  "}}}
  
  " Initialize omni function list."{{{
  if !exists('g:neocomplcache_omni_functions')
    let g:neocomplcache_omni_functions = {}
  endif
  "}}}

  let s:keyword_cache = {}
  let s:completion_length = neocomplcache#get_auto_completion_length('omni_complete')
endfunction"}}}
function! neocomplcache#complfunc#omni_complete#finalize()"{{{
endfunction"}}}

function! neocomplcache#complfunc#omni_complete#get_keyword_pos(cur_text)"{{{
  let l:filetype = neocomplcache#get_context_filetype()
  if neocomplcache#is_eskk_enabled()
    let l:omnifunc = &l:omnifunc
  elseif has_key(g:neocomplcache_omni_functions, l:filetype)
    let l:omnifunc = g:neocomplcache_omni_functions[l:filetype]
  elseif &filetype == l:filetype
    let l:omnifunc = &l:omnifunc
  else
    " &omnifunc is irregal.
    return -1
  endif

  if l:omnifunc == ''
    return -1
  endif
  
  if has_key(g:neocomplcache_omni_patterns, l:omnifunc)
    let l:pattern = g:neocomplcache_omni_patterns[l:omnifunc]
  elseif l:filetype != '' && has_key(g:neocomplcache_omni_patterns, l:filetype)
    let l:pattern = g:neocomplcache_omni_patterns[l:filetype]
  else
    let l:pattern = ''
  endif

  if !neocomplcache#is_eskk_enabled() && neocomplcache#is_auto_complete() && l:pattern == ''
    return -1
  endif

  let l:is_wildcard = g:neocomplcache_enable_wildcard && a:cur_text =~ '\*\w\+$'
        \&& neocomplcache#is_auto_complete()

  " Check wildcard.
  if l:is_wildcard
    " Check wildcard.
    let l:cur_text = a:cur_text[: match(a:cur_text, '\%(\*\w\+\)\+$') - 1]
  else
    let l:cur_text = a:cur_text
  endif

  if neocomplcache#is_auto_complete() &&
        \l:cur_text !~ '\%(' . l:pattern . '\m\)$'
    return -1
  endif

  " Save pos.
  let l:pos = getpos('.')
  let l:line = getline('.')

  if neocomplcache#is_auto_complete()
    call setline('.', l:cur_text)
  endif

  try
    let l:cur_keyword_pos = call(l:omnifunc, [1, ''])
  catch
    let l:cur_keyword_pos = -1
  endtry

  " Restore pos.
  if neocomplcache#is_auto_complete()
    call setline('.', l:line)
  endif
  call setpos('.', l:pos)

  if !neocomplcache#is_eskk_enabled() && neocomplcache#is_auto_complete() && col('.') - l:cur_keyword_pos < s:completion_length 
    " Too short completion length.
    return -1
  endif

  return l:cur_keyword_pos
endfunction"}}}

function! neocomplcache#complfunc#omni_complete#get_complete_words(cur_keyword_pos, cur_keyword_str)"{{{
  let l:is_wildcard = g:neocomplcache_enable_wildcard && a:cur_keyword_str =~ '\*\w\+$'
        \&& neocomplcache#is_eskk_enabled() && neocomplcache#is_auto_complete()

  let l:filetype = neocomplcache#get_context_filetype()
  if neocomplcache#is_eskk_enabled()
    let l:omnifunc = &l:omnifunc
  elseif has_key(g:neocomplcache_omni_functions, l:filetype)
    let l:omnifunc = g:neocomplcache_omni_functions[l:filetype]
  elseif &filetype == l:filetype
    let l:omnifunc = &l:omnifunc
  endif

  let l:pos = getpos('.')
  if l:is_wildcard
    " Check wildcard.
    let l:cur_keyword_str = a:cur_keyword_str[: match(a:cur_keyword_str, '\%(\*\w\+\)\+$') - 1]
  else
    let l:cur_keyword_str = a:cur_keyword_str
  endif

  try
    if l:filetype == 'ruby' && l:is_wildcard
      let l:line = getline('.')
      let l:cur_text = neocomplcache#get_cur_text()
      call setline('.', l:cur_text[: match(l:cur_text, '\%(\*\w\+\)\+$') - 1])
    endif

    let l:list = call(l:omnifunc, [0, (l:filetype == 'ruby')? '' : l:cur_keyword_str])

    if l:filetype == 'ruby' && l:is_wildcard
      call setline('.', l:line)
    endif
  catch
    let l:list = []
  endtry
  call setpos('.', l:pos)

  if empty(l:list)
    return []
  endif

  if l:is_wildcard
    return neocomplcache#keyword_filter(s:get_omni_list(l:list), a:cur_keyword_str)
  else
    return s:get_omni_list(l:list)
  endif
endfunction"}}}

function! neocomplcache#complfunc#omni_complete#get_rank()"{{{
  return 100
endfunction"}}}

function! s:get_omni_list(list)"{{{
  let l:omni_list = []

  " Convert string list.
  for str in filter(copy(a:list), 'type(v:val) == '.type(''))
    let l:dict = { 'word' : str, 'menu' : '[O]' }

    call add(l:omni_list, l:dict)
  endfor

  for l:omni in filter(a:list, 'type(v:val) != '.type(''))
    let l:dict = {
          \'word' : l:omni.word, 'menu' : '[O]',
          \'abbr' : has_key(l:omni, 'abbr')? l:omni.abbr : l:omni.word,
          \}

    if has_key(l:omni, 'kind')
      let l:dict.kind = l:omni.kind
    endif

    if has_key(l:omni, 'menu')
      let l:dict.menu .= ' ' . l:omni.menu
    endif

    call add(l:omni_list, l:dict)
  endfor

  return l:omni_list
endfunction"}}}

" vim: foldmethod=marker
