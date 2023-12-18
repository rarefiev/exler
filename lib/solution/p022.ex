defmodule Solution.P022 do

  @start_code 64

  def run do
    incoming = Utils.parse_two_string_seq()
    run(incoming) |> Enum.each(&IO.puts/1)
  end

  def run({xs, ys}) do
    run(Enum.sort(xs), ys, [])
  end

  def run(_, [], rs) do
    Enum.reverse(rs)
  end

  def run(xs, [y | ys], rs) do
    run(xs, ys, [val(xs, y) | rs])
  end

  def val(xs, y) do
    (Enum.find_index(xs, fn x -> x == y end) + 1) * num(y)
  end

  def charcode(x) do
    x |> String.to_charlist() |> hd()
  end

  def charnum(x) do
    charcode(x) - @start_code
  end

  def charnums(x) do
    List.map(String.to_charlist(x), fn x -> x - @start_code end)
  end

  def num(x) do
    (x |> String.to_charlist() |> Enum.sum()) - String.length(x) * @start_code
  end

end
