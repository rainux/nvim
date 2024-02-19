" ----------------------------------------------------------------------------
" Key mappings
"
" Navigate in content and command line  ................................. {{{1
"
" Up & Down   Navigate display line upward & downward
map <Up> gk
map <Down> gj
imap <Up> <Esc><Up>a
imap <Down> <Esc><Down>a

" Emacs-style editing on the command-line
"
" start of line
cnoremap <C-A>         <Home>
" back one character
cnoremap <C-B>         <Left>
" delete character under cursor
cnoremap <C-D>         <Del>
" end of line
cnoremap <C-E>         <End>
" forward one character
cnoremap <C-F>         <Right>
" recall newer command-line
cnoremap <C-N>         <Down>
" recall previous (older) command-line
cnoremap <C-P>         <Up>
" back one word
cnoremap <Esc><C-B>    <S-Left>
" forward one word
cnoremap <Esc><C-F>    <S-Right>
" ....................................................................... }}}1

" Essential toggles  .................................................... {{{1
"
" ,k    Toggle iskeyword contain or not contain '_'
map ,k  :call <SID>ToggleIsKeyword('_')<CR>
function! s:ToggleIsKeyword(char) " ..................................... {{{2
  if stridx(&iskeyword, a:char) < 0
    exec 'setlocal iskeyword+=' . a:char
    echo '&iskeyword now contain "' . a:char . '"'
  else
    exec 'setlocal iskeyword-=' . a:char
    echo '&iskeyword now not contain "' . a:char . '"'
  endif
endfunction " ........................................................... }}}2
" ....................................................................... }}}1

" Search & Replace  ..................................................... {{{1
"
" ,*    Substitute(Replace)
nmap ,* :%s/<C-R><C-W>/
" ....................................................................... }}}1

" General text editing  ................................................. {{{1
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" ....................................................................... }}}1

" Work with code  ....................................................... {{{1

" ,cd   Change buffer directory to current file's parent
map ,cd :lcd %:p:h<CR>

" ,sr     Compile and Run with SingleCompile
nmap ,sr  :SCCompileRun<CR>
" ,sc     Compile with SingleCompile
nmap ,sc  :SCCompile<CR>

" ,cw ,cq   Open and close quickfix window
nmap ,cw  :cwindow<CR>
nmap ,cq  :cclose<CR>
" ,lw ,lq   Open and close location window
nmap ,lw  :lwindow<CR>
nmap ,lq  :lclose<CR>
" ,, ,. ,m  Jump to current, next or prev error in quickfix list
nmap ,, :cc<CR>
nmap ,. :cnext<CR>
nmap ,m :cNext<CR>
" ,< ,> ,M  Jump to current, next or prev error in location list
nmap ,< :ll<CR>
nmap ,> :lnext<CR>
nmap ,M :lNext<CR>

" ""  List contents of all registers (that typically contain pasteable text).
nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

" Don't use Ex mode, use Q for formatting
nmap Q gq
" ,ff   Format code
nmap ,ff :set ff=unix<CR>:%!fromdos<CR>gg=G:%s/\s\+$//ge<CR>
" ,fc   Clean code
nmap ,fc :set ff=unix<CR>:%!fromdos<CR>:%s/\s\+$//ge<CR>
" \ftu  Convert to UTF-8
nmap <Leader>ftu   :set fenc=utf8<CR>:w<CR>
" \ftg  Convert to GBK
nmap <Leader>ftg   :set fenc=gbk<CR>:w<CR>

" \str  Convert double quotation string to single quotation
nmap <Leader>str :%s/[\\]\@<!\(["]\)\(\(\(#{\)\@<![^"]\)\+\)\1/'\2'/gce<CR>
vmap <Leader>str :s/[\\]\@<!\(["]\)\(\(\(#{\)\@<![^"]\)\+\)\1/'\2'/gce<CR>
" \sym  String to Symbol for Ruby
nmap <Leader>sym :%s/[\\]\@<!\(['"]\)\([0-9A-Za-z_$]\+\)\1/:\2/gce<CR>
vmap <Leader>sym :s/[\\]\@<!\(['"]\)\([0-9A-Za-z_$]\+\)\1/:\2/gce<CR>
" \hash Convert hash to Ruby 1.9's JSON-like style
nmap <Leader>hash :%s/\%(\w\|:\)\@1<!:\(\w\+\) *=> */\1: /gce<CR>
vmap <Leader>hash :s/\%(\w\|:\)\@1<!:\(\w\+\) *=> */\1: /gce<CR>
" \url  Convert url to a relative path
nmap <Leader>url :%s/https\?:\/\/[^/]\+\/\@=//gce<CR>
vmap <Leader>url :s/https\?:\/\/[^/]\+\/\@=//gce<CR>
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

" Close various informative/minor window with `q`  ...................... {{{1
"
" Close left window (original file) in diff mode
nnoremap <expr> q &diff ? ':diffoff<CR><C-W>h:q<CR>' : 'q'
" Close Vim help window
autocmd FileType help nnoremap <buffer> q :q<CR>
" Close vim-fugitive window
autocmd FileType fugitive,git,gitcommit nnoremap <buffer> q :q<CR>
" Close netrw window
autocmd FileType netrw nnoremap <buffer> q :q<CR>
autocmd FileType netrw nnoremap <buffer> <C-L> <C-W>l
" Close QuickFix & Location window
autocmd FileType qf nnoremap <buffer> q :q<CR>
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
