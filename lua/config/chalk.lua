vim.cmd([[
let g:chalk_char = "."
let g:chalk_edit = 0

" Files for which to add a space between the marker and the current text
au BufRead,BufNewFile *.vim,*.lua let b:chalk_space_before = 1

vmap zf <Plug>Chalk          " Create fold at visual selection
nmap zf <Plug>Chalk          " Create fold at operator movement
nmap zF <Plug>ChalkRange     " Create fold for specified number of lines

nmap Zf <Plug>SingleChalk    " Create single (opening) fold marker
                             " at current level or specified count
nmap ZF <Plug>SingleChalkUp  " Create single (opening) fold marker
                             "  at next levelor specified count

nmap =z <Plug>ChalkUp        " Increment current fold level
nmap -z <Plug>ChalkDown      " Decrement current fold level
vmap =z <Plug>ChalkUp        " Increment levels in selection
vmap -z <Plug>ChalkDown      " Decrement levels in selection
]])
