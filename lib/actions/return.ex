defmodule Ddd.Actions.ReturnToSender do
  
  def send(endpoint, message) do
    {:ok, as_json} =  Poison.encode message, string: true 

    IO.puts as_json
    IO.puts endpoint

    HTTPoison.start
    HTTPoison.post endpoint, as_json
  end

end
