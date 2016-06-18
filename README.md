# Bash/ZSH history search helper
While this can be done simply by grepping your history, this makes life a bit easier by formatting the output.  It searches `zsh_history` or `bash_history`.  At the moment, it defaults to `zsh_history` if avaibable, otherwise falls back to `bash_history`.  You can pass in your own file with the `--file` parameter.

## Requirements

1. Erlang as this uses escript to create the executable.

## Installation

 1. Copy `/bin/history_search` to your PATH

## Usage
The `command` parameter is the term that you'd like to search for:

    history_search --command=ls

Use quotes to deal with spaces:

    history_search --command="ls -la"

Pass in your own history file:

    history_search --command="ls -la" --file="something.txt"

## Building
`Make` copies the binary to the `bin` folder.    

## Running tests
    mix test
