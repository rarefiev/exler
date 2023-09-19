defmodule Solution.P014 do
  require IEx
  # require Utils
  require Integer
  require MapSet

  def run do
    incoming = Utils.parse()
    maxes = run(incoming)
    Enum.each(maxes, fn x -> IO.puts(x) end)
  end

  def get_rank(ranks, e) do
    Stream.drop_while(ranks, fn x -> x > e end) |> Enum.at(0)
  end

  def run(seq) do
    ranks = run_to(Enum.max(seq))
    Enum.map(seq, fn x -> get_rank(ranks, x) end)
  end

  def run_to(n) do
    run_to(1, n, {nil, 0}, %{1 => 0}, [])
  end

  def run_to(_, 0, _, _cache, ranks) do
    ranks
  end

  def run_to(start, end_, best, cache, ranks) do
    if Map.has_key?(cache, start) do
      run_to(start + 1, end_ - 1, best, cache, ranks)
    else
      new_cache = collatz_seq(start, cache)
      new_best = find_best(best, {start, Map.get(new_cache, start)})
      run_to(start + 1, end_ - 1, if elem(new_best, 0) do new_best else best end, new_cache, update_ranks(ranks, start, new_best))
    end
  end

  def update_ranks(ranks, _, {nil, _}) do
    ranks
  end

  def update_ranks(ranks, _, {v, _}) do
      [v | ranks]
  end

  def collatz_seq([k | n], cache) do
    r = [k | n]
    if Map.has_key?(cache, k) do
      start_len = Map.get(cache, k)
      update_cache(cache, r, start_len)
    else
      collatz_seq([collatz(k) | r], cache)
    end
  end

  def collatz_seq(n, cache) do
    collatz_seq([n], cache)
  end

  # [9, 28, 14, 7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16, 8, 4, 2, 1],

  def update_cache(cache, [], _) do
    cache
  end

  def update_cache(cache, [h | t], idx) do
    update_cache(Map.put(cache, h, idx), t, idx + 1)
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

  def find_best({_, l0}, {_, l1}) when l0 > l1 do
    {nil, nil}
  end

  def find_best({start0, l0}, {start1, l1}) when l0 == l1 do
    if start0 >= start1 do
      {nil, nil}
    else
      {start1, l1}
    end
  end

end
