" reference: https://github.com/JunichiIto/dotfiles

" No vi compatibility
set nocompatible
" Once disable filetype
filetype off

""""""""""""""""""""""""""""""""""""""""""""
"  PLUGIN SETUP
""""""""""""""""""""""""""""""""""""""""""""
if has('vim_starting')
	set nocompatible               " Be iMproved
	" Required:
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Make file open convenient
NeoBundle 'Shougo/unite.vim'
" List recently used file in Unite.vim
NeoBundle 'Shougo/neomru.vim'
" Display directory tree
NeoBundle 'scrooloose/nerdtree'

" Completion
NeoBundle 'Shougo/neocomplcache'

" Make commnet on/off easier
NeoBundle 'tyru/caw.vim.git'
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" Run with buffer
NeoBundle 'thinca/vim-quickrun'

" Color indent
NeoBundle 'nathanaelkane/vim-indent-guides'
" Make space in end of line visible
NeoBundle 'bronson/vim-trailing-whitespace'

call neobundle#end()

" Required:
filetype plugin indent off

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
""""""""""""""""""""""""""""""""""""""""""""

let g:neocomplcache_enable_at_startup = 1

" Enable vim-indent-guides when starting
"let g:indent_guides_enable_on_vim_startup = 1

""""""""""""""""""""""""""""""""""""""""""""
"  VIM SETUP
""""""""""""""""""""""""""""""""""""""""""""
" Display line numer
set number
" Disable creating swap file
set noswapfile
" Display cursor position
set ruler
" Line for command execusion
set cmdheight=2
" Display status line
set laststatus=2
" Set information on title bar
set title
" Display command candidate
set wildmenu
" Ignore case when search
set ignorecase
" Not ignore case whne search in case there is upper letter
set smartcase
" Increamental search
set incsearch
" Highlight result of search
set hlsearch
" Keep indent when starting new line
"set autoindent
" Smart indnet for c language
"set cindent
" Tab Space
set tabstop=5
" Show corresponding brackets
set showmatch
" Open another file with not stored file
set hidden
" Make cursor unstop in the end of line
"set whichwrap=b,s,h,l,<,>,[,]
" ?????
set showcmd
" Color for dark background
set background=dark
" Enable backspace
set backspace=indent,eol,start
""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" COLOR SETUP
""""""""""""""""""""""""""""""""""""""""""""
syntax on
" Set color scheme
colorscheme desert
" Set Line number color
highlight LineNr ctermfg=darkyellow
""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Unit.vim Setup
""""""""""""""""""""""""""""""""""""""""""""
" Start with insert mode
let g:unite_enable_start_insert=1
" Shot cuts
nnoremap <silent> ,uff :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
" Split
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" Split (virtical)
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" Stop
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" QuickRun setup
""""""""""""""""""""""""""""""""""""""""""""
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config.cpp = {
	\ 'command' : 'g++',
	\ 'cmdopt'  : '-Wall -Wextra',
	\ }
let g:quickrun_config.py = {
	\ 'command' : 'python',
	\ 'cmdopt'  : '',
	\ }
let g:quickrun_config.sh = {
	\ 'command' : 'bash',
	\ 'cmdopt'  : '-x',
	\ }
"nnoremap <silent> ,qr :<C-u>QuickRun -outputter/buffer/split ":botright 8sp" -args
nnoremap <silent> ,qr :<C-u>QuickRun -outputter quickfix -args
""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Change color of status line when insert mode
""""""""""""""""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
	augroup InsertHook
		autocmd!
		autocmd InsertEnter * call s:StatusLine('Enter')
		autocmd InsertLeave * call s:StatusLine('Leave')
	augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
	if a:mode == 'Enter'
		silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
		silent exec g:hi_insert
	else
		highlight clear StatusLine
		silent exec s:slhlcmd
	endif
endfunction

function! s:GetHighlight(hi)
	redir => hl
	exec 'highlight '.a:hi
	redir END
	let hl = substitute(hl, '[\r\n]', '', 'g')
	let hl = substitute(hl, 'xxx', '', '')
	return hl
endfunction
""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Recover last cursor position
""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
	autocmd BufReadPost *
	\ if line("'\"") > 0 && line ("'\"") <= line("$") |
	\   exe "normal! g'\"" |
	\ endif
endif
""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Add closed bracket automatically
""""""""""""""""""""""""""""""""""""""""""""
"imap { {}<LEFT>
"imap [ []<LEFT>
"imap ( ()<LEFT>
"imap < <><LEFT>
""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""
" Short cut
""""""""""""""""""""""""""""""""""""""""""""
" For htags
nnoremap <C-g> :Gtags
nnoremap <C-i> :Gtags -f %<CR>
nnoremap <C-j> :GtagsCursor<CR>
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>
nnoremap <C-x> :cclose<CR>
" For NERDTree
nnoremap <C-t> :NERDTree<CR>
" Others
nnoremap <C-c> :close<CR>

""""""""""""""""""""""""""""""""""""""""""""
" Neocomplcache steup (from neocomplcache.txt)
""""""""""""""""""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
	\ 'default' : '',
	\ 'vimshell' : $HOME.'/.vimshell_hist',
	\ 'scheme' : $HOME.'/.gosh_completions'
	\ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return neocomplcache#smart_close_popup() . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif
if !exists('g:neocomplcache_force_omni_patterns')
	let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.c =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
let g:neocomplcache_omni_patterns.cpp =
\ '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl =
\ '[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'
""""""""""""""""""""""""""""""""""""""""""""
set path+=/usr/include/c++/4.4.7/
set path+=~/tools/boost/include/

" It seems better to add on last
filetype on
