defmodule ApexECS.Engine do
  @moduledoc """

  """

  defmacro __using__(_opts) do
    quote do
      use GenServer
      import ApexECS.Engine
      require Logger

      def start_link(_) do
        ApexECS.Engine.start_link(__MODULE__)
      end

      def init(_) do
        Enum.each(components(), fn module -> module.init() end)
        Logger.info("Component ETS tables initialised")

        interval = div(1000, ApexECS.tick_hz())
        timer_ref = :timer.send_interval(interval, :tick)

        send(self(), :start_game)

        {:ok,
         %{
           timer_ref: timer_ref
         }}
      end

      def handle_info(:update_tick_interval, state) do
        :timer.cancel(state.timer_ref)

        interval = div(1000, ApexECS.tick_hz())
        timer_ref = :timer.send_interval(interval, :tick)

        {:noreply,
         %{
           timer_ref: timer_ref
         }}
      end

      def handle_info(:tick, state) do
        Enum.each(systems(), fn system ->
          system.run()
        end)

        {:noreply, state}
      end

      def handle_info(:start_game, state) do
        if Application.get_env(:apex_ecs, :start_function) do
          Application.get_env(:apex_ecs, :start_function).()
        end

        {:noreply, state}
      end
    end
  end

  @doc false
  def start_link(module) do
    GenServer.start_link(module, [], name: module)
  end
end
