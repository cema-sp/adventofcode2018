defmodule SolutionTmplTest do
  use ExUnit.Case

  test "example 1" do
    input = ""
    result = SolutionTmpl.run(input)
    assert result.distance == 3
  end
end
