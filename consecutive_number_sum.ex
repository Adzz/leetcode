defmodule Solution do
  @spec consecutive_numbers_sum(n :: integer) :: integer
  def consecutive_numbers_sum(1), do: 1
  def consecutive_numbers_sum(0), do: 0

  def consecutive_numbers_sum(n) do
    # So for large lists this will be a lot of memory. Instead
    # is there a number formula? Spoiler. Yes there is a maths trick.
    sum(Enum.to_list(1..(n - 1)), n, 1)
  end

  defp sum([], _target, total), do: total

  defp sum(range, target, total) do
    case consume_until_bust(range, 0, target) do
      :bust -> sum(tl(range), target, total)
      :hit -> sum(tl(range), target, total + 1)
    end
  end

  defp consume_until_bust([], running_total, running_total), do: :hit

  defp consume_until_bust([], _, _total) do
    :bust
  end

  defp consume_until_bust([head | rest], running_total, target) do
    current = head + running_total

    if current > target do
      :bust
    else
      if current < target do
        consume_until_bust(rest, current, target)
      else
        :hit
      end
    end
  end
end

defmodule Main do
  def run() do
    # 5
    # |> Solution.consecutive_numbers_sum()
    # |> IO.inspect(limit: :infinity, label: "1")

    # 9
    # |> Solution.consecutive_numbers_sum()
    # |> IO.inspect(limit: :infinity, label: "2")

    5_809_342
    |> Solution.consecutive_numbers_sum()
    |> IO.inspect(limit: :infinity, label: "3")
  end
end

Main.run()
