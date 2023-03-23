defmodule OpenAI.Edits do
  @moduledoc false
  alias OpenAI.Client

  @edits_base_url "/v1/edits"

  def url(), do: @edits_base_url

  def fetch(params, custom_config) do
    url()
    |> Client.api_post(params, custom_config)
  end
end
