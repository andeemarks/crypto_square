defmodule NormaliserTest do
  use ExUnit.Case

  @moduletag :capture_log

  setup do
    {:ok, [normaliser: spawn(Normaliser, :run, [])]}
  end

  test "normalising lower case single words does nothing", context do
    send(context[:normaliser], {self(), "foo"})
    assert_receive {_, :normal_plaintext, "foo"}
  end

  test "normalising mixed case words converts to lower case", context do
    send(context[:normaliser], {self(), "Foo"})
    assert_receive {_, :normal_plaintext, "foo"}

    send(context[:normaliser], {self(), "ooF"})
    assert_receive {_, :normal_plaintext, "oof"}
  end

  test "normalising multiple words removes spaces", context do
    send(context[:normaliser], {self(), "Foo bar"})
    assert_receive {_, :normal_plaintext, "foobar"}
  end

  test "normalising sentences removes punctuation", context do
    send(context[:normaliser], {self(), "First, second: third! "})
    assert_receive {_, :normal_plaintext, "firstsecondthird"}
  end
end
