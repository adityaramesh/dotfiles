<!--
  ** File Name:	shell_notes.md
  ** Author:	Aditya Ramesh
  ** Date:	06/17/2014
  ** Contact:	_@adityaramesh.com
-->

# Renaming Files

Even simple renaming in Bash is painful:

	for i in $(ls); do mv "$i" "${i##*Bach_ }"; done
	for i in $(ls); do mv "$i" "${i/_/}"; done

This is easily done in ZSH using captures (TODO fill in details).

# FFmpeg

## Extracting Part of a Video

Note that in the following example, the the value after the `-t` flag is the
duration, not the end time.

	ffmpeg -ss 00:00:30 -t 00:00:05 -i <orginalfile> -vcodec copy -acodec copy <newfile>

# Git Usage

## Showing Uncommitted Removals

To list old files that are not in the working branch and have not been removed
from the remote repository, use the following:

	git status --porcelain
