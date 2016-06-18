defmodule HistorySearch do
  def main(args) do
    args |> parse_args |> parse_search
  end

  def parse_search(options) do
    IO.puts "Search for #{options[:command]}"
    search(options[:command], options[:file])
  end

  def search(nil, file_path) do
    IO.puts "Term cannot be nil"
  end

  def search(search_command, nil) do
    search(search_command, path_to_use)
  end

  def search(search_command, file_path) do
    pid = HistoryDatabase.new(file_path)
    res = HistoryDatabase.search(pid, search_command)
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
      switches: [command: :string]
    )
    options
  end
end
