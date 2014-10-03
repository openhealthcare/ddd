defmodule Ddd.Decider do
  alias Poison, as: JSON

  def start_link do
    sub = spawn_link &(decide/0)
    Phoenix.Topic.subscribe(sub, "decision")
    {:ok, sub}
  end

  def decide do
    receive do
      { :change, params } ->
        {:ok, pre}  = Poison.decode("#{params[:pre]}")
        {:ok, post} = Poison.decode("#{params[:pre]}")
        endpoint    = params[:endpoint]

        IO.puts "Called change for endpoint #{endpoint}"

        cond do
          post["date_of_admission"].starts_with? "2014" ->
            IO.puts "Episode from 2014"
          true ->
            IO.puts "No Rules"
        end
              
      _ ->
    end
    decide
  end
end
