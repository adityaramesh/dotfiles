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
" Make it so that the cursor is always at the center of the screen, except when
" at the start or end of the file.
set scrolloff=999
" This sets the name of the register associated with the OS copy buffer.
let g:clipbrdDefaultReg="+"
" Set the leader to the comma character.
let mapleader=","
" Makes Session files use relative paths instead of absolute paths.
set ssop-=curdir
set ssop+=sesdir
" Diable the irritating Vim TeX symbol conversion. Seriously, who would possibly
" find this helpful?
let g:tex_conceal = ""

"
" Vundle configuration.
"

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Package management
Plugin 'gmarik/Vundle.vim'

" Color schemes.
Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'adityaramesh/xoria_lite'

" Syntax highlighting.

" Syntax highlighting for Markdown
Plugin 'plasticboy/vim-markdown'

" Autocompletion.

" C++ semantic autocompletion
" Plugin 'Rip-Rip/clang_complete'
" Autocompletion tied to tab key
" Plugin 'ervandew/supertab'
" TextMate snippets for Vim
" Plugin 'SirVer/ultisnips'
" My snippets repository
" Plugin 'adityaramesh/vim-snippets'

" Enhanced editing.

" File signing
Plugin 'adityaramesh/smartfile'
" Text alignment
Plugin 'godlygeek/tabular'
" Renaming files without copying
Plugin 'danro/rename.vim'
" Better support for text objects.
Plugin 'tpope/vim-surround'
" Additional text objects
Plugin 'wellle/targets.vim'
" Allows use of '.' to repeat plugin commands.
Plugin 'tpope/vim-repeat'
" Use 'gc<action>' to comment out text objects.
Plugin 'tpope/vim-commentary'

call vundle#end()
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

" Disable folding for Markdown syntax plugin because I do not like folding.
let g:vim_markdown_folding_disabled=1

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
" Colors and highlighting.
"

" If we select the color scheme or enable syntax highlighting after we enable
" the cursor line, then our settings will be wiped.
syntax enable
colorscheme xoria_lite

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
" UltiSnips configuration.
"

" let g:UltiSnipsSnippetDirectories=["my_snippets"]
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"
" clang_complete configuration.
"

if has("mac") || has("macunix")
	let s:clang_library_path="/opt/local/libexec/llvm-3.6/lib/"
elseif has("unix")
	let s:clang_library_path="/usr/lib/llvm-3.6/lib"
endif

if isdirectory(s:clang_library_path)
	let g:clang_library_path=s:clang_library_path
endif

if v:version >= 703
	set conceallevel=2
	set concealcursor=vin
endif

set completeopt=menu,menuone
set pumheight=20

let g:clang_snippets=1
let g:clang_conceal_snippets=1
let g:clang_user_options="-std=c++1y -Wno-deprecated-register"
let g:clang_auto_select=1
let g:clang_complete_copen=1
let g:clang_trailing_placeholder=1
let g:clang_close_preview=1
let g:clang_complete_patterns=1

" Make `<leader>c` check the syntax of the current buffer.
" nnoremap <silent> <leader>c :call g:ClangUpdateQuickFix()<cr>

"
" Smartfile configuration.
"

let g:sf_author = "Aditya Ramesh"
let g:sf_contact = "_@adityaramesh.com"
let g:sf_dateformat = "%m/%d/%Y"
let g:sf_website = "adityaramesh.com"
let g:sf_headerformat = "fadc"
