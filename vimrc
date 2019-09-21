" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Rust stuff
let g:rustfmt_autosave = 1
let g:rust_clip_command = 'pbcopy'
nmap <C-c> :TagbarToggle<CR>

" Rust LSP -> RLS integration
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

let g:lsp_diagnostics_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼', 'icon': '/path/to/some/icon'} " icons require GUI
let g:lsp_signs_hint = {'icon': '/path/to/some/other/icon'} " icons require GUI
highlight link LspErrorText GruvboxRedSign " requires gruvbox
highlight clear LspWarningLine

noremap <silent> H :LspHover<CR>
noremap gd :LspDefinition<CR>
noremap gD :LspDeclaration<CR>
noremap gu :LspNextReference<CR>
noremap <silent> R :LspRename<CR>
noremap <silent> S :LspDocumentSymbol<CR>
noremap <C-n> :LspNextError<CR>
noremap <C-d> :LspDocumentDiagnostics<CR>
noremap <silent> T :RustTest<CR>

"" Rust async complete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"
set foldmethod=syntax
set foldlevel=4
set foldlevelstart=4

"----
" General stuff
:set ic  " Case insensitive
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
:set ignorecase smartcase
:set autoindent smartindent
:set diffopt=vertical
:set shiftwidth=4
:set tabstop=4
:set expandtab


" Colors
:colorscheme gruvbox

