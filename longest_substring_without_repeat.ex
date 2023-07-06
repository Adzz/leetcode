defmodule Solution do
  @spec length_of_longest_substring(s :: String.t()) :: integer

  def length_of_longest_substring(s) do
    s = String.graphemes(s)
    find_longest(s, s, 0, 0, MapSet.new())
  end

  def find_longest([], _, _, longest, _), do: longest
  def find_longest(_, [], _, longest, _), do: longest

  def find_longest(head, [curr | rest], curr_len, longest, seen) do
    {head, seen, curr_len} =
      if MapSet.member?(seen, curr) do
        contract(head, curr, seen, curr_len)
      else
        {head, MapSet.put(seen, curr), curr_len + 1}
      end

    find_longest(head, rest, curr_len, max(longest, curr_len), seen)
  end

  def contract([el | rest], target, seen, curr_len) when el == target do
    {rest, seen, curr_len}
  end

  def contract([el | rest], target, seen, curr_len) do
    contract(rest, target, MapSet.delete(seen, el), curr_len - 1)
  end
end

defmodule Main do
  def run() do
    "abcabcbb"
    |> Solution.length_of_longest_substring()
    |> IO.inspect(limit: :infinity, label: "(3)")

    "bbbbb"
    |> Solution.length_of_longest_substring()
    |> IO.inspect(limit: :infinity, label: "(1)")

    "pwwkew"
    |> Solution.length_of_longest_substring()
    |> IO.inspect(limit: :infinity, label: "(3)")

    "dvdf"
    |> Solution.length_of_longest_substring()
    |> IO.inspect(limit: :infinity, label: "4: (3)")

    "aabaab!bb"
    |> Solution.length_of_longest_substring()
    |> IO.inspect(limit: :infinity, label: "5: (3)")
  end
end

Main.run()
