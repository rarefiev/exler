defmodule Solution.P017 do
  @ones %{
    "0" => "",
    "1" => "One",
    "2" => "Two",
    "3" => "Three",
    "4" => "Four",
    "5" => "Five",
    "6" => "Six",
    "7" => "Seven",
    "8" => "Eight",
    "9" => "Nine",
    "10" => "Ten",
    "11" => "Eleven",
    "12" => "Twelve"
  }

  @lower_tens %{"3" => "Thir", "5" => "Fif", "8" => "Eigh"}

  @upper_tens %{"2" => "Twen", "4" => "For"}

  @teen "teen"
  @ty "ty"

  @degrees ["", "Thousand", "Million", "Billion", "Trillion"]

  def run do
    incoming = Utils.parse_string()
    result = run(incoming)
    Enum.each(result, fn x -> IO.puts(x) end)
  end

  def run(seq) do
    seq |> Enum.map(&run_one/1)
  end

  def run_one(x) do
    ret = align(x)
    |> String.split("", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.reverse()
    |> Enum.zip(@degrees)
    |> Enum.map(fn {x, y} -> triplet_to_words(x) ++ [y] end)
    |> Enum.reject(fn x -> Enum.at(x, 0) == "" end)
    |> Enum.reduce([], fn x, acc -> x ++ acc end)
    |> Enum.join(" ")
    if ret == "" do
      "Zero"
    else
      String.split(ret, " ", trim: true) |> Enum.join(" ")
    end
  end

  def triplet_to_words(["0", "0", "0"]) do
    [Map.get(@ones, "0")]
  end

  def triplet_to_words([a, "0", "0"]) do
    [Map.get(@ones, a), "Hundred"]
  end

  def triplet_to_words(["0", "0", c]) do
    [Map.get(@ones, c)]
  end

  def triplet_to_words(["0", "1", c]) do
    n = Map.get(@ones, "1" <> c)

    if n do
      [n]
    else
      [map_get([@lower_tens, @ones], c) <> @teen]
    end
  end

  def triplet_to_words(["0", b, c]) do
    [map_get([@upper_tens, @lower_tens, @ones], b) <> @ty, Map.get(@ones, c)]
  end

  def triplet_to_words([a, b, c]) do
    triplet_to_words([a, "0", "0"]) ++ triplet_to_words(["0", b, c])
  end

  def align(s) do
    n = String.length(s)
    String.duplicate("0", rem(3 - rem(n, 3), 3)) <> s
  end

  def map_get([], _) do
    nil
  end

  def map_get([m | ms], k) do
    if Map.has_key?(m, k) do
      Map.get(m, k)
    else
      map_get(ms, k)
    end
  end
end
