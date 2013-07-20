# rprompt

Pimp your prompt :-)

This prompt is a shameless port (and enhancement) of the "Informative git prompt for bash and fish" which you can find [here](https://github.com/magicmonty/bash-git-prompt.git)

This gem is targeted toward users who use ruby, rvm and git. It will improve your ``bash`` prompt by displaying information about the current git repository or the rvm ruby version and gemset.

## Usage

The prompt is customizable via a yaml file that enables you to:

* choose the options you want to see
* set your standard unix prompt
* set your git prompt
* set your rvm prompt
* change the layout of what goes where
* change the symbols to identify options
* change colors (all colors provided by the term-ansicolor gem)

Using the layout is actually very easy: throw the name of the options around, add white spaces, delimiters, etc... Save, hit enter in your shell, done!

### Git examples

The prompt may look like the following:

* ``(master↑3|✚1)``: on branch ``master``, ahead of remote by 3 commits, 1 file changed but not staged
* ``(status|●2)``: on branch ``status``, 2 files staged
* ``(master|✚7…)``: on branch ``master``, 7 files changed, some files untracked
* ``(master|✖2✚3)``: on branch ``master``, 2 conflicts, 3 files changed
* ``(experimental↓2↑3|✔)``: on branch ``experimental``; your branch has diverged by 3 commits, remote by 2 commits; the repository is otherwise clean

The symbols are as follows:

- Local Status Symbols
  - ``✔``: repository clean
  - ``●n``: there are ``n`` staged files
  - ``✖n``: there are ``n`` unmerged files
  - ``✚n``: there are ``n`` changed but *unstaged* files
  - ``…n``: there are ``n`` untracked files
- Branch Tracking Symbols
  - ``↑n``: ahead of remote by ``n`` commits
  - ``↓n``: behind remote by ``n`` commits

### Rvm examples

* ∆1.9.3-p448: ruby version 1.9.3
* ›global: using the global gemset

## Installation

	$ gem install rprompt

Once the gem is installed,

	$ rpromptconf

This will provide a standard config file: ```$HOME/.rprompt/config.yml```

To make the magic happen:

* edit your ~/.bashrc or ~/.bash_profile
(depending on your preferences and setup)
* if you're setting PS1 already, comment it while you're using rprompt
* paste the following lines between '---' at the end of the file

		---
		# Setting terminal promt with rprompt gem
		PROMPT_COMMAND="$PROMPT_COMMAND PS1=\"\$(rprompt)\";"
		---

* quit your terminal and re-open it for the change to take effect.

Edit $HOME/.rprompt/config.yml to change the configuration.
(you can always re-install the default configuration by issuing 'rpromptconf')

Enjoy :\))