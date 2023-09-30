defmodule Solution.P015 do

  def run do
    incoming = Utils.parse_integer_seq()
    result = run(incoming)
    Enum.each(result, fn x -> IO.puts(x) end)
  end

  def run(seq) do
    seq |> Enum.map(fn x -> apply(&f/2, x) end)
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

  def f(m, 0) do
    1
  end

  def f(m, n) do
    0..(n - 1) |> Stream.map(fn i -> max(f(1, i),  f(m - 1, n - i)) |> mod1097() end) |> Enum.sum() |> plus_one() |> mod1097()
  end

  def plus_one(x) do
    x + 1
  end

  def mod1097(x) do
    rem(x, 1_000_000_000 + 7)
  end

end
