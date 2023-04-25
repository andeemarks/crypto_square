defmodule CryptoSquareTest do
  use ExUnit.Case

  setup _context do
    {:ok, [cs: spawn(CryptoSquare, :encrypt, [])]}
  end

  test "starts with a plaintext argument", context do
    plaintext = "If man was meant to stay on the ground, god would have given us roots."

    assert send(context[:cs], {:start, plaintext}) == {:start, plaintext}
  end

  test "normalises a plaintext argument", context do
    plaintext = "If man was meant to stay on the ground, god would have given us roots."

    assert send(context[:cs], {:normal_plaintext, plaintext}) == {:normal_plaintext, plaintext}
  end

  test "calculates the row_length for plaintext and a row_length", context do
    plaintext = "If man was meant to stay on the ground, god would have given us roots."

    assert send(context[:cs], {:row_length, plaintext, 3}) == {:row_length, plaintext, 3}
  end

  test "encrypts ciphertext", context do
    ciphertext = "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau"

    assert send(context[:cs], {:encrypt, ciphertext}) == {:encrypt, ciphertext}
  end
end
