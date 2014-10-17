defmodule Ddd.Actions.Email do
 use Mailgun.Client, domain: Application.get_env(:ddd, :mailgun_domain),
                      key: Application.get_env(:ddd, :mailgun_key)
  @from "info@example.com"
 
  def send(to, subject, body) do
    IO.puts "sending"

    send_email to: to,
             from: @from,
          subject: subject,
             body: body
  end
  
end
