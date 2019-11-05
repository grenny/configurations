set nocompatible
filetype off
let mapleader = " "
let g:Perl_MapLeader = ","

" Begin Vundle Configuration
if !has("compatible")
	set rtp+=~/.vim/bundle/Vundle.vim/
	call vundle#begin()

	" let Vundle manage Vundle
	Plugin 'VundleVim/Vundle.vim'

	" NERDTree
	Plugin 'scrooloose/nerdtree'
	autocmd StdinReadPre * let s:std_in=1
	autocmd vimenter * NERDTree * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

	" CTRL-P fuzzy search
	Plugin 'ctrlpvim/ctrlp.vim'

	" Perl-Support
	Plugin 'wolfgangmehner/perl-support'

	" PaperColor Theme
	Plugin 'NLKNguyen/papercolor-theme'

	" Highlight Whitespace
	Plugin 'ntpeters/vim-better-whitespace'

	" Airline
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'

	" All Plugins must be added above this
	call vundle#end()
	filetype plugin indent on
	color PaperColor

	""" Airline configuration
	" Use powerline fonts
	let g:airline_powerline_fonts = 1

	""" NERDTree configuration
	" Close VIM if NERDTree is the only buffer open
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

	" Toggle NERDTree on/off using "<space>ne"
	nmap <leader>ne :NERDTreeToggle<cr>

	" Change CWD whenever the tree root is changed
	let g:NERDTreeChDirMode = 2

	" Close when a file is open
	let NERDTreeQuitOnOpen = 1

	" Enable mouse support
	:set mouse=a
	let g:NERDTreeMouseMode = 3
	""" CTRL-P configuration
	" begin finding a root from the CWD.
	let g:crtrp_working_path_mode = 'rw'

endif
" End Vundle Configuration

set nu

syntax on

" Set Color Scheme
" color darkblue
set background=dark
set t_Co=256

" autoindent
autocmd FileType perl set autoindent|set smartindent

" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" make tab in visual mode indent/deindent code
vmap <tab> >gv
vmap <s-tab> <gv

" lookup docs
nnoremap <buffer> <silent> _f :perldoc -f <cword><Enter>

" make "pe" in normal mode execute 'p4 edit %'
nmap pe :!p4 edit %<CR>

" make "pr" in normal mode execute 'p4 revert %'
nmap pr :!p4 revert %<CR>

set dictionary+=/usr/share/dict/words

" incremental search
set incsearch

""" PERL-specific configuration

" show matching brackets
autocmd FileType perl set showmatch

" FZF
set rtp+=~/.linuxbrew/bin/fzf

" Reduce annoying ESC delay
set timeoutlen=1000 ttimeoutlen=10

