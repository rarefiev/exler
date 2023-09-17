defmodule Solution.P014 do
  require IEx
  # require Utils
  require Integer
  require MapSet

  def run do
    incoming = Utils.parse()
    ranks = run(incoming)
    Enum.each(incoming, fn x -> IO.puts(Map.get(ranks, x)) end)
  end

  def run(seq) do
    run_to(Enum.max(seq))
  end

  def run_to(n) do
    run_to(1, n, {nil, 0}, %{1 => 0}, Map.new())
  end

  def run_to(_, 0, _, _cache, ranks) do
    ranks
  end

  def run_to(start, end_, best, cache, ranks) do
    if Map.has_key?(cache, start) do
      run_to(start + 1, end_ - 1, best, cache, update_ranks(ranks, start, best))
    else
      new_cache = collatz_seq(start, cache)
      new_best = find_best(best, {start, Map.get(new_cache, start)})
      run_to(start + 1, end_ - 1, new_best, new_cache, update_ranks(ranks, start, new_best))
    end
  end

  def update_ranks(ranks, k, v) do
    Map.put(ranks, k, elem(v, 0))
  end

  def collatz_seq([k | n], cache) do
    r = [k | n]
    start_len = Map.get(cache, k)
    if start_len do
      update_cache(cache, r, start_len)
    else
      collatz_seq([collatz(k) | r], cache)
    end
  end

  def collatz_seq(n, cache) do
    collatz_seq([n], cache)
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

  def collatz(n) when Integer.is_even(n) do
    Integer.floor_div(n, 2)
  end

  def collatz(n) do
    3 * n + 1
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

end
