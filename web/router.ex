defmodule Ddd.Router do
  use Phoenix.Router

  get "/", Ddd.PageController, :index, as: :pages

  get "/api/v0.1/", Ddd.Api01Controller, :index
  
  get "/api/v0.1/change/", Ddd.Api01Controller, :changedoc
  post "/api/v0.1/change/", Ddd.Api01Controller, :change

  # Begin HL7 ADT event types
  get "/api/v0.1/admit/", Ddd.Api01Controller, :admitdoc
  post "/api/v0.1/admit/", Ddd.Api01Controller, :admit
  
  get "/api/v0.1/discharge/", Ddd.Api01Controller, :dischargedoc
  post "/api/v0.1/discharge/", Ddd.Api01Controller, :discharge
  
  get "/api/v0.1/transfer/", Ddd.Api01Controller, :transferdoc
  post "/api/v0.1/transfer/", Ddd.Api01Controller, :transfer
  
  
end
