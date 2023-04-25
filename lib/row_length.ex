defmodule RowLength do
  def run() do
    receive do
      {sender, text} ->
        send(sender, {self(), :row_length, text, row_length(text)})
    end

    run()
  end

  defp row_length(text) do
    text
    |> String.length()
    |> :math.sqrt()
    |> round_up
  end

  defp round_up(n), do: trunc(Float.ceil(n))
end
