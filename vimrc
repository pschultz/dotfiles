syntax on
se ai nu vb t_Co=256 pastetoggle=<F9> scrolloff=3 hlsearch history=1000 listchars=tab:>-,trail:-,extends:>,precedes:<
se expandtab shiftwidth=4 softtabstop=4

color twilight256
se cursorline
hi cursorline  cterm=NONE ctermbg=234 ctermfg=none guibg=black guifg=none

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

call pathogen#infect()

if has("autocmd")

  " These languages tend to have quite deep nesting levels, so set tabwidth to 2
  au FileType javascript setl sw=2 sts=2 et
  au FileType html       setl sw=2 sts=2 et
  au FileType xml        setl sw=2 sts=2 et

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

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") > 1 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif

  augroup END 

else

  set autoindent>--->---" always set autoindenting on

endif " has("autocmd")

