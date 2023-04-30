defmodule RowLengthTest do
  use ExUnit.Case

  @moduletag :capture_log

  setup do
    {:ok, [row_length: spawn(RowLength, :run, [])]}
  end

  def assert_row_length_for(context, text, expected_row_length) do
    send(context[:row_length], {self(), text})
    assert_receive({_, :row_length, ^text, ^expected_row_length})
  end

  test "row length for empty string is 0", context do
    assert_row_length_for(context, "", 0)
  end

  test "row length for string length that is a perfect square is the corresponding square root",
       context do
    assert_row_length_for(context, "a", 1)
    assert_row_length_for(context, "abcd", 2)
    assert_row_length_for(context, "abcdefghi", 3)
    assert_row_length_for(context, "abcdefghijklmnop", 4)
  end

  test "row length for string length that is not a perfect square is larger than the corresponding root",
       context do
    assert_row_length_for(context, "abc", 2)
    assert_row_length_for(context, "abcdef", 3)
    assert_row_length_for(context, "abcdefghijklmno", 4)
    assert_row_length_for(context, "abcdefghijklmnopqrst", 5)
    assert_row_length_for(context, "ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots", 8)
  end
end
