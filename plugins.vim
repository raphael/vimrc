call plug#begin('~/.config/nvim/plugged')

" the silver searcher
Plug 'rking/ag.vim'

" Status line
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts=1
Plug 'vim-airline/vim-airline'

" Theme
let g:gruvbox_italic=1
Plug 'morhetz/gruvbox'

" General
Plug 'scrooloose/nerdtree'
let NERDTreeShowBookmarks=0
let NERDTreeShowHidden=0
let NERDTreeChDirMode=2 " Keep cwd in sync with tree root
let NERDTreeQuitOnOpen=0 " Do not close tree after opening a file
let g:nerdtree_tabs_open_on_gui_startup=0
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>f :execute 'NERDTreeFind'<CR>

Plug 'tpope/vim-surround'

Plug 'dkprice/vim-easygrep'

Plug 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode='ra' " Use parent directory with '.git' file as root (r) or current directory if none (a)
let g:ctrlp_custom_ignore="/(.log$\|public\/|\.(git|hg|svn)|ui\/)"

Plug 'godlygeek/csapprox'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'mbbill/undotree'
nnoremap <Leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle=1

Plug 'tpope/vim-repeat'

" Syntax checking
Plug 'scrooloose/syntastic'

" Commenting
Plug 'scrooloose/nerdcommenter'

" deoplete
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" Complete with tab
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" neocomplete like
" set completeopt+=noinsert
" deoplete.nvim recommend
"set completeopt+=noselect

" Path to python interpreter for neovim
let g:python3_host_prog  = '/usr/bin/python'
" Skip the check of neovim module
" let g:python3_host_skip_check = 1

" Run deoplete.nvim automatically
let g:deoplete#enable_at_startup = 1
" deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" YCM
"Plug 'Valloric/YouCompleteMe'

" Git
Plug 'tpope/vim-fugitive'
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>

Plug 'majutsushi/tagbar'
" GO support (https://github.com/jstemmer/gotags)

" Git gutter
Plug 'airblade/vim-gitgutter'

" TMUX
"Plug 'edkolev/tmuxline.vim'

" Javascript
Plug 'leafgarland/typescript-vim'
Plug 'leshill/vim-json'
Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'

" Ruby
let g:ruby_path = system('echo $HOME/.rbenv/shims')
Plug 'vim-ruby/vim-ruby'
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby let g:rubycomplete_buffer_loading=1
autocmd FileType ruby let g:rubycomplete_classes_in_global=1

" rbenv
Plug 'tpope/vim-rbenv'

" tmux
Plug 'tmux-plugins/vim-tmux'

" bbye
Plug 'gwww/vim-bbye'
nnoremap <Leader>q :Bdelete<CR>

" impaired
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
Plug 'tpope/vim-unimpaired'

" GO - golang
Plug 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

" Present
Plug 'raphael/vim-present-simple'

" FISH'go',
Plug 'dag/vim-fish'

" Use tabs in GO
autocmd Filetype go set softtabstop=8
autocmd Filetype go set shiftwidth=8
autocmd Filetype go set tabstop=8
autocmd Filetype go set noexpandtab
autocmd Filetype go set nolist " Do not hightlight tabs in go or other things in go, gofmt will clean it all up anyway
au FileType go nmap <Leader>gs <Plug>(go-implements)
au FileType go nmap <Leader>gi <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>gr <Plug>(go-referrers)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <leader>gc <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>e <Plug>(go-rename)

" Misc
Plug 'tpope/vim-markdown'
Plug 'mhinz/vim-startify'

call plug#end()
