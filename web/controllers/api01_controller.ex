defmodule Ddd.Api01Controller do
  use Phoenix.Controller
  
  def index(conn, _params) do
    render conn, "index"
  end

  def changedoc(conn, _params) do
    render conn, "change"
  end

  def change(conn, %{"pre" => pre, "post" => post, "endpoint" => endpoint}) do
    json conn, JSON.encode!(%{:success => "We got your change. We'll be in touch."})
  end

  def change(conn, _params) do
    json conn, JSON.encode!(%{:error => "You really need to provide some input data Larry. Try pre, post and endpoint ;)"})
  end
  
end
