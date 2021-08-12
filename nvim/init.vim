" load plugins
source ./plugins.vim

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
set colorcolumn=80
set background=dark
filetype plugin indent on
let mapleader=" "

if has('mac') && has('gui_running')
    set macligatures

    set guifont=FiraCode-Retina:h14
endif

colorscheme gruvbox
let g:netrw_banner=0

"" Hide Tmux Status
" autocmd VimEnter,VimLeave * silent !tmux set status

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
    autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd FileType vimwiki setlocal concealcursor=nc
augroup END

"" Custom keymaps
inoremap jk <ESC>
nnoremap <leader>v :e $HOME/.config/nvim/init.vim<CR>
nnoremap <leader>% :tab split<CR>
nnoremap <C-n> :tabnew<CR>
inoremap <C-n> <ESC>:tabnew<CR>
nnoremap <leader>c :nohl<CR>
vnoremap > >gv
vnoremap < <gv
vnoremap <CR> :'<,'>y+<CR>

" tabs
nnoremap <tab> :bnext<CR>
nnoremap <S-tab> :bprev<CR>
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
    \'colorscheme': 'gruvbox',
    \}

" fzf
nnoremap <leader><space> :GFiles<CR>
nnoremap <leader>f :Files<CR>
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

" tagbar
let g:tagbar_show_visibility = 1

" nerdtree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

function! SmartNERDTree()                   
    if (@% == "" || g:NERDTree.IsOpen())
        NERDTreeToggle                      
    else                                    
        NERDTreeFind                        
    endif                                   
endfun

nnoremap <leader>p :call SmartNERDTree()<CR>

" indentline
let g:indentLine_enabled = 1
let g:indentLine_setConceal = 0

" Vim-python syntax
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1

" VimWiki
let g:vimwiki_ext2syntax = {'.wiki': 'markdown'}
let g:vimwiki_list = [{
    \ 'automatic_nested_syntaxes': 1,
    \ 'path_html': '$HOME/vimwiki/html',
    \ 'path': '$HOME/vimwiki/content',
    \ 'syntax': 'markdown',
    \ 'custom_wiki2html': 'wiki2html',
    \ 'template_ext': '.html',
    \ 'ext': '.md'
  \ }]
