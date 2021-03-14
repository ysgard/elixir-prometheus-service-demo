defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger
  
  plug(Plug.Logger, log: :debug)
  plug SimpleServer.Metrics.PrometheusExporter
  plug(:match)

  plug(:dispatch)

  get "/hello" do
    SimpleServer.Metrics.HttpCode.inc 200
    send_resp(conn, 200, "world")
  end

  post "/post" do
    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    IO.inspect(body)
    SimpleServer.Metrics.HttpCode.inc 201
    send_resp(conn, 201, "created: #{get_in(body, ["message"])}")
  end

  # "Default" route that will get called when no other route is matched
  match _ do
    SimpleServer.Metrics.HttpCode.inc 404
    send_resp(conn, 404, "not found")
  end
end
