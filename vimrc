"Activate indentation
filetype off
filetype plugin indent on
set smartindent

"Non-expanded, 4-wide tabulations
set tabstop=4
set shiftwidth=4
set noexpandtab
set mouse=a
autocmd FileType javascript set tabstop=2 softtabstop=0 expandtab shiftwidth=2 nosmarttab
autocmd FileType ruby set tabstop=2
autocmd FileType ruby set shiftwidth=2

"Disable vi-compatibility
set nocompatible

set hidden

"Real-world encoding
set encoding=utf-8

"Interpret modelines in files
set modelines=1

"Do not abandon buffers
set hidden

"Don't bother throttling tty
set ttyfast

"More useful backspace behavior
set backspace=indent,eol,start

"Use statusbar on all windows
set laststatus=2

"Better search
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

"Prevent backups when editing system files
au BufWrite /private/tmp/crontab.* set nowritebackup
au BufWrite /private/etc/pw.* set nowritebackup

"Source user configuration
if filereadable(expand("~/.vim/.myvimrc"))
		source ~/.vim/.myvimrc
endif
