call plug#begin("~/.vim/plugged")
  Plug 'dracula/vim'
  Plug 'posva/vim-vue'
  Plug 'sheerun/vim-polyglot'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'unkiwii/vim-nerdtree-sync'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'preservim/nerdcommenter'
  Plug 'zivyangll/git-blame.vim'
  Plug 'heavenshell/vim-jsdoc', { 
  \ 'for': ['javascript', 'javascript.jsx','typescript'], 
  \ 'do': 'make install'
  \}
call plug#end()

" 自动保存session
fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction
" fu! RestoreSess()
" if filereadable(getcwd() . '/.session.vim')
    " execute 'so ' . getcwd() . '/.session.vim'
    " if bufexists(1)
        " for l in range(1, bufnr('$'))
            " if bufwinnr(l) == -1
                " exec 'sbuffer ' . l
            " endif
        " endfor
    " endif
" endif
" endfunction
autocmd VimLeave * call SaveSess()
" autocmd VimEnter * nested call RestoreSess()

" git blame
nnoremap <Leader>g:<C-u>call gitblame#echo()<CR>

let g:python_host_prog  = '/usr/bin/python'
"let g:python3_host_prog = '/usr/bin/python3'
let g:loaded_python3_provider = 0

"coc插件
let g:coc_global_extensions = ['coc-vetur', 'coc-eslint', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

set guifont=DroidSansMono_Nerd_Font:h14

"高亮当前行
set cursorline

"显示行号
set number
  
"支持鼠标
if has('mouse')
  set mouse=r
endif

let mapleader=";"
nmap <Leader>a ggVG
vnoremap <Leader>y :w !pbcopy<CR><CR>
nmap <Leader>p :r !pbpaste<CR><CR>
  
"配置颜色
syntax enable
colorscheme dracula

"配置目录树
let g:nerdtree_sync_cursorline = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:NERDTreeIgnore = ['^node_modules$']
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
  split term://bash
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

"配置注释
let g:NERDSpaceDelims = 2
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
