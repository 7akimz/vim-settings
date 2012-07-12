" use vim settings instead of vi
set nocompatible

runtime bundle/vim-unbundle/unbundle.vim

"""""""""""""""""""""""""""""""""""""""
" Basic Editing Configuration
"""""""""""""""""""""""""""""""""""""""
set history=10000
" hide and don't close the buffer 
" when they are not the current
set hidden

" Change the mapping of backtick and single quote
nnoremap ' `
nnoremap ` '

" Show ruler
set ruler
" Show status bar
set ls=2
" Show numbers on buffer
set number
" search case-sensitive when upper-case char
set ignorecase smartcase

set autoindent

set showmatch

set showcmd

set winheight=5
" Set unused window height
set winminheight=5
" Set the current window height
set winheight=60

" highlight the matched search pattern
set hlsearch

" highlight matched word while typing
set incsearch

set cursorline

set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" Intuitive backspacing in insert mode
set backspace=indent,eol,start
 
 " File-type highlighting and configuration.
 " Run :filetype (without args) to see what you may have
 " to turn on yourself, or just set them all to be sure.
 syntax on
 filetype on
 filetype plugin on
 filetype indent on

"List all matches without completing, then each full match
set wildmode=list:longest
" Show files included in directory
set wildmenu

set scrolloff=3

" set vim leader character to , instead of \
let mapleader = ","

" set default indentations for tabstop, softtabstop,
" shiftwidth lengths and set expandtab on to use
" space instead of
" tabs
set ts=2 sts=2 sw=2 expandtab

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

"""""""""""""""""""""""""""""""""""""""
"Misc Keys Maps
"""""""""""""""""""""""""""""""""""""""
" map splits with control key, not control w keys
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-h>h
nnoremap <c-l> <c-l>l

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

"""""""""""""""""""""""""""""""""""""""
" Status Line
"""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

"""""""""""""""""""""""""""""""""""""""
" Color
"""""""""""""""""""""""""""""""""""""""
set t_Co=256 " 256 colors
" set the background lighting
set background=light

colorscheme solarized

" map ,v to open a split window with .vimrc file
nmap <leader>vim :split $MYVIMRC<CR>

" map the ,l to toggle invisible
nmap <leader>l :set list!<CR>

" set change symbols for tabs and eol
set listchars=tab:▸\ ,eol:¬

"""""""""""""""""""""""""""""""""""""""
" Custom AutoCmd
"""""""""""""""""""""""""""""""""""""""

if has("autocmd")

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Auto source .vimrc when saved
  autocmd bufwritepost vimrc source $MYVIMRC

  " Enable file type detection
  filetype on
  " Syntax strict languages
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab

  " Customization based on own style
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et
  " Example of treating a file as another type of file
  " autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml
  autocmd VimEnter * :call Plugins()

  " Set line numbering to absolute when in insert
  " and to relative everywhere else
  autocmd InsertEnter * :set number
  autocmd InsertLeave * :set relativenumber

  " Set numbering when focus lost and gained
  :au FocusLost * :set number
  :au FocusGained * :set relativenumber
endif

function Plugins()
  """""""""""""""""""""""""""""""""""""""
  " Tabular
  """""""""""""""""""""""""""""""""""""""
  if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>

    inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
     
    function! s:align()
      let p = '^\s*|\s.*\s|\s*$'
      if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
      endif
    endfunction
  endif
endfunction


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

"""""""""""""""""""""""""""""""""""""""
" Multipurpose tab key
" Indent at beginning else complete
"""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>


"""""""""""""""""""""""""""""""""""""""
" Promote Variable to rspec let

"""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

"""""""""""""""""""""""""""""""""""""""
" Command-T config

"""""""""""""""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""""""""""""
" Switch between absolute and relative
" line numbering
"""""""""""""""""""""""""""""""""""""""

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>
