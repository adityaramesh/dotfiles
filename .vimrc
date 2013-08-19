"
" File Name:	.vimrc
" Author:	Aditya Ramesh
" Date:		02/11/2012
" Contact:	_@adityaramesh.com
"
" On development machines, create a symbolic link in the home directory to this
" file.
"

"
" General Vim configurations.
"

" By foregoing compatibility with Vi, we get several feature upgrades, including
" better undo and redo functionality.
set nocompatible
" Disables the mouse in [a]ll modes.
set mouse-=a
" Allows loaded buffers to be abandoned.
set hidden
" Uses a nice predefined format for the status bar at the bottom-right corner of
" the screen.
set ruler
" Shows the command currently being typed.
set showcmd
" Disable the annoying terminal bell sound. Who would really want this...?
set noeb vb t_vb=
" This sets the name of the register associated with the OS copy buffer.
let g:clipbrdDefaultReg="+"

"
" Vundle configuration.
"

filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle "gmarik/vundle"
Bundle "godlygeek/tabular"
Bundle "adityaramesh/smartfile"
Bundle "Shougo/neocomplcache"
Bundle "danro/rename.vim"
Bundle "flazz/vim-colorschemes"
filetype plugin indent on
filetype indent off

"
" Text navigation and editing.
"

" Disable the arrow keys, in case they are accidentally pressed.
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Make j and k move to the next visual line instead of the next physical line.
" [Source](https://github.com/jackfranklin/dotfiles/blob/master/.vimrc).
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

" Reselect the visual block after indentation.
" [Source](https://github.com/jackfranklin/dotfiles/blob/master/.vimrc).
vnoremap < <gv
vnoremap > >gv

" Fix the annoying delay after pressing `<ESC>O`.
set timeout timeoutlen=1000 ttimeoutlen=100
" Allow backspace to delete anything in insert mode.
set backspace=indent,eol,start

"
" Text formatting configurations.
"

" Copies the indentation from the current line to the next.
set autoindent
set tw=80
set wrap

" See `:h fo-table` for information about the flags.
set formatoptions=tcqor2

" Shitty, suboptimal compromise on indentation for C-like families.
au FileType c,cpp,objc,objcpp setlocal smartindent

"
" Colors and highlighting.
"

" If we select the color scheme or enable syntax highlighting after we enable
" the cursor line, then our settings will be wiped.
syntax enable
colorscheme xoria256

" Highlights the current line. Setting `cterm=NONE` removes the underline from
" the cursor line (which I do not like).
set cursorline
hi CursorLine cterm=NONE

"
" Syntax configuration. Make sure that set t_Co=256 appears before any commands
" that affect the color scheme!
"

set t_Co=256
let c_no_curly_error = 1
if version >= 700
	set spl=en spell
	set nospell
endif

"
" Search configuration.
"

set incsearch
set showmatch
" Remap the command to redraw the screen, so that any highlighting from previous
" commands is no longer visible.
nnoremap <silent> <C-l> :nohl<CR><C-l>

"
" Window configuration.
"

" Create the vertically split panel to the right by default.
set splitright
" Make help windows split the screen vertically by default.
cnoreabbrev <expr> h getcmdtype() == ":" && getcmdline() == "h" ? "vertical h" : "h"
cnoreabbrev <expr> help getcmdtype() == ":" && getcmdline() == "help" ? "vertical help" : "help"

"
" GUI configuration.
"

set go+=c
set go-=T
set go-=L
set go-=l
set go-=r
set go-=b
set go-=m

"
" Neocomplcache configuration.
"

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_dictionary_filetype_lists = { 'default': '' }

if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
" <CR> closes popup and saves the indentation.
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS> close the popup and delete the previous character.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" Enable omnicompletion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable the more computationally-expensive omnicompletion patterns.
if !exists('g:neocomplcache_omni_patterns')
	let g:neocomplcache_omni_patterns = {}
endif

let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

"
" Smartfile configuration.
"

let g:sf_author = "Aditya Ramesh"
let g:sf_contact = "_@adityaramesh.com"
let g:sf_dateformat = "%m/%d/%Y"
let g:sf_website = "adityaramesh.com"
let g:sf_headerformat = "fadc"
