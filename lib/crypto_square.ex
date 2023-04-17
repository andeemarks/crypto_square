defmodule CryptoSquare do
  @moduledoc """
  Documentation for `CryptoSquare`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> CryptoSquare.hello()
      :world

  """
  def encrypt() do
    receive do
      {plaintext} ->
        IO.puts("CryptoSquare#encrypt#1")
        normaliser = spawn(Normaliser, :run, [])
        send(normaliser, {self(), plaintext})
        encrypt()

      {_, :normal_plaintext, normal_plaintext} ->
        IO.puts("CryptoSquare#encrypt#2")
        row_length = spawn(RowLength, :run, [])
        send(row_length, {self(), normal_plaintext})
        encrypt()

      {_, :row_length, normal_plaintext, row_length} ->
        IO.puts("CryptoSquare#encrypt#3")
        ciphertext = encrypt(normal_plaintext, row_length)
        IO.puts(ciphertext)
        encrypt()
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
