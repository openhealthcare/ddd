defmodule Ddd.Actions.Email do
 use Mailgun.Client, domain: Application.get_env(:ddd, :mailgun_domain),
                      key: Application.get_env(:ddd, :mailgun_key)
  @from "info@example.com"
 
  @actually_send Mix.Project.config[:external_actions]

  @doc"""
  Send an email to TO, with SUBJECT and BODY
  """
  def send(to, subject, body) do
    IO.puts "sending"
    
    if @actually_send do
      send_email to: to,
               from: @from,
            subject: subject,
               body: body
    end
    {:ok, "Sent"}
  end
  
end
