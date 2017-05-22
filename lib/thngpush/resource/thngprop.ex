defmodule Evrythng.ThngPush.Resource.ThngProp do

  use Evrythng.ThngPush.Client

  def start_link(api_key, thng_id, property) do
    {:ok, pid} = Evrythng.ThngPush.Client.start_link(api_key)
  end

  def init({thng_id, property, subscriber_pid}) do
    []
  end


  def topic_path(parts) do
    parts
    |> Tuple.to_list 
    |> List.insert_at(0, "")
    |> Enum.map(fn(x) -> to_string(x) end) 
    |> Enum.join("/")
  end

end
