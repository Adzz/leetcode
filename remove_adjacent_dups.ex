defmodule Solution do
  @spec remove_duplicates(s :: String.t()) :: String.t()
  def remove_duplicates(s) do
    remove_dup(s, [])
  end

  defp remove_dup(<<>>, acc) do
    IO.iodata_to_binary(Enum.reverse(acc))
  end

  defp remove_dup(<<char::utf8, rest::binary>>, []) do
    remove_dup(rest, [char])
  end

  defp remove_dup(<<char::utf8, rest::binary>>, [prev | rest_acc] = acc) do
    if char === prev do
      remove_dup(rest, rest_acc)
    else
      remove_dup(rest, [char | acc])
    end
  end
end

defmodule Main do
  def run() do
    Solution.remove_duplicates("abbaca")
    |> IO.inspect(limit: :infinity, label: "ANSWER")

    "aaaaaaaa"
    |> Solution.remove_duplicates()
    |> IO.inspect(limit: :infinity, label: "ANSWER")

    "aababaab"
    |> Solution.remove_duplicates()
    |> IO.inspect(limit: :infinity, label: "ANSWER")
  end
end

Main.run()
