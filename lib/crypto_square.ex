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
        # IO.puts("CryptoSquare#encrypt#1")
        normaliser = spawn(Normaliser, :run, [])
        # normal_plaintext = Normaliser.normalise(plaintext)
        send(normaliser, {self(), plaintext})
        encrypt()

      {_, normal_plaintext} ->
        # IO.puts("CryptoSquare#encrypt#2")
        row_length = row_length(normal_plaintext)

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

  @spec row_length(String.t()) :: integer
  def row_length(text) do
    text
    |> String.length()
    |> :math.sqrt()
    |> round_up
  end

  defp round_up(n), do: trunc(Float.ceil(n))
end
