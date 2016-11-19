# first PS1 edit, kept for historical sake
# export PS1=" 💾  \033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[31m\][\w]\[\033[m\]💰 "

# user@home:$PWD, newline, hex for right hook arrow, return color to base
export PS1=$'\033[36m\]\u\[\033[32m\]@\[\033[36m\]\h:\[\033[31m\][\w]\n\[\033[31m\]\xe2\x86\xaa\[\033[m\] '

# don't use these anymore, gave basic terminal colors
# LSCOLORS is for diff colors for dirs and files and sym links and such
#export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad

# Following adds color to man pages, highlights variables / keywords 
export LESS_TERMCAP_mb=$(printf '\e[01;31m')
export LESS_TERMCAP_md=$(printf '\e[01;35m')
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_so=$(printf '\e[01;33m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_us=$(printf '\e[04;36m')


# aliases
alias ls='ls -GFh'
alias ll='ls -alh'
alias py3='python3'
alias archeypic='archey -c && sleep 1 && screencapture ~/Desktop/picture.png'
alias sqlstart='sudo /usr/local/mysql/support-files/mysql.server start'
alias sqlstop='sudo /usr/local/mysql/support-files/mysql.server stop'

# increased size of history file
HISTSIZE=50000

# getweather (city/zip) pulls weather from wunderground.
# usage: getweather dc or getweather 20009 (loc or zip).
function getweather
{
    curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-<YOURZIPORLOC>}"|perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&printf $1, "\n"';
}

# calls getweather with dc as argument feeds to toilet for silly ascii art.
function weather
{
    getweather dc | toilet -t --gay -f mono9 | less -R;
}

# scrapes images 
function getpapes
{
    wget -H -A .webm,.jpg,.png,.gif,.swf -rc -nd -Di.4cdn.org -P pics -erobots=off --no-clobber "$1";
}

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"

# MySQL path, fogot why I had to set this but I had to.
PATH="/usr/local/mysql/bin:${PATH}"  

export PATH
