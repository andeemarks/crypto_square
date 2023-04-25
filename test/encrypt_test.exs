defmodule EncryptTest do
  use ExUnit.Case

  @moduletag :capture_log

  test "encrypted ciphertext returned to caller" do
    encrypt = spawn(Encrypt, :run, [])
    send(encrypt, {self(), "abcde", 3})

    assert_receive {_, :ciphertext, "ad be c "}
  end

  test "right sizing text ensures the length evenly fits a rectangle" do
    assert Encrypt.size_to_rectangle("ab", 2) == "ab"
    assert Encrypt.size_to_rectangle("abcde", 3) == "abcde "
  end

  test "encoding an array of strings is top-to-bottom, left-to-right" do
    assert Encrypt.encrypt("ifmanwasmeanttostayonthegroundgodwouldhavegivenusroots", 8) ==
             "imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn  sseoau "

    assert Encrypt.encrypt("abcd", 2) == "ac bd"
    assert Encrypt.encrypt("abcde", 3) == "ad be c "
  end
end
