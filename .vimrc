set nocompatible              " be iMproved, required
 
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'git://git.wincent.com/command-t.git'
Plugin 'ycm-core/YouCompleteMe'
"Plugin 'vim-syntastic/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'zhou13/vim-easyescape'
Plugin 'vhdirk/vim-cmake'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'tpope/vim-commentary'
Plugin 'jeaye/color_coded'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Color Scheme
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

"let g:ycm_use_clang=1
let g:ycm_semantic_triggers =  {
  \   'c' : ['->', '.','re![_a-zA-z0-9]'],
  \   'objc' : ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \             're!\[.*\]\s'],
  \   'ocaml' : ['.', '#'],
  \   'cpp,objcpp' : ['->', '.', '::','re![_a-zA-Z0-9]'],
  \   'perl' : ['->'],
  \   'php' : ['->', '::'],
  \   'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.'],
  \   'ruby' : ['.', '::'],
  \   'lua' : ['.', ':'],
  \   'erlang' : [':'],
  \ }

nnoremap <leader>] :YcmCompleter GoToDefinition<CR> 
set completeopt-=preview 
"let g:syntastic_cpp_clang_check_post_args = ""
set expandtab
set shiftwidth=2
set softtabstop=2
set number

let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 60

cnoremap jk <ESC>
cnoremap kj <ESC>
vnoremap jk <ESC>
vnoremap kj <ESC>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nmap <C-a> O<Esc>jk
nmap <C-s> o<Esc>jk
 
let g:asyncrun_open = 10
nnoremap <F3> :AsyncRun -cwd=<root> sh ~/dev/dotfiles/build-and-run.sh <cr>
nnoremap <F5> :AsyncRun -cwd=<root> sh ~/dev/dotfiles/build-and-debug.sh <cr>

packadd termdebug
