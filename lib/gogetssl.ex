defmodule Gogetssl do
  @moduledoc """
  Main module for handling sending/receiving requests to GoGetSSL's API
  """

  @default_api_endpoint "https://my.gogetssl.com/api/"
  @client_version Mix.Project.config()[:version]

  def version do
    @client_version
  end

  alias Gogetssl.{AuthenticationError, APIConnectionError, APIError, InvalidRequestError}

  @missing_username_password_error_message """
    The ggssl_auth_username and the ggssl_auth_password settings is required to use gogetssl. Please include your
    gogetss username and password in your application config file like so:

    config :gogetssl, ggssl_auth_username: {:system, "GGSSL_AUTH_USERNAME"}, ggssl_auth_password: {:system, "GGSSL_AUTH_PASSWORD"}
  """

  defp get_username do
    System.get_env("GGSSL_AUTH_USERNAME") ||
      Application.get_env(:gogetssl, :ggssl_auth_username) ||
      raise AuthenticationError, message: @missing_username_password_error_message
  end

  defp get_password do
    System.get_env("GGSSL_AUTH_PASSWORD") ||
      Application.get_env(:gogetssl, :ggssl_auth_password) ||
      raise AuthenticationError, message: @missing_username_password_error_message
  end

  defp get_api_endpoint do
    System.get_env("GOGETSSL_API_ENDPOINT") ||
      Application.get_env(:stripe, :api_endpoint) ||
      @default_api_endpoint
  end

  defp request_url(endpoint) do
    Path.join(get_api_endpoint(), endpoint)
  end

  defp request_url(endpoint, []) do
    Path.join(get_api_endpoint(), endpoint)
  end

  defp request_url(endpoint, data, auth_key) do
    base_url = request_url(endpoint)
    query_params = Gogetssl.Utils.encode_data(data)
    "#{base_url}?auth_key=#{auth_key}"
  end

  def request(action, endpoint, data, opts) when action in [:get, :post, :delete] do
    HTTPoison.request(action, request_url(endpoint, data), "")
    |> handle_response
  end

  defp handle_response({:ok, %{body: body, status_code: 200}}) do
    {:ok, process_response_body(body)}
  end
  
  defp handle_response({:ok, %{body: body, status_code: code}}) do
    %{"message" => message} = error =
      body
      |> process_response_body
      |> Map.fetch!("error")

    error_struct =
      case code do
        code when code in [400, 404] ->
          %InvalidRequestError{message: message, param: error["param"]}
        401 ->
          %AuthenticationError{message: message}
        _ ->
          %APIError{message: message}
      end

    {:error, error_struct}
  end

  defp handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    %APIConnectionError{message: "Network Error: #{reason}"}
  end
  
  defp process_response_body(body) do
    Poison.decode!(body)
  end
end
