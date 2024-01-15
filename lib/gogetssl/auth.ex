defmodule Gogetssl.Auth do 
  @moduledoc"""
  Functions related to Auth
  """

  def endpoint do
    "auth"
  end

  @spec auth(Keyword.t) :: binary
  def auth(opts \\ []) do
    user = Keyword.get(opts, :user) || get_username()
    pass = Keyword.get(opts, :pass) || get_password()
    Gogetssl.request(:post, "#{endpoint()}", [user: user, pass: pass], opts)
  end

  @missing_username_password_error_message """
    An auth username and password is required to use GoGetSSl. Please include your
    auth username and password in your application config file like so:

      config :gogetssl, ggssl_auth_username: {:system, "GGSSL_AUTH_USERNAME"}, ggssl_auth_password: {:system, "GGSSL_AUTH_PASSWORD"}

    You can also pass in username and password option for Gogetssl.Auth.generate_authorize_url/1
      Gogetssl.Auth.authorize_url(username: <USERNAME>, passowrd: <PASSWORD>)
  """

  defp get_username do 
    System.get_env("GGSSL_AUTH_USERNAME") || 
    Application.get_env(:gogetssl, :ggssl_auth_username) || 
    raise Gogetssl.AuthenticationError, message: @missing_username_password_error_message
  end
  
  defp get_password do 
    System.get_env("GGSSL_AUTH_PASSWORD") || 
    Application.get_env(:gogetssl, :ggssl_auth_password) || 
    raise Gogetssl.AuthenticationError, message: @missing_username_password_error_message
  end
end
