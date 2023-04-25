defmodule Encrypt do
  def run do
    receive do
      {sender, text, row_length} ->
        send(sender, {self(), :ciphertext, encrypt(text, row_length)})
    end
  end

  def encrypt(_, 0), do: ""

  def encrypt(text, row_length) do
    text
    |> size_to_rectangle(row_length)
    |> break_into_rows(row_length)
    |> rows_to_rectangle
  end

  @spec size_to_rectangle(String.t(), integer) :: String.t()
  def size_to_rectangle(text, row_length) do
    rectangle_size = round_up(String.length(text) / row_length) * row_length

    String.pad_trailing(text, rectangle_size)
  end

  defp break_into_rows(text, row_length) do
    text
    |> String.codepoints()
    |> Enum.chunk_every(row_length)
  end

  defp rows_to_rectangle(text) do
    text
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.join(" ")
  end

  defp round_up(n), do: trunc(Float.ceil(n))
end
