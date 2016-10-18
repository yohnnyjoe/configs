#export PS1=" 💾  \033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[31m\][\w]\[\033[m\]💰 "
export PS1="\033[36m\]\u\[\033[37m\]@\[\033[34m\]\h:\[\033[31m\][\W]\[\033[m\]"

#export CLICOLOR=1
#export LSCOLORS=ExFxBxDxCxegedabagacad

#Following add color to less, in order for man pages to have color
export LESS_TERMCAP_mb=$(printf '\e[01;31m')
export LESS_TERMCAP_md=$(printf '\e[01;35m')
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_so=$(printf '\e[01;33m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_us=$(printf '\e[04;36m')

alias ls='ls -GFh'
alias ll='ls -alh'
alias py3='python3'
alias archeypic='archey -c && sleep 1 && screencapture ~/Desktop/picture.png'

HISTSIZE=50000

#getweather (city/zip)
function getweather
{
    curl -s "http://api.wunderground.com/auto/wui/geo/ForecastXML/index.xml?query=${@:-<YOURZIPORLOC>}"|perl -ne '/<title>([^<]+)/&&printf "%s: ",$1;/<fcttext>([^<]+)/&&printf $1, "\n"';
}

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

PATH="/usr/local/mysql/bin:${PATH}"  
export PATH
