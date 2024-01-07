defmodule Solution.P028 do
  import Utils

  @modulo 1_000_000_000 + 7

  def run do
    incoming = Utils.parse_integer()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run(xs) do
    m = tr(Enum.sort(xs), sum_stream())
    Enum.map(xs, fn x -> Map.get(m, x) end)
  end

  def f_stream() do
    Stream.iterate({1, [1]}, &f_step/1)
  end

  def f_step({n, xs}) do
    y = Enum.at(xs, -1)
    xs_1 = Enum.map(1..4, &(&1 * (n + 1) + y))
    {n + 2, xs_1}
  end

  def sum_stream() do
    f_stream() |> Stream.map(fn {i, xs} -> {i, Enum.sum(xs)} end)
  end

  def tr(xs, stream) do
    Stream.transform(stream, {0, xs}, &tr_fn/2) |> Map.new()
  end

  def tr_fn(_, {agg, []}) do
    {:halt, {nil, nil}}
  end


  def tr_fn({k, v}, {agg, [x | xs] = xs1}) do
    agg1 = rem(agg + v, @modulo)
    if k == x do
      {[{k, agg1}], {agg1, xs}}
    else
      {[], {agg1, xs1}}
    end
  end

end
