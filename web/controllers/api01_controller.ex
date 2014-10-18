defmodule Ddd.Api01Controller do
  use Phoenix.Controller
  
  def index(conn, _params) do
    render conn, "index"
  end

  def changedoc(conn, _params) do
    render conn, "change"
  end

  def change(conn, %{"pre" => pre, "post" => post, "endpoint" => endpoint}) do
    Phoenix.Topic.broadcast "decision", {:change , pre: pre, post: post, endpoint: endpoint}
    json conn, JSON.encode!(%{:success => "We got your change. We'll be in touch."})
  end

  def change(conn, _params) do
    json conn, JSON.encode!(%{:error => "You really need to provide some input data Larry. Try pre, post and endpoint ;)"})
  end

  def admitdoc(conn, _params) do
    render conn, "admit"
  end

  def admit(conn, %{ "episode" => episode, "endpoint" => endpoint }) do
    Phoenix.Topic.broadcast "decision", {:admit, episode: episode, endpoint: endpoint}
  end

  def admit(conn, _params) do
    json conn, JSON.encode!(%{:error => "You really need to provide some input data Larry. Try episode and endpoint ;)"})
  end

  def dischargedoc(conn, _params) do
    render conn, "discharge"
  end

  def discharge(conn, %{ "episode" => episode, "endpoint" => endpoint }) do
    Phoenix.Topic.broadcast "decision", {:discharge, episode: episode, endpoint: endpoint}
  end

  def discharge(conn, _params) do
    json conn, JSON.encode!(%{:error => "You really need to provide some input data Larry. Try episode and endpoint ;)"})
  end

  def transferdoc(conn, _params) do
    render conn, "transfer"
  end

  def transfer(conn, %{ "pre" => pre, "post" => post, "endpoint" => endpoint }) do
    Phoenix.Topic.broadcast "decision", {:transfer, pre: pre, post: post, endpoint: endpoint}
  end

  def transfer(conn, _params) do
    json conn, JSON.encode!(%{:error => "You really need to provide some input data Larry. Try pre, post and endpoint ;)"})
  end
  
end
