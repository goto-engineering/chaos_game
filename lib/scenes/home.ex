defmodule ChaosGame.Scene.Home do
  use Scenic.Scene
  require Logger

  alias Scenic.Graph
  alias Scenic.ViewPort

  import Scenic.Primitives
  # import Scenic.Components

  @text_size 24

  def point({x, y}) do
    rectangle_spec({1, 1}, stroke: {1, :white}, translate: {x, y})
  end

  def init(_, opts) do
    {:ok, %ViewPort.Status{size: {width, height}}} = ViewPort.info(opts[:viewport])

    fraction = 2

    rules = [
      fn ({x, y}) -> {x - x/fraction, y - y/fraction} end,
      fn ({x, y}) -> {x + (width - x)/fraction, y - y/fraction} end,
      fn ({x, y}) -> {x - x/fraction, y + (height - y)/fraction} end,
      fn ({x, y}) -> {x + (width - x)/fraction, y + (height - y)/fraction} end
    ]

    start = {:rand.uniform(width), :rand.uniform(height)}

    reduction = 1..5000 |> Enum.reduce({[start], 0}, fn (_, {acc, last_vertex}) ->
      rnd = Enum.to_list(1..Enum.count(rules)) -- [last_vertex]
            |> Enum.shuffle 
            |> Enum.at(0)

      new_point = Enum.at(rules, rnd - 1).(Enum.at(acc,0))

      {[new_point | acc], rnd}
    end)

    {points, _} = reduction

    graph =
      Graph.build(font: :roboto, font_size: @text_size)
      |> add_specs_to_graph(
        points |> Enum.map(&point/1)
      )

    {:ok, graph, push: graph}
  end

  def handle_input(event, _context, state) do
    Logger.info("Received event: #{inspect(event)}")
    {:noreply, state}
  end
end
