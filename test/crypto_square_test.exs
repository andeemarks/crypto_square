defmodule CryptoSquareTest do
  use ExUnit.Case

  @tag :pending
  test "encrypts known plaintext to known cyphertext" do
    assert CryptoSquare.encrypt(
             "If man was meant to stay on the ground, god would have given us roots."
           ) ==
             "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "
  end

  test "row length for empty string is 0" do
    assert CryptoSquare.row_length("") == 0
  end

  test "row length for string length that is a perfect square is the corresponding square root" do
    assert CryptoSquare.row_length("a") == 1
    assert CryptoSquare.row_length("abcd") == 2
    assert CryptoSquare.row_length("abcdefghi") == 3
    assert CryptoSquare.row_length("abcdefghijklmnop") == 4
  end

  test "row length for string length that is not a perfect square is larger than the corresponding root" do
    assert CryptoSquare.row_length("abc") == 2
    assert CryptoSquare.row_length("abcdef") == 3
    assert CryptoSquare.row_length("abcdefghijklmno") == 4
    assert CryptoSquare.row_length("abcdefghijklmnopqrst") == 5

    assert CryptoSquare.row_length("ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots") ==
             8
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
