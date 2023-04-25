defmodule Normaliser do
  def run do
    receive do
      {sender, text} ->
        send(sender, {self(), :normal_plaintext, normalise(text)})
    end

    run()
  end

  defp normalise(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^a-z1-9]/, "")
  end
end
