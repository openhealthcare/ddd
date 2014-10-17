defmodule Ddd.Decider do
  alias Poison, as: JSON
  alias Ddd.Actions.Email, as: Email
  alias Ddd.Actions.ReturnToSender, as: ReturnToSender
  
  def start_link do
    sub = spawn_link &(decide/0)
    Phoenix.Topic.subscribe(sub, "decision")
    {:ok, sub}
  end

  @doc"""
  Perform BEHAVIOUR for ACTION with PRE and POST, returning to ENDPOINT as required
  """
  def behave(behaviour, action, {pre, post, endpoint}) do
    Ddd.Matcher.process_block behaviour, {pre, post}
  end

  @doc"""
  Decide on what to do for change events.
  """
  def decide do
    receive do
      { :change, params } ->
        {:ok, pre}  = Poison.decode("#{params[:pre]}")
        {:ok, post} = Poison.decode("#{params[:post]}")
        endpoint    = params[:endpoint]

        IO.puts "Called change for endpoint #{endpoint}"

        Path.wildcard("behaviours/*/*.behaviour")
          |> Enum.map(&(behave &1, :change, {pre, post, endpoint}))
      _ ->
    end
  decide
  end
end
