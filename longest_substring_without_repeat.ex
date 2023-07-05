defmodule Solution do
  @spec length_of_longest_substring(s :: String.t()) :: integer
  def length_of_longest_substring(""), do: 0

  def length_of_longest_substring(s) do
    consume_string(s, [], 0)
  end

  defp consume_string(<<head::utf8>>, substring, longest) do
    substring =
      if head in substring do
        substring
      else
        [head | substring]
      end

    max(longest, length(substring))
  end

  defp consume_string(<<head::utf8, rest::binary>>, [], longest) do
    consume_string(rest, [head], longest)
  end

  defp consume_string(<<head::utf8, rest::binary>>, [prev | _] = substring, longest) do
    if head in substring do
      string =
        Enum.reduce_while(substring, rest, fn previous, acc ->
          if previous == head do
            {:halt, acc}
          else
            {:cont, <<previous::utf8, acc::binary>>}
          end
        end)

      consume_string(string, [], max(longest, length(substring)))
    else
      consume_string(rest, [head | substring], longest)
    end
  end
end

defmodule Main do
  def run() do
    Solution.length_of_longest_substring("abcabcbb")
    |> IO.inspect(limit: :infinity, label: "")

    Solution.length_of_longest_substring("bbbbb")
    |> IO.inspect(limit: :infinity, label: "")

    Solution.length_of_longest_substring("pwwkew")
    |> IO.inspect(limit: :infinity, label: "")

    Solution.length_of_longest_substring("dvdf")
    |> IO.inspect(limit: :infinity, label: "4: (3)")
  end
end

Main.run()
