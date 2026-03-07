defmodule GoogleAuthRecipeWeb.Auth.Controls.Ueberauth.Auth do
  @moduledoc false

  @uid "100000000000000000000"

  def example do
    %Ueberauth.Auth{
      uid: @uid,
      provider: :google,
      strategy: Ueberauth.Strategy.Google,
      info: info(),
      credentials: credentials(),
      extra: extra()
    }
  end

  def info do
    %Ueberauth.Auth.Info{
      name: "John Smith",
      first_name: "John",
      last_name: "Smith",
      nickname: nil,
      email: "jsmith@example.com",
      location: nil,
      description: nil,
      image: "https://lh3.googleusercontent.com/a/fake-image",
      phone: nil,
      birthday: nil,
      urls: %{profile: nil, website: "example.com"}
    }
  end

  def credentials do
    %Ueberauth.Auth.Credentials{
      token: ":fake-token:",
      refresh_token: nil,
      token_type: "Bearer",
      secret: nil,
      expires: true,
      expires_at: ~U[2010-06-15 12:00:00Z] |> DateTime.to_unix(),
      scopes: [
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/userinfo.profile",
        "openid"
      ],
      other: %{}
    }
  end

  def extra do
    %Ueberauth.Auth.Extra{
      raw_info: %{
        user: %{
          "email" => "jsmith@example.com",
          "email_verified" => true,
          "family_name" => "Smith",
          "given_name" => "John",
          "hd" => "example.com",
          "name" => "John Smith",
          "picture" => "https://lh3.googleusercontent.com/a/fake-image",
          "sub" => @uid
        },
        token: %OAuth2.AccessToken{
          access_token: ":fake-access-token:",
          refresh_token: nil,
          expires_at: ~U[2010-06-15 12:00:00Z] |> DateTime.to_unix(),
          token_type: "Bearer",
          other_params: %{
            "id_token" => ":fake-id-token",
            "scope" =>
              "https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile openid"
          }
        }
      }
    }
  end
end
