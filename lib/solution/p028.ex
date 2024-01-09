defmodule Solution.P028 do
  import Utils

  @modulo 1_000_000_000 + 7

  def run do
    incoming = Utils.parse_integer()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run(xs) do
    Enum.map(xs, fn x ->  diag_sum(div(x, 2)) end)
  end

  def diag_sum(n) do
    rem(1 + 4 * n + div(8 * n * (n + 1) * (2 * n + 1), 3) + 2 * n * (n + 1), @modulo)
  end

end
