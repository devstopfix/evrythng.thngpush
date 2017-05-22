defmodule Evrythng.Test.ThngPropTester do

  # use Evrythng.ThngPush.Resource.ThngProp
  use GenServer

  def start_link(test_pid) do
    GenServer.start_link(__MODULE__, test_pid)
  end

  def init(test_pid) do
    {:ok, test_pid}
  end

  def handle_cast({:thng, thng_id, :property, name, value}, test_pid) do
    GenServer.cast(test_pid, {:thng, thng_id, :property, name, value})    
  end

end