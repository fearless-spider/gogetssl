defmodule Gogetssl.AuthTest do 
  use ExUnit.Case 

  test "Gogetssl.Auth.auth/1 should generate urls with correct params" do 
    {:ok, %{"message"=> "test"}} = Gogetssl.Auth.auth(
      user: "TEST_USERNAME",
      pass: "TEST_PASSWORD"
    )

  end

  test "Gogetssl.Auth.auth/1 should raise AuthenticationError when username and/or password is not set" do
    assert_raise Gogetssl.AuthenticationError, fn -> Gogetssl.Auth.auth() end
  end 
end
