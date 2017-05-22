defmodule Evrythng.ThngPush.Client do

  use GenServer

  defmacro __using__(_opts) do
    IO.puts "You are USING Evrythng.ThngPush.Client"
    quote do          # <--
      import Evrythng.ThngPush.Client     # <--
    end               # <--
  end  

  def start_link(api_key) do
    GenServer.start_link(__MODULE__, api_key)
  end  

  def init(api_key) do
    {:ok, mqttc_pid} = :emqttc.start_link([
      {:host, 'mqtt.evrythng.com'}, 
      {:port, 8883}, :ssl, 
      {:username, <<"authorization">>}, 
      {:password, api_key},
      {:client_id, generate_client_id()}])
    {:ok, mqttc_pid}
  end

  def terminate(_reason, mqttc_pid) do
    # TODO move to supervisor
    :emqttc.disconnect(mqttc_pid)
  end

  def handle_info({:publish, Topic, Payload}, state) do
      :io.format("Message Received from ~s: ~p~n", [Topic, Payload]) |> IO.puts
    {:noreply, state}
  end

  def handle_info({:mqttc, pid, :connected}, state) do
    IO.puts("Connected " <> inspect(pid));
    {:noreply, state}
  end

  @doc """
  Variation of the EMQTTC client id using the host name, user agent and random number.

  See [https://github.com/emqtt/emqttc/blob/815ebeca103025bbb5eb8e4b2f6a5f79e1236d4c/src/emqttc_protocol.erl#L125](emqttc_protocol.erl#L125)
  """
  def generate_client_id do
    {:ok, host} = :inet.gethostname()
    :rand.seed(:exsplus)
    i1 = :rand.uniform(round(:math.pow(2, 48))) - 1
    i2 = :rand.uniform(round(:math.pow(2, 32))) - 1
    [user_agent(), host, (:io_lib.format("~12.16.0b~8.16.0b", [i1, i2]) |> to_string)] |> Enum.join("_")
  end

  # UserAgent

  @version Mix.Project.config[:version]
  def version(), do: @version

  def user_agent(), do: "Elixir/ThngPush/" <> version()

end
