defmodule Metrics.Setup do
  def setup do
    SimpleServer.MetricsExporter.setup()
  end
end
