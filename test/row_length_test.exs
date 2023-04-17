defmodule RowLengthTest do
  use ExUnit.Case

  test "row length for empty string is 0" do
    assert RowLength.row_length("") == 0
  end

  test "row length for string length that is a perfect square is the corresponding square root" do
    assert RowLength.row_length("a") == 1
    assert RowLength.row_length("abcd") == 2
    assert RowLength.row_length("abcdefghi") == 3
    assert RowLength.row_length("abcdefghijklmnop") == 4
  end

  test "row length for string length that is not a perfect square is larger than the corresponding root" do
    assert RowLength.row_length("abc") == 2
    assert RowLength.row_length("abcdef") == 3
    assert RowLength.row_length("abcdefghijklmno") == 4
    assert RowLength.row_length("abcdefghijklmnopqrst") == 5

    assert RowLength.row_length("ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots") ==
             8
  end
end
