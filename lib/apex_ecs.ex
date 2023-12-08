defmodule ApexECS do
  @moduledoc """
  Example config:

  # Required
  config :apex_ecs,
    module_tracker: MyApp.ApexModuleTracker,
    engine: MyApp.ApexEngine

  # Optional
  config :apex_ecs,
    start_function: &MyApp.start_function/0,
    tick_hz: 20
  """
  use Application

  @doc false
  def start(_type, _args) do
    children = [] ++ List.wrap(ApexECS.engine() || [])
    Supervisor.start_link(children, strategy: :one_for_one, name: ApexECS.Supervisor)
  end

  @doc """
  Returns the ApexECS engine module.

  This is set in your app configuration:

  ```elixir
  config :apex_ecs,
    engine: MyApp.ApexEngine
  ```
  """
  @spec engine() :: module()
  def engine do
    Application.get_env(:apex_ecs, :engine)
  end

  @doc """
  Returns the number of ticks per second (tick rate) the application.

  This defaults to 30, and can be changed in your app configuration:

  ```elixir
  config :apex_ecs,
    tick_hz: 20
  ```
  """
  @spec tick_hz() :: integer()
  def tick_hz do
    Application.get_env(:apex_ecs, :tick_hz, 30)
  end
end
