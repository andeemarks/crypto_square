defmodule Runner do
  def new() do
    task =
      Task.async(fn ->
        CryptoSquare.encrypt(
          "If man was meant to stay on the ground, god would have given us roots."
        )
      end)

    IO.puts("Ciphertext: #{Task.await(task)}")
  end
end
