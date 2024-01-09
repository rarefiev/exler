defmodule Solution.P026 do

  import Utils

  def run do
    incoming = Utils.parse_integer()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run(xs) do
    max = Enum.max(xs)
    seq = stream_max_length() |> Stream.map(fn {x, _} -> x end) |> Stream.take_while(&(&1 <= max)) |> Enum.reverse()
    Enum.map(xs, fn n -> related_max(seq, n) end)
  end

  def related_max(seq, n) do
    Enum.drop_while(seq, &(&1 >= n)) |> hd()
  end

  def recurring_length(n) do
    dm_stream(n) |> Stream.transform({0, Map.new()}, &reducer/2) |> Enum.at(0)
  end

  def stream_length() do
    Stream.iterate(2, &(&1 + 1)) |> Stream.map(fn x -> {x, recurring_length(x)} end)
  end

  def stream_max_length() do
    stream_length() |> Stream.transform({1, 0}, &max_length_reducer/2)
  end

  def max_length_reducer({_, b} = elt, {_, d} = acc) do
    if b > d do
      {[elt], elt}
    else
      {[], acc}
    end
  end

  def reducer(_, {:halt, _}) do
    {:halt, nil}
  end

  def reducer(elt, {n, m}) do
    if elt == {0, 0} do
      {[0], {:halt, nil}}
    else
      prev = Map.get(m, elt)
      if prev != nil do
        {[n - prev], {:halt, nil}}
      else
        {[], {n + 1, Map.put(m, elt, n)}}
      end
    end
  end

  def dm_stream(n) do
    Stream.iterate({0, 1}, fn {_, x} -> dm(10 * x, n) end)
  end

  def dm(x, y) do
    {div(x, y), rem(x, y)}
  end

end
