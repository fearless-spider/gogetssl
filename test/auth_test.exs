defmodule Gogetssl.AuthTest do 
  use ExUnit.Case 

  test "Gogetssl.Auth.authorize_url/1 should generate urls with correct query params" do 
    url = Gogetssl.Auth.authorize_url(
      user: "TEST_USERNAME",
      pass: "TEST_PASSWORD"
    )

    assert url =~ "username=TEST_USERNAME"
    assert url =~ "password=TEST_PASSWORD"
    assert url =~ "response_type=code"
  end

  test "Gogetssl.Auth.authorize_url/1 should raise AuthenticationError when username and/or password is not set" do
    assert_raise Gogetssl.AuthenticationError, fn -> Gogetssl.Auth.authorize_url() end
  end 
end
