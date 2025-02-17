# GOGETSSL API - in progress

Documentation: https://documenter.getpostman.com/view/5593375/T1LHFp7m

Order and manage SSL certificates, Seals & Scanners using our API.

## 🚀 Features

- Log in and fetch token

## 📖 Installation

1. Add `gogetssl` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gogetssl, "~> 0.1.0"}
  ]
end
```

2. Make sure your gogetssl username/password is added to your config file:

```elixir
config :gogetssl, ggssl_auth_username: {:system, "GGSSL_AUTH_USERNAME"}, ggssl_auth_password: {:system, "GGSSL_AUTH_PASSWORD"}

```

## 📖 Basic Usage

## ⭐️ Support

Give a ⭐️ if this project helped you!

## 🤝 Contributing

If you'd like to contribute, please fork the repository and open a pull request to the `main` branch.

## 📝 License

The [Apache License 2.0](LICENSE)
