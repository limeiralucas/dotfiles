call plug#begin('~/.config/nvim/plugged')
    Plug 'tomasiser/vim-code-dark'
    Plug 'pangloss/vim-javascript'
    Plug 'itchyny/lightline.vim'
    Plug 'itchyny/vim-gitbranch'
    Plug 'szw/vim-maximizer'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'kassio/neoterm'
    Plug 'tpope/vim-commentary'
    Plug 'sbdchd/neoformat'
    Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-gitgutter'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'preservim/tagbar'
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'lilydjwg/colorizer'
call plug#end()

" default options
set completeopt=menuone,noinsert,noselect
set mouse=a
set splitright
set splitbelow
set expandtab
set tabstop=4
set shiftwidth=4
set number
set relativenumber
set ignorecase
set smartcase
set incsearch
set diffopt+=vertical
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
set signcolumn=yes
set updatetime=300
filetype plugin indent on
let mapleader=" "

colorscheme codedark
let g:netrw_banner=0

"" Path config
if isdirectory($PWD .'/node_modules')
    let $PATH .= ':' . $PWD . '/node_modules/.bin'
endif

"" Specific Filetype config
augroup FileTypeSpecificAutocommands
    autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType typescriptreact setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

"" Custom keymaps
inoremap jk <ESC>
nnoremap <leader>v :e $HOME/.config/nvim/init.vim<CR>
nnoremap <leader>% :tab split<CR>
nnoremap <C-b> :CocCommand explorer<CR>
nnoremap <C-n> :tabnew<CR>
inoremap <C-n> <ESC>:tabnew<CR>

" tabs
nnoremap <M-tab> :tabnext<CR>
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt
nnoremap <M-0> 10gt

" resize
nnoremap <Up>    :resize +5<CR>
nnoremap <Down>  :resize -5<CR>
nnoremap <Left>  :vertical resize -5<CR>
nnoremap <Right> :vertical resize +5<CR>

" move split
nnoremap <leader>j :wincmd J<CR>
nnoremap <leader>k :wincmd K<CR>
nnoremap <leader>h :wincmd H<CR>
nnoremap <leader>l :wincmd L<CR>

" vim-maximizer
nnoremap <leader>m :MaximizerToggle!<CR>

" neoformat
let g:neoformat_enabled_python = ['black']
let g:neoformat_enabled_typescript = ['prettier']
nnoremap <leader>F :Neoformat<CR>

" lightline
let g:lightline = {
    \'active': {
    \   'left': [['mode', 'paste'],
    \            ['gitbranch', 'readonly','filename','modified'], ['tagbar']]
    \},
    \'component': {'tagbar': '%{tagbar#currenttag("%s", "", "f")}'},
    \'component_function': {'gitbranch': 'gitbranch#name'},
    \'colorscheme': 'codedark',
    \}

" fzf
nnoremap <leader><space> :Files<CR>
nnoremap <leader>f :GFiles?<CR>
inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
    \"find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
    \fzf#wrap({'dir': expand('%:p:h')}))

if has('nvim')
    au! FileType fzf tnoremap <Esc> <C-c>
endif

" coc

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" neoterm
function! TermHome()
    execute "normal! ^"
endfunction
tnoremap <C-ESC> <C-\><C-n>
function! ClearTerm()
    execute b:neoterm_id . "T clear"
endfunction
let g:neoterm_default_mod='vertical'
let g:neoterm_size=60
let g:neoterm_autoinsert=1
nnoremap <C-q> :Ttoggle<CR>
inoremap <C-q> <Esc>:Ttoggle<CR>
tnoremap <C-q> <C-\><C-n>:Ttoggle<CR>
tnoremap <C-l> <C-\><C-n>:call ClearTerm()<CR>i
tnoremap <C-h> <C-\><C-n><C-w>h
" tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <c-k> <C-\><C-n><C-w>k

" tagbar
let g:tagbar_show_visibility = 1

" nerdtree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! s:ToggleFileTree()
    if (exists("g:NERDTree") && g:NERDTree.IsOpen())
        NERDTreeToggle
    else
        NERDTreeFind
    endif
endfunction

function! SyncFileTree()
    if (exists("g:NERDTree") && g:NERDTree.IsOpen())
        NERDTreeFind
    endif
endfunction

" nnoremap <C-b> :call ToggleFileTree()<CR>
" inoremap <C-b> <ESC>:call ToggleFileTree()<CR>
" autocmd BufEnter * call SyncFileTree() 
nnoremap <C-b> :call <SID>ToggleFileTree()<CR>
