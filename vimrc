" load the pathogen plugin
call pathogen#infect()

" use vim settings instead of vi
set nocompatible

" hide and don't close the buffer 
" when they are not the current
set hidden

" Show ruler
set ruler

" Show status bar
set ls=2

" Show numbers on buffer
set number

" Show files included in directory
set wildmenu

set winheight=5
" Set unused window height
set winminheight=5

" Set the current window height
set winheight=60

if has("cmdline_hist")
  set history=1000
endif

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
nmap <leader>vim :split $MYVIMRC<CR>

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

" Expand the path to the current directory
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" Toggle between the last two files
nnoremap <leader>b <c-^>

" Command-T config

" Open file flush the cache then open fuzzy finder
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>

" Open files limited to the opened file directory
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>
" These options limited to rails usage or any
" dir that contains the same folder heirarchy

" Open search in models directory
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
" Open search in views directory
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
" Open search in controllers directory
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
" Open search in the helpers directory 
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
" Open search in the lib directory 
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
