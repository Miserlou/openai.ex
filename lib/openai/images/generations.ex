defmodule OpenAI.Images.Generations do
  @moduledoc false
  alias OpenAI.Client

  @base_url "/v1/images/generations"

  def url(), do: @base_url

  def fetch(custom_config, params, request_options \\ []) do
    url()
    |> Client.api_post(custom_config, params, request_options)
  end
end
