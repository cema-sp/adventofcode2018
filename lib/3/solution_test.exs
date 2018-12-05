defmodule Solution3Test do
  use ExUnit.Case

  test "example 1" do
    input = """
    #123 @ 3,2: 5x4
    """
    result = Solution3.overlap_area(input)
    assert result == 0
  end

  test "example 2" do
    input = """
    #1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2
    """
    result = Solution3.overlap_area(input)
    assert result == 4
  end

  test "example 3" do
    input = """
    #1 @ 1,3: 4x4
    #2 @ 3,1: 4x4
    #3 @ 5,5: 2x2
    """
    result = Solution3.plain_piece_id(input)
    assert result == "3"
  end
end
