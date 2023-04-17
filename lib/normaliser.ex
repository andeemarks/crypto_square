defmodule Normaliser do
  @spec normalise(String.t()) :: String.t()
  def normalise(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^a-z1-9]/, "")
  end
end
