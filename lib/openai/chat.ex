defmodule OpenAI.Chat do
  @moduledoc false
  alias OpenAI.Client

  @base_url "/v1/chat/completions"

  def url(), do: @base_url

  def fetch(params, custom_config) do
    url()
    |> Client.api_post(params, custom_config)
  end
end
