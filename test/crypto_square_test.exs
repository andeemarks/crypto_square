defmodule CryptoSquareTest do
  use ExUnit.Case

  @tag :pending
  test "encrypts known plaintext to known cyphertext" do
    assert CryptoSquare.encrypt(
             "If man was meant to stay on the ground, god would have given us roots."
           ) ==
             "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "
  end
end
