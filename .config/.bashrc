#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls -l --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='vim PKGBUILD'
alias more=less

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
shopt -s autocd
shopt -s histappend
# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"
backup()
{
    echo "1: Backup /home/comfy (.tar.xz)"
    echo "2: Backup /(.tar.xz)"

    read opt
    case "$opt" in
	1)tar cvpJf /home/comfy ;;
        2)tar cvpJf /           ;;
    esac
}
cdl()
{
    cd "$@"
    ls -la --color=auto
    echo ""
    echo "Working dir: $PWD"
}
mcd()
{
	mkdir "$@"
	cd "$@"
}

cdbin()
{
	cdl /home/comfy/bin
}


bash_aliases()
{
	alias bashrc='vim ~/.bashrc && source ~/.bashrc'
	alias apt='sudo pacman -S'
	alias pacup='sudo pacman -Syu'
	alias v='vim'
	alias su='su -l'
	alias mkdir='mkdir -pv'
	alias sha1='sha1sum'
	alias sha512='sha512sum'
	alias start_bar='killall polybar ; polybar -r openbox-bar >/tmp/log.polybar 2>/tmp/error.polybar &'
        alias i3conf='vim ~/.config/i3/config' 
	alias obout='oblogout'
	alias grubup='sudo update-grub'
}

ctl()
{
	echo '1: Logout'
	echo '2: Shutdown'
	echo '3: Lock'
	echo '4: Reboot'
	echo '5: Oblogout'
	echo ''
	
	read opt

	case "$opt" in
		"1")killall i3    ;;
		"2")poweroff      ;;
		"3")i3lock-script ;;
		"4")reboot        ;;
		"5")oblogout      ;;
	esac
}

akill()
{
 killall -SIGUSR1 $1	
}



fullterm(){
for i in 1,2,3,4,5,6,7,8,9,10
 do
 COMMAND="$@"
 FOCUSED=$(xprop -root _NET_ACTIVE_WINDOW | awk -F' ' '{print $NF}')
 
 if xprop -id ${FOCUSED} _NET_WM_STATE | grep -q _NET_WM_STATE_FULLSCREEN; then
     i3-msg "[id=${FOCUSED}] fullscreen enable"
     i3-msg "[id=${FOCUSED}] kill"
 else
     i3-msg "[id=${FOCUSED}] fullscreen enable"
 fi
done

}	
bash_aliases		 

DEFAULT=$PS1
PS1="\[\033[01;32m\]/dev/pts/\l \[\033[34m\] \[\033[05;34m\][`uptime -p`]\[\033[0;34m\] \$  "

nfetch 
