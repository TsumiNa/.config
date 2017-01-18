" true colors in the terminal
" set termguicolors


" >>==========================================
" vim 自身（非插件）快捷键
" >>=======================================
" 定义快捷键的前缀，即 <Leader>
let mapleader=","

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 定义快捷键到行首和行尾
nmap LB 0
nmap LE $

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至vim
nnoremap <Leader>p "+p

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 开启实时搜索功能
set incsearch

" 搜索时大小写不敏感
set ignorecase

" 关闭兼容模式
if &compatible
  set nocompatible
endif

" backspace设置
set backspace=indent,eol,start

" vim 自身命令行模式智能补全
set wildmenu
set wildmode=longest:list,full

" 显示行号
set number
set cursorline
set cursorcolumn

" 设定编码和换行方式
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
set fileformat=unix
set fileformats=unix,dos,mac

" 缩进
set autoindent
set cindent
set breakindent
set tabstop=4 shiftwidth=4 softtabstop=4
set shiftround

" 使用空格代替tab
set expandtab
" AutocmdFT neosnippet,gitconfig setlocal noexpandtab

" 折行和屏幕宽度
set wrap
set winwidth=40
set wrapscan
set showmatch

" 启动时不启用输入法重置
set iminsert=0 imsearch=0

" 代码折叠
set foldenable
nnoremap <space> za
" set foldmethod=marker

" 多字节符号显示
set ambiwidth=double

" 文件被外部修改时自动重读
set autoread

" 编译时自动保存
set autowrite

" 历史记录和保存
set history=100
if ! isdirectory($HOME.'/.config/undo')
    call mkdir($HOME.'/.config/undo', 'p')
endif
set undodir=~/.config/undo
set undofile

" 交换文件
set noswapfile

" 不存储临时文件
set backupskip=/tmp/*,/private/tmp/*



" >>=============================
" 便利脚本
" >>=============================
" 自动关闭QuickFix窗口
au BufEnter * call MyLastWindow()
function! MyLastWindow()
    " if the window is quickfix go on
    if &buftype=="quickfix"
        " if this window is last on screen quit without warning
        if winbufnr(2) == -1
            quit!
        endif
    endif
endfunction



" >>=============================
" 按键映射（插件无关）
" >>=============================
"Ctrl+Shift+上下移动当前行
nnoremap <silent><C-S-Down> :m .+1<CR>==
nnoremap <silent><C-S-Up> :m .-2<CR>==
inoremap <silent><C-S-Down> <Esc>:m .+1<CR>==gi
inoremap <silent><C-S-Up> <Esc>:m .-2<CR>==gi

"上下移动选中的行
vnoremap <silent><C-S-Down> :m '>+1<CR>gv=gv
vnoremap <silent><C-S-Up> :m '<-2<CR>gv=gv

" 保存与退出
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>:bd<cr>

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
  nnoremap <Leader><C-a> <C-a>
endif

inoremap <C-Q>     <C-O>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>


" 窗口间移动
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W
" 避免必须保存修改才可以跳转buffer
set hidden

" 插入模式另起新行
inoremap <C-p> <C-O>o

set foldenable              " 开始折叠
set foldmethod=syntax       " 设置语法折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldlevelstart=99       " 打开文件是默认不折叠代码

"set foldclose=all          " 设置为自动关闭折叠
" 用空格键来开关折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 全选
nnoremap <C-a> ggVG
inoremap <C-a> <C-O>ggVG


" >>=============================
" dein.vim 插件管理器
" 设定插件管理器路径和插件路径
set runtimepath+=~/.config/dein/repos/github.com/Shougo/dein.vim

" 必须标记开始
call dein#begin(expand('~/.config/dein'))

" 安装插件 dein自己管理自己
call dein#add('Shougo/dein.vim')

" 片段和自动补完
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('honza/vim-snippets')
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-jedi')
call dein#add('davidhalter/jedi-vim')
call dein#add('carlitux/deoplete-ternjs')
call dein#add('mhartington/deoplete-typescript')
call dein#add('zchee/deoplete-go', {'build': 'make'})
call dein#add('eagletmt/neco-ghc')
call dein#add('fatih/vim-go')

" 多行拼合
call dein#add('AndrewRadev/splitjoin.vim')

" 括号自动补完
call dein#add('Shougo/neopairs.vim')
call dein#add('Raimondi/delimitMate')

" 状态栏
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

" 主题
call dein#add('w0ng/vim-hybrid')
call dein#add('mhartington/oceanic-next')
call dein#add('joshdick/onedark.vim')

" 文件操作
call dein#add('tpope/vim-eunuch')
call dein#add('scrooloose/nerdtree')

" 显示缩进线
call dein#add('Yggdroot/indentLine')

" 扩展选择
call dein#add('terryma/vim-expand-region')

" 时光机
call dein#add('sjl/gundo.vim')

" 语法检查
" call dein#add('vim-syntastic/syntastic')
call dein#add('neomake/neomake')
call dein#add('tell-k/vim-autopep8')

" 注释插件
call dein#add('scrooloose/nerdcommenter')
call dein#add('Xuyuanp/nerdtree-git-plugin')

" 快速查找
call dein#add('/usr/local/opt/fzf')
" call dein#add('/home/liuchang/.linuxbrew/opt/fzf')
call dein#add('junegunn/fzf.vim')

" 跳转
call dein#add('kshenoy/vim-signature')
call dein#add('Lokaltog/vim-easymotion')

" 替换与重复命令
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-repeat')

" 输入法
" 依赖fcitx for mac
" brew install fcitx-remote-for-osx
"call dein#add('CodeFalling/fcitx-vim-osx')

" 多光标
call dein#add('terryma/vim-multiple-cursors')

" 清除行尾空格
call dein#add('bronson/vim-trailing-whitespace')

" 大纲导航
" 依赖【Exuberant ctags】
" brew install ctags
call dein#add('majutsushi/tagbar')

" 自动对齐
call dein#add('junegunn/vim-easy-align')

" 语法高亮
" 常用语言语法高亮和缩进设定 vim-polyglot
" JavaScript单独设定
call dein#add('sheerun/vim-polyglot')

call dein#add('othree/yajs.vim')
call dein#add('othree/es.next.syntax.vim')
call dein#add('othree/javascript-libraries-syntax.vim')
call dein#add('HerringtonDarkholme/yats.vim')
" call dein#add('othree/html5.vim')
" call dein#add('digitaltoad/vim-pug')
" call dein#add('kchmck/vim-coffee-script')
" call dein#add('hail2u/vim-css3-syntax')
" call dein#add('cakebaker/scss-syntax.vim')

" Markdown预览
call dein#add('iamcco/markdown-preview.vim')

" 快速执行
call dein#add('thinca/vim-quickrun')

" 代码折叠
call dein#add('tmhedberg/SimpylFold')

" git插件
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')

" 必须标记结束
call dein#end()

" 开启插件语法识别
filetype plugin indent on
let python_highlight_all=1
syntax enable
syntax on

" 启动时自动安装缺失插件
if dein#check_install()
  call dein#install()
endif
"<<================================


" >>==============================
" 插件设置
" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#max_menu_width = 80
let g:deoplete#sources#tss#javascript_support = 1
let g:tern_request_timeout = 1
let g:used_javascript_libs = 'jquery,underscore'
" let g:tern_show_signature_in_pum = '0'

" neosnippet
let g:neosnippet#snippets_directory = '~/.config/dein/repos/github.com/honza/vim-snippets'
let g:deoplete#enable_smart_case = 1

" 回车键用于展开片段
imap <expr><CR>
 \ pumvisible() && neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand)" : pumvisible() ? deoplete#close_popup() : '<Plug>delimitMateCR'
smap <expr><CR>
 \ pumvisible() && neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand)" : pumvisible() ? deoplete#close_popup() : '<Plug>delimitMateCR'
xmap <expr><CR>
 \ pumvisible() && neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand)" : pumvisible() ? deoplete#close_popup() : '<Plug>delimitMateCR'

" tab键选择补完项
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" pair
let g:neopairs#enable = 1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap ]b <Plug>AirlineSelectPrevTab
nmap [b <Plug>AirlineSelectNextTab

" let g:airline_theme='oceanicnext'
" let g:airline_theme='hybridline'
let g:airline_theme='onedark'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#buffer_idx_mode = 1

" 设定主题
syntax enable
set background=dark
if (has("termguicolors"))
 set termguicolors
endif

colorscheme onedark

" colorscheme OceanicNext
" let g:oceanic_next_terminal_italic = 1
" let g:oceanic_next_terminal_bold = 1

" try
"     colorscheme hybrid
" catch /:E185/
"     " do nothing
" endtry
" let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.

" 配置Neomake
autocmd BufReadPost,BufWritePost * Neomake
let g:quickfixsigns_protect_sign_rx = '^neomake_'

" 不论location还是QuickFix，都是用同样的快捷键切换
nnoremap <Leader>e  :NextError<CR>
nnoremap <Leader>E  :PrevError<CR>
com! -bar NextError  call s:GoForError("next")
com! -bar PrevError  call s:GoForError("previous")
func! s:GoForError(partcmd)
     try
         try
             exec "l". a:partcmd
         catch /:E776:/
             " No location list
             exec "c". a:partcmd
         endtry
     catch
         echohl ErrorMsg
         echomsg matchstr(v:exception, ':\zs.*')
         echohl None
     endtry
endfunc

let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_go_enabled_makers = ['golint', 'govet', 'go']
" let g:neomake_open_list = 2
let g:neomake_list_height = 5
let g:neomake_serialize = 1

" 文件搜索
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
  " let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" File preview using Highlight (http://www.andre-simon.de/doku/highlight/en/highlight.php)
let g:fzf_files_options =
  \ '--preview "(highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader>ff (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
" nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>fa       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>fg       :GFiles <C-R><C-A><CR>
nnoremap <silent> <Leader>fb       :Lines<CR>
nnoremap <silent> <Leader>fm       :Marks<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" let g:fzf_layout = { 'right': '~15%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window':  'botright 10new' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'



" NERDTree config
map <F2> :NERDTreeToggle<CR>
au bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore=['\.pyc$', '\~$']
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" 缩进线设定
let g:indentLine_char = '¦'
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#669999'

" 扩展选择
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" 清楚行尾空格
map <F12> :FixWhitespace<cr>

" 多光标
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" 智能跳转
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)

" 自动对齐
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

" 大纲导航
nmap <F3> :TagbarToggle<CR>
" 启动时自动focus
let g:tagbar_autofocus = 1

" for ruby, delete if you do not need
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }

" 配置jedi
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "top"
autocmd BufWinEnter '__doc__' setlocal bufhidden=delete

" 配置fatih/vim-go
" 开启额外的语法高亮
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports" " 自动导入
let g:go_play_open_browser = 0
let g:go_get_update = 0

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

au FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <leader>t  <Plug>(go-test-func)
au FileType go nmap <Leader>d <Plug>(go-def-vertical)
au FileType go nmap <Leader>r <Plug>(go-rename)
au FileType go nmap <Leader>n <Plug>(go-referrers)
au FileType go nmap <Leader>j <Plug>(go-alternate-vertical)


" gutter
set updatetime=250
let g:gitgutter_map_keys = 0
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hd <Plug>GitGutterUndoHunk

" 语法高亮
let g:html5_event_handler_attributes_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0

" 注释
map <Leader><space> <Plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Markdown预览
" let g:mkdp_path_to_chrome = "open -a Google\\ Chrome"
let g:mkdp_path_to_chrome = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
" let g:mkdp_auto_start = 1
nmap <silent> <F9> <Plug>MarkdownPreview
imap <silent> <F9> <Plug>MarkdownPreview
nmap <silent> <C-F9> <Plug>StopMarkdownPreview
imap <silent> <C-F9> <Plug>StopMarkdownPreview

" 快速执行
let g:quickrun_no_default_key_mapping = 1
let g:quickrun_config = {
\   "_" : {
\       "outputter" : "message",
\   },
\}

" unmap <Leader>r
nmap <F5> <Plug>(quickrun)

" 时光机
nnoremap <F4> :GundoToggle<CR>

" 括号匹配
let delimitMate_expand_cr = 1
" let delimitMate_expand_space = 1

" 代码折叠
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0

" css3 语法高亮修正
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

" vim-polyglot
let g:polyglot_disabled = ['javascript', 'typescript']

" haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" neco-ghc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1
