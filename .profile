#
# File Name:	.profile
# Author:	Aditya Ramesh
# Date:		08/19/2013
# Contact:	_@adityaramesh.com
#
# Note: this file should *only* contain settings that are valid for all versions
# of OS X or Linux. For settings specific to a particular machine, use
# `~/.platform_profile`. For ZSH-specific settings, see `.zprofile`. On
# development machines, create a symbolic link in the home directory to this
# file.
#

#
# If this script is being run by Dash instead of Bash, then Dash will crap out
# with syntax errors at the if statements. When XSession parses this file, it
# uses Dash for performance reasons, and this leads to errors that prevent
# initialization. I do not use Dash, so I am making the shell return from the
# script and resume execution if it is Dash.
#

if [[ "$BASH_VERSION" = '' && "$ZSH_VERSION" = '' ]]; then
	return
fi

if [ -f ~/.platform_profile ]; then
	source ~/.platform_profile
fi

#
# Environment variables
#

# Platform detection

platform="unknown"
unamestr=`uname`

if [[ "$unamestr" == "Linux" ]]; then
	platform="linux"
elif [[ "$unamestr" == "Darwin" ]]; then
	platform="os x"
fi

# Environment paths

if [[ $platform == "os x" ]]; then
	# Directories to add to the environment path
	export COREUTILS_BIN=/opt/local/libexec/gnubin
	export MACPORTS_BIN=/opt/local/bin:/opt/local/sbin
	export PYTHON_BIN=/opt/local/Library/Frameworks/Python.framework/Versions/3.4/bin/
	export MATLAB_BIN=/Applications/MATLAB_R2012a_Student.app/bin
	export CUDA_BIN=/Developer/NVIDIA/CUDA-7.0/bin
	export PATH=~/bin:$MACPORTS_BIN:$COREUTILS_BIN:$PYTHON_BIN:$MATLAB_BIN:$CUDA_BIN:$PATH

	# Compilers
	export GCC="gcc-mp-4.8"
	export CLANG="clang-mp-3.6"
	export GPLUSPLUS="g++-mp-4.8"
	export CLANGPLUSPLUS="$CLANG -stdlib=libc++"
	export CXX=$CLANGPLUSPLUS

	# Interpreters
	export RUBY=ruby2.0

	# Environment variables used by our applications
	export TEXMFHOME=~/Library/texmf
	export CCBASE_INCLUDE_PATH=~/projects/c++/ccbase/master/include
	export BOOST_INCLUDE_PATH=/opt/local/include
	export OPENCV2_INCLUDE_PATH=/opt/local/include
	export EIGEN3_INCLUDE_PATH=/opt/local/include/eigen3
elif [[ $platform == "linux" ]]; then
	# Directories to add to the environment path
	export LOCAL_BIN=~/local/bin
	export PATH=$LOCAL_BIN:$PATH

	# Compilers
	export GCC="gcc"
	export CLANG="clang"
	export GPLUSPLUS="g++"
	export CLANGPLUSPLUS="clang++"

	# Set to gcc instead of clang, so that Torch can compile with support for multithreading.
	export CXX=$GPLUSPLUS

	# Interpreters
	export RUBY=ruby

	# Environment variables used by our applications
	export CCBASE_INCLUDE_PATH=~/projects/ccbase/include
	export BOOST_INCLUDE_PATH=/usr/include
fi

#
# Platform-dependent Bash aliases.
#

alias vim="vim -U NONE -u ~/.vimrc"

if [[ $platform == "os x" ]]; then
	# System commands
	alias ls="ls --color"
	alias grep="grep --color=auto"
	alias port="sudo port"

	# Compilers and interpreters
	alias gdb="ggdb"
	alias gcc=$GCC
	alias g++=$GPLUSPLUS
	alias clang=$CLANG
	alias clang++=$CLANGPLUSPLUS
	alias ruby="ruby2.0"
	alias irb="irb1.8"
	alias rake="rake-1.8"
	alias pip="sudo pip-3.4"
	alias python="python3.4"
	alias ipython="ipython-3.4"

	# Applications
	alias matlab="matlab"
	alias clmatlab="matlab -nodisplay -nojvm" 
	alias evince="open -a \"Preview\" "
	alias preview="open -a \"Preview\" "
	alias safari="open -a \"Safari\" "
	alias iphone="open -a \"iOS Simulator\""
elif [[ $platform == "linux" ]]; then
	# System commands
	alias ls="ls --color"
	alias grep="grep --color=auto"

	# Package managers
	alias apt-get="sudo apt-get"
	alias pacman="sudo pacman"
	alias yaourt="sudo yaourt"

	# Compilers and interpreters
	alias gcc=$GCC
	alias g++=$GPLUSPLUS
	alias clang=$CLANG
	alias clang++=$CLANGPLUSPLUS

	# Applications
	alias clmatlab="matlab -nodisplay -nojvm" 
fi

#
# General options
#

# Configuration for the status line prompt.

if [[ "$ZSH_VERSION" != '' ]]; then
	if [[ "$HOST" == *.local ]]; then
		export PROMPT="%n:%~⨠ "
	else
		export PROMPT="%n@%m:%~⨠ "
	fi
else
	if [[ "$HOSTNAME" == *.local ]]; then
		export PS1="\u:\w⨠ "
	else
		export PS1="\u@\h:\w⨠ "
	fi
fi

set -o vi

#
# Utilities
#

# Input file separators.
IFS=$(echo -en "\n\b")

# Stuff related to networking.
alias post_json="curl -X POST -H 'Content-Type: application/json'"
alias patch_json="curl -X PATCH -H 'Content-Type: application/json'"

start_git_auth()
{
	eval "$(ssh-agent -s)"
	ssh-add ~/security/aditya.github
}
