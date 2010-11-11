let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
      \ 'name': 'font',
      \ }

function! s:unite_source.gather_candidates(args, context)
  let list = has('gui_macvim') ?
        \ split(glob('/Library/Fonts/*'), "\n") :
        \ ['Menlo', 'Andale Mono'] " FIXME
  call map(list, "fnamemodify(v:val, ':t:r')")
  call map(list, "[v:val, substitute(v:val, ' ', '\\\\ ', 'g')]")
  " list is like [("Andale Mono", "Andale\ Mono"), ...]

  return map(list, '{
        \ "word": v:val[0],
        \ "source": "font",
        \ "kind": "command",
        \ "action__command": "set guifont=" . v:val[1],
        \ }')
endfunction

function! unite#sources#font#define()
  return s:unite_source
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
