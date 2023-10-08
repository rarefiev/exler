defmodule Solution.P020 do
  def run do
    incoming = Utils.parse_integer()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run(seq) do
    Enum.map(seq,  &run_one/1)
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
