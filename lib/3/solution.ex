defmodule Solution3 do
  @moduledoc """
  --- Day 3: No Matter How You Slice It ---
  The Elves managed to locate the chimney-squeeze prototype fabric for Santa's suit (thanks to someone who helpfully wrote its box IDs on the wall of the warehouse in the middle of the night). Unfortunately, anomalies are still affecting them - nobody can even agree on how to cut the fabric.

  The whole piece of fabric they're working on is a very large square - at least 1000 inches on each side.

  Each Elf has made a claim about which area of fabric would be ideal for Santa's suit. All claims have an ID and consist of a single rectangle with edges parallel to the edges of the fabric. Each claim's rectangle is defined as follows:

  The number of inches between the left edge of the fabric and the left edge of the rectangle.
  The number of inches between the top edge of the fabric and the top edge of the rectangle.
  The width of the rectangle in inches.
  The height of the rectangle in inches.
  A claim like #123 @ 3,2: 5x4 means that claim ID 123 specifies a rectangle 3 inches from the left edge, 2 inches from the top edge, 5 inches wide, and 4 inches tall. Visually, it claims the square inches of fabric represented by # (and ignores the square inches of fabric represented by .) in the diagram below:

  ...........
  ...........
  ...#####...
  ...#####...
  ...#####...
  ...#####...
  ...........
  ...........
  ...........
  The problem is that many of the claims overlap, causing two or more claims to cover part of the same areas. For example, consider the following claims:

  #1 @ 1,3: 4x4
  #2 @ 3,1: 4x4
  #3 @ 5,5: 2x2
  Visually, these claim the following areas:

  ........
  ...2222.
  ...2222.
  .11XX22.
  .11XX22.
  .111133.
  .111133.
  ........
  The four square inches marked with X are claimed by both 1 and 2. (Claim 3, while adjacent to the others, does not overlap either of them.)

  If the Elves all proceed with their own plans, none of them will have enough fabric. How many square inches of fabric are within two or more claims?

  --- Part Two ---

  Amidst the chaos, you notice that exactly one claim doesn't overlap by even a single square inch of fabric with any other claim. If you can somehow draw attention to it, maybe the Elves will be able to make Santa's suit after all!

  For example, in the claims above, only claim 3 is intact after all claims are made.

  What is the ID of the only claim that doesn't overlap?
  """

  def execute(str) do
    IO.puts("Overlap area: #{overlap_area(str)}")
    IO.puts("Plain piece id: #{plain_piece_id(str)}")
  end

  def overlap_area(str) do
    str
    |> String.split("\n", trim: true)
    |> project_claims()
    |> filter_overlaps()
    |> length()
  end

  def plain_piece_id(str) do
    str
    |> String.split("\n", trim: true)
    |> project_claims()
    |> analyze_overlaps()
    |> find_plain_id()
  end

  defp project_claims(claims) do
    state = %{}
    project_claims(claims, state)
  end

  defp project_claims([], state), do: state

  defp project_claims([claim_str | rest_claims], state) do
    claim = parse_claim(claim_str)
    project_claims(rest_claims, project_calim(state, claim))
  end

  defp parse_claim(str) do
    regex = ~r/\#(\d+) \@ (\d+)\,(\d+)\: (\d+)x(\d+)/

    [_all, id, x, y, w, h] = Regex.run(regex, str)

    %{
      id: id,
      x: String.to_integer(x),
      y: String.to_integer(y),
      w: String.to_integer(w),
      h: String.to_integer(h)
    }
  end

  defp project_calim(state, claim) do
    xs = claim.x..(claim.x + claim.w - 1)
    ys = claim.y..(claim.y + claim.h - 1)

    Enum.reduce(xs, state, fn (x, acc) ->
      Enum.reduce(ys, acc, fn (y, st) ->
        coord = {x, y}
        Map.update(
          st,
          coord,
          MapSet.new([claim.id]),
          &MapSet.put(&1, claim.id)
        )
      end)
    end)
  end

  defp filter_overlaps(state) do
    Enum.filter(state, fn ({_coord, ids}) ->
      MapSet.size(ids) > 1
    end)
  end

  defp analyze_overlaps(state) do
    Enum.reduce(state, %{}, fn ({_coord, ids}, acc) ->
      Enum.reduce(ids, acc, fn (id, res) ->
        overlaps = MapSet.delete(ids, id)
        Map.update(res, id, overlaps, &MapSet.union(&1, overlaps))
      end)
    end)
  end

  defp find_plain_id(overlaps) do
    overlaps
    |> Enum.find(fn ({id, overlap_ids}) -> Enum.empty?(overlap_ids) end)
    |> elem(0)
  end
end
