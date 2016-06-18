defmodule HistorySearch do
  def main(args) do
    args |> parse_args |> parse_search
  end

  def parse_search(options) do
    h = HistoryDatabase.new
    IO.puts "Hello #{options[:term]}"
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [term: :string]
    )
    options
  end
end
