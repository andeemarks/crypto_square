require Logger

defmodule CryptoSquare do
  use Task

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
  def encrypt(plaintext) do
    Logger.debug("CryptoSquare#plaintext: #{plaintext}")
    normaliser = spawn(Normaliser, :run, [])
    send(normaliser, {self(), plaintext})

    encrypt()
  end

  def encrypt() do
    receive do
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
        Logger.debug("Ciphertext: #{ciphertext}")

        {:ciphertext, ciphertext}
    end
  end
end
