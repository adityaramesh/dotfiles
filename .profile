#
# File Name:	.profile
# Author:	Aditya Ramesh
# Date:		08/19/2013
# Contact:	_@adityaramesh.com
#
# On development machines, create a symbolic link in the home directory to this
# file.
#

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
	export PATH=~/utilities:/opt/local/bin:/Applications/MATLAB_R2012a_Student.app/bin:$PATH
	export TEXMFHOME=~/Library/texmf
	export CCBASE_INCLUDE_PATH=~/projects/c++/ccbase
	export MPL_INCLUDE_PATH=/projects/c++/mpl
	export BOOST_INCLUDE_PATH=/opt/local/include
	export OPENCV2_INCLUDE_PATH=/opt/local/include
	export EIGEN3_INCLUDE_PATH=/opt/local/include/eigen3

	# Compilers.
	export GCC="gcc-mp-4.8"
	export CLANG="clang-mp-3.3"
	export GPLUSPLUS="g++-mp-4.8"
	export CLANGPLUSPLUS="clang++-mp-3.3 -stdlib=libc++"
	export CXX=$CLANGPLUSPLUS

	# Interpreters.
	export RUBY=ruby2.0
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
	alias nasm="/opt/local/bin/nasm"
	alias gdb="gdb"
	alias gcc=$GCC
	alias g++=$GPLUSPLUS
	alias clang=$CLANG
	alias clang++=$CLANGPLUSPLUS
	alias ruby="ruby2.0"
	alias irb="irb2.0"
	alias rake="rake2.0"

	# Applications.
	alias matlab="sudo matlab"
	alias clmatlab="sudo matlab -nodisplay -nojvm" 
	alias evince="open -a \"Preview\" "
	alias preview="open -a \"Preview\" "
	alias safari="open -a \"Safari\" "
	alias block="sudo block"
	alias unblock="sudo unblock"
	alias iphone="open -a \"iPhone Simulator\""
fi

#
# General options.
#

set -o vi

#
# Utility functions.
#

# Input file separators.
IFS=$(echo -en "\n\b")

# Recursively downloads all of the files from a given directory over HTTP; if a
# glob is specified in the string, no recursion past the specified directory
# level is performed. The "--no-parent" flag is enabled, so that files that are
# not in subdirectories of the specified directory are not downloaded.
rget()
{
	if [[ "$1" == *"*"* ]]; then
		# Strips out the glob from the URL, e.g. "foo/bar/*.ext" becomes
		# "foo/bar".
		url=${1%/*}
		# To get the extension in a separate string, we compute the
		# length $n$ of the URL and extract the last $n+2$ characters
		# from the original string. This is an ugly hack, but I could
		# not find a better way to do it without using external
		# utilities.
		len=${#url}
		ext=${1:len+2}
		wget -r --no-parent -l1 -A.${ext} ${url}
	else
		wget -r --no-parent -l1 $1
	fi
}

#
# Random notes
#

# for i in $(ls); do mv "$i" "${i##*Bach_ }"; done
# for i in $(ls); do mv "$i" "${i/_/}"; done
#
# To list old files not in the working branch but that have not been removed
# from the remote repository.
# 	git status --porcelain
#
# Extracting part of a video using FFmpeg:
#	ffmpeg -ss 00:00:30 -t 00:00:05 -i orginalfile -vcodec copy -acodec copy newfile
# The value after the `-t` flag is the duration, not the end time.

##
# Your previous /Users/aditya/.profile file was backed up as /Users/aditya/.profile.macports-saved_2013-11-04_at_06:31:05
##

# MacPorts Installer addition on 2013-11-04_at_06:31:05: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

