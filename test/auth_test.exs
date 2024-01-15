defmodule Gogetssl.AuthTest do 
  use ExUnit.Case 

  test "Gogetssl.Auth.auth/1 should return message about missing username/password" do 
    {:ok, %{"description" => "This request requires username and password", "error" => true, "message" => "Username and/or password not supplied"}} = Gogetssl.Auth.auth(
      user: "TEST_USERNAME",
      pass: "TEST_PASSWORD"
    )

  end

  test "Gogetssl.Auth.auth/1 should raise AuthenticationError when username and/or password is not set" do
    assert_raise Gogetssl.AuthenticationError, fn -> Gogetssl.Auth.auth() end
  end 
end
