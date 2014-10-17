defmodule Ddd.Decider do
  alias Poison, as: JSON
  alias Ddd.Actions.Email, as: Email
  
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
        IO.puts "#{post["date_of_admission"]}"

        cond do
          String.starts_with? post["date_of_admission"], "2014" ->
            IO.puts "Episode from 2014"
            Email.send "david@deadpansincerity.com", "Hai from DDD", "This is an email from DDD"
          true ->
            IO.puts "No Rules"
        end
              
      _ ->
    end
    decide
  end
end
