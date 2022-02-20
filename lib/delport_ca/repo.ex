defmodule DelportCa.Repo do
  use Ecto.Repo,
    otp_app: :delport_ca,
    adapter: Ecto.Adapters.Postgres
end
