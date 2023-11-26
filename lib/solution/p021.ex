defmodule Solution.P021 do
  def run do
    incoming = Utils.parse_integer()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run(seq) do
    a = amicables(Enum.max(seq))
    Enum.map(seq, fn x -> sum_amicables(a, x) end)
  end

  def sum_amicables(a, n) do
    Enum.filter(a, fn x -> x < n end) |> Enum.sum()
  end

  def amicables(n) do
    Enum.sort(amicables(Enum.to_list(1..n), []))
  end

  def amicables([], ys) do
    ys
  end

  def amicables([n|xs], ys) do
    k = amicable(n)
    if k != nil do
      amicables(List.delete(xs, k), [n, k | ys])
    else
      amicables(xs, ys)
    end
  end

  def amicable(x) do
    y = d(x)
    if d(y) == x and y != x do
      y
    else
      nil
    end
  end

  def d(x) do
    (Stream.flat_map(2..ceil(:math.sqrt(x)), fn z -> divs(z, x) end) |> Enum.sum()) + 1
  end

  def divs(n, m) do
    if Integer.mod(m, n) == 0 do
      k = div(m, n)
      if k == n do
        [k]
      else
        [n, k]
      end
    else
      []
    end
  end

end
