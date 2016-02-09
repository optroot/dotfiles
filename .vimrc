set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'Chiel92/vim-autoformat'
Plugin 'coot/CRDispatcher'
Plugin 'coot/EnchantedVim'
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'mbbill/undotree'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'nanotech/jellybeans.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
"Plugin 'tmhedberg/matchit'
Plugin 'tommcdo/vim-exchange'
Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-airline/vim-airline'
Plugin 'Xuyuanp/nerdtree-git-plugin'

call vundle#end()
filetype plugin indent on

"filetype on
"syn on

" Editing
set autoindent smartindent cindent
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set noerrorbells visualbell
set ruler number
set report=1
set ignorecase
set showcmd
set showmatch
set virtualedit=all
set hidden
"set backspace=2
set title
set scrolloff=8
set lazyredraw
set showmode
"set nospell
set cpoptions+=$
set mouse=
set nocompatible
set pastetoggle=<F2>
set noswapfile
" TODO F2 broken?
"set list
"set relativenumber
set laststatus=2

" TODO conceal

" Search
"set noincsearch
"set gdefault

" Text Settings
"TODO
"scriptencoding utf-8
"set encoding=utf-8
"set listchars=tab:▸\ ,eol:\ ,precedes:\ ,extends:\ ,trail:.
"set nolist

" Enchanted
let g:VeryMagicSubstitute = 1
let g:VeryMagicGlobal = 1
let g:VeryMagicVimGrep = 1
let g:VeryMagicSearchArg = 1
let g:VeryMagicFunction = 1
let g:VeryMagicHelpgrep = 1
let g:VeryMagicRange = 1
let g:VeryMagicEscapeBackslashesInSearchArg = 1
let g:SortEditArgs = 1
" TODO: use me?

" Jedi
"let g:jedi#show_call_signatures = 0
autocmd FileType python setlocal completeopt-=preview

" Supertab
let g:SuperTabDefaultCompletionType = "<C-N>"
"let g:SuperTabContextDefaultCompletionType = "<C-N>"

" Save folds and history
"set history=10000
set undodir=~/.vim/undodir
set undofile

" Wild menu
set wildmenu
set wildignore+=*/.git/*,*/.svn/*,*.o,*.pyc,*~,*.so,*.swp,*.zip,*.tar,*.tar.gz,
set wildmode=full

" Color Settings
syn on
set t_Co=256
set background=dark
colorscheme jellybeans

" View
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

" Airline
autocmd VimEnter * AirlineTheme wombat
let g:airline_powerline_fonts=1
let g:airline#extensions#gutentags#enabled=1
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#undotree#enabled=1
let g:airline#extensions#unite#enabled=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" NERDTree
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Indentguides
au VimEnter * silent! IndentGuidesToggle
let g:indent_guides_guide_size=1
let g:indent_guides_istart_level=2
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" Gutentags
let g:gutentags_enabled=0
let g:gutentags_tagfile='.tags'
let g:gutentags_project_root=['.git']
au FileType c,php,java let g:gutentags_enabled=1

" Formatting
let g:formatdef_astyle_c = '"astyle --mode=c -A2ps4CSKNwpUjCk3fH"'
let g:formatters_c = ['astyle_c']
"let g:autoformat_verbosemode = 1
let g:syntastic_error_symbol='✖'
let g:syntastic_warning_symbol='!'
let g:syntastic_style_warning_symbol='⚑'
let g:syntastic_style_erro_symbol='⚑'
let g:syntastic_python_pylint_args='--disable=C0111,C0103'
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

" Git
let g:gitgutter_max_signs = 999
" TODO symbols?
" Style?
" https://github.com/airblade/vim-gitgutter

" RainbowParentheses
au VimEnter * silent! RainbowParenthesesToggle
au Syntax * silent! RainbowParenthesesLoadRound
au Syntax * silent! RainbowParenthesesLoadSquare
au Syntax * silent! RainbowParenthesesLoadBraces

" Turn off automatic line commenting
au FileType * silent! setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Syntax languages
au BufRead,BufNewFile *.inc silent! set filetype=php
au BufRead,BufNewFile *.less silent! set filetype=css   
au BufRead,BufNewFile *.tex silent! set filetype=tex

" TODO better/more
au FileType python silent! noremap <F5> :pyf %<CR>
au FileType c silent! noremap <F5> :make<CR>

" Leader Commands
let mapleader="\<SPACE>"

noremap  \\ :NERDTreeToggle<CR>
nnoremap \vim :e ~/.vimrc
nnoremap \todo :e ~/VIMTODO.txt

" Mappings TODO (FKEYS BROKEN?!)
noremap  <F1> <ESC>
nnoremap <F3> :Autoformat<CR>
nnoremap <F4> :SyntasticCheck<CR>
nnoremap <F6> :SyntasticToggleMode<CR>
vnoremap <F7> :'<,'>!python<CR>
nnoremap <F7> :.!python<CR>
nnoremap <F8> Y:@"<CR>
nnoremap <F9> :%s/\s\+$//e<CR>
nnoremap <F10> :UndotreeToggle<CR>

" TODO TEMPORARY
set pastetoggle=<LEADER>2
noremap  <LEADER>1 <ESC>
nnoremap <LEADER>3 :Autoformat<CR>
nnoremap <LEADER>4 :SyntasticCheck<CR>
nnoremap <LEADER>6 :SyntasticToggleMode<CR>
vnoremap <LEADER>7 :'<,'>!python<CR>
nnoremap <LEADER>7 :.!python<CR>
nnoremap <LEADER>8 Y:@"<CR>
nnoremap <LEADER>9 :%s/\s\+$//e<CR>
nnoremap <LEADER>10 :UndotreeToggle<CR>

" Navigation
au Vimenter * silent! nnoremap <C-H> <C-W>h
au Vimenter * silent! nnoremap <C-K> <C-W>k
au Vimenter * silent! nnoremap <C-L> <C-W>l
au Vimenter * silent! nnoremap <C-J> <C-W>j
nnoremap <UP> {{
nnoremap <DOWN> }}
nnoremap <LEFT> :bp<CR>
nnoremap <RIGHT> :bn<CR>

" Moving Visuals
vnoremap <UP> xkkp`[V`]
vnoremap <DOWN> xp`[V`]
vnoremap <RIGHT> >`[V`]
vnoremap <LEFT> <`[V`]

