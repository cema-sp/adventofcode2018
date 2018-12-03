defmodule Solution2 do
  @moduledoc """
  --- Day 2: Inventory Management System ---

  ...

  To make sure you didn't miss any, you scan the likely candidate boxes again, counting the number that have an ID containing exactly two of any letter and then separately counting those with exactly three of any letter. You can multiply those two counts together to get a rudimentary checksum and compare it to what your device predicts.

  For example, if you see the following box IDs:

  abcdef contains no letters that appear exactly two or three times.
  bababc contains two a and three b, so it counts for both.
  abbcde contains two b, but no letter appears exactly three times.
  abcccd contains three c, but no letter appears exactly two times.
  aabcdd contains two a and two d, but it only counts once.
  abcdee contains two e.
  ababab contains three a and three b, but it only counts once.
  Of these box IDs, four of them contain a letter which appears exactly twice, and three of them contain a letter which appears exactly three times. Multiplying these together produces a checksum of 4 * 3 = 12.

  What is the checksum for your list of box IDs?

  --- Part Two ---

  Confident that your list of box IDs is complete, you're ready to find the boxes full of prototype fabric.

  The boxes will have IDs which differ by exactly one character at the same position in both strings. For example, given the following box IDs:

  abcde
  fghij
  klmno
  pqrst
  fguij
  axcye
  wvxyz
  The IDs abcde and axcye are close, but they differ by two characters (the second and fourth). However, the IDs fghij and fguij differ by exactly one character, the third (h and u). Those must be the correct boxes.

  What letters are common between the two correct box IDs? (In the example above, this is found by removing the differing character from either ID, producing fgij.)
  """

  def execute(str) do
    IO.puts("Checksum: #{checksum(str)}, common IDs part: #{find_similar(str)}")
  end

  def checksum(str) do
    ids = String.split(str, "\n", trim: true)

    ids
    |> Enum.map(&stats/1)
    |> Enum.map(&analyze_stats/1)
    |> Enum.reduce(fn {c2, c3}, {ac2, ac3} -> {ac2 + c2, ac3 + c3} end)
    |> Tuple.to_list()
    |> Enum.reduce(&(&1 * &2))
  end

  def find_similar(str) do
    ids = String.split(str, "\n", trim: true)

    found_tuple =
      Enum.reduce_while(ids, %{}, fn id, search_tree ->
        found_ids = search(search_tree, id, limit: 1)

        if Enum.empty?(found_ids) do
          {:cont, index_id(search_tree, id)}
        else
          fid = found_ids |> MapSet.to_list() |> List.first()
          {:halt, {id, fid}}
        end
      end)

    if found_tuple do
      intersect_ids(found_tuple)
    else
      ""
    end
  end

  defp stats(id) do
    id
    |> String.graphemes()
    |> Enum.reduce(%{}, fn chr, acc ->
      Map.update(acc, chr, 1, &(&1 + 1))
    end)
  end

  defp analyze_stats(stats) do
    Enum.reduce(stats, {0, 0}, fn
      {_chr, 2}, {0, c3} -> {1, c3}
      {_chr, 3}, {c2, 0} -> {c2, 1}
      _, {c2, c3} -> {c2, c3}
    end)
  end

  defp index_id(tree, id) do
    index_value(tree, id, id)
  end

  defp index_value(tree, <<chr::bytes-size(1)>>, value) do
    tree
    |> Map.put_new(chr, MapSet.new())
    |> Map.update!(chr, &MapSet.put(&1, value))
  end

  defp index_value(tree, <<chr::bytes-size(1)>> <> rest, value) do
    tree
    |> Map.put_new(chr, %{})
    |> Map.update!(chr, &index_value(&1, rest, value))
  end

  defp search(tree, key, limit: limit) do
    do_search(tree, key, limit)
  end

  defp do_search(tree, "", _limit), do: MapSet.new()

  defp do_search(tree, <<chr::bytes-size(1)>> <> rest, limit) do
    cond do
      Enum.empty?(tree) ->
        MapSet.new()

      Map.has_key?(tree, chr) ->
        subtree = tree[chr]

        if match?(%MapSet{}, subtree) do
          subtree
        else
          do_search(subtree, rest, limit)
        end

      limit > 0 ->
        tree
        |> Map.values()
        |> Enum.map(&do_search(&1, rest, limit - 1))
        |> Enum.reject(&is_nil/1)
        |> Enum.reduce(MapSet.new(), &MapSet.union/2)

      true ->
        MapSet.new()
    end
  end

  defp intersect_ids({id1, id2}) do
    id1_chars = String.graphemes(id1)
    id2_chars = String.graphemes(id2)

    id1_chars
    |> Enum.zip(id2_chars)
    |> Enum.filter(fn {c1, c2} -> c1 == c2 end)
    |> Enum.unzip()
    |> elem(0)
    |> Enum.join()
  end
end
