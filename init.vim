" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" So mapping in plugins are set correctly
let mapleader=","

" Use system clipboard
set clipboard+=unnamedplus

" Plugins
source ~/.config/nvim/plugins.vim

" Appearance
set background=dark
colorscheme gruvbox
"colorscheme monochrome
set guioptions-=T " turns off toolbar
set vb " turns off visual bell
set noerrorbells " don't make noise

" Prevent slow scrolling of long lines
set synmaxcol=400

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" TMUX integration
autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
autocmd VimLeave * call system("tmux setw automatic-rename")
autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
set title

" Editor behavior
set linespace=0
set autoread
set smartindent
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

" Show vertical bar after 100 characters
set colorcolumn=100

" No backup and no swap
set nobackup
set noswapfile

" Formatting
set nowrap " Do not wrap long lines
set softtabstop=4
set shiftwidth=4
set tabstop=4
set autoindent
set expandtab " Use spaces instead of tabs
set pastetoggle=<F12> " pastetoggle (sane indentation on pastes)
set nofoldenable

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

" Use old / fast regular expression engine
set re=1

" Auto-completion
set completeopt-=preview " Remove annoying scratch window on completion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType html,markdown,xml setlocal omnifunc=htmlcomplete#CompleteTags

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

set tw=100
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

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
"nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Force saving when needing to sudo first"
cnoreabbrev <expr> w!!
  \((getcmdtype() == ':' && getcmdline() == 'w!!')
  \?('!sudo tee % >/dev/null'):('w!!'))

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
