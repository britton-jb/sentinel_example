defmodule SentinelExample.PageController do
  use SentinelExample.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
