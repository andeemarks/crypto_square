defmodule Runner do
  def new() do
    crypto_square = spawn(CryptoSquare, :encrypt, [])

    send(
      crypto_square,
      {"If man was meant to stay on the ground, god would have given us roots."}
    )
  end
end
