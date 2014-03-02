set nocompatible
filetype off
filetype plugin indent off

set rtp+=/usr/local/go/misc/vim
set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kchmck/vim-coffee-script'
Bundle 'seebi/dircolors-solarized'
Bundle 'stephpy/vim-php-cs-fixer'
Bundle 'godlygeek/tabular'
Bundle 'pschultz/snipmate.vim'
Bundle 'rodjek/vim-puppet'
Bundle 'pschultz/nginx-vim-syntax'
Bundle 'beyondwords/vim-twig'
Bundle 'joonty/vim-phpqa'
Bundle 'beberlei/vim-php-refactor'
Bundle 'austintaylor/vim-commaobject'
Bundle 'scrooloose/syntastic'

filetype plugin indent on

syntax on
se ai nu vb t_Co=256 pastetoggle=<F9> scrolloff=3 hlsearch history=1000 listchars=tab:>-,trail:-,extends:>,precedes:<
se expandtab shiftwidth=4 softtabstop=4

color twilight256
se cursorline
hi cursorline  cterm=none ctermbg=234 ctermfg=none guibg=black guifg=none
hi colorcolumn ctermbg=234

let g:gofmt_command = '~/bin/goimports'

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
let g:phpqa_codesniffer_autorun = 1
let g:phpqa_codesniffer_args = "--standard=PSR2"

if has("autocmd")

  nnoremap <leader>u :r ! php -r 'echo uniqid("",1);'<CR>

  " These languages tend to have quite deep nesting levels, so set tabwidth to 2
  au FileType javascript setl sw=2 sts=2 et
  au FileType coffee     setl sw=2 sts=2 et
  au FileType html       setl sw=2 sts=2 et
  au FileType twig       setl sw=2 sts=2 et
  au FileType xml        setl sw=2 sts=2 et
  au FileType ruby       setl sw=2 sts=2 et
  au FileType puppet     hi cursorline  cterm=NONE ctermbg=234 ctermfg=none guibg=black guifg=none
  au FileType php        nnoremap <leader>f :w<CR>:call PhpCsFixerFixFile()<CR>:e<CR>
  au FileType php        setl cc=121
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

  autocmd FileType go autocmd BufWritePre <buffer> Fmt

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

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

  au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!

  augroup END 

else

  set autoindent>--->---" always set autoindenting on

endif " has("autocmd")

set exrc
