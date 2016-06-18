defmodule HistorySearch do
  def main(args) do
    args |> parse_args |> parse_search
  end

  def parse_search(options) do
    IO.puts "Search for #{options[:term]}"
    options[:term] |> search
  end

  def search(nil) do
    IO.puts "Term cannot be nil"
  end

  def search(search_term) do
    pid = HistoryDatabase.new(path_to_use)
    res = HistoryDatabase.search(pid, search_term)
    IO.puts StringHelpers.pretty_print(res)
  end

  def path_to_use do
    zsh = Path.expand("~/.zsh_history")
    bash = Path.expand("~/.bash_history")
    if File.exists?(zsh) do
      zsh
    else
      bash
    end
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [term: :string]
    )
    options
  end
end
