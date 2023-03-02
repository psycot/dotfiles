" Usage:
" Active in Mix Project buffer
" <Leader>tv: Open terminal buffer vertically in which tests run
" <Leader>tl: Cursor in a test block, only that test runs.
"     or else Cursor in a describe block, whole that block runs.
" <Leader>tf Runs all tests in current file.
" <Leader>ta Runs all tests in current project.
" <Leader>tc c Close terminal
" for Only single test buffer

" MixTest* commands
command! -nargs=0 MixTestOpen call s:term_open()
command! -nargs=0 MixTestRunAll call s:run_all_test()
command! -nargs=0 MixTestRunCurrentFile call s:run_current_file_test()
command! -nargs=0 MixTestRunCurrentLine call s:run_current_line_test()
command! -nargs=0 MixTestRunPrevious call s:run_previous_test()
command! -nargs=0 MixTestClose call s:term_send("exit\<CR>")

" Registers short-keys on current buffer when open a elixir source
augroup mix_test_key
  autocmd!
  autocmd FileType elixir call s:configure_shortcut_current_buffer()
augroup END

" short-keys
function! s:configure_shortcut_current_buffer()
  " Terminal
  " open vertically
  nnoremap <buffer> <Leader>tv :MixTestOpen<CR>
  " close
  nnoremap <buffer> <Leader>tc :MixTestClose<CR>
  " Test
  " run all tests
  nnoremap <buffer> <Leader>ta :MixTestRunAll<CR>
  " run current file tests
  nnoremap <buffer> <Leader>tf :MixTestRunCurrentFile<CR>
  " run under the cursor
  nnoremap <buffer> <Leader>tl :MixTestRunCurrentLine<CR>
  " run previous test
  nnoremap <buffer> <Leader>th :MixTestRunPrevious<CR>
endfunction

" exit event: close term
function! s:on_exit(id, data, event) abort
  let s:is_term_active = 0
  execute(s:term_buffer .. 'bwipeout!')
endfunction

function! s:on_stdout(id, data, event) abort
  call s:move_bottom()
endfunction

" open a term buffer
function! s:term_open() abort
  let cur_winid = win_getid()
  set splitright
  vnew
  let option = {
        \ 'on_exit': function('s:on_exit'),
        \ 'on_stdout': function('s:on_stdout'),
        \ 'on_stderr': function('s:on_stdout'),
        \ }
  " start bash
  let s:term_id = termopen("bash", option)
  let s:term_buffer = bufnr()
  let s:is_term_active = 1

  " activate source window
  call win_gotoid(cur_winid)
endfunction

" send data to term
function! s:term_send(data) abort
  if s:is_term_active
    call chansend(s:term_id, a:data)
  endif
endfunction

function! s:move_bottom() abort
  if exists('s:term_buffer')
    let winid = bufwinid(s:term_buffer)
    if winid != -1
      call win_execute(winid, '$')
    endif
  endif
endfunction

function! s:run_all_test() abort
  let s:current_test = "mix test\<CR>"
  call s:term_send(s:current_test)
endfunction

function! s:run_current_file_test() abort
  let current_file = expand('%')
  let s:current_test = "mix test " . current_file . "\<CR>"
  call s:term_send(s:current_test)
endfunction

function! s:run_current_line_test() abort
  let current_file = expand('%')
  let line = line('.')
  let s:current_test = "mix test " . current_file . ":" . line . "\<CR>"
  call s:term_send(s:current_test)
endfunction

function! s:run_previous_test() abort
  if exists('s:current_test')
    call s:term_send(s:current_test)
  endif
endfunction
