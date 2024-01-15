defmodule Gogetssl.Auth do 
  @moduledoc"""
  Functions related to Auth
  """

  def endpoint do
    "auth"
  end

  @spec auth(Keyword.t) :: binary
  def auth(opts \\ []) do
    user = Keyword.get(opts, :user) || Gogetssl.get_username()
    pass = Keyword.get(opts, :pass) || Gogetssl.get_password()
    Gogetssl.request(:post, "#{endpoint()}", [user: user, pass: pass])
  end
end
