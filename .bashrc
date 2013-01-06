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
alias push='git push origin'
alias log='git log --oneline && echo'
alias checkout='git checkout $1'
alias tag='git tag -a $1'
alias bashrc="vi $HOME/.bashrc && source $HOME/.bashrc"

function load() {
   source $HOME/configs/$1
}

function init_project_www() {
   if [ -z $1 ]; then 
      echo "Usage: init_project_www <project_name>"; 
      return
   fi
   if [ -d /var/www/$1 ] || [ -f $HOME/configs/$1 ]; then 
      echo "Directory /var/www/$1 already exists or $HOME/configs/$1 already exists"; 
      return   
   fi
   mkdir /var/www/$1
   mkdir /var/www/$1/inc
   mkdir /var/www/$1/libs
   mkdir /var/www/$1/templates
   touch /var/www/$1/inc/config.php
   touch /var/www/$1/README.md
   echo "alias cdw='cd /var/www/$1'" >> $HOME/configs/$1
   echo "alias cdi='cd /var/www/$1/inc'" >> $HOME/configs/$1
   echo "alias cdl='cd /var/www/$1/libs'" >> $HOME/configs/$1
   echo "alias cdt='cd /var/www/$1/templates'" >> $HOME/configs/$1
   echo "alias config='vi /var/www/$1/inc/config.php'" >> $HOME/configs/$1
   echo "alias readme='vi /var/www/$1/README.md'" >> $HOME/configs/$1
   echo "alias wwwown='chown -R www-data: /var/www/$1'" >> $HOME/configs/$1
   cat << EOF > /var/www/$1/inc/config.php
<?php
   define('DEBUG',false);
   #define('DEBUG',true);

   if (DEBUG) {
    ini_set('display_errors','on');
   } else {
    ini_set('display_errors','off');
   }

   define('ROOT_DIR','/var/www/$1/');
   define('INC_DIR', ROOT_DIR . 'inc/');
   define('LIBS_DIR', ROOT_DIR . 'libs/');
   ini_set('include_path',LIBS_DIR);

EOF
   cd /var/www/$1
   git init .
   git add .
   git commit -m "First commit"
   git status
}

function init_project_mysql() {
   if [ -z $1 ]; then 
      echo "Usage: init_project_mysql <project_name>" 
      return
   fi
   if [ ! -d /var/www/$1 ]; then 
      echo "Directory /var/www/$1 does not exists - create it with:  'init_project_www $1'"; 
      return
   fi
   cat << EOF > /var/www/$1/inc/config.php
   // MYSQL Connection data

   define('MYSQL_HOST','localhost');
   define('MYSQL_USER','$1');
   define('MYSQL_PASS','${1}123');
   define('MYSQL_NAME','$1');
EOF
   mysql -e "Create database if not exists $1";
   mysql -e "grant all on ${1}.* to ${1}@'%' identified by '${1}123'"

}


COUNT=$(ls -1 $HOME/.ssh/ | grep -Ev '(pub|known_hosts|tun|sock)' | wc -l)


if [ ! -f $HOME/ssh-agent-vars  ] && [ $COUNT -gt 0 ]; then
   ssh-agent > $HOME/ssh-agent-vars
   . $HOME/ssh-agent-vars
   for i in $(ls -1 $HOME/.ssh/ | grep -Ev '(pub|known_hosts|tun|sock)'); do
      echo "Importing key: $i";
      ssh-add $HOME/.ssh/$i
   done;
else
      if [ -f $HOME/ssh-agent-vars ]; then
         . $HOME/ssh-agent-vars
         echo "Keys loaded:";
         ssh-add -l
         echo 
      fi
fi
