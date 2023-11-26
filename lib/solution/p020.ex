defmodule Solution.P020 do
  def run do
    incoming = Utils.parse_integer()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run(seq) do
    Enum.map(fac_seq(seq),  &sum_of_digits/1)
  end


  def sum_of_digits(x) do
    Integer.to_string(x) |> String.replace("0", "")
    |> String.split("", trim: true) |> Enum.map_reduce(0, fn x, acc -> {x, acc + (Integer.parse(x) |> elem(0))} end) |> elem(1)
  end

  def fac_seq(xs) do
    m = fac_map(xs)
    Enum.map(xs, fn x -> Map.get(m, x) end)
  end

  def fac_map(xs) do
    fac_map(1, 0, Enum.max(xs), Map.new(xs, fn x -> {x, 1} end))
  end

  def fac_map(_, n, n, m) do
    m
  end

  def fac_map(r, i, n, m) do
    x = i + 1
    r1 = r * x
    m1 = if Map.has_key?(m, x) do
      Map.put(m, x, r1)
    else
      m
    end
    fac_map(r1, x, n, m1)
  end


  def run_one(x) do
    fac(x) |> Integer.to_string() |> String.replace("0", "")
    |> String.split("", trim: true) |> Enum.map_reduce(0, fn x, acc -> {x, acc + (Integer.parse(x) |> elem(0))} end) |> elem(1)
  end

  def fac(1) do
    1
  end

  def fac(n) do
    n * fac(n - 1)
  end

end
