
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'Chiel92/vim-autoformat'
Plug 'coot/CRDispatcher'
Plug 'coot/EnchantedVim'
Plug 'justinmk/vim-sneak'
Plug 'kien/rainbow_parentheses.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'michaeljsmith/vim-indent-object'
Plug 'morhetz/gruvbox'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tommcdo/vim-exchange'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wellle/targets.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'https://github.com/tpope/vim-tbone'

" Experiments
Plug 'vim-scripts/closetag.vim'
Plug 'https://github.com/Townk/vim-autoclose'
let g:closetag_html_style=1

" TODO REMOVE
"Plug 'kbarrette/mediummode'

call plug#end()

" Editing
set smartindent cindent
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set noerrorbells visualbell
set number
set report=1
set ignorecase
set showcmd
set showmatch
set virtualedit=all
set scrolloff=8
set hidden
set showmode
set mouse=
set nocompatible
set pastetoggle=<F2>
set noswapfile
set laststatus=2
set formatoptions+=j
set cpoptions+=$

set title
let &titlestring = expand("%:p")
autocmd BufCreate  *.* let &titlestring = expand("%:p")
autocmd BufRead    *.* let &titlestring = expand("%:p")
autocmd BufLeave   *.* let &titlestring = expand("%:p")
autocmd BufEnter   *.* let &titlestring = expand("%:p")

" Text Settings
set listchars=tab:▸\ ,eol:\ ,precedes:\ ,extends:\ ,trail:.

" Save folds and history
" TODO check if ~/.vim/view is made automatically
set undofile
silent! execute '!mkdir -p ~/.vim/undo'
set undodir=~/.vim/undo
"set viewdir=~/.vim/view
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent! loadview

" Wild menu
set wildignore+=*/.git/*,*/.svn/*,*.o,*.pyc,*~,*.so,*.swp,*.zip,*.tar,*.tar.gz,
set wildmode=full
set wildignorecase

" Color Settings
" TODO Tabline background
" TODO confimation on split window save/open
syn on
set t_Co=256
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_sign_column='bg0'
let g:gruvbox_invert_selection=0
colorscheme gruvbox
set background=dark

" Airline
autocmd VimEnter * :AirlineTheme base16
let g:airline_powerline_fonts=1
let g:airline#extensions#gutentags#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#unite#enabled=1
let g:airline#extensions#fugitive#enabled=1

" NERDTree
"autocmd VimEnter * if !argc() | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd l | endif
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Enchanted
let g:VeryMagicSubstitute=1
let g:VeryMagicGlobal=1

" Indent guides
autocmd VimEnter * silent! IndentGuidesToggle
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0

" Gutentags
let g:gutentags_enabled=0
let g:gutentags_tagfile='.tags'
let g:gutentags_project_root=['.git']
autocmd FileType c,php,java,python let g:gutentags_enabled=1

" Formatting
let g:formatdef_astyle_c='"astyle --mode=c -A2ps4CSKNwpUjCk3fH"'
let g:formatters_c=['astyle_c']

" Git
let g:gitgutter_max_signs=999
nnoremap cog :GitGutterToggle<CR>
autocmd VimEnter * silent! GitGutterDisable

" RainbowParentheses
autocmd VimEnter * silent! RainbowParenthesesToggle
autocmd Syntax * silent! RainbowParenthesesLoadRound
autocmd Syntax * silent! RainbowParenthesesLoadSquare
autocmd Syntax * silent! RainbowParenthesesLoadBraces

" Turn off automatic line commenting
autocmd FileType * silent! setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Syntax languages
autocmd BufRead,BufNewFile *.inc silent! set filetype=php
autocmd BufRead,BufNewFile *.less silent! set filetype=css
autocmd BufRead,BufNewFile *.tex silent! set filetype=tex
autocmd BufRead,BufNewFile *.md silent! set filetype=markdown

"au BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt,*.pdf silent set ro
"au BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout
"au BufReadPost *.pdf silent %!pdftotext -nopgbrk -layout -q -eol unix "%" - | fmt -w78


" Leader Commands
let mapleader="\<SPACE>"

noremap  \\ :NERDTreeToggle<CR>
nnoremap \vim   :e ~/.vimrc<CR>
nnoremap \vimrc :e ~/.vimrc<CR>
nnoremap \bash  :e ~/todo/bashtodo.md<CR>
nnoremap \todo  :e ~/todo/vimtodo.md<CR>
nnoremap \idea  :e ~/todo/ideas.md<CR>
nnoremap \ideas :e ~/todo/ideas.md<CR>
nnoremap \word  :e ~/todo/words.md<CR>
nnoremap \words :e ~/todo/words.md<CR>
nnoremap \pass  :e ~/todo/pass.md<CR>

" TODO F mappings
"nnoremap <F1>
nnoremap <F3> :silent! call TmuxSplitCmd('')<CR>
nnoremap <F4> :Autoformat<CR>
vnoremap <F6> :!python<CR>
nnoremap <F6> :.!python<CR>
nnoremap <F7> Y:@"<CR>
vnoremap <F7> Y:@"<CR>
"nnoremap <F8>
"nnoremap <F9>
nnoremap <F10> :echo "hi<"   . synIDattr(synID(line("."),col("."),1),"name")."> ".
            \  "trans<". synIDattr(synID(line("."),col("."),0),"name")."> ".
            \  "lo<"   . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")."> ".
            \  "co<"   . synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg").">"<CR>

" Navigation
autocmd VimEnter * silent! nnoremap <C-H> <C-W>h
autocmd VimEnter * silent! nnoremap <C-K> <C-W>k
autocmd VimEnter * silent! nnoremap <C-L> <C-W>l
autocmd VimEnter * silent! nnoremap <C-J> <C-W>j
autocmd VimEnter * silent! inoremap <C-H> <ESC><C-W>h
autocmd VimEnter * silent! inoremap <C-K> <ESC><C-W>k
autocmd VimEnter * silent! inoremap <C-L> <ESC><C-W>l
autocmd VimEnter * silent! inoremap <C-J> <ESC><C-W>j

command! -bang -nargs=? -complete=file E e<bang> <args>
command! -bang -nargs=? -complete=file W w<bang> <args>
command! -bang -nargs=? -complete=file Q q<bang> <args>
command! -bang -nargs=? -complete=file Wq wq<bang> <args>
command! -bang -nargs=? -complete=file WQ wq<bang> <args>

nnoremap j gj
nnoremap k gk
" TODO remove leading spaces from joined lines
" Automatically remove \'s
"TODO take count
nnoremap J j^d0i<BS><ESC>
nnoremap gJ J

" Moving Visuals
nnoremap gV `[V`]
vmap <DOWN> xpgV
vmap <LEFT> <gV
vmap <RIGHT> >gV
vmap <UP> xkkpgV

nnoremap <UP> {
nnoremap <DOWN> }
nnoremap <TAB> :bn<CR>
nnoremap <S-TAB> :bp<CR>
" TODO jumplist/quickfix?
nnoremap <LEFT> <C-O>
nnoremap <RIGHT> <C-I>

" EXPERIMENTAL
" CAPS LOCK is ESC
" TODO MAP CAPS to C-c and map ESC to nop
" Force C-w over multiple BS in insertmode
set nostartofline
nnoremap ' `
vnoremap ' `
inoremap <C-K> <ESC>d$
"inoremap <C-Y> <C-R>"
"nnoremap <C-Y> ""P
nnoremap Q qq

" Use vim-sneak for f
let g:sneak#use_ic_scs=1

"map? vmode?
"replace 'f' with 1-char Sneak
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
"replace 't' with 1-char Sneak
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

nnoremap n nzzzv
nnoremap N Nzzzv

inoremap <C-_> </<C-X><C-O><ESC>cit
inoremap <C-F> <C-X><C-F>

" TODO common coding misspelling of variables etc.
"iabbrev

autocmd VimEnter * silent! execute 'try | Tmux rename-window vim | endtry'
"autocmd VimEnter * silent! execute 'try | Tmux set-option -g status-position top | endtry'
autocmd VimLeave * silent! execute 'try | Tmux rename-window bash | endtry'
"autocmd VimLeave * silent! execute 'try | Tmux set-option -g status-position bottom | endtry'

nnoremap <leader>top  :silent! call TmuxSplitCmd('top', 12)<CR>
nnoremap <leader>htop :silent! call TmuxSplitCmd('htop', 20)<CR>
nnoremap <leader>bmon :silent! call TmuxSplitCmd('bmon -p eth0', 25)<CR>
nnoremap <leader>sh   :silent! call TmuxSplitCmd('', 12)<CR>

" TODO better/more
"autocmd FileType python silent! noremap <F5> :pyf %<CR>
"autocmd FileType c silent! noremap <F5> :make<CR>

" TODO try to send output to bottom first?

autocmd FileType python silent! noremap <F5> :silent! call TmuxSplitCmd('python %')<CR>
autocmd FileType c      silent! noremap <F5> :silent! call TmuxSplitCmd('gcc -Wall % && ./a.out')<CR>
autocmd FileType html   silent! noremap <F5> :silent! call TmuxSplitCmd('x-www-browser %')<CR>
autocmd FileType matlab silent! noremap <F5> :silent! call TmuxSplitCmd('matlab -nosplash -nodesktop -r "run('%')"')<CR>
autocmd FileType vim    silent! noremap <F5> :so %<CR>


" TODO f5 for web -> x-www-broswer %

function! TmuxSplitCmd(cmd, ...)
    if a:0 == 1
        let l:lines=a:1
    else
        let l:lines='12'
    endif

    if a:cmd != ''
        let l:s=substitute(a:cmd.'', '%', shellescape(expand('%:p')), 'g')
        let l:s=substitute(s, ' ', '\\ ', 'g')
    else
        let l:s=""
    endif

    " try
    "     silent! execute 'Tmux break-pane -t bottom \; rename-window vimoutput \; select-window -l'
    "     execute 'sleep 200m'
    "     silent! execute 'Tmux send-keys -t vimoutput '.l:s
    "     silent! execute 'Tmux join-pane -dvl'.l:lines.' -s vimoutput'
    "     silent! execute 'Tmux select-pane -D'
    "     echo "THIS HAPPENED"
    "     return
    " catch
    "     echo "WHAT?"
    " endtry

    silent! execute 'Tmux break-pane -t bottom \; rename-window vimout \; select-window -l'
    silent! execute 'Tmux new-window -dn vimshell -c '.shellescape(getcwd())
    execute 'sleep 200m'
    silent! execute 'Tmux send-keys -t vimshell '.l:s
    silent! execute 'Tmux join-pane -dvl'.l:lines.' -s vimshell'
    silent! execute 'Tmux select-pane -D'

    "execute 'sleep 200m'
    "silent! execute 'Tmux send-keys -t vimshell '.l:s
    "silent! execute 'Tmux join-pane -dvl'.l:lines.' -s vimshell'
    "silent! execute 'Tmux select-pane -D'

endfunction


"nnoremap <F1> :execute 'Tmux split-window -v -l 12 -c '.shellescape(getcwd())<CR>
