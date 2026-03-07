defmodule GoogleAuthRecipe.AccountFixtures do
  @moduledoc false

  alias GoogleAuthRecipe.Accounts.Application.Users

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"

  def valid_user_attrs(attrs \\ %{}) do
    Enum.into(attrs, %{
      first_name: "John",
      last_name: "John",
      email: unique_user_email(),
      domain: "example.com",
      profile_image_url: "https://example.com/image.jpg"
    })
  end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attrs()
      |> Users.register_oauth_user()

    user
  end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
