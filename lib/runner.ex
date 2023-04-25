defmodule Runner do
  def new() do
    crypto_square = spawn(CryptoSquare, :encrypt, [])

    send(
      crypto_square,
      {:plaintext, "If man was meant to stay on the ground, god would have given us roots."}
    )

    send(
      crypto_square,
      {:foo, "This should result in an error"}
    )
  end
end
