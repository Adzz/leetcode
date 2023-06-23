defmodule Solution do
  @spec longest_consecutive(nums :: [integer]) :: integer
  @doc """
  Tricky. Obviously is we could sort then it's easy.. but sort is O log n

  So some thoughts are:

    - for every integer n we need to see n + 1 or n - 1. If we find either of those then it
      can be counted as "in a sequence". Is there a way to keep a list of all sequence lengths
      as we go? Then select the largest of them. The issue is how do you know when two sequences
      connect? I guess you know when we have a hit that is a hit for two sequences. In that case
      you add the counts together...?
      That could work.
    - So what does the data structure for the required hits look like? We need to have a map per integer
      and only combine when a hit is both... All feels a bit weird honestly.
  """
  def longest_consecutive(nums) do
    # is this consensus? we want to converge "up" to the value?
    # like could you make that work somehow? use a vector clock as the data structure
    # and have a way to add nodes....
    Enum.reduce(nums, %{}, fn num, acc ->
      before = Map.get(acc, num - 1, 0)
      after_ = Map.get(acc, num + 1, 0)
      duplicated = Map.get(acc, num, 0)

      increment =
        if duplicated > 0 do
          2
        else
          1
        end

      # if we are duplicated AND there exists a before or after then we need to add
      # 2 - one for the duplicate and the rest of the
      if before > 0 || after_ > 0 do
        Map.put(acc, num, before + after_ + increment)
        |> Map.put(num + 1, before + after_ + increment)
        |> Map.put(num, before + after_ + increment)
        |> Map.put(num - 1, before + after_ + increment)
      else
        Map.put(acc, num, 1)
      end
    end)
    |> IO.inspect(limit: :infinity, label: "")
    |> Map.values()
    |> Enum.max()
  end
end

defmodule Main do
  def run() do
    Solution.longest_consecutive([100, 4, 200, 1, 3, 2])
    |> IO.inspect(limit: :infinity, label: "")

    Solution.longest_consecutive([0, 3, 7, 2, 5, 8, 4, 6, 0, 1])
    |> IO.inspect(limit: :infinity, label: "")
  end
end

Main.run()
