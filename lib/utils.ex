defmodule Utils do

  def parse_integer() do
    parse(&Integer.parse/1)
  end

  def parse_string() do
    parse(fn x -> x end)
  end

  def parse_integer_seq() do
    parse(&as_intger_seq/1)
  end

  def parse_integer_seq_of_seq() do
    n = parse_integer_line()
    for _ <- 1..n do
      parse_integer_seq()
    end
  end

  def parse(f) do
    n = parse_integer_line()
    for _ <- 1..n, do: parse_line(f)
  end

  defp parse_integer_line() do
    parse_line(&as_integer/1)
  end

  defp parse_string_line() do
    parse_line(fn x -> x end)
  end

  defp parse_line(f) do
    IO.gets("") |> IO.chardata_to_string() |> String.trim() |> f.()
  end

  defp as_integer(x) do
    Integer.parse(x) |> elem(0)
  end

  defp as_intger_seq(x) do
    String.split(x, " ") |> Enum.map(&as_integer/1)
  end

end
