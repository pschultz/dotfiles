set nocompatible
filetype off
filetype plugin indent off

if filereadable(expand('~/.vim/bundle/vundle/README.md'))
    echo "Removing old version of Vundle.."
    echo ""
    silent !rm -rf ~/.vim/bundle/vundle
endif

let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim
    let iCanHazVundle=0
endif

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'godlygeek/tabular'
Plugin 'pschultz/snipmate.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'pschultz/nginx-vim-syntax'
Plugin 'beyondwords/vim-twig'
"Plugin 'joonty/vim-phpqa'
Plugin 'beberlei/vim-php-refactor'
Plugin 'austintaylor/vim-commaobject'
Plugin 'tpope/vim-pathogen'
Plugin 'scrooloose/syntastic'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'brookhong/DBGPavim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-scripts/bats.vim'
Plugin 'fatih/vim-go'
Plugin 'empanda/vim-varnish'

" Use :PluginInstall to install newly added plugins

call vundle#end()

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :PluginInstall
endif

call pathogen#infect() " Need this for syntastic

filetype plugin indent on

syntax on
se ai nu vb t_Co=256 pastetoggle=<F9> scrolloff=3 hlsearch history=1000 listchars=tab:>-,trail:-,extends:>,precedes:<
se expandtab shiftwidth=4 softtabstop=4

color twilight256
"color solarized
"se background=light
se cursorline
hi cursorline  cterm=none ctermbg=234 ctermfg=none guibg=black guifg=none
hi colorcolumn ctermbg=234

nnoremap <leader>cl :hi cursorline  cterm=none ctermbg=234 ctermfg=none guibg=black guifg=none<CR>:hi colorcolumn ctermbg=234<CR>
nnoremap <leader>s :sort<CR>

Helptags


vmap <space> zf

function ToggleFold()
    if foldlevel('.') == 0
        let x = line('.')
        normal 0
        call search("{")
        normal %
        let y = line('.')
        execute x . "," . y . " fold"
    else
        normal zd
    endif
endfunction

nmap <space> :call ToggleFold()<CR>

if &diff
    colorscheme twilight256
endif

let g:PHP_vintage_case_default_indent = 1
let g:php_cs_fixer_path = "~/bin/php-cs-fixer.phar"
let g:php_cs_fixer_level = "all"
let g:php_cs_fixer_config = "default"
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_fixers_list = ""
let g:phpqa_messdetector_autorun = 0
let g:phpqa_codesniffer_autorun = 0
let g:phpqa_codesniffer_args = "--standard=PSR2"
let g:gofmt_command = '~/bin/goimports'
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['go', 'javascript'],'passive_filetypes': [] }
let g:syntastic_javascript_checkers = ['jshint']

if has("autocmd")

  nnoremap <leader>u :r ! php -r 'echo uniqid("",1);'<CR>

  " These languages tend to have quite deep nesting levels, so set tabwidth to 2
  au FileType javascript setl sw=2 sts=2 et
  au FileType coffee     setl sw=2 sts=2 et
  au FileType html       setl sw=2 sts=2 et
  au FileType twig       setl sw=2 sts=2 et
  au FileType xml        setl sw=2 sts=2 et
  au FileType ruby       setl sw=2 sts=2 et
  au FileType go         setl ts=4
  au FileType puppet     hi cursorline  cterm=NONE ctermbg=234 ctermfg=none guibg=black guifg=none
  au FileType php        nnoremap <leader>f :w<CR>:call PhpCsFixerFixFile()<CR>:e<CR>
  au FileType php        setl cc=151
  au FileType xml        nnoremap <leader>f :w<CR>:%!xmllint --format -<CR>
  au FileType xsd        nnoremap <leader>f :w<CR>:%!xmllint --format -<CR>
  au FileType javascript nnoremap <leader>f :w<CR>:%!python -mjson.tool<CR>

  " Use hard tabs for Makefiles
  au FileType make setl noet sw=4 ts=4

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au! 

  autocmd FileType go autocmd BufWritePre <buffer> silent Fmt

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  "autocmd BufReadPost *
  "  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  "  \   exe "normal! g`\"" |
  "  \ endif

  au BufNewFile,BufRead *.less set filetype=less
  au BufNewFile,BufRead *.json set filetype=javascript
  au BufNewFile,BufRead *.json nnoremap <leader>f :w<CR>:%!python -mjson.tool<CR>
  au BufNewFile,BufRead *.god  set filetype=ruby
  au BufNewFile,BufRead *.thor set filetype=ruby
  au BufNewFile,BufRead *.twig set filetype=twig
  au BufNewFile,BufRead *.html.twig set filetype=html.twig
  au BufNewFile,BufRead *.god  set filetype=ruby
  au BufNewFile,BufRead *.ejs set filetype=html
  au BufNewFile,BufRead *.sls set filetype=yaml

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

  augroup END 

else

  set autoindent>--->---" always set autoindenting on

endif " has("autocmd")

set exrc            " enable per-directory .vimrc files
set secure          " disable unsafe commands in local .vimrc files
