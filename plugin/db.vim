" =============================================================================
" File:          autoload/ctrlp/sample.vim
" Description:   Example extension for ctrlp.vim
" =============================================================================

" To load this extension into ctrlp, add this to your vimrc:
"
"     let g:ctrlp_extensions = ['sample']
"
" Where 'sample' is the name of the file 'sample.vim'
"
" For multiple extensions:
"
"     let g:ctrlp_extensions = [
"         \ 'my_extension',
"         \ 'my_other_extension',
"         \ ]

" Load guard
if ( exists('g:loaded_ctrlp_db') && g:loaded_ctrlp_sample )
	\ || v:version < 700 || &cp
	finish
endif
let g:loaded_ctrlp_db = 1


" Add this extension's settings to g:ctrlp_ext_vars
"
" Required:
"
" + init: the name of the input function including the brackets and any
"         arguments
"
" + accept: the name of the action function (only the name)
"
" + lname & sname: the long and short names to use for the statusline
"
" + type: the matching type
"   - line : match full line
"   - path : match full line like a file or a directory path
"   - tabs : match until first tab character
"   - tabe : match until last tab character
"
" Optional:
"
" + enter: the name of the function to be called before starting ctrlp
"
" + exit: the name of the function to be called after closing ctrlp
"
" + opts: the name of the option handling function called when initialize
"
" + sort: disable sorting (enabled by default when omitted)
"
" + specinput: enable special inputs '..' and '@cd' (disabled by default)
"
call add(g:ctrlp_ext_vars, {
	\ 'init': 'db#init()',
	\ 'accept': 'db#accept',
	\ 'lname': 'Seleccione una tabla para ver sus columnas',
	\ 'sname': 'SimpleDB',
	\ 'type': 'line',
	\ 'enter': 'db#enter()',
	\ 'exit': 'db#exit()',
	\ 'opts': 'db#opts()',
	\ 'sort': 0,
	\ 'specinput': 0,
	\ })



" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! db#init()

  ShowTables
  let file = readfile('/tmp/vim-simpledb-result.txt')
  let result = []
  for elem in file
    if elem !~ '(\d'
      break
    endif
    echom elem
    call add(result, elem)
  endfor
	return result
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! db#accept(mode, str)
	" For this example, just exit ctrlp and run help
  if a:mode == 'e'
    ShowTables
    return
  end
	call ctrlp#exit()
endfunction


" (optional) Do something before enterting ctrlp
function! db#enter()
endfunction


" (optional) Do something after exiting ctrlp
function! db#exit()
endfunction


" (optional) Set or check for user options specific to this extension
function! db#opts()
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! db#id()
	return s:id
endfunction


" Create a command to directly call the new search type
"
" Put this in vimrc or plugin/db.vim
command! CtrlPDB call ctrlp#init(db#id())


" vim:nofen:fdl=0:ts=2:sw=2:sts=2
