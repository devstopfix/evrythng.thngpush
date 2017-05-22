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
    :ok = GenServer.cast(test_pid, {:thng, thng_id, :property, name, value})
    {:noreply, test_pid}
  end

end

defmodule Evrythng.ThngPushTest do
  use ExUnit.Case
  doctest Evrythng.ThngPush

  import Evrythng.Test.ThngPropTester
  alias Evrythng.Test.ThngPropTester, as: ThngPropTester

  test "the truth" do
    {:ok, pid} = ThngPropTester.start_link(self())
    GenServer.cast(pid, {:thng, "T1", :property, "P", "V"})
    assert_receive {_, {:thng, "T1", :property, "P", _}}, 500
  end
end
