" =============================================================================
" File:          plugin/fzf_mru.vim
" Description:   CtrlP Most Recently Used Files source for FZF
" Author:        Pawel Bogut <github.com/pbogut>
" =============================================================================

if exists('g:fzf_mru_loaded') | finish | endif
let g:fzf_ctrlp_mru_loaded = 1

function! s:fzf_mru_source()
  " remove current file from the list
  return filter(copy(ctrlp#mrufiles#list()), 'v:val != expand("%")')
endfunction

" prepare params
function! s:params(params)
  let params = join(a:params, ' ')
  if (len(params) && params[0] != '-')
    let params = '-q ' . shellescape(params)
  endif

  return params
endfunction

function! s:fzf_mru(...) abort
  let options = {
        \   'source': s:fzf_mru_source(),
        \   'options': '--prompt "MRU> " ' . s:params(a:000),
        \ }
  let extra = extend(copy(get(g:, 'fzf_layout', g:fzf#vim#default_layout)), options)

  call fzf#vim#files('', extra)
endfunction

command! -nargs=* FZFMru call s:fzf_mru(<q-args>)