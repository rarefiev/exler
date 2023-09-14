defmodule ExlerTest do
  use ExUnit.Case
  doctest Exler

  test "greets the world" do
    assert Exler.hello() == :world
  end
end
