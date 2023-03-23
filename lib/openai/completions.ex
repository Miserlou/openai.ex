defmodule OpenAI.Completions do
  @moduledoc false
  alias OpenAI.Client

  @base_url "/v1/completions"
  @engines_base_url "/v1/engines"

  def deprecated_url(engine_id), do: "#{@engines_base_url}/#{engine_id}/completions"
  def url(), do: @base_url

  def fetch(custom_config, engine_id, params) do
    deprecated_url(engine_id)
    |> Client.api_post(custom_config, params)
  end

  def fetch(custom_config, params) do
    url()
    |> Client.api_post(custom_config, params)
  end
end
