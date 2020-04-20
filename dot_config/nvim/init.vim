" no compatibility with vi
set nocompatible

" plugins
call plug#begin()
Plug 'sainnhe/gruvbox-material'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'

Plug 'neoclide/coc.nvim', {'branch': 'release'}


Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ivalkeen/nerdtree-execute'
Plug 'majutsushi/tagbar'


Plug 'jeffkreeftmeijer/vim-numbertoggle'

Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'




Plug 'cespare/vim-toml'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'junegunn/goyo.vim'


call plug#end()
filetype plugin indent on

let mapleader = " "


" perfomance
set hidden
set nobackup
set nowritebackup
set noswapfile
" set updatetime=10

" search
set incsearch       " search as characters are entered
set hlsearch        " highlight matches
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lowercase
                    " case-sensitive otherwise
" clipboard
set clipboard+=unnamedplus

" spaces and tabs
set tabstop=4        " number of visual spaces per TAB
set softtabstop=4    " number of spaces in tab when editing
set shiftwidth=4     " number of spaces to use for autoindent
set expandtab        " tabs are space
set autoindent
set copyindent
set shiftround       " use multiple of shiftwidth when indenting with > and <

" UI config
set ruler
set number relativenumber
set cursorline
set cursorcolumn
set wildmenu
set linebreak
set breakindent
set numberwidth=5
set signcolumn=yes
set scrolloff=6

" color
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

syntax on
set termguicolors
let base16colorspace=256
set t_Co=256
set background=dark
let g:gruvbox_material_background = 'medium'
colorscheme gruvbox-material

" copy, cut, and paste
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d

" switch between window 
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" switch between buffers
map <A-n> :bn<CR>
map <A-p> :bp<CR>

" custom command
command Config e $HOME/.config/nvim/init.vim

" automatic command
autocmd BufRead,BufNewFile *.conf setfiletype conf
autocmd BufWritePost ~/.Xresources !xrdb ~/.Xresources
autocmd BufWritePost ~/.Xresources.d/* !xrdb ~/.Xresources

" restore cursor position when opening file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g`\"" |
    \ endif

" use TAB for completion
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" coc
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
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
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

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

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)


" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'


" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>



" git gutter
let g:gitgutter_sign_added = '+ '
let g:gitgutter_sign_modified = '~ '
let g:gitgutter_sign_removed = '- '
let g:gitgutter_sign_removed_first_line = '_^ '
let g:gitgutter_sign_modified_removed = '~-'
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 1
autocmd BufWritePost * GitGutter
highlight GitGutterAdd    guifg=#009900 guibg=<X> ctermfg=2 
highlight GitGutterChange guifg=#bbbb00 guibg=<X> ctermfg=3
highlight GitGutterDelete guifg=#ff2222 guibg=<X> ctermfg=1

" Goyo
map <C-g> :Goyo<CR>
let g:goyo_width=200
let g:goyo_height=200

" NERDTree
nnoremap <silent>- :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeAutoDeleteBuffer = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | ene | exe 'NERDTree' argv()[0] | endif

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets=1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

" Vim-Airline {{{
" ----------------------------------------------------------------------------
let g:airline_powerline_fonts = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" Here is a complete list of formatters with screenshots:
" default, jsformatter, unique_tail, unique_tail_improved

" enable/disable fugitive/lawrencium integration
let g:airline#extensions#branch#enabled = 1

" enable/disable showing a summary of changed hunks under source control.
let g:airline#extensions#hunks#enabled = 1

" enable/disable showing only non-zero hunks.
let g:airline#extensions#hunks#non_zero_only = 1

let g:airline#extensions#whitespace#enabled = 0

let g:airline#extensions#tmuxline#enabled = 0

" Vim-Airline-Theme
let g:airline_theme='gruvbox_material'

" Patching for middle section status line Terminal color
let s:saved_theme = []
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  for colors in values(a:palette)
    if has_key(colors, 'airline_c') && len(s:saved_theme) ==# 0
      let s:saved_theme = colors.airline_c
    endif
    if has_key(colors, 'airline_term')
      let colors.airline_term = s:saved_theme
    endif
  endfor
endfunction


" nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 2

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1


nnoremap <silent> <C-n> :set relativenumber!<cr>
nnoremap <leader>t :TagbarToggle<CR>
" ----------------------------------------------------------------------------
" }}}

