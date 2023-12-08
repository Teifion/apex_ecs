defmodule ApexECS.System do
  @moduledoc """

  """
  defmacro __using__(_opts) do
    quote do
      @behaviour ApexECS.System
    end
  end

  @doc """
  Runs the system
  """
  @callback run() :: any()
end
