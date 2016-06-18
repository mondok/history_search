use Timex

defmodule HistoryDatabase do
  def new(file) do
    spawn fn -> loop(create_database(file)) end
  end

  def create_database(file) do
    file |> read_file |> parse
  end

  def read_file(file) do
    path = Path.expand(file)
    {:ok, file} =  File.read path
    file
  end

  def parse(contents) do
    rows = String.split(contents, "\n") |> Enum.map(
          fn line ->
            split_line(line)
          end
        ) |> Enum.reject(
              fn {_, _, content} ->
                content == nil
              end
            )
  end

  def split_line(line) do
    line |> String.split(";") |> create_record
  end

  def create_record(split_line) do
    timestamp =  Enum.at(split_line, 0)
      |> String.split(":", trim: true)
      |> Enum.at(0)
      |> StringHelpers.trim
      |> Integer.parse
      |> TimeConvert.from_timestamp

    {:record, timestamp, Enum.at(split_line, 1)}
  end

  def search(pid, term) do
    send(pid, {:search, term, self()})
    receive do x -> x end
  end

  def search_database(term, recs) do
    recs |>
      Enum.filter(fn {_, _, content} -> match(content, term) end)
  end

  def match(content, term) do
    func = fn(c) -> c |> String.downcase |> String.strip |> String.replace(" ", "") end
    cmd = func.(content)
    ptrn = func.(term)
    String.contains?(cmd, ptrn)
  end

  defp loop(data) do
    receive do
      {:search, term, from} ->
        send(from, :ok)
        loop(data)
    end
  end
end
