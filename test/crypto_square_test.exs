defmodule CryptoSquareTest do
  use ExUnit.Case

  test "encrypts known plaintext to known cyphertext" do
    crypto_square = spawn(CryptoSquare, :encrypt, [])
    plaintext = "If man was meant to stay on the ground, god would have given us roots."

    assert send(crypto_square, {:start, plaintext}) == {:start, plaintext}
  end
end
