defmodule Solution.P015 do
  @cache :cache

  def run do
    incoming = Utils.parse_integer_seq()
    result = run(incoming)
    Enum.each(result, fn x -> IO.puts(x) end)
  end

  def run(seq) do
    init()
    r = seq |> Enum.map(fn x -> apply(&f/2, x) end)
    cleanup()
    r
  end

  def init() do
    :ets.new(@cache, [:named_table])
  end

  def cleanup() do
    :ets.delete(@cache)
  end

  def run_one(x) do
    apply(&f/2, x)
  end

  def f(m, n) when m < n do
    f(n, m)
  end

  def f(m, 1) do
    m + 1
  end

  def f(_, 0) do
    1
  end

  def f(m, n) do
    r = lookup_cache(m, n)
    unless r do
      insert_cache(m, n,
       0..(n - 1) |> Stream.map(fn i -> max(f(1, i),  f(m - 1, n - i)) end) |> Enum.sum() |> plus_one() |> mod1097())
    else
      r
    end
  end

  def lookup_cache(m, n) do
    try do
      :ets.lookup_element(@cache, {m, n}, 2)
    rescue
      ArgumentError -> nil
    end
  end

  def insert_cache(m, n, r) do
    :ets.insert(@cache, {{m, n}, r})
    r
  end

  def plus_one(x) do
    x + 1
  end

  def mod1097(x) do
    rem(x, 1_000_000_000 + 7)
  end

end
