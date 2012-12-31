# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

## GIT helpers
# Autocompletion for commands
source /etc/bash_completion.d/git

# Prompt with current branch
PS1='[\u@\h \w]\n$(__git_ps1 "(%s) ")\$ '

alias add='git status -s | while read flag file; do git add "$file"; done;'
alias save='add && git commit -am "Saving work @ $(date)"'
alias status='git status'
alias push='git push orgin'
alias log='git log --oneline && echo'
alias checkout='git checkout $1'
alias tag='git tag -a $1'

alias bashrc='vi /root/.bashrc && source /root/.bashrc'

for i in $(ls -1 $HOME/configs); do
   . $HOME/configs/$i
done

if [ ! -f $HOME/ssh-agent-vars  ]; then
   ssh-agent > $HOME/ssh-agent-vars
   . $HOME/ssh-agent-vars
   for i in $(ls -1 $HOME/.ssh/ | grep -Ev '(pub|known_hosts)'); do
      echo "Importing key: $i";
      ssh-add $HOME/.ssh/$i
   done;
else
      . $HOME/ssh-agent-vars
      echo "Keys loaded:";
      ssh-add -l
      echo 
fi
