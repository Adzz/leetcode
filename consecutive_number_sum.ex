defmodule Solution do
  @moduledoc """
  https://leetcode.com/problems/consecutive-numbers-sum

  """
  @spec consecutive_numbers_sum(n :: integer) :: integer
  def consecutive_numbers_sum(1), do: 1
  def consecutive_numbers_sum(0), do: 0

  def consecutive_numbers_sum(n) do
    # So for large lists this will be a lot of memory. Instead
    # is there a number formula? Spoiler. Yes there is a maths trick.
    sum(1, n, 1)
  end

  defp sum(current, target, total) when current == target - 1, do: total

  defp sum(starting_value, target, total) do
    case consume_until_bust(starting_value, 0, target) do
      :bust -> sum(starting_value + 1, target, total)
      :hit -> sum(starting_value + 1, target, total + 1)
    end
  end

  defp consume_until_bust(head, running_total, target) do
    current = head + running_total

    if current > target do
      :bust
    else
      if current < target do
        consume_until_bust(head + 1, current, target)
      else
        :hit
      end
    end
  end
end

defmodule Main do
  def run() do
    5
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "1")

    9
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "2")

    15
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "3")

    3
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "3")

    5_809_342
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "4")
  end
end

Main.run()
