defmodule SimpleServer.Router do
  use Plug.Router
  use Plug.Debugger
  require Logger
  
  plug(Plug.Logger, log: :debug)

  plug(:match)

  plug(:dispatch)

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  post "/post" do
    {:ok, body, conn} = read_body(conn)
    body = Poison.decode!(body)
    IO.inspect(body)
    send_resp(conn, 201, "created: #{get_in(body, ["message"])}")
  end

  # "Default" route that will get called when no other route is matched
  match _ do
    send_resp(conn, 404, "not found")
  end
end