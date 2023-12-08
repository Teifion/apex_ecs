defmodule ApexECSTest do
  use ExUnit.Case
  doctest ApexECS

  test "greets the world" do
    assert ApexECS.tick_hz() |> is_integer()
  end
end
