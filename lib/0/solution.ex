defmodule Solution0 do
  @moduledoc """
  Crossing the bridge, you've barely reached the other side of the stream when a program comes up to you, clearly in distress. "It's my child process," she says, "he's gotten lost in an infinite grid!"

  Fortunately for her, you have plenty of experience with infinite grids.

  Unfortunately for you, it's a hex grid.

  The hexagons ("hexes") in this grid are aligned such that adjacent hexes can be found to the north, northeast, southeast, south, southwest, and northwest:

    \ n  /
  nw +--+ ne
    /    \
  -+      +-
    \    /
  sw +--+ se
    / s  \
  You have the path the child process took. Starting where he started, you need to determine the fewest number of steps required to reach him. (A "step" means to move from the hex you are in to any adjacent hex.)
  """

  def execute(str) do
    state = run(str)
    IO.puts("Distance: #{state.distance}, Max distance: #{state.max_distance}")
  end

  def run(str) do
    initial_state = %{
      distance: 0,
      max_distance: 0,
      position: %{
        n: 0,
        ne: 0,
        se: 0,
        s: 0,
        sw: 0,
        nw: 0
      }
    }

    str |> parse_steps |> Enum.reduce(initial_state, &do_step/2)
  end

  defp parse_steps(str) do
    str |> String.split(",") |> Enum.map(&String.to_atom/1)
  end

  defp do_step(dir, state) do
    moves = %{
      n: %{se: :ne, sw: :nw, s: :opposite},
      ne: %{s: :se, nw: :n, sw: :opposite},
      se: %{n: :ne, sw: :s, nw: :opposite},
      s: %{ne: :se, nw: :sw, n: :opposite},
      sw: %{se: :s, n: :nw, ne: :opposite},
      nw: %{s: :sw, ne: :n, se: :opposite}
    }

    dir_change =
      Enum.find(moves[dir], fn {compl_dir, _} ->
        state.position[compl_dir] > 0
      end)

    if dir_change do
      {compl_dir, res_dir} = dir_change

      state = state |> step_backward(compl_dir)

      if res_dir == :opposite do
        state
      else
        do_step(res_dir, state)
      end
    else
      state |> step_forward(dir)
    end
  end

  defp step_forward(state, direction) do
    position = Map.update!(state.position, direction, &(&1 + 1))
    distance = state.distance + 1
    max_distance = if(distance > state.max_distance, do: distance, else: state.max_distance)

    %{state | position: position, distance: state.distance + 1, max_distance: max_distance}
  end

  defp step_backward(state, direction) do
    position = Map.update!(state.position, direction, &(&1 - 1))

    %{state | position: position, distance: state.distance - 1}
  end
end
