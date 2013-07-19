# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    battery
    brew
    coffee
    git
    gitfast
    node
    npm
    osx
    pip
    ruby
    supervisor
    vagrant
    virtualenv
    virtualenvwrapper
)

source $ZSH/oh-my-zsh.sh #is this necessary?

export EDITOR="emacs"
alias e="emacs"
alias ec="emacsclient"
alias es="emacs --daemon"
alias v="vim"
alias .vimrc="vim ~/.vimrc"
[[ $EMACS = t ]] && unsetopt zle # enable zsh inside eshell
alias reload_zsh="source ~/.zshrc"
alias .reload_zsh=reload_zsh
alias .zshrc="$EDITOR ~/.zshrc"
ANDROID_HOME=~/code/android-sdk
alias aliases="alias -p" #print all aliases
alias .tmux="$EDITOR ~/.tmux.conf"
alias ackl="ack -i --literal"
alias .emacs="$EDITOR ~/.emacs.d/init.el"
alias ls="ls -G"
alias mkdir="mkdir -p" #create intermediate path for directory
alias untar="tar -zxvf"
alias pt="ps -e -o pid,command | grep"
export LSCOLORS="Bx"
export LESS="-X --quit-if-one-screen --ignore-case --RAW-CONTROL-CHARS"
export ACKRC=".ackrc" #allow directory specific .ackrc files
export GREP_OPTIONS='-I --exclude=*.pyc --exclude-dir=.git'
alias grepr="grep -R"
###How to add ssh without a password:
#`scp ~/.ssh/id_rsa.pub USER@HOST:~/.ssh/authorized_keys2`
#you might need to do `chmod 700 ~/.ssh; chmod 640 ~/.ssh/authorized_keys2` too
alias mcoder="mencoder mf://pngs/*.png -mf fps=50 -ovc lavc -lavcopts vcodec=msmpeg4v2 -oac copy -o recording.avi"
alias saveToICloud="defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool" # use this alias followed by true/false
ffind () {
    dir="."
    regexp="$1"
    if (( $# == 2 )); then
        dir="$1"
        regexp="$2"
    fi
    find $dir | grep --color $regexp
}
alias .dotfiles="cd ~/.dotfiles"
alias .code="cd ~/code/"
alias gc="git commit"
alias gca="git commit -a"
alias gg="git grep --ignore-case"
alias gcam="git commit -am"
alias gd="git diff"
alias gdc="git diff --cached"
alias gdh="git diff HEAD"
alias gds="git diff --staged"
alias gs="git status"
alias gsl="git stash list"
alias gss="git stash save"
alias gb="git branch"
alias gbl="git blame"
alias gblr="git blame --reverse"
gsa () {
    if (( $# == 0 )); then
        git stash apply
    else
        git stash apply stash@{$1}
    fi
}
unalias gsd
gsd () {
    if (( $# == 0 )); then
        git stash drop
    else
        git stash drop stash@{$1}
    fi
}
alias gp="git push"
alias grh="git reset --hard"
alias gl="git lg"
#alias gpom="git push origin master"
alias gpo="git push origin"
alias battery="battery_pct_remaining"
alias facetime_kill="sudo killall VDCAssistant"
alias py=python
alias ipy=ipython
alias json="python -mjson.tool"
alias nocolor="sed \"s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g\""
#alias alog="adb logcat | ack"
alog () {
    if (( $# == 0 )); then
        adb logcat -v time
    elif [[ $1 == "runtime" ]]; then
        local pattern='E/AndroidRuntime' # |V/Crash
        # mac osx sed does not have unbuffered sed
        #adb logcat | ack "E/AndroidRuntime" | sed -u "s/E\/AndroidRuntime([0-9]*)://"
        #adb logcat | ack "$pattern" | gawk -F':' '{print $2":"$3}'
        adb logcat -v time | ack --ignore-case $pattern
    else
        adb logcat -v time | ack --ignore-case $@
    fi
}

#convenient aliases for managing multiple jobs
for (( i=0; i < 10; i++ )); do
    alias $i="fg %$i"
done

# virtualenv setup
export WORKON_HOME=~/.venvs
VIRTUALENV_HOME=/usr/local/bin/virtualenvwrapper.sh
if [ ! -f  ]; then
    source $VIRTUALENV_HOME
fi
#export PROJECT_HOME=~/.Devel


bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '^W' kill-region

function longPrompt(){
    PROMPT_LENGTH="%~"
    precmd
}
function shortPrompt(){
    PROMPT_LENGTH="%1~"
    precmd
}

# until pull request is merged into oh-my-zsh, include the plugged_in function here
function plugged_in() {
    [ $(ioreg -rc AppleSmartBattery | grep -c '^.*"ExternalConnected"\ =\ Yes') -eq 1 ]
}



BATTERY_BACK_TO_HEALTH="%U%{$fg[blue]%}%uBattery is back to health%{${reset_color}%}"
precmd () {
    #git_branch="$(__git_ps1 "%s")"
    branch="$(current_branch)" #branch will be changed but you want to save git_branch for later

    if [[ -z $branch ]]; then
        branch="" #do nothing
    else
        git_status="$(git status 2>/dev/null)"
        
        # to add a warning for a branch, do
        # `git config --local --add branch.BRANCHNAME.editwarning true` and
        # unset with `git config --local --unset branch.BRANCHNAME.editwarning
        branch_warning="branch.$(current_branch).editwarning=true"
        hide="$(git config -l)"
        
        if [[ $hide =~ $branch_warning ]]; then
            branch="%{$bg[red]%} -- ${branch} -- %{$reset_color%}"
        else
            branch="(${branch})"
        fi
        
        if [[ $git_status =~ "Untracked files" ]]; then
            color="yellow"
        elif [[ $git_status =~ "Changes not staged for commit" ]]; then
            color="yellow"
        elif [[ $git_status =~ "Changes to be committed" ]]; then
            color="magenta"
        elif [[ $git_status =~ "Your branch is ahead" ]]; then
            color="cyan"
        elif [[ $git_status =~ "nothing to commit" ]]; then
            color="blue"
        fi
        branch=" %{$fg_no_bold[$color]%}$branch%{$reset_color%}% "
    fi

    VENV=""
    if [[ $VIRTUAL_ENV != "" ]]; then
        VENV="%{$fg_no_bold[blue]%}(`basename $VIRTUAL_ENV`) "
    fi

    PROMPT="$VENV%U%{$fg_no_bold[green]%}$PROMPT_LENGTH%u %{$reset_color%}%$branch $ "

    battery=`battery_pct`
    if [[ $battery == "no battery" ]]; then
        battery=""
    elif [[ $battery -le 20 ]]; then
        color="red"
        if plugged_in ; then
            color="green"
        fi
        if [[ $battery -le 10 ]]; then
            style="$bg[$color]$fg[black]"
        else
            style="$fg[$color]"
        fi
        battery="%U%{${style}%}%uBattery: $battery%%%{${reset_color}%}"
    else
        if [[ $RPROMPT != "" && $RPROMPT != $BATTERY_BACK_TO_HEALTH ]]; then
            battery=$BATTERY_BACK_TO_HEALTH
        else
            battery=""
        fi
    fi
    RPROMPT=$battery

    # TODO Display the time every 15/30 minutes in RPROMPT as Dark Blue
    # `date`
}


if [[ -z $PROMPT_LENGTH ]]; then
    shortPrompt # don't reset to shortPrompt after .zshrc is reloaded
fi

export PATH="/usr/local/bin:/usr/local/mybin:/usr/local/sbin"
PATH=$PATH":usr/local/share/python"
PATH=$PATH":/usr/local/mongodb/bin:/usr/local/mysql/bin"
PATH=$PATH":/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin"
PATH=$PATH":$HOME/code/android-sdk/platform-tools:$HOME/code/android-sdk/tools"
PATH=$PATH":$HOME/.rvm"

function loadrvm(){
    if [[ `which rvm` != "rvm not found" ]]; then
        source /Users/ronshapiro/.rvm/scripts/rvm
        PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
    fi
}

function editMacKeyBindings() {
    dir=~/Library/KeyBindings
    if [ ! -d $dir ]; then
        mkdir $dir
    fi

    file=$dir/DefaultKeyBinding.dict
    if [ ! -f $file ]; then
        sudo touch $file
    fi
    sudo $EDITOR $file
    #sudo $EDITOR ~/.mac_keybindings
}


# No correct list
alias which="nocorrect which"
alias ffind="nocorrect ffind"

### ZSH Options ###
# `man zshoptions`
unsetopt AUTO_PUSHD
unsetopt AUTO_CD
setopt ALIASES
# setopt IGNORE_EOF
# autoload -Uz zsh-newuser-install
# zsh-newuser-install -f
#TRAPEXIT() {
    #echo $?
    #zsh
#}


### Notes
# `cd -` sends you back to the previous directory you were in
# trap finish EXIT # use at the end of a shell script, where finish() is a
  # self defined function to cleanup
# ab - Apache HTTP server benchmarking tool

source ~/.venmorc
