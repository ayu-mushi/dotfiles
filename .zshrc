fpath=(/usr/share/zsh/functions ${fpath})
autoload -U compinit
compinit

PROMPT="%B%{[31m%}<INS>%/#%{[m%}%b "


#zshプロンプトにモード表示#################################### (http://nishikawasasaki.hatenablog.com/entry/20101227/1293459255)
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
    PROMPT="%B%{[31m%}<NOR>%/#%{[m%}%b "
    ;;
    main|viins)
    PROMPT="%B%{[31m%}<INS>%/#%{[m%}%b "
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
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


export LESS="-R"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"

export PATH=/usr/local/texlive/2018/bin/i386-linux:/usr/local/texlive/2017/bin/x86_64-linux:/usr/share/texlive/texmf-dist/scripts/texlive/:$HOME/.local/bin:/usr/local/lib/anaconda2/bin/:/opt/mozart/bin/:/usr/local/ghc-7.10/bin:/usr/local/ghc-7.8.4/bin:/usr/local/ghc-7.10.2/bin/:/usr/local/bin:/opt/local/bin:/usr/local/ghc-7.8/bin:~/.cabal/bin/:$PATH
alias emacs="emacs -nw"
alias gnome-open=xdg-open
export ncc="mono /opt/nemerle/ncc.exe"
alias domino="/usr/local/lib/domino/Domino.exe"
alias commentaries="cat ~/w3m_commentary/*.md | less"

EDITOR=vim
export EDITOR

alias mpg321="mpg321 -g 2"
alias timidity="timidity -A 10"

alias kitten="~/program/kitten/dist/build/kitten/kitten -L ~/program/kitten/dist/build/kitten"
alias fay="fay --package-conf=~/program/fay-base-0.20.0.0/.cabal-sandbox/i386-linux-ghc-7.10.1-packages.conf.d"
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
alias -s jpg=display
alias -s agda=emacs
alias -s takt=emacs
alias -s png=display
alias -s gif=eog
alias ubuntu-version='cat /etc/lsb-release'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
alias kindle="wine ~/Dropbox/Amazon/Kindle/Kindle.exe"
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

source ~/program/zaw/zaw.zsh
source ~/program/zaw-sources/zaw-mendeley.zsh

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
