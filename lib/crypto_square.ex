require Logger

defmodule CryptoSquare do
  @moduledoc """
  Documentation for `CryptoSquare`.
  """

  @doc """
  ## Examples

      iex> crypto_square = spawn(CryptoSquare, :encrypt, [])

    send(
      crypto_square,
      {:start, "If man was meant to stay on the ground, god would have given us roots."}
    )
     
  """
  def encrypt() do
    receive do
      {:plaintext, plaintext} ->
        Logger.debug("CryptoSquare#plaintext: #{plaintext}")
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

      {_, :ciphertext, ciphertext} ->
        Logger.debug("CryptoSquare#ciphertext: #{ciphertext}")
        Logger.info("Ciphertext: #{ciphertext}")

      _ ->
        raise "Unexpected message received"
    end
  end
end
