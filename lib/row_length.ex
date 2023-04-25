defmodule RowLength do
  def run() do
    receive do
      {sender, text} ->
        # IO.puts("RowLength#run")
        send(sender, {self(), :row_length, text, row_length(text)})
    end

    run()
  end

  @spec row_length(String.t()) :: integer
  def row_length(text) do
    text
    |> String.length()
    |> :math.sqrt()
    |> round_up
  end

  defp round_up(n), do: trunc(Float.ceil(n))
end
