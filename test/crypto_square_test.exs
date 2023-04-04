defmodule CryptoSquareTest do
  use ExUnit.Case

  test "encrypts known plaintext to known cyphertext" do
    assert CryptoSquare.encrypt(
             "If man was meant to stay on the ground, god would have given us roots."
           ) ==
             "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "
  end

  test "normalising lower case single words does nothing" do
    assert CryptoSquare.normalise("foo") == "foo"
  end

  test "normalising mixed case words converts to lower case" do
    assert CryptoSquare.normalise("Foo") == "foo"
  end

  test "normalising multiple words removes spaces" do
    assert CryptoSquare.normalise(" Foo bar ") == "foobar"
  end

  test "row length for empty string is 0" do
    assert CryptoSquare.row_length_for("") == 0
  end

  test "row length for string length that is a perfect square is the corresponding square root" do
    assert CryptoSquare.row_length_for("a") == 1
    assert CryptoSquare.row_length_for("abcd") == 2
    assert CryptoSquare.row_length_for("abcdefghi") == 3
    assert CryptoSquare.row_length_for("abcdefghijklmnop") == 4
  end

  test "row length for string length that is not a perfect square is larger than the corresponding root" do
    assert CryptoSquare.row_length_for("abc") == 2
    assert CryptoSquare.row_length_for("abcdef") == 3
    assert CryptoSquare.row_length_for("abcdefghijklmno") == 4
    assert CryptoSquare.row_length_for("abcdefghijklmnopqrst") == 5
  end

  test "encoding an array of strings is top-to-bottom, left-to-right" do
    assert CryptoSquare.encode(["ab"]) == "ab"
    assert CryptoSquare.encode(["ab", "cd"]) == "acbd"
    assert CryptoSquare.encode(["abc", "cd "]) == "acbdc"
  end
end
