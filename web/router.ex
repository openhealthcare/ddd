defmodule Ddd.Router do
  use Phoenix.Router

  get "/", Ddd.PageController, :index, as: :pages

end
