defmodule SolutionTmplTest do
  use ExUnit.Case

  test "example 1" do
    input = ""
    result = Solution.run(input)
    assert result.distance == 3
  end
end
