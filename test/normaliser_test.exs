defmodule NormaliserTest do
  use ExUnit.Case

  test "normalising lower case single words does nothing" do
    assert Normaliser.normalise("foo") == "foo"
  end

  test "normalising mixed case words converts to lower case" do
    assert Normaliser.normalise("Foo") == "foo"
  end

  test "normalising multiple words removes spaces" do
    assert Normaliser.normalise(" Foo bar ") == "foobar"
  end

  test "normalising sentences removes punctuation" do
    assert Normaliser.normalise("First, second: third! ") == "firstsecondthird"
  end
end
