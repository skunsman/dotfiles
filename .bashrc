export EDITOR="vim"

export MANPAGER="less -X"

export LC_ALL="en_US.UTF-8"
export LANG="en_US"

export HOMEBREW_CASK_OPTS="--appdir=/Applications"
eval "$(/opt/homebrew/bin/brew shellenv)"

PATH=$PATH:/Applications/MacVim.app/Contents/bin
PATH="/usr/local/opt/ruby@2.7/bin:$PATH"

source "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"

eval "$(starship init bash)"

function docker_compose_helper() {
  service=$1
  shift
  action=$@

  dcyml="${HOME}/development/${service}/docker-compose.yml"

  if [ ! -f "$dcyml" ]; then
    echo "Can't find docker-compose.yml file for ${service} -- $dcyml"
    return
  fi

  docker-compose -f $dcyml $action
}

function parse_jwt() {
  local token=$1
  local payload=`echo $token | cut -d '.' -f 2`
  local len="${#payload}"
  local mod=$((len % 4))

  if [[ $mod -gt 0 ]]; then
    local pad=$((4 - mod))
    local padding=`echo '======' | cut -c 1,$pad`
    local payload="${payload}${padding}"
  fi 
  echo "$payload"
  echo $payload | base64 --decode | jq '.'
}


function copy_current_branch_name() {
  git symbolic-ref --short HEAD | tr -d '\n' | pbcopy
}

function docker_prompt_for_bash() {
  local container=`docker ps  --format '{{.ID}} {{.Names}}' | fzf | cut -f 1 -d ' '`
  if [ ! -z $container ]; then
    docker exec -it $container bash
  fi
}

function set_title() {
  echo -n -e "\033]0;${1}\007\c"
}

# z beats cd most of the time. `brew install z`
zpath="$(brew --prefix)/etc/profile.d/z.sh"
[ -s $zpath ] && source $zpath

## Aliases
alias ll="ls -l"
alias json_pretty="python -m json.tool"
alias godev="cd ~/development"
alias dc="docker_compose_helper"
alias jwt="parse_jwt"
alias title="set_title"
alias prov="~/development/bin/odreadprov.sh"
alias unugly="npm run --prefix ~/development/wishbone-utilities/unugly unugly"
alias getbuid="/Users/dheindel/development/wishbone-utilities/getbuid/getbuid.rb"
alias getlib="/Users/dheindel/development/wishbone-utilities/getbuid/getlib.rb"
alias findlib="/Users/dheindel/development/wishbone-utilities/getbuid/findlib.rb"
alias gb="copy_current_branch_name"
alias jkb="open https://jenkins-read.svc.overdrive.com/job/wishbone_server_deploy/build?delay=0sec"
alias jka="open https://jenkins-read.svc.overdrive.com/job/wishbone_js_upload_to_asset_server/build?delay=0sec"
alias myip="ipconfig getifaddr en0"
alias dsh="docker_prompt_for_bash"
alias wishbone="open http://wishbone.dev.dv.io"
alias alpha="open https://soraalpha.com"
alias beta="open https://sorabeta.com"
alias charlie="open https://soraapp.com"
alias headers="httpstat"
export HTTPSTAT_SAVE_BODY=false


###
# time to upgrade `ls`

# use coreutils `ls` if possible…
hash gls >/dev/null 2>&1 || alias gls="ls"

# always use color, even when piping (to awk,grep,etc)
if gls --color > /dev/null 2>&1; then colorflag="--color"; else colorflag="-G"; fi;
export CLICOLOR_FORCE=1

# ls options: A = include hidden (but not . or ..), F = put `/` after folders, h = byte unit suffixes
alias ls='gls -Fh ${colorflag}'
alias lsd='ls -l | grep "^d"' # only directories
#    `la` defined in .functions
###


# here's LS_COLORS
# github.com/trapd00r/LS_COLORS
command -v gdircolors >/dev/null 2>&1 || alias gdircolors="dircolors"
eval "$(gdircolors -b ~/.dircolors)"
