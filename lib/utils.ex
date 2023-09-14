defmodule Utils do
  def parse do
    n = parse_line()
    for _ <- 1..n, do: parse_line()

  end

  defp parse_line do
    IO.gets("") |> IO.chardata_to_string() |> String.trim() |> Integer.parse() |> elem(0)
  end
end
