# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install

autoload -Uz compinit
compinit

source ~/.gregzshrc
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode


# load zgen
source "${HOME}/zsh/zgen/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
	echo "Creating a zgen save"

	### TO LOAD NEW PLUGINS
	# Run zgen-update

	# plugins
	zgen load zsh-users/zsh-history-substring-search
	zgen load hchbaw/opp.zsh
	zgen load willghatch/zsh-cdr
	zgen load zsh-users/zaw
	zgen load willghatch/zsh-saneopt
	zgen load willghatch/zsh-hooks
	zgen load termoshtt/zaw-systemd

	# Themes
	#zgen load willghatch/zsh-megaprompt
	zgen load https://github.com/nojhan/liquidprompt

	# completions
	zgen load zsh-users/zsh-completions src

	zgen load zsh-users/zsh-syntax-highlighting

	# save all to init script
	zgen save
fi



bindkey -M viins '^R' zaw-history
bindkey -M viins '^@' zaw

export PYTHONSTARTUP=$HOME/.pythonrc
