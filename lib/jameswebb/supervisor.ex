defmodule Jameswebb.Supervisor do
  @moduledoc false
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      {Bandit, plug: Jameswebb.Router, port: 8080}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
