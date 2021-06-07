" Plugins
""""""""""""""""""""""""""""""""""""""
call plug#begin() 
Plug 'vimwiki/vimwiki'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-sneak'
Plug 'flazz/vim-colorschemes'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'kassio/neoterm'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()
""""""""""""""""""""""""""""""""""""""

" Theme
""""""""""""""""""""""""""""""""""""""
set background=dark
colorscheme molokai
""""""""""""""""""""""""""""""""""""""

" Syntax and Sets
""""""""""""""""""""""""""""""""""""""
syntax on
set expandtab
set noswapfile
set ts=4 sw=4
set number
" set relativenumber
set termguicolors
set incsearch
""""""""""""""""""""""""""""""""""""""

" Need this for fzf in vim
""""""""""""""""""""""""""""""""""""""
set rtp+=/usr/local/opt/fzf
""""""""""""""""""""""""""""""""""""""

" Neoterm config
""""""""""""""""""""""""""""""""""""""
let g:neoterm_default_mod = "botright"

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF


" golang config
""""""""""""""""""""""""""""""""""""""
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
""""""""""""""""""""""""""""""""""""""


" terraform config
""""""""""""""""""""""""""""""""""""""
let g:terraform_fmt_on_save=1
let g:terraform_fold_sections=1
let g:terraform_align=1
""""""""""""""""""""""""""""""""""""""


" Key Mappings
""""""""""""""""""""""""""""""""""""""
set mouse=a
nnoremap <SPACE> <Nop>
let mapleader=" "
inoremap jk <Esc>

nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
lua <<EOF
require'telescope'.setup {
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
}
require('telescope').load_extension('fzy_native')
EOF


nnoremap <leader>n :NERDTreeToggle<CR>
" nnoremap <leader>f :Files<CR>
" nnoremap <leader>r :Rg<CR>
nnoremap <leader>s :BLines<CR>
" nnoremap <leader>b :Buffers<CR>
nnoremap <C-t> :Ttoggle<CR>
nnoremap <leader>t :T 
tnoremap jk <C-\><C-n>

nmap <C-h> :noh<CR>
""""""""""""""""""""""""""""""""""""""

" Coc shortcuts
""""""""""""""""""""""""""""""""""""""
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>R <Plug>(coc-rename)
""""""""""""""""""""""""""""""""""""""

" Configurations
"
" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes




" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()




" Use Ctrl+K to show documentation in preview window
nnoremap <C-k> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
