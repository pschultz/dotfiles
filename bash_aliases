#!/bin/bash

alias ll='ls -l --color=auto'
alias rm='rm -rf'
alias cp='cp -r'

alias ys='sudo yum search'
alias yi='sudo yum install'
alias yu='sudo yum update'
alias yr='sudo yum remove --remove-leaves'
alias yp='sudo yum provides'
alias ymc='sudo yum makecache'

alias grep='grep -E -nH --color=auto'
alias to_unix_line_ending="perl -pi -e 's/\r\n|\n|\r/\n/g' $@";
alias cake='/home/pschultz/workspace/frameworks/cakephp/1.2.x/cake/console/cake -app /home/pschultz/Zend/workspaces/DefaultWorkspace7/maklerbackend/app'

alias dphp='php -d xdebug.remote_autostart=1 -d xdebug.remote_enable=1'
alias prove='prove -l'
export WCGREP_GREPARGS='--color=auto'
alias wg='wcgrep -n'

alias irc='XIRC=1 ssh -o SendEnv=XIRC asterisk'
alias irc-fedora='XIRC_FEDORA=1 ssh -o SendEnv=XIRC_FEDORA heimstar.net'
alias irc-oi='XIRC_OI=1 ssh -o SendEnv=XIRC_OI heimstar.net'

alias ish='ssh -o UserKnownHostsfile=/dev/null -o StrictHostKeyChecking=no'

alias confirmable_agents="psql -U postgres -p 6432 -h 192.168.178.130 -c \"select agents.agent_id FROM immodata.ovb_print_adverts join immodata.real_estate_objects on real_estate_objects.re_id = ovb_print_adverts.re_id join immodata.agents on agents.agent_id = real_estate_objects.agent_id join immodata.users on users.id = user_id;\" immobilo_v2"
alias mbtags="git tag | sed -e 's/[a-z-]\{3,\}//' | sort -V"
alias start-webhat='sudo /etc/init.d/httpd start && sudo /etc/init.d/nginx start'

alias gits='git status'
alias gitc='git checkout'
alias gitco='git commit'

alias cal="cal -3m"
alias shttp="python -m SimpleHTTPServer"

alias cmp="composer.phar"
alias composer="composer.phar"

function ssh-any () {

USER=$1
HOST=$2

set -x
ssh $USER@$( ssh $( awk '/server-id/ { print $3 }' $( ls -1tr /var/lib/dhclient/dhclient-*eth0.lease | tail -n1 ) | tr -d ';' ) "cat /var/lib/dhcp3/dhcpd.leases | grep -B 6 $HOST | awk '/lease/ { print \$2 }'" )
set -x
}

alias docker-clean='docker ps -a -q | xargs --no-run-if-empty --max-args 5 docker rm; docker images | awk "/<none>/ { print \$3 }" | xargs --no-run-if-empty --max-args 5 docker rmi'
