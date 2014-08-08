#
# File Name:	.profile
# Author:	Aditya Ramesh
# Date:		08/19/2013
# Contact:	_@adityaramesh.com
#
# This file contains settings common to Bash and ZSH. For ZSH-specific settings,
# see `.zprofile`. On development machines, create a symbolic link in the home
# directory to this file.
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
# Environment variables.
#

# Platform detection.

platform="unknown"
unamestr=`uname`

if [[ "$unamestr" == "Linux" ]]; then
	platform="linux"
elif [[ "$unamestr" == "Darwin" ]]; then
	platform="os x"
fi

# Environment paths.

if [[ $platform == "os x" ]]; then
	export COREUTILS_BIN=/opt/local/libexec/gnubin
	export MACPORTS_BIN=/opt/local/bin:/opt/local/sbin
	export PYTHON_BIN=/opt/local/Library/Frameworks/Python.framework/Versions/3.4/bin/
	export MATLAB_BIN=/Applications/MATLAB_R2012a_Student.app/bin
	export PATH=~/bin:$MACPORTS_BIN:$COREUTILS_BIN:$PYTHON_BIN:$MATLAB_BIN:$PATH
	export TEXMFHOME=~/Library/texmf
	export CCBASE_INCLUDE_PATH=~/projects/c++/ccbase/master/include
	export MPL_INCLUDE_PATH=~/projects/c++/mpl/include
	export BOOST_INCLUDE_PATH=/opt/local/include
	export OPENCV2_INCLUDE_PATH=/opt/local/include
	export EIGEN3_INCLUDE_PATH=/opt/local/include/eigen3

	# Compilers.
	export GCC="gcc-mp-4.8"
	export CLANG="clang-mp-3.4"
	export GPLUSPLUS="g++-mp-4.8"
	export CLANGPLUSPLUS="clang++-mp-3.4 -stdlib=libc++"
	export CXX=$CLANGPLUSPLUS

	# Interpreters.
	export RUBY=ruby2.0
elif [[ $platform == "linux" ]]; then
	#export PATH=
	#export TEXMFHOME=
	export CCBASE_INCLUDE_PATH=~/projects/ccbase/include
	export MPL_INCLUDE_PATH=~/projects/mpl/include
	export BOOST_INCLUDE_PATH=/usr/include
	#export OPENCV2_INCLUDE_PATH=
	#export EIGEN3_INCLUDE_PATH=

	# Compilers.
	export GCC="gcc"
	export CLANG="clang"
	export GPLUSPLUS="g++"
	export CLANGPLUSPLUS="clang++"
	export CXX=$CLANGPLUSPLUS

	# Interpreters.
	export RUBY=ruby
fi

#
# Bash aliases.
#

if [[ $platform == "os x" ]]; then
	# System commands.
	alias ls="ls -G"
	alias grep="grep --color=auto"
	alias port="sudo port"

	# Compilers and Interpreters.
	alias gdb="ggdb"
	alias gcc=$GCC
	alias g++=$GPLUSPLUS
	alias clang=$CLANG
	alias clang++=$CLANGPLUSPLUS
	alias scan-build="scan-build-mp-3.4"
	alias scan-view="scan-view-mp-3.4"
	alias ruby="ruby2.0"
	#alias irb="irb1.8"
	alias rake="rake-1.8"
	alias pip="sudo pip-3.4"
	alias ipython="ipython-3.4"
	alias ipn="ipython-3.4 notebook --pylab inline"

	# Applications.
	alias matlab="sudo matlab"
	alias clmatlab="sudo matlab -nodisplay -nojvm" 
	alias evince="open -a \"Preview\" "
	alias preview="open -a \"Preview\" "
	alias safari="open -a \"Safari\" "
	alias block="sudo block"
	alias unblock="sudo unblock"
	alias iphone="open -a \"iPhone Simulator\""
elif [[ $platform == "linux" ]]; then
	# System commands.
	alias ls="ls --color"
	alias grep="grep --color=auto"
	alias apt-get="sudo apt-get"

	# Compilers and Interpreters.
	alias nasm="nasm"
	alias gdb="gdb"
	alias gcc=$GCC
	alias g++=$GPLUSPLUS
	alias clang=$CLANG
	alias clang++=$CLANGPLUSPLUS
	alias ruby="ruby"
	alias irb="irb"
	alias rake="rake"
	alias python="python3"
	alias pip="pip3"

	# Applications
	alias vim=~/local/bin/vim
fi

#
# General options.
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
# Utility functions.
#

# Input file separators.
IFS=$(echo -en "\n\b")
