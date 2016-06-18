defmodule StringHelpers do
  def trim(nil) do trim("0") end

  def trim(str) do str |> String.strip end

  def match_content(nil, _) do false end

  def match_content(content, term) do
    func = fn(c) -> c |> String.downcase |> String.strip |> String.replace(" ", "") end
    cmd = func.(content)
    ptrn = func.(term)
    String.contains?(cmd, ptrn)
  end

  def pretty_print({:ok, recs}) do
    recs |> Enum.map(fn {:record, ts, cmd} ->
      "#{ts}: #{cmd}"
    end) |> Enum.join("\n")
  end
end
