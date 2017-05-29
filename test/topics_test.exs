defmodule Evrythng.TopicsTest do
  use ExUnit.Case
  doctest Evrythng.ThngPush.Resource.Topics

  alias Evrythng.ThngPush.Resource.Topics, as: Topics

  test "Topic path split" do
    {:thngs, "UmyxDwBxBDswQ5aaaYykthDm", :properties} = Topics.split_topic("/thngs/UmyxDwBxBDswQ5aaaYykthDm/properties")
  end

  test "Empty Topic" do
    {:unknown_topic, ""} = Topics.split_topic("")
  end

  # test "Unknown Topic" do
  #   {:unknown_topic, "/rabbits"} = Topics.split_topic("/rabbits")
  # end

end