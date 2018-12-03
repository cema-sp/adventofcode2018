defmodule Solution2Test do
  use ExUnit.Case

  test "example 1" do
    input = """
    abcdef
    bababc
    abbcde
    abcccd
    aabcdd
    abcdee
    ababab
    """

    result = Solution2.checksum(input)
    assert result == 12
  end

  test "example 2" do
    input = """
    fghij
    fguij
    """

    result = Solution2.find_similar(input)
    assert result == "fgij"
  end

  test "example 3" do
    input = """
    abcde
    fghij
    klmno
    pqrst
    fguij
    axcye
    wvxyz
    """

    result = Solution2.find_similar(input)
    assert result == "fgij"
  end
end
