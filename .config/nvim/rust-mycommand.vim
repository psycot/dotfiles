" Usage:
" rust command shortcut
" Ctrl-L -> r or l :Cargo run
" Ctrl-L -> t :Cargo test
" Ctrl-L -> b :Cargo build
" hint: to close terminal 'aa'

" Registers shortcuts when open a rust source
augroup rust_source
  autocmd!
  autocmd FileType rust call s:configure_shortcut_current_buffer()
augroup END

" Registers short-keys on current buffer
function! s:configure_shortcut_current_buffer()
  " Cargo commands
  " Ctrl + l -> r -> cargo run release
  nnoremap <buffer> <C-l>r :Cargo run --release<CR>
  nnoremap <buffer> <C-l><C-r> :Cargo run --release<CR>
  " Ctrl + l -> l -> cargo run (Primary)
  nnoremap <buffer> <C-l>l :Cargo run<CR>
  nnoremap <buffer> <C-l><C-l> :Cargo run<CR>
  " Ctrl + l -> t -> cargo test
  nnoremap <buffer> <C-l>t :Cargo test<CR>
  nnoremap <buffer> <C-l><C-t> :Cargo test<CR>
  " Ctrl + l -> b -> cargo build
  nnoremap <buffer> <C-l>b :Cargo build<CR>
  
endfunction
