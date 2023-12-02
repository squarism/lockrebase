function lockrebase

  # locals
  set -l print_only 0
  set -l main_branch "main"
  
  for arg in $argv
    switch $arg
      case '--print-only'
        set print_only 1
      case '--main'
        set main_branch (string replace -- '--main=' '' -- $arg)
      case '--help'
        echo "lockrebase: A tool to manage package lock files during git rebase."
        echo "Usage: lockrebase <package manager> [flags]"
        echo ""
        echo "Supported package managers:"
        
        echo "  bundler  - Ruby's package manager."
        # echo "  cargo    - Rust's package manager."
        # echo "  composer - PHP's package manager."
        # echo "  mix      - Elixir's package manager."
        echo "  npm      - NodeJS's package manager."
        echo "  poetry   - Python's package manager."
        echo "  yarn     - NodeJS's package manager."
        
        echo ""
        echo "Flags:"
        echo "  --help   - This output."
        echo ""
        echo "Example:"
        echo "  To resolve `yarn.lock` from main for a Yarn project:"
        echo ""
        echo "    lockrebase yarn"
        return 0
    end
  end
  
  # remove options from arguments
  set argv (string match -vr -- '--.*' -- $argv)

  # validation
  if test (count $argv) -eq 0
    echo "Please specify a package manager (e.g., npm, poetry, cargo)"
    return 1
  end
  
  # flags after validation
  set package_manager $argv[1]
  set command ""

  switch $package_manager
    case bundler
      set command "git checkout $main_branch -- Gemfile.lock; bundle install; git add Gemfile.lock; git rebase --continue"
  
    # cargo
    
    # composer
    
    # mix
  
    case npm
      set command "git checkout $main_branch -- package-lock.json; npm install; git add package-lock.json; git rebase --continue"

    case poetry
      set command "git checkout $main_branch -- poetry.lock; poetry install; git add poetry.lock; git rebase --continue"

    case yarn
      set command "git checkout $main_branch -- yarn.lock; yarn install; git add yarn.lock; git rebase --continue"
    
    case '*'
      echo "Unsupported package manager: $package_manager"
      return 1
  end
  
  
  # print mode only
  if test $print_only -eq 1
    echo $command
    return 0
  end

  # execute  
  eval $command
end
