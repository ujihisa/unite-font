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

  return map(list, '{
        \ "word": v:val,
        \ "source": "font",
        \ "kind": "command",
        \ "action__command": "let &guifont=" . string(v:val),
        \ }')
endfunction

function! unite#sources#font#define()
  return has('gui_running') ? s:unite_source : []
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
