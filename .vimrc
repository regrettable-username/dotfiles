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
Plugin 'tikhomirov/vim-glsl'
Plugin 'jnurmine/Zenburn'
Plugin 'jiangmiao/auto-pairs'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

set foldmethod=indent
set foldnestmax=1
" Color Scheme
syntax enable
set background=dark
let g:solarized_termcolors=256
" colorscheme solarized

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif
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
set smarttab
set ai
set si
set shiftwidth=2
set softtabstop=2
set number

" JK/KJ to escape insert and visual modes.
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100

cnoremap jk <ESC>
cnoremap kj <ESC>
vnoremap <Space> <ESC>

" Ctrl h/j/k/l to switch buffers.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Ctrl a to add line above Ctrl s to add line below.
nmap <C-a> O<Esc>jk
nmap <C-s> o<Esc>jk
 
let g:asyncrun_open = 6
nnoremap <F2> :AsyncStop <cr> 
nnoremap <F3> :AsyncRun -cwd=<root> sh ~/dev/dotfiles/build-and-run.sh <cr>
nnoremap <F5> :AsyncRun -cwd=<root> sh ~/dev/dotfiles/build-and-debug.sh <cr>

packadd termdebug
