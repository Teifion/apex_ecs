# Create project
```sh
mix new --sup ecs_hello_world
```

## Dependencies
Add ApexECS to your dependencies:
```elixir
{:apex_ecs, "~> 0.1"}
```

Now get and compile
```sh
mix deps.get && mix deps.compile
```

hello_component.ex
```elixir
defmodule EcsHelloWorld.Components.HelloComponent do
  @moduledoc """
  Component to hold the value "Hello"
  """
  use ApexECS.Component
end
```


hello_system.ex
```elixir
defmodule EcsHelloWorld.Systems.HelloSystem do
  @moduledoc """
  A system saying Hello for every HelloComponent
  """
  use ApexECS.System

  alias EcsHelloWorld.Components.HelloComponent

  @impl ApexECS.System
  @spec run() :: :ok
  def run do
    HelloComponent.list_all()
    |> Enum.each(fn {entity_id, component} ->
      IO.inspect {entity_id, component}
    end)
    IO.puts ""
  end
end
```

