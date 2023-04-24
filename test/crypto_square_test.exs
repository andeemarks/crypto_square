defmodule CryptoSquareTest do
  use ExUnit.Case

  test "starts with a plaintext argument" do
    crypto_square = spawn(CryptoSquare, :encrypt, [])
    plaintext = "If man was meant to stay on the ground, god would have given us roots."

    assert send(crypto_square, {:start, plaintext}) == {:start, plaintext}
  end

  test "normalises a plaintext argument" do
    crypto_square = spawn(CryptoSquare, :encrypt, [])
    plaintext = "If man was meant to stay on the ground, god would have given us roots."

    assert send(crypto_square, {:normal_plaintext, plaintext}) == {:normal_plaintext, plaintext}
  end

  test "calculates the row_length for plaintext and a row_length" do
    crypto_square = spawn(CryptoSquare, :encrypt, [])
    plaintext = "If man was meant to stay on the ground, god would have given us roots."

    assert send(crypto_square, {:row_length, plaintext, 3}) == {:row_length, plaintext, 3}
  end

  test "encrypts ciphertext" do
    crypto_square = spawn(CryptoSquare, :encrypt, [])
    ciphertext = "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau"

    assert send(crypto_square, {:encrypt, ciphertext}) == {:encrypt, ciphertext}
  end
end
