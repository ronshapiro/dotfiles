" Pathogen
set nocompatible
" filetype off " Pathogen needs to run before plugin indent on
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags() " generate helptags for everything in 'runtimepath'
 filetype plugin indent on
 filetype on
 filetype plugin on
 filetype indent on
syntax on

imap jj <Esc> " Professor VIM says '87% of users prefer jj over esc', jj abrams disagrees

" *Mapping notes*
" http://stackoverflow.com/questions/3776117/vim-what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-ma#answer-3776182
" map - mapping will recursively check other mappings
" noremap - nonrecursive mapping
" prefixes:
   " n - normal
   " i - insert
   " v - visual AND select modes
   " s - select
   " x - visual
   " c - command-line
   " I - insert, commandline, regexp-search

" http://github.com/twerth/dotfiles/blob/master/etc/vim/vimrc
" very good vimrc (and well documented!)

" always do very magic search
:nnoremap / /\v
:cnoremap %s/ %s/\v

set history=50
set textwidth=80
set linebreak
"set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words
"set complete-=k complete+=k
"set number
set et
set sw=4
set smarttab
set incsearch
set hlsearch
set ignorecase
set smartcase
set cursorline
" set cursorcolumn
"set list " turn invisibles on by default
" show in title bar
set title
set ruler
set showmode
set showcmd
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent    (local to buffer)
set tags=./tags;
set grepprg=ack
"set list

"set equalalways " Multiple windows, when created, are equal in size
"set splitbelow splitright"

" Professor VIM says '87% of users prefer jj over esc', jj abrams disagrees
imap jj <esc>

""==================================start varun
" have vim jump to the last position when reopening a file
if has("autocmd")
  au bufreadpost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" have vim load indentation rules according to the detected filetype. per
" default debian vim only load filetype specific plugins.
if has("autocmd")
  filetype indent on
endif
set mouse=a

" move within paragraph
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk


" Make clipboard work with system clipboard
"set clipboard=unnamed
""==================================end varun

autocmd winenter * setlocal cursorline
autocmd winleave * setlocal nocursorline
autocmd bufread,bufnewfile,bufdelete * :syntax on

let g:minibufexplmapwindownavvim = 1
let g:minibufexplmapwindownavarrows = 1
let g:minibufexplmapctabswitchbufs = 1
let g:miniBufExplModSelTarget = 1

let g:pyflakes_use_quickfix = 0

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python setlocal list
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=html.django_template " For SnipMate

au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" fix backspace in vim 7
:set backspace=indent,eol,start
"nmap <buffer> <CR> gf
"nmap <buffer> <C-S-y> <Esc>yy<Esc>:bd<CR>:edit @"<CR>

" popout split buffer hack
" map <C-S-p>  <Esc>:hide<CR>:blast<CR>

" ctrl-p paste
imap <C-l> <C-r>"

" duplicate line"
" imap <C-D> <Esc>yyp
" nmap <C-D> <Esc>yyp

nmap ,bs :ConqueTermSplit bash<CR>
nmap ,bv :ConqueTermVSplit bash<CR>

" copy all to clipboard
nmap ,a ggVG"*y
" copy word to clipboard
nmap ,d "*yiw
" underline current line, markdown style
nmap ,u "zyy"zp:.s/./-/g<CR>:let @/ = ""<CR>

" delete inner xml tag
nmap ,dit dt<dT>
nmap ,cit dt<cT>

""==end varun

nmap ,kk ^"=strftime("%Y-%m-%d ")<CR>P<Esc>:,!~/Dropbox/nix/bin/note_archive.sh>/dev/null<CR>
nmap ,ll ^"=strftime("%Y-%m-%d ")<CR>P<Esc>:,!~/Dropbox/nix/bin/note_not_done.sh>/dev/null<CR>

nmap ,t <Leader>t

"clear the search buffer, not just remove the highlight
map \c :let @/ = ""<CR>

" Revert the current buffer
nnoremap \r :e!<CR>

"Easy edit of vimrc
nmap \s :source $MYVIMRC<CR>
nmap \v :e $MYVIMRC<CR>

:runtime! ~/.vim/
":helptags ~/.vim/doc 


let g:pydiction_location = '~/.vim/bundle/pydiction/ftplugin/pydiction-1.2/complete-dict'

