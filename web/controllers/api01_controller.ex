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
    json conn, JSON.encode!(%{:success => "We got your admission. We'll be in touch."})
  end

  def admit(conn, _params) do
    json conn, JSON.encode!(%{:error => "You really need to provide some input data Larry. Try episode and endpoint ;)"})
  end

  def dischargedoc(conn, _params) do
    render conn, "discharge"
  end

  def discharge(conn, %{ "episode" => episode, "endpoint" => endpoint }) do
    Phoenix.Topic.broadcast "decision", {:discharge, episode: episode, endpoint: endpoint}
    json conn, JSON.encode!(%{:success => "We got your discharge. We'll be in touch."})
  end

  def discharge(conn, _params) do
    json conn, JSON.encode!(%{:error => "You really need to provide some input data Larry. Try episode and endpoint ;)"})
  end

  def transferdoc(conn, _params) do
    render conn, "transfer"
  end

  # ADT-A04 – Patient Registration
  def registration(conn, %{ "pre" => pre, "post" => post, "endpoint" => endpoint }) do
    Phoenix.Topic.broadcast "decision", {:registration, pre: pre, post: post, endpoint: endpoint}
    json conn, JSON.encode!(%{:success => "We got your registration. We'll be in touch."})
  end

  def registration(conn, _params) do
    json conn, JSON.encode!(%{:error => "You really need to provide some input data Larry. Try pre, post and endpoint ;)"})
  end

  def registrationdoc(conn, _params) do
    render conn, "registration"
  end

  # ADT-A05 – patient pre-admission
  def preadmission(conn, %{ "pre" => pre, "post" => post, "endpoint" => endpoint }) do
    Phoenix.Topic.broadcast "decision", {:preadmission, pre: pre, post: post, endpoint: endpoint}
    json conn, JSON.encode!(%{:success => "We got your preadmission. We'll be in touch."})
  end

  def preadmission(conn, _params) do
    json conn, JSON.encode!(%{:error => "You really need to provide some input data Larry. Try pre, post and endpoint ;)"})
  end

  def preadmissiondoc(conn, _params) do
    render conn, "preadmission"
  end

  # ADT-A08 – patient information update
  def update(conn, %{ "pre" => pre, "post" => post, "endpoint" => endpoint }) do
    Phoenix.Topic.broadcast "decision", {:update, pre: pre, post: post, endpoint: endpoint}
    json conn, JSON.encode!(%{:success => "We got your update. We'll be in touch."})
  end

  def update(conn, _params) do
    json conn, JSON.encode!(%{:error => "You really need to provide some input data Larry. Try pre, post and endpoint ;)"})
  end

  def updatedoc(conn, _params) do
    render conn, "update"
  end

end
