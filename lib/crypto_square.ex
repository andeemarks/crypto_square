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
      {:start, plaintext} ->
        # IO.puts("CryptoSquare#encrypt#1")
        normaliser = spawn(Normaliser, :run, [])
        send(normaliser, {self(), plaintext})
        encrypt()

      {_, :normal_plaintext, normal_plaintext} ->
        # IO.puts("CryptoSquare#encrypt#2")
        row_length = spawn(RowLength, :run, [])
        send(row_length, {self(), normal_plaintext})
        encrypt()

      {_, :row_length, normal_plaintext, row_length} ->
        # IO.puts("CryptoSquare#encrypt#3")
        encrypter = spawn(Encrypt, :run, [])
        send(encrypter, {self(), normal_plaintext, row_length})
        # ciphertext = encrypt(normal_plaintext, row_length)
        encrypt()

      {_, :encrypt, ciphertext} ->
        # IO.puts("CryptoSquare#encrypt#4")
        IO.puts("Ciphertext: #{ciphertext}")
        encrypt()
    end
  end
end
