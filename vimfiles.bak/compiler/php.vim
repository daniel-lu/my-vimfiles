" Vim compiler file
" Compiler:     php
" Maintainer:   Vital <vital@phpexpert.51.net>
" URL:        http://phpexpert.51.net/~vital/vim/compiler/php.vim
" Last Change:  2005 Jul 02

if exists("current_compiler")
  finish
endif
let current_compiler = "php"

if exists(":CompilerSet") != 2        " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=php\ %

CompilerSet errorformat=%m\ in\ %f\ on\ line\ %l

