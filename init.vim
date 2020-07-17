let g:python3_host_prog = expand('/usr/local/bin/python3')
set number
set hlsearch
set ruler

set tabstop=4       
set shiftwidth=4    
set softtabstop=0   
set expandtab       
set smarttab        
set shiftround

set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split
set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split
nnoremap <silent> <S-j> :split<CR>
nnoremap <silent> <S-l> :vsplit<CR>
nnoremap <Bar> $:let pos = getpos(".")<CR>:join<CR>:call setpos('.', pos)<CR>
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l

" 折り返し行移動
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" 20行ずつ移動
nnoremap <C-n> 20j
vnoremap <C-n> 20j
nnoremap <C-p> 20k
vnoremap <C-p> 20k

inoremap <silent> jj <ESC>:<C-u>w<CR>

"ウィンドウ移動に使用するのでsの元の機能を削除(ci)
nnoremap s <Nop>
"s + hjkl でウィンドウ間を移動
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sw <C-w>w
"ウィンドウそのものを移動
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H

" sh
set sh=fish
tnoremap <silent> <ESC> <C-\><C-n>

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/shuji-oh/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/shuji-oh/.cache/dein')
  call dein#begin('/Users/shuji-oh/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/shuji-oh/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/denite.nvim')           " 検索
  call dein#add('scrooloose/nerdtree')          " C-eで，ディレクトリ表示
  call dein#add('tpope/vim-fugitive')           " git操作
  call dein#add('vim-airline/vim-airline')      " cool status bar
  call dein#add('Shougo/deoplete.nvim')         " 単語補間
  call dein#add('kana/vim-submode')             " s<,s>,s+,s-で，分割画面の大きさ調整
  call dein#add('kassio/neoterm')               " C-tで，terminal表示
  call dein#add('ludovicchabant/vim-gutentags') " 定義へジャンプ

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" ### denite ###
nnoremap [denite] <Nop>
nmap <C-d> [denite]

" grep
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

nnoremap <silent> [denite]<C-g> :<C-u>Denite grep -mode=normal<CR>
nnoremap <silent> [denite]<C-r> :<C-u>Denite -resume<CR>
nnoremap <silent> [denite]<C-n> :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <silent> [denite]<C-p> :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>

" ノーマルモードで起動、jjでノーマルへ
call denite#custom#option('default', {'mode': 'normal'})
call denite#custom#map('insert', 'jj', '<denite:enter_mode:normal>')

" ファイル一覧
noremap [denite] :Denite file/rec -mode=insert
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('file_rec', 'matchers', ['matcher_fuzzy', 'matcher_ignore_globs'])
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ ['.git/', '__pycache__/', '*.o', '*.make', '*.min.*'])

" ディレクトリ一覧
noremap [denite]<C-d> :<C-u>Denite directory_rec<CR>
noremap [denite]<C-c> :<C-u>Denite directory_rec -default-action=cd<CR>
noremap [denite]<C-f> :<C-u>Denite line<CR>

" 移動
call denite#custom#map('normal', 'j', '<denite:nop>', 'noremap')
call denite#custom#map('normal', 'k', '<denite:nop>', 'noremap')
call denite#custom#map('normal', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('normal', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('normal', '<C-u>', '<denite:move_up_path>', 'noremap')
call denite#custom#map('insert', '<C-u>', '<denite:move_up_path>', 'noremap')

" ウィンドウを分割して開く
call denite#custom#map('normal', '<C-j>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', '<C-j>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', '<C-l>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#map('insert', '<C-l>', '<denite:do_action:vsplit>', 'noremap')

call denite#custom#option('default', 'prompt', '>')

" ### NERD Tree ###
nnoremap <silent> <C-e> :NERDTreeToggle<CR>

" 表示幅
let g:NERDTreeWinSize=20

" ブックマークを表示
let g:NERDTreeShowBookmarks=1

" 親ディレクトリへ移動
let g:NERDTreeMapUpdir=''

" ファイルの開き方
let g:NERDTreeMapOpenSplit='<C-j>'
let g:NERDTreeMapOpenVSplit='<C-l>'

" ファイルを開いたらNERDTreeを閉じる
let g:NERDTreeQuitOnOpen=0

" 隠しファイルを表示
let g:NERDTreeShowHidden=1

" 非表示ファイル
let g:NERDTreeIgnore=['\.git$', '\.clean$', '\.swp$', '\.bak$', '\~$']

" NERDTreeを同時に閉じる
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

" ### vim fugitive ###
nmap [figitive] <Nop>
map <C-x> [figitive]
nmap <silent> [figitive]s :<C-u>Gstatus<CR>
nmap <silent> [figitive]d :<C-u>Gdiff<CR>
nmap <silent> [figitive]b :<C-u>Gblame<CR>
nmap <silent> [figitive]l :<C-u>Glog<CR>

" ### vim-airline ###
" パワーラインでかっこよく
let g:airline_powerline_fonts = 1
" カラーテーマ指定してかっこよく
let g:airline_theme = 'badwolf'
" タブバーをかっこよく
let g:airline#extensions#tabline#enabled = 1

" 選択行列の表示をカスタム(デフォルトだと長くて横幅を圧迫するので最小限に)
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

" virtulenvを認識しているか確認用に、現在activateされているvirtualenvを表示(vim-virtualenvの拡張)
let g:airline#extensions#virtualenv#enabled = 1

" gitのHEADから変更した行の+-を非表示(vim-gitgutterの拡張)
let g:airline#extensions#hunks#enabled = 0

" Lintツールによるエラー、警告を表示(ALEの拡張)
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#ale#error_symbol = 'E:'
let g:airline#extensions#ale#warning_symbol = 'W:'

" ### deoplete ###
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1

" ### colorsheme ###
syntax enable
colorscheme molokai

" ### submode ###
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" ### neoterm ###
let g:neoterm_default_mod='vertical'
nnoremap <C-t> :Ttoggle<CR>
tnoremap <C-t> <C-¥><C-n>:Ttoggle<CR>

" ### vim-gutentags ###
let g:gutentags_project_root = ['.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
