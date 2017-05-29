defmodule Evrythng.ThngPush.Resource.Topics do

  def split_topic(topic) do
    topic
    |> String.split("/")
    |> Enum.drop(1)
    |> List.to_tuple
    |> convert_topic(topic)
  end

  defp convert_topic({}, topic_str), do: {:unknown_topic, topic_str}

  defp convert_topic({"thngs", id, "properties"}, _), do: {:thngs, id, :properties}

  defp convert_topic(other), do: {:unknown_topic, other}

end
