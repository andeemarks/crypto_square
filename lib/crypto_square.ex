require Logger

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
        Logger.debug("CryptoSquare#start: #{plaintext}")
        normaliser = spawn(Normaliser, :run, [])
        send(normaliser, {self(), plaintext})
        encrypt()

      {_, :normal_plaintext, normal_plaintext} ->
        Logger.debug("CryptoSquare#normal_plaintext: #{normal_plaintext}")
        row_length = spawn(RowLength, :run, [])
        send(row_length, {self(), normal_plaintext})
        encrypt()

      {_, :row_length, normal_plaintext, row_length} ->
        Logger.debug("CryptoSquare#row_length: #{normal_plaintext}, #{row_length}")
        encrypter = spawn(Encrypt, :run, [])
        send(encrypter, {self(), normal_plaintext, row_length})
        encrypt()

      {_, :encrypt, ciphertext} ->
        Logger.debug("CryptoSquare#encrypt: #{ciphertext}")
        Logger.info("Ciphertext: #{ciphertext}")
        encrypt()
    end
  end
end
