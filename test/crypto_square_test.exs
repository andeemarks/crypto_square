defmodule CryptoSquareTest do
  use ExUnit.Case

  @tag capture_log: true

  setup_all _context do
    {:ok,
     [
       cs: spawn(CryptoSquare, :encrypt, []),
       plaintext: "If man was meant to stay on the ground, god would have given us roots."
     ]}
  end

  test "starts with a plaintext argument", context do
    assert send(
             context[:cs],
             {:plaintext, context[:plaintext]}
           ) ==
             {:plaintext, context[:plaintext]}
  end

  test "receives a normalised plaintext", context do
    assert send(
             context[:cs],
             {self(), :normal_plaintext, context[:plaintext]}
           ) ==
             {self(), :normal_plaintext, context[:plaintext]}
  end

  test "receives a calculated row_length for plaintext", context do
    assert send(
             context[:cs],
             {self(), :row_length, context[:plaintext], 3}
           ) ==
             {self(), :row_length, context[:plaintext], 3}
  end

  test "receives an encrypted ciphertext", context do
    ciphertext = "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau"

    assert send(
             context[:cs],
             {self(), :ciphertext, ciphertext}
           ) ==
             {self(), :ciphertext, ciphertext}
  end

  test "fails on unexpected messages", context do
    Process.flag(:trap_exit, true)
    pid = spawn_link(fn -> send(context[:cs], {self(), :unexpected}) end)
    assert_receive {:EXIT, ^pid, :normal}
  end
end
