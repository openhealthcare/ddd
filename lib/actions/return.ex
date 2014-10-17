defmodule Ddd.Actions.ReturnToSender do
  
  @doc"""
  Send a MESSAGE to ENDPOINT

  Typically ENDPOINT is provided to an API call as the return 
  path for messages.
  """
  def send(endpoint, message) do
    {:ok, as_json} =  Poison.encode message, string: true 

    IO.puts as_json
    IO.puts endpoint

    HTTPoison.start
    HTTPoison.post endpoint, as_json
  end

end
        #     demographics = hd(post["demographics"])
        #     patient_id = "#{demographics["patient_id"]}"
        #     IO.puts patient_id
        #     episode_id = "#{post["id"]}"
        #     IO.puts episode_id

        #     return = %{
        #                :status => :ok,
        #                :type => :msg, 
        #                :value => "OMG Admitted in 2014!",
        #                :patient => patient_id, 
        #                :episode =>episode_id
        #            }
        #     ReturnToSender.send endpoint, return 
