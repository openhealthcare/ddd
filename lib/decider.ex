defmodule Ddd.Decider do
  alias Poison, as: JSON
  alias Ddd.Actions.Email, as: Email
  alias Ddd.Actions.ReturnToSender, as: ReturnToSender
  
  def start_link do
    sub = spawn_link &(decide/0)
    Phoenix.Topic.subscribe(sub, "decision")
    {:ok, sub}
  end

  def decide do
    receive do
      { :change, params } ->
        {:ok, pre}  = Poison.decode("#{params[:pre]}")
        {:ok, post} = Poison.decode("#{params[:post]}")
        endpoint    = params[:endpoint]

        IO.puts "Called change for endpoint #{endpoint}"
        IO.puts "#{post["date_of_admission"]}"

        cond do
          String.starts_with? post["date_of_admission"], "2014" ->
            IO.puts "Episode from 2014"
            Email.send "david@deadpansincerity.com", "Hai from DDD", "This is an email from DDD"

            demographics = hd(post["demographics"])
            patient_id = "#{demographics["patient_id"]}"
            IO.puts patient_id
            
            episode_id = "#{post["id"]}"
            IO.puts episode_id

            return = %{
                       :status => :ok,
                       :type => :msg, 
                       :value => "OMG Admitted in 2014!",
                       :patient => patient_id, 
                       :episode =>episode_id
                   }
            ReturnToSender.send endpoint, return 
          true ->
            IO.puts "No Rules"
        end
              
      _ ->
    end
    decide
  end
end
