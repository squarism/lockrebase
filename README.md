# Lock Rebase

Have you ever been on a feature branch that adds a package?  When you check out main, someone else has too?  And now your lock file has conflicts and Git is mad and angry?

Well, this project is for you.  It's a shell helper that resolves your lock file and continues.


## Installation

### Fish

You can use [fisher](https://github.com/jorgebucaran/fisher) to install `lockrebase`:

```
fisher install squarism/lockrebase
```


## Usage

You use this command when all other commands are finished and you want to resolve your lock file.  For example, you have already rebased package.json but `package-lock.json` is still conflicted:

```
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   package.json

Unmerged paths:
  (use "git restore --staged <file>..." to unstage)
  (use "git add <file>..." to mark resolution)
	both modified:   package-lock.json
```
Now you resolve `package-lock.json` using `lockrebase`.  `lockrebase` only deals with the lockfile.


```
lockrebase yarn
```
After confirmation, this effectively will do `git checkout origin/main -- yarn.lock; yarn install; git add yarn.lock; git rebase --continue`.  Lockrebase support a few flags

This shell helper includes autocomplete for the package manager it knows about and extra option flags.  See `--help` for a full list.  Here are a sampling of flags `lockrebase` has.

```
--print-only      Prints the command to be run but does not execute it
--main=[branch]   Overrides the remote branch.  Default: origin/main
```

These flags are also covered by autocomplete, so after installing `lockrebase` and the autocomplete helper, hit `[tab][tab]` after typing `lockrebase`.


The following package managers are known:

* Bundler - `Gemfile.lock`
* Cargo - `Cargo.lock`
* Composer - `composer.lock`
* Mix - `mix.lock`
* NPM - `package-lock.json`
* Poetry - `poetry.lock`
* Yarn - `yarn.lock`

If yours is not listed, you could use `--print-only` to help you construct a command.


## Why

If you are on a branch that has modified the lock file and someone else has done the same on main, you need to replay your commits on top of main and basically throw away your current lockfile and recreate it.  This process works most of the time because you are putting your package on top of what is in main in the declarative file but the lock file is the problem.  Here is an example.

Your branch
```
{
  "dependencies": {
    "a": "1.0.0"
  }
}
```

But on main someone added "b".
```
{
  "dependencies": {
    "b": "1.0.0"
  }
}
```

These two changes go together without conflict on `package.json` but the lock file derived from this change conflicts.  What you need to do is take main's lockfile which includes "b" and then add "a" to it.  That's what this shell helper does but you don't have to remember all the commands all around your package manager commands.


## License

MIT
