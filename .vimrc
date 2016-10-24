" 
" I used this vimrc as a starting point, I've adjusted a few things here 
" and there, such as added syntax highlighting for Java.  I forget where I got 
" this from.  It's on git for peace of mind and consistency if needed, but feel
" free to use it.
"
" -John
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2014 Feb 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif


" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Create a backup directory to remove clutter
set backupdir=~/.vim/backupfiles

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" remapping esc to jk
inoremap jk <ESC>

colorscheme solarized
"colorscheme badwolf
let g:solarized_termcolors=256

" Tabs & Spaces, sets visual spaces, editing spaces to 4
" last line makes tabs spaces, useful for python 
set tabstop=4 		"visual
set softtabstop=4 	"editing
set expandtab 		"tabs are spaces
set shiftwidth=4        "makes autoindent 4

"UI Config - options to change random visuals
set number 		"shows line numbers
set showcmd 		"shows last command in bottom bar
"set cursorline 		"highlights current line
set showmatch 		"highlights matching [{(}])	

"Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk

"move to begginning 
nnoremap B ^
nnoremap E $

"$/^ to nada
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" change leader to comm
let mapleader=","

" set textwidth to 80
set textwidth=80

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.

syntax on
set hlsearch
"turn off search highlight with ,<space>
nnoremap <leader><space> :nohlsearch<CR> 
set background=dark 
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
  filetype on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!
  "trying to get good syntax for java
  au BufReadPost,BufNewFile *.java colorscheme monokai
  au BufReadPost,BufNewFile *.py colorscheme molokaiyo

  " For all text files set 'textwidth' to 78 characters.
  " Hopefully this doesn't mess shit up
  autocmd FileType * setlocal textwidth=78 formatoptions+=t
  " Disable auto commenting for next line
  " autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  au FileType java setlocal comments-=:// comments+=f://
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
