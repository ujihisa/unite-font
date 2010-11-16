let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
      \ 'name': 'font',
      \ }

function! s:unite_source.gather_candidates(args, context)
  if has('gui_macvim')
    let list = split(glob('/Library/Fonts/*'), "\n")
    call map(list, "fnamemodify(v:val, ':t:r')")
  elseif executable('fc-list')
    let list = split(system('fc-list'), "\n")
    call map(list, "substitute(v:val, ':.*', '', '')")
  else
    echoerr 'Your environment does not support the current version of unite-font.'
    finish
  endif
  call map(list, "[v:val, substitute(v:val, ' ', '\\\\ ', 'g')]")
  " list is like [("Andale Mono", "Andale\ Mono"), ...]

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
