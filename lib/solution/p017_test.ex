defmodule Solution.P017Test do
  use ExUnit.Case
  doctest Solution.P017
  test "zero" do
    assert Solution.P017.run_one("0") == "Zero"
  end

  test "12" do
    assert Solution.P017.run_one("12") == "Twelve"
  end

  test "10000" do
    assert Solution.P017.run_one("10000") == "Ten Thousand"
  end

  test "104382426112" do
    assert Solution.P017.run_one("104382426112") == "One Hundred Four Billion Three Hundred Eighty Two Million Four Hundred Twenty Six Thousand One Hundred Twelve"
  end

  test "zero" do
    assert Solution.P017.run_one("40") == "Forty"
  end



end
