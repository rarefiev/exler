defmodule Solution.P014 do
  # require Utils
  require Integer
  require MapSet

  def run do
    Utils.parse() |> run() |> Enum.each(&IO.puts/1)
  end

  def run(seq) do
    indexed = indexed_sort(seq)
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

  def restore_unsorted(seq, indexed) when length(seq) == length(indexed) do
    for({x, {_, i}} <- Enum.zip(seq, indexed), do: {i, x})
    |> Enum.sort(fn {i0, _}, {i1, _} -> i0 <= i1 end)
    |> values()
  end

  def run_many(seq) do
    make_chunks(seq) |> run_many([], %{2 => [1]})
  end

  def make_chunks(seq) do
    [0 | seq]
    |> Enum.chunk_every(2, 1)
    |> Enum.filter(fn x -> length(x) == 2 end)
    |> Enum.map(fn [x, y] -> Enum.to_list((x + 1)..y) end)
  end

  def run_many([h | t], candidates, cache) do
    {new_candidate, new_cache} = run_one(h, List.first(candidates), cache)
    run_many(t, [new_candidate | candidates], new_cache)
  end

  def run_many([], candidates, _) do
    candidates |> Enum.reverse() |> Enum.map(fn x -> Enum.at(x, 0) end)
  end

  def run_one([], candidate, cache) do
    {candidate, cache}
  end

  def run_one([n | rest], candidate, cache) do
    if Map.get(cache, n) do
      run_one(rest, candidate, cache)
    else
      {seq, new_cache} = collatz_seq(n, cache)
      run_one(rest, find_best(candidate, seq), new_cache)
    end
  end

  def find_best(nil, old) do
    old
  end

  def find_best(old, new) when length(new) < length(old) do
    old
  end

  def find_best(old, new) when length(new) > length(old) do
    new
  end

  def find_best(old, new) when length(old) == length(new) do

    if List.first(old) >= List.first(new) do
      old
    else
      new
    end
  end

  def collatz(n) when Integer.is_even(n) do
    Integer.floor_div(n, 2)
  end

  def collatz(n) do
    3 * n + 1
  end

  def collatz_seq([k | n], cache) do
    r = [k | n]
    if Map.has_key?(cache, k) do
      seq = Map.get(cache, k)
      result = Enum.reverse(r) ++ seq
      {result, update_cache(cache, result, k)}
    else
      collatz_seq([collatz(k) | r], cache)
    end
  end

  def collatz_seq(n, cache) do
    collatz_seq([n], cache)
  end

  # [9, 28, 14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],

  def update_cache(cache, [k | _], k) do
    cache
  end

  def update_cache(cache, [h | t], k) do
      update_cache(Map.put(cache, h, t), t, k)
  end
end
