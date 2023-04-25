defmodule EncryptTest do
  use ExUnit.Case

  @moduletag :capture_log

  setup do
    {:ok, [encrypt: spawn(Encrypt, :run, [])]}
  end

  test "encrypted ciphertext returned to caller", context do
    send(context[:encrypt], {self(), "abcde", 3})
    assert_receive {_, :ciphertext, "ad be c "}

    send(context[:encrypt], {self(), "ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots", 8})

    assert_receive {_, :ciphertext,
                    "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "}

    send(context[:encrypt], {self(), "abcd", 2})
    assert_receive {_, :ciphertext, "ac bd"}
  end
end
