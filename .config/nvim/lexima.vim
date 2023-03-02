" cohama/lexima.vim
"
" setting
let g:lexima_enable_basic_rules = 1
let g:lexima_enable_newline_rules = 1
let g:lexima_enable_endwise_rules = 1
let g:lexima_ctrlh_as_backspace = 1

" custom rules
call lexima#add_rule({'char': ';', 'at': ';\%#', 'input': '<BS>|><Space>', 'filetype': ['elixir', 'eelixir']})
