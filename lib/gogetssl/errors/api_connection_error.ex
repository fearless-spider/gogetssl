defmodule Gogetssl.APIConnectionError do
  @moduledoc """
  Failure to connect to GoGetSSL's API.
  """
  defexception type: "api_connection_error", message: nil
end
