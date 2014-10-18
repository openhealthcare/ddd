defmodule Ddd.Router do
  use Phoenix.Router

  get "/", Ddd.PageController, :index, as: :pages

  get "/api/v0.1/", Ddd.Api01Controller, :index

  get "/api/v0.1/change/", Ddd.Api01Controller, :changedoc
  post "/api/v0.1/change/", Ddd.Api01Controller, :change

  # Begin HL7 ADT event types

  # ADT-A01 – patient admit
  get "/api/v0.1/admit/", Ddd.Api01Controller, :admitdoc
  post "/api/v0.1/admit/", Ddd.Api01Controller, :admit

  # ADT-A02 – patient transfer
  get "/api/v0.1/transfer/", Ddd.Api01Controller, :transferdoc
  post "/api/v0.1/transfer/", Ddd.Api01Controller, :transfer

  # ADT-A03 – patient discharge
  get "/api/v0.1/discharge/", Ddd.Api01Controller, :dischargedoc
  post "/api/v0.1/discharge/", Ddd.Api01Controller, :discharge

  # ADT-A04 – patient registration
  get "/api/v0.1/registration/", Ddd.Api01Controller, :registrationdoc
  post "/api/v0.1/registration/", Ddd.Api01Controller, :registration

  # ADT-A05 – patient pre-admission
  get "/api/v0.1/preadmission/", Ddd.Api01Controller, :preadmissiondoc
  post "/api/v0.1/preadmission/", Ddd.Api01Controller, :preadmission

  # ADT-A08 – patient information update
  get "/api/v0.1/update/", Ddd.Api01Controller, :updatedoc
  post "/api/v0.1/update/", Ddd.Api01Controller, :update

end
