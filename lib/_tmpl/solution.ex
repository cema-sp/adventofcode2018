defmodule SolutionTmpl do
  @moduledoc """
  Assignment description
  """

  def execute(str) do
    state = run(str)
    IO.puts("Distance: #{state.distance}, Max distance: #{state.max_distance}")
  end

  def run(_str) do
    %{}
  end
end
