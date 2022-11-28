syntax on
autocmd BufEnter *.mdk :highlight link EndOfBuffer Error
set shell=zsh
set clipboard=unnamedplus " c・d・pをclipboardを使う様にする
set wildmenu
set background=dark
set guifont=Ricty\ 19
set omnifunc=syntaxcomplete#Complete
set tabstop=2
set autoindent
set expandtab
set shiftwidth=2
set runtimepath+=~/.vim/bundle/neobundle.vim/
set completeopt=menuone
set smartindent
set backspace=indent,eol,start " backspaceでindent・eol・startを消せる様にする
source $VIMRUNTIME/macros/matchit.vim
let b:match_words = "「:」" ",『:』,（:）,〈:〉,〔:〕,【:】

call neobundle#begin(expand('~/.vim/bundle'))
	NeoBundleFetch 'Shougo/neobundle.vim'
	NeoBundle 'Shougo/neocomplete.vim'
	NeoBundle 'Shougo/vimproc.vim', { 'build' : { 'linux' : 'make'}}
	NeoBundle 'yuratomo/w3m.vim'
	NeoBundle 'tomtom/tcomment_vim'
	NeoBundle 'Shougo/unite.vim'
  NeoBundle 'lambdalisue/vim-gista'
  NeoBundle 'lambdalisue/unite-linephrase'
  NeoBundle 'jceb/vim-orgmode'
  NeoBundle 'vim-scripts/CoqIDE'
  NeoBundle 'ElmCast/elm-vim'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'airblade/vim-gitgutter'
  " NeoBundle 'scrooloose/syntastic'
  NeoBundle 'yogsototh/haskell-vim'
  NeoBundle 'eagletmt/ghcmod-vim'
  NeoBundle 'eagletmt/neco-ghc'
  NeoBundle 'Twinside/vim-hoogle'
  NeoBundle 'bronson/vim-trailing-whitespace'
  NeoBundle 'eagletmt/unite-haddock'
  NeoBundle 'jvoorhis/coq.vim'
  NeoBundle 'itchyny/vim-haskell-indent'
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'fuenor/im_control.vim'
  NeoBundle 'leafgarland/typescript-vim'
  NeoBundleLazy 'vim-scripts/CoqIDE', {
        \ 'autoload' : {
        \  'filetypes' : 'coq'
        \}}
  NeoBundle 'rking/ag.vim'
  NeoBundle 'idris-hackers/idris-vim'
  NeoBundle 'lambdalisue/gina.vim'
  NeoBundle 'kien/rainbow_parentheses.vim'
  NeoBundle 'wlangstroth/vim-racket'
  NeoBundle 'tpope/vim-dispatch'
  NeoBundle 'tpope/vim-pathogen'
  NeoBundle 'vim-syntastic/syntastic'
  NeoBundleLazy 'nosami/Omnisharp', {
\   'autoload': {'filetypes': ['cs']},
\   'build': {
\     'windows': 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
\     'mac': 'xbuild server/OmniSharp.sln',
\     'unix': 'xbuild server/OmniSharp.sln',
\     'linux': 'xbuild server/OmniSharp.sln'
\   }
\ }
NeoBundle 'fsharp/vim-fsharp', {
\ 'description': 'F# support for Vim',
\ 'lazy': 1,
\ 'autoload': {'filetypes': 'fsharp'},
\ 'build': {
\   'unix':  'make fsautocomplete',
\ },
\ 'build_commands': ['curl', 'make', 'mozroots', 'touch', 'unzip'],
\}

" Or, using NeoBundle
NeoBundle 'reasonml-editor/vim-reason-plus'
call neobundle#end()

try
  colorscheme solarized
catch
endtry

let g:unite_source_hadddock_browser = "w3m"
let g:gista#github_user = 'ayu-mushi'
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#auto_completion_start_length = 3
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case_completion = 1
let g:neocomplete#min_syntax_length = 3
let g:neocomplete#enable_quick_match = 3
let g:neocomplete#sources#syntax#min_keyword_length = 3
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns = {}
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType coq highlight SentToCoq ctermbg=17 guibg=#000000
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mdk,mark*} set filetype=markdown

filetype plugin indent on
NeoBundleCheck

let mapleader="-"
let g:mapleader="-"
let maplocalleader = "-"
set tm=2000
nmap <silent> <leader>ht :GhcModType<CR>
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>:lopen<CR>
let g:syntastic_mode_map={'mode': 'active', 'passive_filetypes': ['haskell']}
let g:syntastic_always_populate_loc_list = 1
nmap <silent> <leader>hl :SyntasticCheck hlint<CR>:lopen<CR>

function! SetToCabalBuild()
    if glob("*.cabal") != ''
            set makeprg=cabal\ build
                endif
endfunction

function! IMCtrl(cmd)
  let cmd = a:cmd
  if cmd == 'On'
    let res = system('xvkbd -text "\[Menu]" > /dev/null 2>&1 ')
  elseif cmd == 'Off'
    let res = system('xvkbd -text "\[Muhenkan]" > /dev/null 2>&1 ')
  elseif cmd == 'Toggle'
    "let res = system('xvkbd -text "\[Zenkaku_Hankaku]" > /dev/null 2>&1 ')
  endif
  return ''
endfunction

set timeout timeoutlen=3000 ttimeoutlen=100
set cmdheight=2
set statusline+=%{IMStatus('[日本語固定]')}
nmap <silent> <c-J> :call IMState('FixMode')<CR>
let IM_JpFixModeAutoToggle = 1

autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()
autocmd BufEnter *.hs :call SetToCabalBuild()

let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
:nnoremap <space>r <Plug>(unite_restart)
nmap <space>@ :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag

nnoremap <PageDown> <nop>
nnoremap <PageUp> <nop>


augroup MyAutoCmdFileType
  autocmd! MyAutoCmdFileType
  "...
  autocmd Filetype scheme :RainbowParenthesesToggle
augroup END

autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'


let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_selector_ui = 'unite'
