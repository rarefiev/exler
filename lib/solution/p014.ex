defmodule Solution.P014 do
  # require Utils
  require Integer
  require MapSet

  def run do
    Utils.parse() |> run() |> Enum.each(&IO.puts/1)
  end

  def run(start_len) do
    indexed = indexed_sort(start_len)
    indexed |> keys() |> run_many() |> restore_unsorted(indexed)
  end

  def indexed_sort(x) do
    Enum.with_index(x) |> Enum.sort(fn x, y -> elem(x, 0) <= elem(y, 0) end)
  end

  def values(x) do
    for {_, y} <- x, do: y
  end

  def keys(x) do
    for {y, _} <- x, do: y
  end

  def restore_unsorted(start_len, indexed) when length(start_len) == length(indexed) do
    for({x, {_, i}} <- Enum.zip(start_len, indexed), do: {i, x})
    |> Enum.sort(fn {i0, _}, {i1, _} -> i0 <= i1 end)
    |> values()
  end

  def run_many(start_len) do
    make_chunks(start_len) |> run_many([{nil, 0}], %{1 => 0})
  end

  def make_chunks(start_len) do
    [1 | start_len]
    |> Enum.chunk_every(2, 1)
    |> Enum.filter(fn x -> length(x) == 2 end)
    |> Enum.map(fn [x, y] -> Enum.to_list((x + 1)..y) end)
  end

  def run_many([h | t], candidates, cache) do
    {new_candidate, new_cache} = run_one(h, List.first(candidates), cache)
    run_many(t, [new_candidate | candidates], new_cache)
  end

  def run_many([], candidates, _) do
    candidates |> Enum.drop(-1) |> Enum.reverse()  |> Enum.map(fn x -> elem(x, 0) end)
  end

  def run_one([], candidate, cache) do
    {candidate, cache}
  end

  def run_one([n | rest], candidate, cache) do

    if Map.has_key?(cache, n) do
      run_one(rest, candidate, cache)
    else
      {new_candidate, new_cache} = collatz_seq(n, candidate, cache)
      run_one(rest, new_candidate, new_cache)
    end
  end

  def find_best({_, l0}, {start1, l1}) when l0 < l1 do
    {start1, l1}
  end

  def find_best({start0, l0}, {_, l1}) when l0 > l1 do
    {start0, l0}
  end

  def find_best({start0, l0}, {start1, l1}) when l0 == l1 do

    if start0 >= start1 do
      {start0, l0}
    else
      {start1, l1}
    end
  end

  def collatz(n) when Integer.is_even(n) do
    Integer.floor_div(n, 2)
  end

  def collatz(n) do
    3 * n + 1
  end

  def collatz_seq([k | n], candidate, cache) do
    r = [k | n]
    if Map.has_key?(cache, k) do
      start_len = Map.get(cache, k)
      result_len = length(r) + start_len
      {find_best(candidate, {Enum.at(r, -1), result_len}), update_cache(cache, r, start_len)}
    else
      collatz_seq([collatz(k) | r], candidate, cache)
    end
  end

  def collatz_seq(n, candidate, cache) do
    collatz_seq([n], candidate, cache)
  end

  # [9, 28, 14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],

  def update_cache(cache, seq, start) do
    seq |> Enum.with_index(start) |> Enum.reduce(cache, fn {x, idx}, acc -> Map.put(acc, x, idx) end)
  end

  def collatz_seq_straight(n) when is_integer(n) do
    collatz_seq_straight([n])
  end

  def collatz_seq_straight(seq) do
    case seq do
      [1 | _] -> Enum.reverse(seq)
      [k | _] -> collatz_seq_straight([collatz(k) | seq])
    end
  end

end
