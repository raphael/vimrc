" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Setup Bundle Support {
" The next three lines ensure that the ~/.vim/bundle/ system works
filetype on
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" So mapping in bundles file are set correctly
let mapleader=","

" Bundles
source ~/.vimrc.bundles

" Appearance
colorscheme jellybeans
if has("gui_gtk2")
  set guifont=Droid\ Sans\ Mono\ 6.5
  set guioptions=ai  "remove menu bar, use text tabs to prevent refresh issues
  set guioptions-=T  "remove toolbar

  " Friendly copy/paste shortcuts
  nmap <C-V> "+gP
  nmap ,cl :let @*=expand("%:p")<CR>
  imap <C-V> <ESC><C-V>a
  vmap <C-C> "+y
else
  "set guifont=Envy\ Code\ R\ for\ Powerline:h13
  set guifont=Pragmata\ TT\ for\ Powerline:h13
endif
if has("gui_macvim")
  set transparency=10
endif
set guioptions-=T " turns off toolbar
set vb " turns off visual bell
set noerrorbells " don't make noise

" Prevent slow scrolling of long lines
set synmaxcol=200

" Speed up vim
set ttyfast
set ttyscroll=3
set lazyredraw " to avoid scrolling problems
set re=1

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Editor behavior
set smartindent
set backupdir=~/.vimswaps,/tmp
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=1000 " keep 1000 lines of command line history
set ruler      " show the cursor position all the time
set showcmd    " display incomplete commands
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set shortmess+=filmnrxoOtT " Abbrev. of messages (avoids 'hit enter')
set hidden     " Allow buffer switching without saving
if has('persistent_undo')
  set undofile         " Persistent undo is nice ...
  set undolevels=1000  " Maximum number of changes that can be undone
  set undoreload=10000 " Maximum number lines to save for undo on a buffer reload
  set undodir=~/.vim/undo//
endif
set showmode   " Display the current mode
set cursorline " Highlight current line
set list
set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
set mouse=a    " Automatically enable mouse usage
set mousehide  " Hide the mouse cursor while typing

" Show vertical bar after 120 characters
set colorcolumn=120

" Save backups to a less annoying place than the current directory.
set backupdir=~/.vim/backup//
set backup

" Save swp files to a less annoying place than the current directory.
set directory=~/.vim/swap//

" Create the directories if needed
silent !mkdir -p ~/.vim/swap ~/.vim/backup ~/.vim/undo

" Formatting
set nowrap " Do not wrap long lines
set softtabstop=2
set shiftwidth=2
set tabstop=2
set autoindent
set expandtab " Use spaces instead of tabs
set pastetoggle=<F12> " pastetoggle (sane indentation on pastes)
set nofoldenable
set noballooneval

" Search
set incsearch  " do incremental searching
set smartcase  " Case sensitive when uc present

" Files to be ignored
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.idea/*,.idea,*/.idea,*/.idea/*

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Do not replace tabs with spaces for languages that care
autocmd FileType javascript set dictionary+=$HOME/.vim/dict/node.dict

" Remove trailing spaces
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml,ruby autocmd BufWritePre <buffer> call StripTrailingWhitespace()

" Custom extensions
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
autocmd BufNewFile,BufRead *.jst set filetype=html

" Settings for raw text editing
autocmd BufRead *\.txt setlocal formatoptions=l
autocmd BufRead *\.txt setlocal lbr
autocmd BufRead *\.txt map j gj
autocmd BufRead *\.txt map k gk
autocmd BufRead *\.txt setlocal spell spelllang=en_us

" Use tabs in GO
"autocmd Filetype go set softtabstop=4
"autocmd Filetype go set shiftwidth=4
"autocmd Filetype go set tabstop=4
"autocmd Filetype go set noexpandtab
"autocmd FileType go autocmd BufWritePre <buffer> Fmt
"autocmd Filetype go set nolist " Do not hightlight tabs in go or other things in go, gofmt will clean it all up anyway

" Auto-completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby let g:rubycomplete_buffer_loading=1
autocmd FileType ruby let g:rubycomplete_classes_in_global=1
autocmd FileType html,markdown,xml setlocal omnifunc=htmlcomplete#CompleteTags

" Use rbenv for setting up ruby interpreter
let g:ruby_path = system('echo $HOME/.rbenv/shims')

" Switch between absolute and relative numbering on focus and insert
set number relativenumber

autocmd FocusGained * set number relativenumber
autocmd WinEnter    * set number relativenumber
autocmd InsertLeave * set number relativenumber
autocmd BufNewFile  * set number relativenumber
autocmd BufReadPost * set number relativenumber

autocmd FocusLost   * set number norelativenumber
autocmd InsertEnter * set number norelativenumber
autocmd WinLeave    * set number norelativenumber

" Make ESC work faster
set ttimeoutlen=10
autocmd InsertEnter * set timeoutlen=0
autocmd InsertLeave * set timeoutlen=1000

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>

" Bundle filetype
autocmd BufNewFile,BufReadPost *.bundle set filetype=vim


" Key Mappings
map Q gq " Don't use Ex mode, use Q for formatting
map <leader>t :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR>
map <leader>l :TagbarToggle<CR>
nmap <silent> <leader>/ :nohlsearch<cr>

" Buffer window swapping
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction
nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Move across tabs
map <S-H> gT
map <S-L> gt

" Save with CTRL+s / CTRL+SHIFT+s
map <C-S> :wa<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" F4 to copy current filename into clipboard
noremap <silent> <F4> :let @+=expand("%:p")<CR>

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Force saving when needing to sudo first"
cnoreabbrev <expr> w!!
  \((getcmdtype() == ':' && getcmdline() == 'w!!')
  \?('!sudo tee % >/dev/null'):('w!!'))

" Enable omni completion.
" Strip whitespace
function! StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
