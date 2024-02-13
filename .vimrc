" An example for a vimrc file.
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change: 2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"    for OpenVMS:  sys$login:.vimrc

" When opening a directory, `r` brings up the controls menu thing

nnoremap <SPACE> <Nop>
let mapleader = " "

set number                     " Show current line number
set nocompatible               " We're running Vim, not Vi!
set hidden       " Allow moving between buffers when not saved
set laststatus=2       " Show status line always

set ignorecase

" Settings recommended by COC.vim
set nobackup " Some servers have issues with backup files, see #649.
set nowritebackup
set cmdheight=2  " Give more space for displaying messages.
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
set shortmess+=c  " Don't pass messages to |ins-completion-menu|.

" Hopefully sets this as the default
set tabstop=4

" Sets how far your indent is
set shiftwidth=4

" Spaces instead of tabs
set expandtab

" Tabs after certain characters made for programming, including { and other keywords.  Also keeps the same tabbing
" from line before when starting a newline (unless newline ended with { or some other keyword)
set smarttab autoindent

" Change the use of the mark.  ` normally brings you back to the row AND column of the mark.  ' just brings you to the
" row of the mark.  Switch ' with `
nnoremap ' `
nnoremap ` '

syntax on " Enable syntax highlighting

" make sure syntax highlighting stays in sync
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

filetype on " Enable filetype detection
filetype indent on " Enable filetype-specific indenting
filetype plugin on " Enable filetype-specific plugins
autocmd FileType python setlocal tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType eruby setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType typescriptreact setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType php setlocal expandtab shiftwidth=4 tabstop=4
autocmd FileType yml setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=2
autocmd FileType terraform setlocal expandtab shiftwidth=2 tabstop=2
set noautochdir

set clipboard+=unnamedplus
set clipboard=unnamed

" SWP File Management
" The directory option contains a list of places where VIM try to store the SWP files.
" Prepend this tmp directory to the list (^=)
" Use abosolute path of files to avoid collisions (//)
set directory^=$HOME/.vim/tmp//

" ColdFusion Support
au BufNewFile,BufRead *.cfc,*.cfm
  \ set noexpandtab |
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set textwidth=120

" Gruvbox Theme
set background=dark    " Setting dark mode
autocmd vimenter * ++nested colorscheme wildcharm

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Vim-Plug Config
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Theme Plugin
Plug 'morhetz/gruvbox'
Plug 'bignimbus/pop-punk.vim'

" Git usage
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'

" Status Bar
"Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'bignimbus/you-are-here.vim'

" Easy Traversal of directories
Plug 'tpope/vim-vinegar'

"Creates Directories for you if they don't exist
Plug 'pbrisbin/vim-mkdir'

" FZF Wrapper for Vim (Fuzzy Find all sorts of things)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

Plug 'vim-scripts/tComment'

" Code Completion
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

" JavaScript syntax highlighting
Plug 'jsdoc/jsdoc'
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" Typescript syntax highlighting
Plug 'leafgarland/typescript-vim'

" JSX syntax highlighting
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

" GraphQL syntax highlighting
Plug 'jparise/vim-graphql'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" JSON Syntax
Plug 'kevinoid/vim-jsonc'

" VDebug
Plug 'vim-vdebug/vdebug'

" VIM-php-cs-fixer
Plug 'aeke/vim-php-cs-fixer'

" PDV - PHPDocumentor
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'

" Git Gutter
Plug 'airblade/vim-gitgutter'

" Git blame
Plug 'zivyangll/git-blame.vim'
cmap gb :<C-u>call gitblame#echo()

" Closing a buffer without closing the window
Plug 'moll/vim-bbye'
cmap bd Bdelete

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Splits and Tabbed Files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitbelow splitright

"" Remap splits navigation to just CTRL + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

"" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:fzf_layout = { 'down': '~40%' }
" let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 }}
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => COC.vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SafeCheckBackSpace() abort
  if col('.') <= 1
    return 1
  endif
  let line = getline('.')
  let col = col('.') - 1
  return col <= len(line) && line[col - 1] =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ SafeCheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" If prettier or eslint is there, enable it in vim
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  " nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  " inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  " vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

"""
" Vdebug Settings
"
let g:vdebug_keymap = {
\    "run" : "<Leader>/",
\    "run_to_cursor" : "<Down>",
\    "step_over" : "<Up>",
\    "step_into" : "<Left>",
\    "step_out" : "<Right>",
\    "close" : "Q",
\    "detach" : "<F7>",
\    "set_breakpoint" : "<Leader>s",
\    "eval_visual" : "<Leader>e"
\}


" Allows Vdebug to bind to all interfaces.
let g:vdebug_options = {}
let g:vdebug_options["port"] = 9000
"let g:vdebug_options["server"] = '127.0.0.1'
"let g:vdebug_options["server"] = '172.21.0.1'

let g:vdebug_options["debug_file"] = '/Users/ganderson/code/vdebug.log'

" Stops execution at the first line.
let g:vdebug_options['break_on_open'] = 0
" let g:vdebug_options['max_children'] = 128

" Use the compact window layout.
" let g:vdebug_options['watch_window_style'] = 'compact'

" IDE_KEY
" let g:vdebug_options['ide_key'] = 'XDEBUG_SESSION'

"
" " Sync the remote path ('/remote/path') with the local path ('/local/path')
"let g:vdebug_options['path_maps'] = {
"\   '/app': '/Users/ganderson/code/profiles-service/'
"\   }

" Helpful Things
" Change selected text from NameLikeThis to name_like_this.
vnoremap <leader>u :s/\<\@!\([A-Z]\)/\_\l\1/g<CR>gul

" Change selected text from name_like_this to NameLikeThis.
vnoremap <leader>c :s/_\([a-z]\)/\u\1/g<CR>gUl

" VIM-php-cs-fixer Config
let g:php_cs_fixer_path = "./dev-tools/php-cs-fixer/vendor/bin/php-cs-fixer" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
let g:php_cs_fixer_cache = "./dev-tools/php-cs-fixer/.php_cs.cache" " options: --cache-file
let g:php_cs_fixer_config_file = "./dev-tools/php-cs-fixer/.php_cs.laravel.php" " options: --config
let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 0     " Enable the mapping by default (<leader>pcd) (Set below)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 1                    " Return the output of command if 1, else an inline information.

nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

" autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

" PDV - PHPDocumentor
let g:pdv_template_dir = "./dev-tools/pdv-php-documentor/templates_snip"
nnoremap <silent><leader>doc :call pdv#DocumentWithSnip()<CR>

" Ultisnips
let g:UltiSnipsExpandTrigger = "<nop>" " Ultisnips default tab assignment conflicts with COC's tab assignment

"" Backup Vimrc
"set backup
"
"" Where to store backups
"set backupdir=~/.vim/backup//
"
"" Make backup before overwriting the current buffer
"set writebackup
"
"" Overwrite the original backup file
"set backupcopy=yes
"
"" Meaningful backup name, i.e. filename@2015-04-05.14:59
"au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
"
" Lightline status line plugin configuration
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" for the airline theme - note the underscore instead of the hyphen
let g:airline_theme = 'pop_punk'

" Vim Fugitive
nmap <leader>gf :diffget //3<CR>
nmap <leader>gj :diffget //2<CR>
nmap <leader>gs :G<CR>
nmap <leader>gb :GBranches<CR>

" Vim GitGutter
let g:gitgutter_diff_base = "develop"
"
" VIM normally keeps track of 20 'things' back.  Change to 1000
set history=1000

" Indicate jump out of the screen when 5 lines before end of the screen
set scrolloff=3

" Change search highlight color to blue with white lettering
hi Search cterm=NONE ctermfg=white ctermbg=blue
 
" Change folding color to black with white lettering
hi Folded ctermfg=White ctermbg=Black

" Show line numbers in netrw (directory browser)
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" Makes flipping windows between split screens much easier and faster.  Simply hold control and press the arrow key in the direction
" that you want to move the window.
map <C-Up> <C-W>K
map <C-Down> <C-W>J
map <C-Left> <C-W>H
map <C-Right> <C-W>L

" Get out of insert mode much easier and quicker
inoremap jk <Esc>

" Press space to clear the highlighted search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Allows you to do sudo vim in a file after you have already entered as normal vim
cmap w!! w !sudo tee % >/dev/null

set showmatch		" Show matching brackets.

" Change window size much more quickly and easily
if bufwinnr(1)
	" Change for vertical screens
	"map + <C-w>+
	"map - <C-w>-
	" Change for horizontal screens
	map , <C-w><
	map . <C-w>>
endif

" Setup a different colorscheme when diffing (it's hard to follow otherwise)
"if &diff
"	colorscheme evening
"endif

"inoremap {<CR> {<CR>}<Esc>O<TAB>
" END GREG
