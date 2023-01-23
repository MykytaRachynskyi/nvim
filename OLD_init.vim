:set number
:set relativenumber
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a
:set ignorecase
:set encoding=utf-8
:set nobackup
:set nowritebackup
:set updatetime=300
:set signcolumn=yes
:set showmode
:set cursorline

call plug#begin()

" Navigation
Plug 'preservim/nerdtree'
Plug 'BurntSushi/ripgrep'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'branch' : '0.1.0'}
" Completion
Plug 'neoclide/coc.nvim'
Plug 'dense-analysis/ale'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'neovim/nvim-lspconfig'
Plug 'sheerun/vim-polyglot'
" Style
Plug 'Mofiqul/vscode.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'gruvbox-community/gruvbox'
Plug 'vim-airline/vim-airline'
" C#
Plug 'OmniSharp/omnisharp-vim'
Plug 'nickspoons/vim-sharpenup'
" Zig
Plug 'ziglang/zig.vim'

" lsp - related stuff - currently unused
"Plug 'kabouzeid/nvim-lspinstall'
"Plug 'ahmedkhalf/lsp-rooter.nvim'
"Plug 'hrsh7th/cmp-nvim-lsp'

call plug#end()

" Colors =======================================================
augroup ColorschemePreferences
  autocmd!
  " These preferences clear some gruvbox background colours, allowing transparency
  autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
  " Link ALE sign highlights to similar equivalents without background colours
  autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
  autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
  autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END

" Use truecolor in the terminal, when it is supported
if has('termguicolors')
  set termguicolors
endif

set background=dark
" colorscheme gruvbox

" COC START ================================================
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-u> coc#refresh()
else
  inoremap <silent><expr> <c-u> coc#refresh()
endif
"" COC END ==================================================


" Sharpenup =================================================
" All sharpenup mappings will begin with `<Space>o`, e.g. `<Space>ogd` for: OmniSharpGotoDefinition
let g:sharpenup_map_prefix = '<Space>o'

let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
let g:sharpenup_statusline_opts.Highlight = 0

" OmniSharp ================================================== 
let g:OmniSharp_popup_position = 'peek'
let g:OmniSharp_highlighting = 0

if has('nvim')
  let g:OmniSharp_popup_options = {
  \ 'winblend': 30,
  \ 'winhl': 'Normal:Normal,FloatBorder:ModeMsg',
  \ 'border': 'rounded'
  \}
else
  let g:OmniSharp_popup_options = {
  \ 'highlight': 'Normal',
  \ 'padding': [0],
  \ 'border': [1],
  \ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
  \ 'borderhighlight': ['ModeMsg']
  \}
endif
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}

let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText',
\ 'StructName' : 'StructName',
\ 'ClassName' : 'Type',
\ 'EnumName' : 'EnumName',
\ 'NamespaceName' : 'Identifier',
\ 'PreprocessorText' : 'PreProc',
\ 'PreprocessorKeyword' : 'PreProc',
\ 'Keyword' : 'Keyword',
\ 'NumericLiteral' : 'EnumName'
\}

" BAR BAR HOTKEYS ===========================================
" Move to previous/next
nnoremap <silent>    <M-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <M-.> <Cmd>BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <M-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <M->> <Cmd>BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout
" Close commands
"                          :BufferCloseAllButCurrent
"                          :BufferCloseAllButVisible
"                          :BufferCloseAllButPinned
"                          :BufferCloseAllButCurrentOrPinned
"                          :BufferCloseBuffersLeft
"                          :BufferCloseBuffersRight
" Magic buffer-picking mode
nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>
" Sort automatically by...
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect


" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used
" BAR BAR HOTKEYS END =======================================

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

"" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" ALE =========================================================
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'

" Enable completions as you type
let g:completion_enable_auto_popup = 1
let g:ale_disable_lsp = 1
let g:ale_zig_compiler = "zig"

let g:ale_linters = { 'cs': ['OmniSharp'] , 'zig': ['zls']}

let g:OmniSharp_highlighting = 1

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> <leader><C-A> <cmd>OmniSharpGetCodeActions<cr>
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

lua require('conf_tree_sitter')
lua require('tree_sitter')
lua require('vscode_theme')
