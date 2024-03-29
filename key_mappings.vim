" ----------------------------------------------------------------------------
" Key mappings
"
" General text editing  ................................................. {{{1
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" ....................................................................... }}}1

" Rust development  ..................................................... {{{1
"
" TODO: Create mappings based on project type instead of file type for better
" experience. Maybe take advantage of LSP status.
au FileType rust map ,ru :VimuxInterruptRunner<CR>:CargoRun<CR>
au FileType rust map ,rl :VimuxInterruptRunner<CR>:VimuxRunLastCommand<CR>
au FileType rust map ,ri :VimuxInterruptRunner<CR>
au FileType rust map ,rk :VimuxRunCommand 'cargo bench'<CR>
au FileType rust map ,rp :VimuxRunCommand 'cargo run -- '<C-B>
au FileType rust map ,rt :CargoTestAll<CR>
au FileType rust map ,rb :CargoUnitTestCurrentFile<CR>
au FileType rust map ,rf :CargoUnitTestFocused<CR>

" Smart semicolon insertion
au FileType rust inoremap ;<CR> <End>;<CR>
au FileType rust inoremap ;;<CR> <Down><End>;<CR>
" ....................................................................... }}}1

" Work with vim configurations  ......................................... {{{1
"
" ,vs   Reload vimrc
nmap ,vs  :source $HOME/.config/nvim/init.vim<CR>
" ,pi   Install plugins
nmap ,pi  :source $HOME/.config/nvim/lua/plugins.lua<CR>:PackerInstall<CR>:PackerCompile<CR>
" ,pu   Update (sync) plugins
nmap ,pu  :source $HOME/.config/nvim/lua/plugins.lua<CR>:PackerSync<CR>
" ....................................................................... }}}1

" Default mappings coming from plugins  ................................. {{{1
"
" \di \ds           Start/Stop DrawIt
"
" splitjoin.vim
" gS      Split a one-liner into multiple lines
" gJ      (with the cursor on the first line of a block)
"         Join a block into a single-line statement

" vim-surround
" cs"'    Change surrounding from double quotes to single quotes
" cs'<q>  Change surrounding from single quotes to <q> tags
" cst"    Change surrounding from HTML tags to double quotes
" ds"     Remove surrounding double quotes
" ysiw]   Surround inner world with []
" ysiw{   Surround inner world with { } and extra spaces
" yss)    Surround entire line with ()
" ysiw<em>
"         Surround inner world with <em> tags
" Visual mode: S<p class="important">
"         Surround selected area with <p class="important">

" vim-jdaddy
" gqaj    Pretty prints the JSON construct under the cursor.
" =       Use gqaj to pretty print JSON
au FileType json nmap <buffer> = gggqaj
au FileType json vmap <buffer> = <Esc>gggqaj

" vim-gh-line
" Default key mapping for a blob view: <leader>gh
" Default key mapping for a blame view: <leader>gb
" Default key mapping for repo view: <leader>go

" taskpaper.vim
" \td     Mark task as done
" \tx     Mark task as cancelled
" \tt     Mark task as today
" \tD     Archive @done items
" \tX     Show tasks marked as cancelled
" \tT     Show tasks marked as today
" \t/     Search for items including keyword
" \ts     Search for items including tag
" \tp     Fold all projects
" \t.     Fold all notes
" \tP     Focus on the current project
" \tj     Go to next project
" \tk     Go to previous project
" \tg     Go to specified project
" \tm     Move task to specified project
"  ...................................................................... }}}1

" vim: set fdm=marker fdl=1:
