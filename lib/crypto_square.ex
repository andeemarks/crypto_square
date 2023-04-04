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
  def encrypt(plaintext) do
    plaintext
  end

  def normalise(plaintext) do
    String.replace(String.downcase(plaintext), " ", "")
  end

  def row_length_for(text) do
    Float.ceil(:math.sqrt(String.length(text)))
  end

  def encode(square) do
    square
  end
end
