defmodule Solution.P023 do
  import Utils

  def run do
    incoming = Utils.parse_integer()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run(xs) do
    Enum.map(xs, fn x -> if(run_one(x), do: "YES", else: "NO") end)
  end

  def run_one(x) when x > 28123 do
    true
  end

  def run_one(x) when x < 24 do
    false
  end

  def run_one(x) do
    run_pair(12, x - 12)
  end

  def run_pair(x, y) when x > y do
    false
  end

  def run_pair(x, y) do
    if is_abundant(x) and is_abundant(y) do
      true
    else
      run_pair(x + 1, y - 1)
    end
  end

  def is_abundant(x) do
    sum_dividers(x) > x
  end

  def sum_dividers(x) do
    (dividers(x) |> Enum.sum()) + 1
  end

  def dividers(x) do
    Stream.flat_map(2..ceil(:math.sqrt(x)), fn z -> divs(z, x) end)
  end

  def divs(n, m) do
    if Integer.mod(m, n) == 0 do
      k = div(m, n)
      case sign(k - n) do
        0 -> [k]
        1 -> [n, k]
        -1 -> []
      end
    else
      []
    end
  end

  def sign(0) do
    0
  end

  def sign(x) when x > 0 do
    1
  end

  def sign(x) when x < 0 do
    -1
  end

end
