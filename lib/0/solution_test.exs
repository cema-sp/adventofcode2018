defmodule Solution0Test do
  use ExUnit.Case

  test "example 1" do
    input = "ne,ne,ne"
    result = Solution0.run(input)
    assert result.distance == 3
  end

  test "example 2" do
    input = "ne,ne,sw,sw"
    result = Solution0.run(input)
    assert result.distance == 0
  end

  test "example 3" do
    input = "ne,ne,s,s"
    result = Solution0.run(input)
    assert result.distance == 2
  end

  test "example 4" do
    input = "se,sw,se,sw,sw"
    result = Solution0.run(input)
    assert result.distance == 3
  end

  test "example 5" do
    input = "se,se,ne,ne,s"
    result = Solution0.run(input)
    assert result.distance == 4
  end

  test "example 6" do
    input = "sw,n"
    result = Solution0.run(input)
    assert result.distance == 1
  end
end
