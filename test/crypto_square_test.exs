defmodule CryptoSquareTest do
  use ExUnit.Case

  setup _context do
    {:ok,
     [
       cs: spawn(CryptoSquare, :encrypt, []),
       plaintext: "If man was meant to stay on the ground, god would have given us roots."
     ]}
  end

  test "starts with a plaintext argument", context do
    assert send(context[:cs], {:plaintext, context[:plaintext]}) ==
             {:plaintext, context[:plaintext]}
  end

  test "receives a normalised plaintext", context do
    assert send(context[:cs], {:normal_plaintext, context[:plaintext]}) ==
             {:normal_plaintext, context[:plaintext]}
  end

  test "receives a calculated row_length for plaintext", context do
    assert send(context[:cs], {:row_length, context[:plaintext], 3}) ==
             {:row_length, context[:plaintext], 3}
  end

  test "receives an encrypted ciphertext", context do
    ciphertext = "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau"

    assert send(context[:cs], {:ciphertext, ciphertext}) == {:ciphertext, ciphertext}
  end
end
