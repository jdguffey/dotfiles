filetype on

" enable syntax highlighting
syntax enable

set autoindent
set backspace=2                                     " Fix broken backspace in some setups
set clipboard=unnamed                               " yank and paste with the system clipboard
set list                                            " show trailing whitespace
set number                                          " show line numbers
set ruler                                           " show where you are
set showcmd
set tabstop=3                                       " actual tabs occupy 8 characters
set expandtab                                       " expand tabs to spaces
set shiftwidth=3                                    " normal mode indentation commands use 2 spaces
set softtabstop=3                                   " insert mode tab and backspace use 2 spaces
set wildmenu                                        " show a navigable menu for tab completion
set wildmode=longest,list,full
set foldmethod=syntax
set foldlevel=2

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
" Autpmatically save and reload folds
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Go crazy!
if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  "
  " set autowrite
  " set nocursorline
  " set nowritebackup
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  "
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  " noremap! jj <ESC>
  source ~/.vimrc.local
endif

