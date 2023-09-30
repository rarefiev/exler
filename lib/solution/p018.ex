defmodule Solution.P018 do
  def run do
    incoming = Utils.parse_integer_seq_of_seq()
    result = run(incoming)
    Enum.each(result, fn x -> IO.puts(x) end)
  end

  def run(seq) do
    seq |> Enum.map(fn xs -> xs |> Enum.reverse() |> run_one() end)
  end

  def run_one([[x]]) do
    x
  end

  def run_one([xs, ys | t]) do
    run_one([zipmap(xs, ys)| t])
  end

  def zipmap(xs, ys) do
    Enum.zip(Enum.chunk_every(xs, 2, 1, :discard), ys) |> Enum.map(fn {[a, b], c} -> c + max(a, b) end)
  end

end
