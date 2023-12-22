defmodule Solution.P024 do
  import Utils

  @letters String.split("abcdefghijklm", "", trim: true)

  def run do
    incoming = Utils.parse_integer()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run(xs) do
    fac_seq = make_factorials() |> IO.inspect(label: "factorials")
    Enum.map(xs, fn x -> run_one(x - 1, fac_seq) end)
  end

  def make_factorials() do
    Stream.map(1..length(@letters), &fac/1) |> Enum.reverse()
  end

  def factorization(n, facs) do
    Enum.map(facs, fn x -> div(n, x) end) |> IO.inspect(label: "0") |> Enum.slice(1, length(facs) - 2) |> IO.inspect(label: "1") |> Enum.concat([Integer.mod(n, 2), 0]) |> IO.inspect(label: "2")
  end

  def run_one(n, facs) do
    xs = factorization(n, facs)
    res = run_one(xs, @letters, [])
    Enum.zip([xs, @letters, String.split(res, "", trim: true)]) |> IO.inspect(label: "factrz")
    res
  end

  def run_one([], orig, dest) do
    IO.puts("0000 orig: #{orig}, dest: #{dest}")
    Enum.reverse(orig) |> Enum.concat(dest) |> Enum.reverse() |> Enum.join("") |> IO.inspect(label: "end")
  end

  def run_one([x | xs], orig, dest) do
    # IO.puts("x: #{x}, xs: #{xs}, orig: #{orig}, dest: #{dest}")
    a = Enum.at(orig, x) |> IO.inspect(label: "a")
    if a != nil do
      new_orig = Enum.reject(orig, fn z -> z == a end) |> IO.inspect(label: "new orig")
      run_one(xs, new_orig, [a | dest])
    else
      run_one([], orig, dest)
    end
  end

  def fac(1) do
    1
  end

  def fac(n) do
    n * fac(n-1)
  end

end
