# autocompletions for the package manager main argument
complete -f -c lockrebase -n "__fish_use_subcommand" -a bundler -d "Resolve Gemfile.lock"
complete -f -c lockrebase -n "__fish_use_subcommand" -a cargo -d "Resolve Cargo.lock"
complete -f -c lockrebase -n "__fish_use_subcommand" -a composer -d "Resolve composer.lock"
complete -f -c lockrebase -n "__fish_use_subcommand" -a mix -d "Resolve mix.lock"
complete -f -c lockrebase -n "__fish_use_subcommand" -a npm -d "Resolve package-lock.json"
complete -f -c lockrebase -n "__fish_use_subcommand" -a poetry -d "Resolve poetry.lock"
complete -f -c lockrebase -n "__fish_use_subcommand" -a yarn -d "Resolve yarn.lock"

# autocomplete for --print-only flag
complete -f -c lockrebase -l print-only -d "Prints the command to be run but does not execute it"

# autocomplete for --main flag
# complete -c lockrebase -l main -d "Overrides the remote branch. Default: origin/main"
complete -f -c lockrebase -l main -d "Overrides the remote branch. Default: origin/main" -xa "(__fish_no_arguments)"

# autocomplete for --help flag
complete -f -c lockrebase -l help -d "Show help information"
