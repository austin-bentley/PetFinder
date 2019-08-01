defmodule Mix.Tasks.Setup do
  use Mix.Task
  @doc """
  Sets up DB and seeds it!
  """
  def run(_) do
    Mix.Task.run("ecto.drop", [])
    Mix.Task.run("ecto.create", [])
    Mix.Task.run("ecto.migrate", [])
    Mix.shell.cmd("mix run priv/repo/seeds/user_seed.exs")
    Mix.shell.cmd("mix run priv/repo/seeds/animal_seed.exs")
    Mix.shell.cmd("mix run priv/repo/seeds/post_seed.exs")
  end
end
