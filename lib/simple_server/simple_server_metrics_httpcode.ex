defmodule SimpleServer.Metrics.HttpCode do
  use Prometheus.Metric
  def setup() do
    Counter.declare(
      name: :http_code,
      help: "HTTP response code total",
      labels: [:code]
    )
  end

  def inc(code) do
    Counter.inc(
      name: :http_code,
      labels: [code]
    )
  end
end

