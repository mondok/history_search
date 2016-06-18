use Timex
defmodule TimeConvert do
  epoch = {{1970, 1, 1}, {0, 0, 0}}
  @epoch :calendar.datetime_to_gregorian_seconds(epoch)

  def from_timestamp({timestamp, _}) do
    {:ok, t} = timestamp
          |> +(@epoch)
          |> :calendar.gregorian_seconds_to_datetime
          |> Date.from
          |> Timex.format("%D", :strftime)
    t
  end

  def from_timestamp(:error) do
    "--"
  end

end
