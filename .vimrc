set nocompatible              " be iMproved, required
 
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'bash-support.vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'keith/swift.vim'
Plugin 'git://git.wincent.com/command-t.git'
" Plugin 'natebosch/vim-lsc'
" Plugin 'ajh17/VimCompletesMe'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'puremourning/vimspector'
" Plugin 'vim-syntastic/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'zhou13/vim-easyescape'
Plugin 'vhdirk/vim-cmake'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'tpope/vim-commentary'
Plugin 'jeaye/color_coded'
Plugin 'tikhomirov/vim-glsl'
Plugin 'rking/ag.vim'
Plugin 'jnurmine/Zenburn'
" Plugin 'jiangmiao/auto-pairs'
Plugin 'majutsushi/tagbar'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" let g:vimspector_enable_mappings = 'HUMAN'

nmap <leader>a <Plug>VimspectorContinue
nmap <leader>s <Plug>VimspectorStepOver
nmap <leader>d <Plug>VimspectorStepInto
nmap <leader>f <Plug>VimspectorStepOut
nmap <F9> <Plug>VimspectorToggleBreakpoint
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
let g:vimspector_sidebar_width = 35
" function s:SetUpTerminal()
"   " Customise the terminal window size/position
"   " For some reasons terminal buffers in Neovim have line numbers
"   call win_gotoid( g:vimspector_session_windows.terminal )
"   set norelativenumber nonumber
" endfunction

" augroup MyVimspectorUICustomistaion
"   autocmd!
"   autocmd User VimspectorTerminalOpened call s:SetUpTerminal()
" augroup END

filetype plugin indent on    " required

" GLSL coloring
autocmd! BufNewFile,BufRead *.vs,*.fs,*.vert,*.frag set ft=glsl

" Tagbar
noremap <S-F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Toggle Header/CPP in same dir
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" SourceKit-LSP configuration
if executable('sourcekit-lsp')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

autocmd Filetype swift setlocal noexpandtab tabstop=2 shiftwidth=2
augroup filetype
  au! BufRead,BufNewFile *.swift set ft=swift
augroup END

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
noremap <S-F9> :call ToggleNetrw()<CR>

" Copy and paste stuff 
nnoremap p p=`]
nnoremap <c-k> p 
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
set clipboard=unnamed

" Ctrl h/j/k/l to switch buffers.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"
" Navigation
nmap <Up>    <Nop>
nmap <Down>  <Nop>
nmap <Left>  <Nop>
nmap <Right> <Nop>
map $ <Nop>
map ^ <Nop>
map { <Nop>
map } <Nop>
noremap K     {
noremap J     }
noremap H     ^
noremap L     $

imap <Up>    <Nop>
imap <Down>  <Nop>
imap <Left>  <Nop>
imap <Right> <Nop>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Folding
set foldmethod=indent
set foldnestmax=1
set nofoldenable

syntax on
if (has("termguicolors"))
  set termguicolors
endif
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext

" let g:ycm_use_clang=1
 let g:ycm_language_server = 
   \ [ 
   \   {
   \     'name': 'swift',
   \     'cmdline': [ '/Users/j/dev/sourcekit-lsp/.build/x86_64-apple-macosx/debug/sourcekit-lsp'],
   \     'filetypes': [ 'swift' ]
   \   }
   \ ]
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
   \   'VimspectorPrompt': [ '.', '->', ':', '<' ]
   \ }

 nnoremap <leader>] :YcmCompleter GoToDefinition<CR> 
 let g:ycm_enable_diagnostic_signs = 1
 let g:ycm_confirm_extra_conf = 0

 set completeopt-=preview 
"let g:syntastic_cpp_clang_check_post_args = ""
set expandtab
set smarttab
set ai
set si
set shiftwidth=2
set softtabstop=2
set number
set mouse=a
" JK/KJ to escape insert and visual modes.
let g:easyescape_chars = { "j": 1, "k": 1 }
let g:easyescape_timeout = 100
let g:termdebug_wide=1

cnoremap jk <ESC>
cnoremap kj <ESC>
vnoremap <Space> <ESC>


" Cmd T tags window
nnoremap <leader>r :CommandTTag<CR> 

" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon

" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

" Ctrl a to add line above Ctrl s to add line below.
nmap <C-a> O<Esc>jk
nmap <C-s> o<Esc>jk
 
" " Map first non-blank to Ctrl n and EOL to Ctrl m
" nmap <C-n> ^
" nmap <C-m> $

"
" vimspector
function BuildAndDebug()
  call system('swift build') 
  call vimspector#Launch()
endfunction

function TestAndDebug()
  call system('swift test') 
  call vimspector#Launch()
endfunction

let g:asyncrun_open = 6
let g:asyncrun_rootmarks = ['build', '.build']
nnoremap <S-F6> :call asyncrun#quickfix_toggle(6)<cr>
nnoremap <S-F2> :AsyncStop <cr> 
" nmap <S-F5> :call BuildAndDebug()<CR>
" nnoremap <S-F5> :AsyncRun -mode=term -pos=right -cwd=<root> sh test.sh<cr>
" nmap <leader><F5> :call BuildAndDebug()<CR>
" nnoremap <F5> :AsyncRun -mode=term -pos=right -cwd=<root> sh run.sh <cr>
" nnoremap <S-F5> :AsyncRun -mode=4 -cwd=<root> sh debug.sh <cr>
nnoremap <F5> :AsyncRun -mode=terminal -pos=bottom -cwd=<root> source build.sh <cr> 
nmap <leader>b :AsyncRun -mode=term -pos=right -cwd=<root> sh run.sh <cr>
" nnoremap <S-F5> :AsyncRun clang++ -std=c++1y -g -Wall "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/bin/program" <cr>

