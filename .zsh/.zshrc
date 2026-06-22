# add autocompletions for homebrew-installed utilities
# this must come before compinit is loaded/initialized
if type brew &>/dev/null; then
  chmod -R go-w "$(brew --prefix)/share"
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# no beeps
setopt NO_BEEP

# comments in interactive shell
setopt INTERACTIVE_COMMENTS

# completion / globbing
setopt COMPLETE_ALIASES # make aliases a distinct command for completion purposes

# note: case_glob and no_case_glob did not work for me
# case- and hyphen-insensitive completion.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z-_}={A-Za-z_-}'

# match even if leading '.' is omitted
setopt GLOB_DOTS

# auto-correction
setopt CORRECT
#setopt CORRECT_ALL

# AUTO-CD
setopt AUTO_CD # omit 'cd'
setopt CHASE_LINKS # resolve symlinks when cd'ing

# HISTORY
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=5000
HISTSIZE=2000
setopt INC_APPEND_HISTORY # greedily append history from all sessions
setopt HIST_IGNORE_DUPS # don't save duplicates
setopt HIST_FIND_NO_DUPS # ignore dups when searching history
setopt HIST_REDUCE_BLANKS # remove blank lines
setopt HIST_IGNORE_SPACE # ignore commands that begin with a space

# KEYBINDINGS
# note: these are for MacOS
# zkbd can be used for more cross-platform keybindings,
# but I couldn't get it to work in the time available.
# TODO

# History Completion | up and down
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

# Word Jump | ctrl+left and ctrl+right
# note: must be freed from shortcuts on a fresh install!
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# Delete Previous Word | ctrl+del
#bindkey "^?" backward-delete-word


###### CONFIG ORGANIZATION BELOW ######

# ZCOMPCACHE LOCATION
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.cache"

# EXTENSIONS
source ${ZDOTDIR:-$HOME}/.extensions/.aliases
source ${ZDOTDIR:-$HOME}/.extensions/.functions
source ${ZDOTDIR:-$HOME}/.extensions/.path
#source ${ZDOTDIR:-$HOME}/.extensions/.ansible

# AUTOCOMPLETION / PROMPT

# note: best if these come after all 'zstyle' commands
autoload -Uz compinit promptinit
compinit -d ${ZDOTDIR:-$HOME}/.cache/.zcompdump # explicit dumpfile location
promptinit

# LS COLORS
export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# STARSHIP
export STARSHIP_CONFIG=${ZDOTDIR:-$HOME}/.starship/config.toml
export STARSHIP_CACHE=${ZDOTDIR:-$HOME}/.cache
eval "$(starship init zsh)"

# AUTOSUGGESTIONS
# note: must go at the end of the .zshrc
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# SYNTAX HIGHLIGHTING
# note: must go at the end of the .zshrc
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh