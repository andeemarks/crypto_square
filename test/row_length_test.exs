defmodule RowLengthTest do
  use ExUnit.Case

  @moduletag :capture_log

  setup do
    {:ok, [row_length: spawn(RowLength, :run, [])]}
  end

  test "row length for empty string is 0", context do
    send(context[:row_length], {self(), ""})
    assert_receive {_, :row_length, "", 0}
  end

  test "row length for string length that is a perfect square is the corresponding square root",
       context do
    send(context[:row_length], {self(), "a"})
    assert_receive {_, :row_length, "a", 1}

    send(context[:row_length], {self(), "abcd"})
    assert_receive {_, :row_length, "abcd", 2}

    send(context[:row_length], {self(), "abcdefghi"})
    assert_receive {_, :row_length, "abcdefghi", 3}

    send(context[:row_length], {self(), "abcdefghijklmnop"})
    assert_receive {_, :row_length, "abcdefghijklmnop", 4}
  end

  test "row length for string length that is not a perfect square is larger than the corresponding root",
       context do
    send(context[:row_length], {self(), "abc"})
    assert_receive {_, :row_length, "abc", 2}

    send(context[:row_length], {self(), "abcdef"})
    assert_receive {_, :row_length, "abcdef", 3}

    send(context[:row_length], {self(), "abcdefghijklmno"})
    assert_receive {_, :row_length, "abcdefghijklmno", 4}

    send(context[:row_length], {self(), "abcdefghijklmnopqrst"})
    assert_receive {_, :row_length, "abcdefghijklmnopqrst", 5}

    send(context[:row_length], {self(), "ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots"})
    assert_receive {_, :row_length, "ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots", 8}
  end
end
