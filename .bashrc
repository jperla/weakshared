# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac

__git_ps1 ()
{
	local b="$(git symbolic-ref HEAD 2>/dev/null)"
	if [ -n "$b" ]; then
		if [ -n "$1" ]; then
			printf "$1" "${b##refs/heads/}"
		else
			printf " (%s)" "${b##refs/heads/}"
		fi
	fi
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;34m\]\u@\h\[\033[00m\]: \[\033[01;35m\]$(__git_ps1 "[%s]")\[\033[00m\]\$ '


# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
#    ;;
#*)
#    ;;
#esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases 
#if [ "$TERM" != "dumb" ]; then
    #eval "`dircolors -b`"
    #alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
#fi

# some more ls aliases
#alias la='ls -A'
#alias l='ls -CF'
alias ll='ls -l'
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias ad='git add'
alias pl='git pull'
alias ph='git push'
alias cm='git commit -a -m'
alias sl='git status -uall'
alias lg='git log'
alias gp='git grep'
alias de='git diff --ignore-space-change'
alias dm='git diff --ignore-space-change master'
alias me='git merge'
alias bh='git branch'
alias ct='git checkout'
alias cb='git checkout -b'

alias sc='source ~/.bashrc'
alias rsc='ruby script/console'
alias rs='ruby script/server -p 3001'
alias rscp='ruby script/console production'
alias rsp='ruby script/server -e production -p 3001'

alias crt='clear && rake test'
alias rtu='clear && rake test:units'
alias rtf='clear && rake test:functionals'
alias rti='clear && rake test:integration'

#utility server stuff
alias sht='ssh jperla@hubert.stickybits.com'
alias siv='ssh jperla@labmeeting.ivycall.com'
alias sfv='ssh jperla@fry.stickybits.com'
alias snt='ssh jperla@napster.turntable.fm'
alias svl='ssh jperla@vito.labmeeting.com'
alias sjl='ssh -L 5380:localhost:80 jperla@jona.labmeeting.com'
alias sll='ssh -L 5006:localhost:8190 jperla@loki.labmeeting.com'
alias cpl='cd ~/projects/labmeeting'
alias cpf='cd ~/projects/frishy'
alias cpd='./script/git/deploy.py' #cap deploy'
alias mb='./script/git/merge_branch.py'
alias rb='./script/git/remote_branch.py'
alias cpdm='cap deploy:migrate'
alias slp='sudo vi /var/www/labmeeting/current/log/production.log'
alias surscp='sudo -u www ruby script/console production'
alias vwlc='cd /var/www/labmeeting/current'

alias cx='chmod +x'
alias sven='sudo vi /etc/nginx/nginx.conf'
alias sein='sudo /etc/init.d/nginx'

alias siv='ssh jperla@ivycall.com'



alias agi='sudo apt-get install'
alias agu='sudo apt-get update'
alias acs='apt-cache search'
alias acp='apt-cache showpkg'
alias mdb='./bin/mongod --dbpath ./data/db'

alias s='screen -RAad'


export PYTHONSTARTUP=.pythonstartup.py
declare -x TEXINPUTS=.:$HOME/texmf/tex/:

declare -x SOLR_PEOPLE_SEARCH_URL="http://localhost:8081/solr-people"


export PATH=$PATH:/var/lib/gems/1.8/bin/
export PATH=$PATH:/home/jperla/programs/
export PATH=$PATH:/Users/josephperla/apps/scala/bin/

export JAVA_HOME="/usr/lib/jvm/java-6-sun/"
export SCALA_HOME="/Users/josephperla/apps/scala"
export MYSQL_CONNECTOR_JAR="/usr/share/java/mysql-connector-java.jar"

umask 002
