# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

. /etc/profile

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
unset HISTSIZE
unset HISTFILESIZE

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# turbo-charged pattern matching
shopt -s extglob

# shared history
shopt -s histappend
#export PROMPT_COMMAND="history -a; history -n"

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

PROMPT_COMMAND='
    pwd="${PWD/$HOME/~}"
    w="*/$(expr match "$pwd" ".*/\(.*/.*/.*\)")"
    test "$w" = "*/" && w=$pwd
    test "$w" = "*$PWD" && w=$PWD
    PS1="\[\033[1;30m\][\A] \[\033[00m\]${debian_chroot:+($debian_chroot)}\u@\h:$w\[\033[1;30m\]$(parse_git_branch)\[\033[00m\]\\$ "
'
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

[ -f /etc/bash_aliases ] && . /etc/bash_aliases
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

[ -f ~/.bash_env ] && . ~/.bash_env

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

function cpp() {
    size=$(stat -c '%s' $1)
    (pv -s $size -n $1 | cat > $2) 2>&1 | dialog --gauge "cp $1 $2" 7 70
}

# no need to do fancy wallpaperstuff without something to display it on
[ -z "$DISPLAY" ] && return 0

# also, this fails horribly on Solaris
[ "$(uname)" == "SunOS" ] && return 0

function new-desktop-background () {
    WPD=$WALLPAPER_DIR

    test -n "$1" && WPD=$1

    [ -z $WPD -o ! -d $WPD ] && return

    imageList=$(find $WPD -type f -o -type l)
    numberOfImages=$(cat<<EOS | wc -l
$imageList 
EOS
)

    randomImage=$(cat<<EOS | head -n $((RANDOM % $numberOfImages + 1)) | tail -1
$imageList
EOS
)

    gsettings set org.gnome.desktop.background picture-uri "file://$randomImage"
}

WALLPAPER_DIR=/home/pschultz/Pictures/wallpapers/dodge-charger

new-desktop-background
