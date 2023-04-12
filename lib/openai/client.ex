defmodule OpenAI.Client do
  @moduledoc false
  alias OpenAI.Config
  use HTTPoison.Base

  def process_url(url), do: Config.api_url() <> url

  def process_response_body(body), do: JSON.decode(body)

  def handle_response(httpoison_response) do
    case httpoison_response do
      {:ok, %HTTPoison.Response{status_code: 200, body: {:ok, body}}} ->
        res =
          body
          |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
          |> Map.new()

        {:ok, res}

      {:ok, %HTTPoison.Response{body: {:ok, body}}} ->
        {:error, body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def add_organization_header(headers, config) do
    if Map.has_key?(config, :org_key) do
      [{"OpenAI-Organization", config[:org_key]} | headers]
    else
      headers
    end
  end

  def request_headers(config) do
    [
      bearer(config),
      {"Content-type", "application/json"}
    ]
    |> add_organization_header(config)
  end

  def bearer(config), do: {"Authorization", "Bearer #{config[:api_key]}"}

  def request_options(), do: Config.http_options()

  def api_get(url, custom_config, request_options \\ []) do
    request_options = Keyword.merge(request_options(), request_options)

    url
    |> get(request_headers(custom_config), request_options)
    |> handle_response()
  end

  def api_post(url, custom_config, params \\ [], request_options \\ [recv_timeout: 60_000, timeout: 60_000]) do
    body =
      params
      |> Enum.into(%{})
      |> JSON.Encoder.encode()
      |> elem(1)

    request_options = Keyword.merge(request_options(), request_options)

    url
    |> post(body, request_headers(custom_config), request_options)
    |> handle_response()
  end

  def multipart_api_post(url, config, file_path, file_param, params, request_options \\ []) do
    body_params = params |> Enum.map(fn {k, v} -> {Atom.to_string(k), v} end)

    body = {
      :multipart,
      [
        {:file, file_path,
         {"form-data", [{:name, file_param}, {:filename, Path.basename(file_path)}]}, []}
      ] ++ body_params
    }

    request_options = Keyword.merge(request_options(), request_options)

    url
    |> post(body, request_headers(config), request_options)
    |> handle_response()
  end

  def api_delete(url, custom_config, request_options \\ []) do
    request_options = Keyword.merge(request_options(), request_options)

    url
    |> delete(request_headers(custom_config), request_options)
    |> handle_response()
  end
end
