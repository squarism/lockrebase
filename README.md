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

```
lockrebase: A tool to manage package lock files during git rebase.
Usage: lockrebase <package manager> [flags]

Supported package managers:
  bundler  - Ruby's package manager.
  npm      - NodeJS's package manager.
  poetry   - Python's package manager.
  yarn     - NodeJS's package manager.

Flags:
  --help   - This output.

Example:
  To resolve `yarn.lock` from main for a Yarn project:

    lockrebase yarn
```


## Details

This example show how this works with NPM but other package managers are known.

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
Now you resolve `package-lock.json` using `lockrebase npm`.  `lockrebase` only deals with the lockfile as the
last step, the other files you have to resolve yourself.

If you want to do it yourself then you can do this:
```
lockrebase --print-only npm
git checkout main -- package-lock.json; npm install; git add package-lock.json; git rebase --continue
```


`lockrebase` includes autocomplete for the flags and the package manager.  Hit `[tab][tab]` after typing
`lockrebase` to explore.

```
--print-only  (Prints the command to be run but does not execute it)
--main        (Overrides the remote branch. Default: origin/main)
--help        (Show help information)
```


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
