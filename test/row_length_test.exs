defmodule RowLengthTest do
  use ExUnit.Case

  @moduletag :capture_log

  def assert_row_length_for(text, expected_row_length) do
    row_length = spawn(RowLength, :run, [])
    send(row_length, {self(), text})
    assert_receive({_, :row_length, ^text, ^expected_row_length})
  end

  test "row length for empty string is 0" do
    assert_row_length_for("", 0)
  end

  test "row length for string length that is a perfect square is the corresponding square root" do
    assert_row_length_for("a", 1)
    assert_row_length_for("abcd", 2)
    assert_row_length_for("abcdefghi", 3)
    assert_row_length_for("abcdefghijklmnop", 4)
  end

  test "row length for string length that is not a perfect square is larger than the corresponding root" do
    assert_row_length_for("abc", 2)
    assert_row_length_for("abcdef", 3)
    assert_row_length_for("abcdefghijklmno", 4)
    assert_row_length_for("abcdefghijklmnopqrst", 5)
    assert_row_length_for("ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots", 8)
  end
end
