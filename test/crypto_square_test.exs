defmodule CryptoSquareTest do
  use ExUnit.Case

  @tag :pending
  test "encrypts known plaintext to known cyphertext" do
    assert CryptoSquare.encrypt(
             "If man was meant to stay on the ground, god would have given us roots."
           ) ==
             "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "
  end

  test "right sizing text ensures the length evenly fits a rectangle" do
    assert CryptoSquare.size_to_rectangle("ab", 2) == "ab"
    assert CryptoSquare.size_to_rectangle("abcde", 3) == "abcde "
  end

  test "encoding an array of strings is top-to-bottom, left-to-right" do
    assert CryptoSquare.encrypt("ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots", 8) ==
             "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "

    assert CryptoSquare.encrypt("abcd", 2) == "ac bd"
    assert CryptoSquare.encrypt("abcde", 3) == "ad be c "
  end
end
