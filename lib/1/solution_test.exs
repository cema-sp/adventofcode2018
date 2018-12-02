defmodule Solution1Test do
  use ExUnit.Case

  test "example 1" do
    input = "+1\n-2\n+3\n+1"
    result = Solution1.one_pass_freq(input)
    assert result == 3
  end

  test "example 2" do
    input = "+1\n+1\n+1"
    result = Solution1.one_pass_freq(input)
    assert result == 3
  end

  test "example 3" do
    input = "+1\n+1\n-2"
    result = Solution1.one_pass_freq(input)
    assert result == 0
  end

  test "example 4" do
    input = "-1\n-2\n-3"
    result = Solution1.one_pass_freq(input)
    assert result == -6
  end

  test "example 5" do
    input = "+1\n-2\n+3\n+1"
    result = Solution1.calibration_freq(input)
    assert result == 2
  end

  test "example 6" do
    input = "-1\n+1"
    result = Solution1.calibration_freq(input)
    assert result == 0
  end

  test "example 7" do
    input = "+3\n+3\n+4\n-2\n-4"
    result = Solution1.calibration_freq(input)
    assert result == 10
  end

  test "example 8" do
    input = "-6\n+3\n+8\n+5\n-6"
    result = Solution1.calibration_freq(input)
    assert result == 5
  end

  test "example 9" do
    input = "+7\n+7\n-2\n-7\n-4"
    result = Solution1.calibration_freq(input)
    assert result == 14
  end
end
