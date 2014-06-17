#
# File Name:	.zprofile
# Author:	Aditya Ramesh
# Date:		08/19/2013
# Contact:	_@adityaramesh.com
#
# This file contains settings specific to ZSH. For settings common to Bash and
# ZSH, see `.profile`. On development machines, create a symbolic link in the
# home directory to this file.
#

# Command history settings.
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt -o sharehistory
setopt -o inc_append_history

# Extra Vim key bindings.
bindkey -M vicmd '?' history-incremental-search-backward

source ~/.profile
