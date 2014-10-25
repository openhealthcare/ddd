defmodule Ddd.EditorController do
  use Phoenix.Controller

  def editor(conn, _params) do
    render conn, "editor"
  end
  
end
