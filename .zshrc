fpath=(/usr/share/zsh/functions ${fpath})
autoload -U compinit
compinit

#PROMPT="%B%{[31m%}<INS>%/#%{[m%}%B "

autoload colors
colors
#zshプロンプトにモード表示#################################### (http://nishikawasasaki.hatenablog.com/entry/20101227/1293459255)
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
    #PROMPT="%B%{[34m%}<NOR>%/#%{[m%}%b "
    PROMPT="%{$fg[green]%}<NOR>%{$reset_color%}%{$fg[cyan]%}[%c@${HOST}]%#%{$reset_color%}"
    ;;
    main|viins)
    #PROMPT="%B%{[34m%}<INS>%/#%{[m%}%b "

    PROMPT="%{$fg[purple]%}<INS>%{$reset_color%}%{$fg[cyan]%}[%c@${HOST}]%# %{$reset_color%}"
    ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=04:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

alias ls="ls -C"
zstyle ':completion:*' list-colors 'di=04' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
autoload predict-on
predict-on
zle -N predict-on
zle -N predict-off
bindkey "^Z" predict-on
bindkey "^B" predict-off
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

export LANG=ja_JP.UTF-8

bindkey -v
SPROMPT="%r is correct? [n,y,a,e]"

HISTFILE=~/.zsh_history
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt hist_ignore_dups
setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


export LESS="-R"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"

export PATH=$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:/usr/java/jre1.8.0_211/bin/:/usr/racket/bin/:$HOME/.opam/system/bin:/usr/local/squid/bin/:/usr/local/squid/sbin:$HOME/.local/bin:/usr/local/lib/anaconda2/bin/:/opt/mozart/bin/:/usr/local/ghc-7.10/bin:/usr/local/ghc-7.8.4/bin:/usr/local/ghc-7.10.2/bin/:/usr/local/bin:/opt/local/bin:/usr/local/ghc-7.8/bin:~/.cabal/bin/:$PATH
# :/usr/local/texlive/2018/bin/x86_64-linux
export LD_LIBRARY_PATH=/usr/local/lib/:/usr/local/share/java/opencv4/:/usr/local/share:$LD_LIBRARY_PATH
alias gnome-open=xdg-open
export ncc="mono /opt/nemerle/ncc.exe"
alias domino="/usr/local/lib/domino/Domino.exe"
alias commentaries="cat ~/w3m_commentary/*.md | less"

EDITOR=vim
export EDITOR
eval "$(direnv hook zsh)"

alias mpg321="mpg321 -g 2"
alias timidity="timidity -A 10"

#alias kitten="~/program/kitten/dist/build/kitten/kitten -L ~/program/kitten/dist/build/kitten"
alias fay="fay --package-conf=~/program/fay-base-0.20.0.0/.cabal-sandbox/i386-linux-ghc-7.10.1-packages.conf.d"
alias otp="oathtool --totp -d 6 --time-step-size=30s --base32 $(cat $HOME/otpkey) | xsel -i"
alias -s htm=vim
alias -s html=vim
alias -s css=vim
alias -s js=vim
alias -s c=vim
alias -s cs=vim
alias -s mp3=mpg321
alias -s mid=timidity
alias -s midi=timidity
alias -s mp4=vlc
alias -s wav=aplay
alias -s flv=vlc
alias -s tar="tar xvf"
alias -s gz="gzip -d"
alias -s tgz="tar zxvf"
alias -s pdf="qpdfview --unique --instance a"
alias -s tex=vim
alias -s hs=vim
alias -s md=vim
alias -s rst=vim
alias -s py=vim
alias twmemo="tw --dm:to=mushi_ayumu"
alias man=w3mman
alias -s exe=wine
alias -s swf=gnash
alias -s jpg=eog
alias -s agda=emacs
alias -s takt=emacs
alias -s png=display
alias -s kra="krita"
alias -s gif=eog
alias ubuntu-version='cat /etc/lsb-release'
#alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT1'

alias kindle="wine ~/program/Amazon/Kindle/Kindle.exe"
alias LINE="wine C:\\\\users\\\\bug3\\\\Local\ Settings\\\\Application\ Data\\\\LINE\\\\bin\\\\LineLauncher.exe"

pdm() { pdftohtml $1 -stdout | w3m -T text/html; }

case $OSTYPE in
darwin*)
  alias ls="ls -G"
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac
setopt auto_cd auto_menu
function chpwd(){ ls }
setopt auto_pushd
setopt correct
setopt list_packed
bindkey -r '^Z' # dup evil

PATH="/home/ayu-mushi/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/ayu-mushi/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/ayu-mushi/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/ayu-mushi/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/ayu-mushi/perl5"; export PERL_MM_OPT;

#source ~/program/zaw/zaw.zsh
#source ~/program/zaw-sources/zaw-mendeley.zsh

alias notice='(){ ag "^$1" $HOME/Memo/notification.md}'

alias kensaku="echo '$1' | sed -e 's/ /+/g'"

alias volume=alsamixer

alias koke="cd ~/program/koke_080806; wine koke.exe"
alias shiba="cd ~/program/koke_080806; wine koke.exe"
alias rm="trash-put"
alias dateHy='date "+%Y-%m-%d"'
alias Unity="/opt/Unity/Editor/Unity"

alias keyev="sleep 10; xvkbd -text '`xsel --clipboard`'"
alias xsel="xsel --clipboard"
alias grep="grep --color=auto"
export NODE_PATH=/usr/local/lib/node_modules
alias :q="exit"

alias wcamera="mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0 -fps 15 -vf screenshot"

# set dual monitors
dual () {
    xrandr --output VGA-0 --primary --left-of HDMI-0 --output HDMI-0 --auto
}

# set single monitor
single () {
    xrandr --output HDMI-0 --off
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ayu-mushi/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ayu-mushi/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ayu-mushi/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ayu-mushi/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH=/usr/bin/$PATH

alias untar="tar -zxvf"

alias mv="cp -iv"
alias cp="mv -iv"
