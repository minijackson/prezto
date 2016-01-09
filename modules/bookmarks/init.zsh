# -*- sh -*-

# Source: https://github.com/vincentbernat/zshrc/blob/master/rc/bookmarks.zsh

# Handle bookmarks. This uses the static named directories feature of
# zsh. Such directories are declared with `hash -d
# name=directory`. Both prompt expansion and completion know how to
# handle them. We populate the hash with directories.
#
# With autocd, you can just type `~-bookmark`. Since this can be
# cumbersome to type, you can also type `@@` and this will be turned
# into `~-` by ZLE.

# Minijackson's edits:
# - Removing zsh version check
# - Adapting MARKPATH
# - Adding a MARKPREFIX to customize the name directory's prefix
# - Added some quoting to prevent word splitting (thanks shellcheck)
# - Wrapping the bookmark reloading in a function
# - Some variables that should be local
# - Remove/add the bookmarks in the hash table when editing with the `bookmark` function

MARKPATH=${MARKPATH:-"$HOME/.zsh-bookmarks"}
MARKPREFIX=${MARKPREFIX:-"-"}

bookmarks-reload() {
	[[ -d "$MARKPATH" ]] || mkdir -p "$MARKPATH"

	local link
	# Populate the hash
	for link in $MARKPATH/*(N@); do
		hash -d -- "-${link:t}=${link:A}"
	done
} && bookmarks-reload

vbe-insert-bookmark() {
	emulate -L zsh
	LBUFFER=${LBUFFER}"~$MARKPREFIX"
}

zle -N vbe-insert-bookmark
# Doesn't work for me? Maybe because of vi-style keybindings?
bindkey '@@' vbe-insert-bookmark

# Manage bookmarks
bookmark() {
	[[ -d "$MARKPATH" ]] || mkdir -p "$MARKPATH"

	if (( $# == 0 )); then
		local link
		# When no arguments are provided, just display existing
		# bookmarks
		for link in $MARKPATH/*(N@); do
			local markname="$fg[green]${link:t}$reset_color"
			local markpath="$fg[blue]${link:A}$reset_color"
			printf "%-30s -> %s\n" "$markname" "$markpath"
		done
	else

		# Otherwise, we may want to add a bookmark or delete an
		# existing one.
		local -a delete
		zparseopts -D d=delete

		if (( $+delete[1] )); then
			# With `-d`, we delete an existing bookmark
			command rm "$MARKPATH/$1"
			unhash -d -- "$MARKPREFIX$1"
		else
			# Otherwise, add a bookmark to the current
			# directory. The first argument is the bookmark
			# name. `.` is special and means the bookmark should
			# be named after the current directory.
			local name=$1
			[[ $name == "." ]] && name=${PWD:t}
			ln -s "$PWD" "$MARKPATH/$name"
			hash -d -- "$MARKPREFIX$name=$PWD"
		fi

	fi
}
