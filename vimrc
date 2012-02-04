" load the pathogen plugin
call pathogen#infect()

" use vim settings instead of vi
set nocompatible

" hide and don't close the buffer 
" when they are not the current
set hidden

" show numbers on buffer
set number

" set default indentations for tabstop, softtabstop,
" shiftwidth lengths and set expandtab on to use
" space instead of
" tabs
set ts=2 sts=2 sw=2 expandtab

" set the background lighting 
"set background=dark

" enable vim to detect syntax
syntax on

" check if vim has any plugin 
" and indentation file for the current buffer
filetype plugin indent on

" change vim used color
colorscheme 256_xoria

if has("autocmd")
  autocmd bufwritepost vimrc source $MYVIMRC
endif
" set vim leader character to , instead of \
let mapleader = ","

" map ,v to open a split window with .vimrc file
nmap <leader>v :split $MYVIMRC<CR>

" map the ,l to toggle invisible
nmap <leader>l :set list!<CR>

" set change symbols for tabs and eol
set listchars=tab:▸\ ,eol:¬

if has("autocmd")
  " Enable file type detection
  filetype on
  " Syntax strict languages
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customization based on own style
  autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  " Example of treating a file as another type of file
  " autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
endif

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")

  " Execute: the command
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
