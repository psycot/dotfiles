" nvim switch
set number
set title
set expandtab
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
set clipboard=unnamed
set hls
set completeopt+=menuone,noselect

" key bindings
let mapleader = ","

"jetpack bootstrap
let s:jetpackfile = stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'altercation/vim-colors-solarized'
Jetpack 'itchyny/lightline.vim'
Jetpack 'nvim-lua/plenary.nvim'
Jetpack 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Jetpack 'neoclide/coc.nvim', { 'branch': 'release' }
Jetpack 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }
Jetpack 'elixir-editors/vim-elixir'
Jetpack 'elixir-lsp/coc-elixir'
Jetpack 'cohama/lexima.vim'
Jetpack 'airblade/vim-gitgutter'
Jetpack 'tpope/vim-fugitive'
call jetpack#end()

" elixir-shortcut
source $HOME/.config/nvim/elixir-mycommand.vim

" telescope.nvim
source $HOME/.config/nvim/telescope.vim

" coc.nvim setting
source $HOME/.config/nvim/coc.vim

" leixima.vim settting
source $HOME/.config/nvim/lexima.vim

" syntax highlight + color scheme
syntax on
set background=dark
colorscheme solarized

" override highlight
highlight CocMenuSel ctermbg=237
highlight CocFloating ctermbg=235
