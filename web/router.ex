defmodule Ddd.Router do
  use Phoenix.Router

  get "/", Ddd.PageController, :index, as: :pages

  get "/api/v0.1/", Ddd.Api01Controller, :index

  get "/api/v0.1/change/", Ddd.Api01Controller, :changedoc
  post "/api/v0.1/change/", Ddd.Api01Controller, :change

  get "/api/v0.1/rules/", Ddd.Api01Controller, :rulesdoc
  post "/api/v0.1/rules/", Ddd.Api01Controller, :rules

end
