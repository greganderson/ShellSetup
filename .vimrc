" Last edited: 7-1-15

" TEST CODE



" END TEST CODE


" Python code

python import vim
py << END_PYTHON
import os

# Overrides the normal mode command 'gx' to open a link in chrome
def open_link():
	(col, row) = vim.current.window.cursor
	line = vim.current.buffer[col-1]
	start = line[:row].rfind(' ')
	if start == -1:
		start = 0
	line = line[start+1:]
	end = line.find(' ')
	if end == -1:
		end = len(line)
	url = line[:end]
	os.system('google-chrome ' + url)

def count():
	b = vim.current.buffer
	total = 0
	for i in range(len(b)):
		try:
			total += int(b[i][-2:])
		except:
			continue
	b[len(b)-1] = str(total)

# Converts char values into the actual char
def convert():
	b = vim.current.buffer
	for i in range(len(b)):
		b[i] = chr(int(b[i]))

END_PYTHON

" Overrides the normal mode command 'gx' to open a link in chrome
" The stuff after calling the python function is to make the vim
" content reappear.  It goes away for some reason.
nnoremap gx :py open_link()<CR>ggVG<ESC><ESC><C-o><C-o>

" https://www.google.com/search?q=put+python+code+in+vimrc&oq=put+python+code+in+vimrc&aqs=chrome..69i57.3123j0j7&sourceid=chrome&es_sm=0&ie=UTF-8#q=put+python+script+in+vimrc


" Execute pathogen, making sure all plugins are installed.
execute pathogen#infect()

" Disable vi-compatibility
set nocompatible

" Always show the statusline
set laststatus=2

" Necessary to show Unicode glyphs
set encoding=utf-8

" Add Vundle to the runtime path
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Powerline plugin
Bundle 'Lokaltog/vim-powerline'

" Set symbols for powerline
let g:Powerline_symbols = 'compatible'
"let g:Powerline_symbols = 'unicode'
"let g:Powerline_symbols = 'fancy'

" Enables syntax coloring for vim
syntax enable

" Set colorscheme
" No colorscheme set because terminal settings are set to solarized, so it carries over.
"colorscheme koehler
"colorscheme vividchalk

" Sets how far your indent is
set shiftwidth=4

" Seems to change tabs at the start of opening your file
set tabstop=4

" Tabs after certain characters made for programming, including { and other keywords.  Also keeps the same tabbing
" from line before when starting a newline (unless newline ended with { or some other keyword)
set smarttab autoindent

" I think autoindent goes with this, but this automatically indents after {
" This might be causing trouble, so I am commenting it out for awhile
"set smartindent

" Lists the numbers on the side
set number

" Change the use of the mark.  ` normally brings you back to the row AND column of the mark.  ' just brings you to the
" row of the mark.  Switch ' with `
nnoremap ' `
nnoremap ` '

" VIM normally keeps track of 20 'things' back.  Change to 1000
set history=1000

" Indicate jump out of the screen when 5 lines before end of the screen
set scrolloff=3

" Fixes issue where backspace won't move from current line
set backspace=indent,eol,start

set cryptmethod=blowfish

" Enables very easy compiling and executing c++ programs (makefile required)
"map <F1> :!clear; make<CR> :!./a.out<CR>
map <F1> :!clear; make driver<CR> :!./driver -f test_file.txt<CR>

" Change search highlight color to blue with white lettering
hi Search cterm=NONE ctermfg=white ctermbg=blue
 
" Change folding color to black with white lettering
hi Folded ctermfg=White ctermbg=Black

" Make it so splitting screens actually makes sense (as far as where the windows are placed)
set splitbelow
set splitright

" Show line numbers in netrw (directory browser)
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" Commands to open directory browser, making them open on the correct split window
cnoremap vspd Vexplore!
cnoremap spd Hexplore



" Automatically work with curly braces

" If you quickly press Enter after the open brace (to begin a code block), the closing brace will be inserted on the
" line below the cursor
inoremap {<CR> {<CR>}<Esc>O<TAB>

" If you quickly press {{, it will complete a block of code that needs curly braces, though only for one liners.
" this:
" if (true)
"	<some code here>
" becomes:
" if (true) {
"	<some code here>
" }
inoremap {{ {<Esc>jo<Backspace>}<Esc>k^

" If you quickly press Enter after a colon (to begin a code block), the line will automatically be indented
inoremap :<CR> :<CR><TAB>

" Makes it so when qualifying something in c++ with class::, it won't wait for <CR> like it normally does
inoremap :: ::

" If you quickly press Enter after starting a block comment, it will set it up for function comments.  For example:
" /*
"  *
"  */
inoremap /*<CR> /*<CR> *<CR>*/<Esc>kA<Space>

" Makes it so when trying to make a normal comment with //, it won't wait for /*<CR> like it normally does
inoremap // //

" Makes finishing a block comment easier
inoremap */ */

" Makes inline block comments (mainly for c code) easier to make
inoremap /*<Space> /* */<Esc>hhi<Space>


" Automatically adds the normal todo comment:
inoremap /t<CR> // TODO: Implement<Esc>

" Makes navigation between split windows much easier and faster.  Simply hold control and go up or down, left or right as desired
map <C-K> <C-W>k
map <C-J> <C-W>j
map <C-H> <C-W>h
map <C-L> <C-W>l

" Makes flipping windows between split screens much easier and faster.  Simply hold control and press the arrow key in the direction
" that you want to move the window.
map <C-Up> <C-W>K
map <C-Down> <C-W>J
map <C-Left> <C-W>H
map <C-Right> <C-W>L

" Get out of insert mode much easier and quicker
inoremap jk <Esc>

" Makes it so words are highlighted when searched
set hlsearch
" Press space to clear the highlighted search
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Change window size much more quickly and easily
if bufwinnr(1)
	" Change for vertical screens
	map + <C-w>+
	map - <C-w>-
	" Change for horizontal screens
	map , <C-w><
	map . <C-w>>
endif

" Allows you to do sudo vim in a file after you have already entered as normal vim
cmap w!! w !sudo tee % >/dev/null

" Rainbow parentheses
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Syntax highlighting for openscad files
au BufRead,BufNewFile *.scad    setfiletype openscad

" From /etc/vim/vimrc
set ignorecase		" Do case insensitive matching
set showmatch		" Show matching brackets.
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Setup a different colorscheme when diffing (it's hard to follow otherwise)
if &diff
	colorscheme evening
endif

" Auto creates a for loop
inoremap <C-h> for (int i = 0; i < ; i++) {<CR>}<Esc>O<TAB>// TODO: loop<Esc>k^f;;i

" *.ino files use the .cpp coloring
au BufRead,BufNewFile *.ino setfiletype cpp

" *.hive, *.hql, and *.spark files use the .sql coloring
au BufRead,BufNewFile *.hive setfiletype sql
au BufRead,BufNewFile *.hql setfiletype sql
au BufNewFile,BufRead *.spark set filetype=sql syntax=sql 

" *.spark files use the .pig coloring
augroup filetypedetect 
au BufNewFile,BufRead *.pig set filetype=pig syntax=pig 
augroup END

" *.cql file syntax highlighting
autocmd BufRead *.cql set syntax=cql

" Load specific settings for different file types



" Load HTML specific settings
function! s:LoadHTMLSettings()
	" Pressing enter right after > automatically closes the tag with correct indentation
	inoremap ><CR> ><Esc>^lveyo</<Esc>pA><Esc>O<TAB>
	" Pressing space right after > automatically closes the tag inline
	inoremap ><Space> ><Esc>^lveyA</<Esc>pA><Esc>F<i
	" Override the remap from above where {{ fixes one line if/else/for/while statements.  Useful for inserting AngularJS.
	inoremap {{ {{
endfunction

autocmd FileType html call s:LoadHTMLSettings()


" Load text file specific settings
function! s:LoadTextFileSettings()
	" Enable spell checking
	"set spell spelllang=en_us
endfunction

autocmd FileType text call s:LoadTextFileSettings()
 


"If using windows, fix the backspace problem
if has('win32')
	set bs=2
endif
