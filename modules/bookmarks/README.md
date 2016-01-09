Bookmarks
=========

Thanks Vincent Bernat and his [wonderful article][1] and the implementation in
his [zshrc repository][2], this module allows static bookmarks: defining a
named directory and accessing it by prepending it by '~'. All names are also
prefixed by '-' for convention and to avoid collision.

Functions
---------

- `bookmark` manages bookmarks:
  - Display all bookmarks if no argument is given
  - If a name is given, create a bookmark to the current location with the
	given name
  - If `-d` and a name is given, delete the given bookmark

Customizations
--------------

- The `MARKPATH` variable to point to a directory where you want to store the
  bookmarks (defaults to `$HOME/.zsh-bookmarks`).
- The `MARKPREFIX` variable tells which string will prefix the bookmarks
  (defaults to `-`).

Authors
-------

  - [Vincent Bernart](https://github.com/vincentbernat/zshrc)
  - [Minijackson](https://github.com/minijackson/prezto)

[1]: http://vincent.bernat.im/en/blog/2015-zsh-directory-bookmarks.html
[2]: https://github.com/vincentbernat/zshrc/blob/master/rc/bookmarks.zsh
