""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff I've decided I don't like
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set clipboard=unnamed
filetype on
syntax on
set isk+=_,$,@,%,#,- "none of these should be word dividers, so make them not
set ignorecase
set smartcase
set gdefault

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

set autoread " Avoid poups complaining that a file has changed (say when switching git branches)


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"    Enable folding, but by default make it act like folding is off, because folding is annoying in anything but a few rare cases
""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text Formatting/Layout
""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme delek

set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set smarttab
set expandtab
set shiftround

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stop smartindent from reindenting # comments
" http://vim.wikia.com/wiki/VimTip644
""""""""""""""""""""""""""""""""""""""""""""""""""""""
":inoremap # a#hxA


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby and rHTML File 2-shift tab
""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufEnter,BufRead,BufNewFile *.rb set tabstop=2
aut BufEnter,BufRead,BufNewFile *.rb set shiftwidth=2
au BufEnter,BufRead,BufNewFile *.rhtml set tabstop=2
aut BufEnter,BufRead,BufNewFile *.rhtml set shiftwidth=2
au BufEnter,BufRead,BufNewFile *.yml set tabstop=2
aut BufEnter,BufRead,BufNewFile *.yml set shiftwidth=2


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual Cues
""""""""""""""""""""""""""""""""""""""""""""""""""""""
set showmatch
set mat=5
set nohlsearch
set incsearch

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VimInfo
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remember all of these between sessions, but only 10 search terms; also
" remember info for 40 files; and only save up to
" 1000 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=/10,'40,\"1000


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"switching between windows
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>j<C-W>_
map <C-J> <C-W>
set wmh=0

"This is great, corrects ugly pastings:
inoremap <silent> <C-a> <ESC>u:set paste<CR>.:set nopaste<CR>gi

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif 

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Useful Abbreviations
""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab hte the
iab slp System.out.println(
iab dbg  #DEBUG: jperla:
iab tdj  #TODO: jperla:
iab opt  #OPTIMIZE: 
iab hbr ########### 
iab ubep #!/usr/bin/env python
iab ippe import pdb; pdb.set_trace()
iab inem if __name__=='__main__':
"ab DATE <C-r>=strftime("%Y-%m-%d")<CR> "date
"ab DATE <c-r>=strftime("%m/%d/%y %H:%M:%S %p")<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line wrapping for text files
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au BufEnter *.txt set tw=0 wrap linebreak
set tw=0 wrap linebreak


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Found here:  http://weblog.jamisbuck.org/2008/10/10/coming-home-to-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make ',e' (in normal mode) give a prompt for opening files
" in the same dir as the current buffer's file.
if has("unix")
  map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
  map ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif

"Vertical split then hop to new buffer
:noremap ,v :vsp^M^W^W
:noremap ,h :split^M^W^W

