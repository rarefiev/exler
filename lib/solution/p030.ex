defmodule Solution.P030 do
  import Utils

  def run do
    incoming = Utils.parse_integer_line()
    run(incoming) |> IO.puts()
  end

  def run(n) do
    filter_seq(n) |> Enum.map(fn x -> sum_of_degrees(n, x) end) |> Enum.sum()
  end

  def filter_seq(n) do
    (seq3() |> Enum.filter(fn x -> sum_is_seq?(n, x) end)) ++
    (seq4() |> Enum.filter(fn x -> sum_is_seq?(n, x) end)) ++
    (seq5() |> Enum.filter(fn x -> sum_is_seq?(n, x) end)) ++
    (seq6() |> Enum.filter(fn x -> sum_is_seq?(n, x) end)) ++
    (seq7() |> Enum.filter(fn x -> sum_is_seq?(n, x) end))
  end

  def sum_of_degrees(n, seq) do
    Enum.reduce(seq,  0, fn x, acc -> acc + :math.pow(x, n) |> round end)
  end

  def number_to_seq(x) do
    Integer.to_string(x) |> String.split("", trim: true) |> Enum.map(&String.to_integer/1) |> Enum.sort(&(&1 >= &2))
  end

  def sum_is_seq?(n, seq) do
    seq == sum_of_degrees(n, seq) |> number_to_seq()
  end

  def seq3() do
    for i0 <- 1..9,
        i1 <- 0..i0,
        i2 <- 0..i1 do
      [i0, i1, i2]
    end
  end

  def seq4() do
    for i0 <- 1..9,
        i1 <- 0..i0,
        i2 <- 0..i1,
        i3 <- 0..i2 do
      [i0, i1, i2, i3]
    end
  end

  def seq5() do
    for i0 <- 1..9,
        i1 <- 0..i0,
        i2 <- 0..i1,
        i3 <- 0..i2,
        i4 <- 0..i3 do
      [i0, i1, i2, i3, i4]
    end
  end

  def seq6() do
    for i0 <- 1..9,
        i1 <- 0..i0,
        i2 <- 0..i1,
        i3 <- 0..i2,
        i4 <- 0..i3,
        i5 <- 0..i4 do
      [i0, i1, i2, i3, i4, i5]
    end
  end

  def seq7() do
    for i0 <- 1..9,
        i1 <- 0..i0,
        i2 <- 0..i1,
        i3 <- 0..i2,
        i4 <- 0..i3,
        i5 <- 0..i4,
        i6 <- 0..i5 do
      [i0, i1, i2, i3, i4, i5, i6]
    end
  end
end
