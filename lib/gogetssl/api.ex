defmodule Gogetssl.API do
  defmacro __using__(opts) do
    quote do
      if :create in unquote(opts) do
        @doc """
        Create a(n) #{__MODULE__ |> to_string |> String.split(".") |> List.last}
        """
        def create(data) do
          Gogetssl.request(:post, endpoint(), data)
        end
      end

      if :retrieve in unquote(opts) do
        @doc """
        Retrive a(n) #{__MODULE__ |> to_string |> String.split(".") |> List.last} by its ID
        """
        def retrieve(id) when is_bitstring(id) do
          resource_url = Path.join(endpoint(), id)
          Gogetssl.request(:get, resource_url, [])
        end
      end

      if :update in unquote(opts) do
        @doc """
        Update a(n) #{__MODULE__ |> to_string |> String.split(".") |> List.last}
        """
        def update(id, data) when is_bitstring(id) do
          resource_url = Path.join(endpoint(), id)
          Gogetssl.request(:post, resource_url, data)
        end
      end

      if :list in unquote(opts) do
        @doc """
        List all #{__MODULE__ |> to_string |> String.split(".") |> List.last}s
        """
        def list() do
          Gogetssl.request(:get, endpoint(), [])
        end
      end

      if :delete in unquote(opts) do
        @doc """
        Delete a(n) #{__MODULE__ |> to_string |> String.split(".") |> List.last}
        """
        def delete(id, data \\ []) when is_bitstring(id) do
          resource_url = Path.join(endpoint(), id)
          Gogetssl.request(:delete, resource_url, data)
        end
      end
    end
  end
end
