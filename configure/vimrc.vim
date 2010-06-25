" The commands in this are executed when the GUI is started.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2001 Sep 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.gvimrc
"	      for Amiga:  s:.gvimrc
"  for MS-DOS and Win32:  $VIM\_gvimrc
"	    for OpenVMS:  sys$login:.gvimrc

" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" set the X11 font to use
" set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1

function! MyOS()
  if has("win16") || has("win32") || has("win64") || has("win95")
    return "windows"
  elseif has("mac")
    return "mac"
  elseif has("unix")
    return "linux"
  endif
endfunction

" define custom variable
if MyOS() == "windows"
    let $VIMHOME = $VIM . "/vimfiles"
else
    let $VIMHOME = $HOME . "/.vim"
endif

set mousehide		" Hide the mouse when typing text

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Only do this for Vim version 5.0 and later.
if version >= 500

  " I like highlighting strings inside C comments
  let c_comment_strings=1

  " Switch on syntax highlighting if it wasn't on yet.
  if !exists("syntax_on")
    syntax on
  endif

  " Switch on search pattern highlighting.
  set hlsearch

  " Do incremental search
  set incsearch

  " For Win32 version, have "K" lookup the keyword in a help file
  "if has("win32")
  "  let winhelpfile='windows.hlp'
  "  map K :execute "!start winhlp32 -k <cword> " . winhelpfile <CR>
  "endif

  " Set nice colors
  " background for normal text is light grey
  " Text below the last line is darker grey
  " Cursor is green, Cyan when ":lmap" mappings are active
  " Constants are not underlined but have a slightly lighter background
  highlight Normal guibg=grey90
  highlight Cursor guibg=Green guifg=NONE
  highlight lCursor guibg=Cyan guifg=NONE
  highlight NonText guibg=grey80
  highlight Constant gui=NONE guibg=grey95
  highlight Special gui=NONE guibg=grey95

endif

""""""""""""""""""""""""""""""""
" general setting
""""""""""""""""""""""""""""""""
"set how many lines of history vim need remember
set history=500

"enable filetype plugin
filetype plugin on
filetype indent on

"set auto read if the file is changed from the outside
set autoread

""""""""""""""""""""""""""""""""
" user interface setting
""""""""""""""""""""""""""""""""
"Remove toolbar and menu
"if has("gui_running")
    "set guioptions-=m
    "set guioptions-=T
"endif

"Show line numbers
set number

"always show current position
set ruler

"backspace config
set backspace=eol,start,indent

"ignore case when search
set ignorecase

"set magic on for regular expressions
set magic

"show matching bracets when text indicator is over them
set showmatch
set mat=2 "How many tenths of a second to blink

"no sound errors
set noerrorbells
set novisualbell
set t_vb=

"set cmdline height
set cmdheight=1

"auto load vimrc
if has("autocmd")
  autocmd! bufwritepost vimrc source $HOME/.virmrc
endif


"language setting
set langmenu=en_US
let $LANG = 'en_US'
if MyOS() == "windows"
	source $VIMRUNTIME/delmenu.vim
	source $VIMRUNTIME/menu.vim
endif

""""""""""""""""""""""""""""""""""""""
" color and font setting
""""""""""""""""""""""""""""""""""""""
"enable syntax highlighting
syntax enable

"font setting
if MyOS() == "mac"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h13
  set shell=/bin/bash
elseif MyOS() == "windows"
  set gfn=Consolas:h10
elseif MyOS() == "linux"
  set gfn=Monospace\ 10
  set shell=/bin//bash
endif

if has("gui_running")
  "set guioptions-=T
  set background=dark
  set t_Co=256
  set background=dark
  colorscheme wombat256 
else
 colorscheme wombat256
 set background=dark 
endif

"encoding setting
set encoding=utf8

try
  lang en_US
catch
endtry

"set default file types
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""
"set nobackup
set nowb
set noswapfile

set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set lbr
set tw=500

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  "set window max
  if MyOS() == "windows"
      autocmd GUIEnter * simalt ~x
  endif
  
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on
  set smartindent		" always set smart indent on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"auto change dir
set autochdir

"no wrap
set nowrap

"show button scroll bar
if has("gui_running")
    set guioptions+=b
endif

"fold settings
set foldmethod=indent

" Show fold column
set foldcolumn=4


"""""""""""""""""""""""""""""""""""
" visual mode related
"""""""""""""""""""""""""""""""""""
"In visual mode when press * or # to search current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

"visual search function
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal !vgvy"
    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    "elseif a:direction == 'gv'
    "    call CmdLine("vimgrep ". '/' . l:pattern . '/' . '**/*.')
    elseif a:direction == 'f'
        exxecute "normal /" . l:pattern . "^M"
    endif
    
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

""""""""""""""""""""""""""""""""""""""
" Command key mapping
""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

map <F2> :tabnew<CR>
map <F3> :tabprevious<CR>
map <F4> :tabnext<CR>

" Fast saving
map <leader>w :w!<CR>

" Fast quit with out saving
map <leader>q :q!<CR>

" Force back to visual mode
map <leader>v :visual!<CR>

" Show fold column
map <leader>f :set foldcolumn=4<CR>

" Hide fold column
map <leader>F :set foldcolumn=0<CR>

" Fast editing .vimrc
if MyOS() == "windows"
    map <Leader>c :e! $VIM/configure/vimrc.vim<CR>
else
    map <leader>c :e! $VIMHOMErc<CR>
endif

" Fast switch from tab setting
map <leader>t2 :setlocal shiftwidth=2<CR>
map <leader>t4 :setlocal shiftwidth=4<CR>
map <leader>t8 :setlocal shiftwidth=8<CR>

imap { {}
imap [ []
imap ( ()

"Command mode shortcuts
" Edit workspace
if MyOS() == "windows"
    cno $w e D:/www/<CR>
    cno $m e D:/www/marketbright/<CR>
    cno $k e D:/www/marketbright/dev/trunk/<CR>
    cno $s e D:/www/marketbright/vtwo/trunk/<CR>
    cno $y e D:/www/youtochina/<CR>
    cno $j e D:/www/joomla/<CR>
    cno $t e D:/www/taiping/<CR>
elseif MyOS() == "linux"
    cno $w e /media/Workspace/www/<CR>
    cno $m e /media/Workspace/www/marketbright/<CR>
    cno $k e /media/Workspace/www/marketbright/DEV/trunk/<CR>
    cno $s e /media/Workspace/www/marketbright/VTWO/trunk/<CR>
    cno $y e /media/Workspace/www/youtochina/<CR>
    cno $j e /media/Workspace/www/joomla/<CR>
    cno $t e /media/Workspace/www/taiping/<CR>
endif

"""""""""""""""""""""""""""""""""""""
" Status line setting
"""""""""""""""""""""""""""""""""""""
"Always show status
set laststatus=2

"Format statusline
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\

""""""""""""""""""""""""""""""""""""
" general abbrevs
""""""""""""""""""""""""""""""""""""
iab xdate <C-R>=strftime("%d/%m/%Y %H:%M:%S")<CR>
iab xauthor Daniel Lu
iab xsvn $Id$

"""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""
"Remove window ^M - when encoding gets messed up
noremap <F12> mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

"""""""""""""""""""""""""""""""
" Plugin configure starts
"""""""""""""""""""""""""""""""
"tag list configure
if MyOS() == "windows"
    let Tlist_Ctags_Cmd = '"'.$VIMRUNTIME.'/ctags.exe"'
elseif MyOS() == "linux"
    let Tlist_Ctags_Cmd = 'ctags'
endif

nnoremap <silent> <F9> :TlistToggle<CR>
"show tags of current document only
let Tlist_Show_One_File = 1
"exit vim if the taglist window is the only window
let Tlist_Exit_OnlyWindow = 1
"show tag list window at right
let Tlist_Use_Right_Window = 1
"auto fold code not being edit
let Tlist_File_Fold_Auto_Close=1
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1

"NERDTree key map
map <F8> :NERDTreeToggle<CR>

"NeoComplcache configure
"NeoCompletion setting
"use neocomplcache
let g:neocomplcache_enable_at_startup=1
"Max candidates displayed
"let g:neocomplcache_max_list=100
"Indication width of candidate displayed
"let g:neocomplcache_max_keyword_width=50
"Auto completion length
let g:neocomplcache_auto_completion_start_length=3
"Manually completion length
let g:neocomplcache_manuall_completion_start_length=3
"The min length of keyword becoming a object of completion list (buffer or dictionary files)
"let g:neocomplcache_min_keyword_length=4
"The min length of keyword becoming a object of completion list (syntax file)
"let g:neocomplcache_min_syntax_length=4
"Inore case while looks for candidate completion or not
"let g:neocomplcache_enable_ignore_case=1
"When a capital letter is included in input, do not ignore the upper/lower case
let g:neocomplcache_enable_smart_case=1
"disable automatic completion or not (manual completion by <C-x><C-u>
"let g:neocomplcache_disable_auto_complete=0
"Use wildcard character '*' or not
"let g:neocomplcache_enable_widcard=1
"Quick select the candidate by the short words
"let g:neocomplcache_enable_quick_match=0
"Use CursorHoldI event or not while complete candidates
"let g:neocomplcache_enable_cursor_hold_i=0
"Selete the first candidate or not
let g:noecomplcache_enable_auto_select=1
"Time of automatic completion by millin second unit
"let g:neocomplcache_cursor_hold_i_time=300
"If input a capital letter, takes ambiguous searching as an end of the words in it or not
let g:neocomplcache_enable_camel_case_completion=0
"Search '_' as an end of the words in it or not when input '_'
let g:neocomplcache_enable_underbar_completion=1
"Show the parameters of the function in command-line or not
"let g:neocomplcache_enable_display_parameter=1
"File size limit of a cache file
"let g:neocomplcache_caching_limit_file_size=500000
"The pattern of the buffer name, if match, do not make a cache of the buffer
"let g:neocomplcache_disable_caching_buffer_name_pattern=''
"Pattern of the buffer name, if match, does not complete automatic.
"let g:neocomplcache_lock_buffer_name_pattern=''

" Print caching percent in statusline. 
"let g:NeoComplCache_CachingPercentInStatusline = 1 

" Define dictionary. 
let g:neocomplcache_dictionary_filetype_lists = { 
      \ 'default' : '', 
      \ 'php' : $VIMHOME.'/dict/php.dict', 
      \ 'python' : $VIMHOME.'/dict/python.dict', 
	  \ 'js' : $VIMHOME.'/dict/javascript.dict',
      \ 'css' : $VIMHOME.'/dict/css.dict', 
      \ 'html' : $VIMHOME.'/dict/html.dict', 
      \ 'htm' : $VIMHOME.'/dict/html.dict',
	  \ 'perl' : $VIMHOME.'/dict/perl.dict',
	  \ 'as' : $VIMHOME.'/dict/actionscript.dict'
      \ } 

" Define keyword. 
if !exists('g:neocomplcache_keyword_patterns') 
  let g:neocomplcache_keyword_patterns = {} 
endif 
let g:neocomplcache_keyword_patterns['default'] = '\h\w*' 

"let g:neocomplcache_snippets_dir = $VIMHOME.'/snippets' 

" Plugin key-mappings. 
imap <silent><C-l>     <Plug>(neocomplcache_snippets_expand) 
smap <silent><C-l>     <Plug>(neocomplcache_snippets_expand) 
inoremap <expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>" 
inoremap <expr><silent><C-g>     neocomplcache#undo_completion() 
inoremap <expr><C-s>     neocomplcache#complete_common_string()

"NERD Commenter setting
map <C-H> ,c<Space>

"dbext configure
let g:dbext_default_profile_ORA = "type=ORA:user=launchpad_app@5.11.183.166:passwd=launchpad_app@5.11.183.166"
let g:dbext_default_profile="ORA"

"Source Explorer setting
"map <F11> :SrcExplToggle<CR>

"" // Set the height of Source Explorer window 
"let g:SrcExpl_winHeight = 8 

"" // Set 100 ms for refreshing the Source Explorer 
"let g:SrcExpl_refreshTime = 100 

"" // Set "Enter" key to jump into the exact definition context 
"let g:SrcExpl_jumpKey = "<ENTER>" 

"" // Set "Space" key for back from the definition context 
"let g:SrcExpl_gobackKey = "<SPACE>" 

"" // In order to Avoid conflicts, the Source Explorer should know what plugins 
"" // are using buffers. And you need add their bufname into the list below 
"" // according to the command ":buffers!" 
"let g:SrcExpl_pluginList = [ 
        "\ "__Tag_List__", 
        "\ "_NERD_tree_", 
        "\ "Source_Explorer" 
    "\ ] 
"" // Enable/Disable the local definition searching, and note that this is not 
"" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
"" // It only searches for a match with the keyword according to command 'gd' 
"let g:SrcExpl_searchLocalDef = 1 

"" // Let the Source Explorer update the tags file when opening 
"let g:SrcExpl_isUpdateTags = 1 

"" // Use program 'ctags' with argument '--sort=foldcase -R' to create or 
"" // update a tags file 
"let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 

"" // Set "<F12>" key for updating the tags file artificially 
"let g:SrcExpl_updateTagsKey = "<F12>"

"SnipMate settings
"snip author name like $TI_FULLNAME in textmate
let g:snips_author='Daniel Lu'
"source $VIMHOME/snippets/support_functions.vim
"autocmd vimenter * call s:SetupSnippets()
"function! s:SetupSnippets()

    "if we're in a rails env then read in the rails snippets
    "if filereadable("./config/environment.rb")
        "call ExtractSnips("$VIMHOME/snippets/ruby-rails", "ruby")
        "call ExtractSnips("$VIMHOME/snippets/eruby-rails", "eruby")
    "endif

    "call ExtractSnips("$VIMHOME/snippets/html", "eruby")
    "call ExtractSnips("$VIMHOME/snippets/html", "xhtml")
    "call ExtractSnips("$VIMHOME/snippets/html", "php")
"endfunction

