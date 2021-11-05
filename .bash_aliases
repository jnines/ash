alias v='lvim'
alias sv='sudoedit'
alias up='sudo apt-get update; sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y && sudo apt-get autoclean -y'
alias uv='lvim +LvimUpdate +LvimCacheReset'
alias nano='nano -c'
alias locate='locate -i'
alias docker-compose='docker compose'
alias syncx='$HOME/bin/syncexternal > /dev/null 2>&1 & disown'

alias basha='lvim ~/.bash_aliases'
alias al='lvim ~/.bash_aliases'

alias ls='ls -ah --color=auto --group-directories-first'
alias ll='ls -alh --color=auto --group-directories-first'
alias lx='ls -lXBh --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias mv='mv -i'
alias cp='cp -Rvi --preserve=timestamps'
alias mkdir='mkdir -p'
alias less='less -R'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'

alias gd='/usr/bin/git --git-dir=$HOME/git/ash --work-tree=$HOME'
alias gda='gd add -u && gd commit -m "..." && gd push'
alias gds='gd status'

# Docker
alias dc='cd "$HOME"/docker'
alias dcup='dc && docker-compose up -d'
alias dcdown='dc && docker-compose down'
alias dockp='dc && yes | docker image prune && yes | docker container prune && yes | docker system prune && yes | docker volume prune'
alias dcupdate='dc && docker-compose pull && docker-compose up -d && dockp && sleep 3 && vpcon'
alias dcres='dc && docker-compose down && dcupdate'
alias dockrm='docker restart transmission radarr sonarr jackett lidarr ytdl ; docker rm transmission radarr sonarr jackett lidarr ytdl ; sleep 3 ; dcup'

# Get a list of contiainer
function dockc() {
containers=$(docker ps | awk '{if(NR>1) print $NF}')

    for container in $containers
    do
    echo $container
done
}

# Docker bash
function dockb() {
       dc;
       if [ -z "$1" ]; then
        dockc
       else
               docker exec -it "$1" bash
       fi
}

# Docker logs
function dockl() {
    dc;
    if [ -z "$1" ]; then
        dockc
    else
        docker-compose logs -f "$1"
    fi
}

# Docker container health
function dci() {
    if [ -z "$1" ]; then
        dockc
    else
        docker inspect "$1" | jq '.' | jq '.[0].State.Health.Status'
    fi
}

# Dc ps
function dps() {
    dc;
    docker-compose $(find *.yml | sed -e 's/^/-f /') ps
}

# Check vpn ip
function vpnip() {
  curl -s ash.lan:8000/v1/publicip/ip | sed -e 's/{"public_ip":"//' -e 's/"\,"region.*}//' 
}

alias tv='cd $HOME/Data/Media/TV'
alias movies='cd $HOME/Data/Media/Movies'
