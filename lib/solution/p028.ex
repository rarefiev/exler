defmodule Solution.P028 do
  import Utils

  def run do
    incoming = Utils.parse_integer()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run(xs) do
    Enum.map(xs, &run_one/1)
  end

  def run_one(x) do
    Stream.iterate(1, &(&1 + 2)) |> Stream.take_while(&(&1 <= x)) |> Stream.flat_map(&f/1) |> Enum.sum()
  end

  def f(1) do
    [1]
  end

  def f(n) when rem(n, 2) == 1 do
    y = Enum.at(f(n - 2), -1)
    Stream.iterate(y, fn x -> x + n - 1 end) |> Stream.drop(1) |>  Enum.take(4)
  end

end
