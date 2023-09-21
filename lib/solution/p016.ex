defmodule Solution.P016 do
  require IEx
  # require Utils
  require Integer
  require Stream
  require String
  require Bitwise

  def run do
    incoming = Utils.parse()
    result = run(incoming)
    Enum.each(result, fn x -> IO.puts(x) end)
  end

  def run(seq) do
    seq |> Enum.map(&run_one/1)
  end

  def run_one(x) do
    Bitwise.bsl(2, x - 1) |> Integer.to_string() |> String.split("") |> Stream.drop(1) |> Stream.drop(-1) |> Stream.map(fn x -> Integer.parse(x) |> elem(0) end) |> Enum.sum()
  end

end
