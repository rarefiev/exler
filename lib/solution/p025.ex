defmodule Solution.P025 do
  import Utils

  def run do
    incoming = Utils.parse_integer()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run(xs) do
    m = fib_sec(Enum.max(xs))
    Enum.map(xs, fn x -> Map.get(m, x) end)
  end

  def fib_sec(k) do
    Stream.iterate({2, 1, 1}, fn {n, x, y} -> {n + 1, y, x + y} end)
    |> Stream.map(&len_string_pair/1)
    |> Stream.dedup_by(fn {n, _} -> n end)
    |> Stream.take_while(fn {n, _} -> n <= k end)
    |> Map.new()
  end

def len_string_pair({n, _, y}) do
  z = Integer.to_string(y)
  {String.length(z), n}
end

end
