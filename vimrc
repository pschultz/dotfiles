syntax on
se ai nu vb t_Co=256 pastetoggle=<F9> scrolloff=3 hlsearch history=1000 listchars=tab:>-,trail:-,extends:>,precedes:<
se expandtab shiftwidth=4 softtabstop=4

color twilight256
se cursorline
hi cursorline  cterm=NONE ctermbg=234 ctermfg=none guibg=black guifg=none
hi ColorColumn ctermbg=234

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
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer"
let g:php_cs_fixer_level = "all"
let g:php_cs_fixer_config = "default"
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_fixers_list = ""

call pathogen#infect()

if has("autocmd")

  nnoremap <leader>u :r ! php -r 'echo uniqid("",1);'<CR>

  " These languages tend to have quite deep nesting levels, so set tabwidth to 2
  au FileType javascript setl sw=2 sts=2 et
  au FileType coffee     setl sw=2 sts=2 et
  au FileType html       setl sw=2 sts=2 et
  au FileType twig       setl sw=2 sts=2 et
  au FileType xml        setl sw=2 sts=2 et
  au FileType puppet     hi cursorline  cterm=NONE ctermbg=234 ctermfg=none guibg=black guifg=none
  au FileType php        nnoremap <leader>f :w<CR>:call PhpCsFixerFixFile()<CR>:e<CR>
  au FileType php        setl cc=121

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
  au BufNewFile,BufRead *.twig set filetype=twig

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

  au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!

  augroup END 

else

  set autoindent>--->---" always set autoindenting on

endif " has("autocmd")

