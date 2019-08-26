# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/gsequeira/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vi ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="/usr/local/bin:${PATH}"
export PATH="$HOME/Library/Python/3.7/bin:${PATH}"
export NVM_DIR="$HOME/.nvm" 
. "/usr/local/opt/nvm/nvm.sh"
export NODE_EXTRA_CA_CERTS="$HOME/Projects/AthenaHealth/athena-certs/athena-ca-certificates.pem"
alias d='~/bin/bash/mosh.sh'
alias mountdev='sshfs -p 22 dev104.athenahealth.com:/home/gsequeira ~/Projects/AthenaHealth/devhome/ -oauto_cache,reconnect,defer_permissions,noappledouble,negative_vncache,volname=devhome'
alias unmountdev='umount ~/Projects/AthenaHealth/devhome'
alias funmountdev='sudo diskutil umount force ~/Projects/AthenaHealth/devhome'
alias idt='cd ~/Projects/AthenaHealth/devhome/p4/prod/perllib/Athena/Athena/IntercontextDataTransfer/'
export GOPATH="$HOME/Projects/Go"
export ATHENA_HOME="$HOME/Projects/AthenaHealth/devhome/p4/prod"
export MIGRATIONS_HOME="$HOME/Projects/AthenaHealth/devhome/p4/prod/perllib/Athena/Athena/IntercontextDataTransfer"
source ~/perl5/perlbrew/etc/bashrc
export AWS_PROFILE=saml

# Manage Java Environment using jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Manage Python Environment using pyenv
export PATH="/Users/gsequeira/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}
# Set badge to show the current session name and git branch, if any is set.
printf "\e]1337;SetBadgeFormat=%s\a" \
  $(echo -n "\(session.name) \(user.gitBranch)" | base64)

# Powerline 
. /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
