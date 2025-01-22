" 手动执行：
" npm install -g @tailwindcss/language-server
"

call plug#begin("~/.vim/plugged")
  if !has("win64")
    let g:plug_url_format = 'git@github.com:%s.git'
  endif

  Plug 'dracula/vim'
  " Plug 'rust-lang/rust.vim'
  " Plug 'dense-analysis/ale'
  " Plug 'prabirshrestha/vim-lsp'
  Plug 'vim-airline/vim-airline'
  Plug 'sheerun/vim-polyglot'
  Plug 'neovim/nvim-lspconfig'
  Plug 'kabouzeid/nvim-lspinstall'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'rmagatti/goto-preview'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'unkiwii/vim-nerdtree-sync'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tomtom/tcomment_vim'
  Plug 'psliwka/vim-smoothie'
  Plug 'zivyangll/git-blame.vim'
  Plug 'ap/vim-css-color'
  Plug 'voldikss/vim-translator'
  Plug 'wfxr/protobuf.vim'
  Plug 'tpope/vim-surround'
  Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
  \}
call plug#end()

let g:loaded_perl_provider = 0 

let g:translator_default_engines = ['youdao', 'bing', 'haici']

" " npm install -g vls
" let g:LanguageClient_serverCommands = {
"     \ 'vue': ['vls']
"     \ }

lua require("lsp-config")

lua require('goto-preview').setup {}
nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>

" 自动保存session
fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction
autocmd VimLeave * call SaveSess()
" fu! RestoreSess()
" if filereadable(getcwd() . '/.session.vim')
"     execute 'so ' . getcwd() . '/.session.vim'
"     if bufexists(1)
"         for l in range(1, bufnr('$'))
"             if bufwinnr(l) == -1
"                 exec 'sbuffer ' . l
"             endif
"         endfor
"     endif
" endif
" endfunction
" autocmd VimEnter * nested call RestoreSess()

" git blame
nnoremap <Leader>g:<C-u>call gitblame#echo()<CR>

"coc插件 https://juejin.cn/post/6968807773366976549
let g:coc_global_extensions = [
      \ '@yaegassy/coc-volar', 
      \ 'coc-eslint', 
      \ 'coc-emmet', 
      \ 'coc-css', 
      \ 'coc-html', 
      \ 'coc-json', 
      \ 'coc-prettier', 
      \ 'coc-tsserver', 
      \ 'coc-tag'
\ ]
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 字体
if !has("win64")
  set guifont=DroidSansMono_Nerd_Font:h14
endif

"高亮当前行
set cursorline

"显示行号
set number
  
"支持鼠标
if has('mouse')
  set mouse=r
endif

" 复制粘贴到系统
set clipboard+=unnamedplus
  
"配置颜色
syntax enable
colorscheme dracula

"配置目录树
let g:nerdtree_sync_cursorline = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeIgnore = ['^node_modules$', '.vscode']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

"使用 ctrl+hjkl 切换分割页
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"配置集成终端
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  if has('win32') || has('win64')
    split term://powershell.exe
  else
    split term://bash
  endif
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

"配置文件搜素
nnoremap <C-p> :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

"配置Prettier
let g:prettier#config#print_width = 100
command! -nargs=0 Prettier :CocCommand prettier.formatFile


" syntax enable
" filetype plugin indent on
" " rust.vim 配置 https://juejin.cn/post/7250005852710797371
" let g:rustfmt_autosave = 1 " 保存时自动格式化
" let g:rustfmt_command = "rustfmt" " 自定义格式化命令
" let g:rust_clip_command = 'pbcopy'
" " ALE 配置
" let g:ale_linters = {
" \  'rust': ['cargo', 'clippy']
" \ }
" let g:ale_fixers = {
" \  'rust': ['cargo', 'rustfmt']
" \ }
" let g:ale_rust_cargo_use_clippy = 1 " 使用 clippy 进行更严格的检查
" vim-airline 配置
let g:airline#extensions#ale#enabled = 1 " 在状态栏显示 ALE 检查结果

lua require("rust-init")
