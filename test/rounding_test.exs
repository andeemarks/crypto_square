defmodule RoundingTest do
  use ExUnit.Case

  @moduletag :capture_log

  test "rounding up to nearest integer" do
    assert Rounding.round_up(1.0000) == 1
    assert Rounding.round_up(0.9999) == 1
    assert Rounding.round_up(0.49) == 1
    assert Rounding.round_up(0.0000001) == 1
    assert Rounding.round_up(99.0000001) == 100
  end
end
