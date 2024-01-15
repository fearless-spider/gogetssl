defmodule Gogetssl.Products do
  use Gogetssl.API, [:list]

  def endpoint do
    "products"
  end
end
