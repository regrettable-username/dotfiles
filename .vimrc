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
Plugin 'rking/ag.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'jiangmiao/auto-pairs'
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" GLSL coloring
autocmd! BufNewFile,BufRead *.vs,*.fs,*.vert,*.frag set ft=glsl

" Tagbar
noremap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Toggle Header/CPP in same dir
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" netrw setup
let g:NetrwIsOpen=0
nmap <unique> <c-p> <Plug>NetrwRefresh
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
let g:netrew_sort_sequence = '[\/]$,\<core\%(\.\d\+\)\=,\.[a-np-z]$,*,\.o$,\.obj$,\.info$,\.swp$,\.bak$,\~$'
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15
noremap <F9> :call ToggleNetrw()<CR>

" Copy and paste stuff 
nnoremap p p=`]
nnoremap <c-k> p 
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP


" Folding
set foldmethod=indent
set foldnestmax=1
set nofoldenable

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
let g:ycm_enable_diagnostic_signs = 1

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

" Cmd T tags window
nnoremap <leader>r :CommandTTag<CR> 

" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon

" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

" Ctrl a to add line above Ctrl s to add line below.
nmap <C-a> O<Esc>jk
nmap <C-s> o<Esc>jk
 
" Map first non-blank to Ctrl n and EOL to Ctrl m
nmap <C-n> ^
nmap <C-m> $

let g:asyncrun_open = 16
let g:asyncrun_rootmarks = ['build']
nnoremap <F2> :AsyncStop <cr> 
nnoremap <F3> :AsyncRun -mode=term -pos=right -cwd=<root> sh ~/dev/dotfiles/build-and-run.sh <cr>
nnoremap <F5> :AsyncRun -cwd=<root> sh ~/dev/dotfiles/build-and-debug.sh <cr>

packadd termdebug
